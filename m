Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83FDDC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F012206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfD0PPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:15:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60776 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2k-0000zQ-Ez; Sat, 27 Apr 2019 16:15:10 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004QS-Vm; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Gerald Schaefer" <gerald.schaefer@de.ibm.com>,
        "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.27910963@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 036/202] s390/smp: fix CPU hotplug deadlock with CPU
 rescan
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

commit b7cb707c373094ce4008d4a6ac9b6b366ec52da5 upstream.

smp_rescan_cpus() is called without the device_hotplug_lock, which can lead
to a dedlock when a new CPU is found and immediately set online by a udev
rule.

This was observed on an older kernel version, where the cpu_hotplug_begin()
loop was still present, and it resulted in hanging chcpu and systemd-udev
processes. This specific deadlock will not show on current kernels. However,
there may be other possible deadlocks, and since smp_rescan_cpus() can still
trigger a CPU hotplug operation, the device_hotplug_lock should be held.

For reference, this was the deadlock with the old cpu_hotplug_begin() loop:

        chcpu (rescan)                       systemd-udevd

 echo 1 > /sys/../rescan
 -> smp_rescan_cpus()
 -> (*) get_online_cpus()
    (increases refcount)
 -> smp_add_present_cpu()
    (new CPU found)
 -> register_cpu()
 -> device_add()
 -> udev "add" event triggered -----------> udev rule sets CPU online
                                         -> echo 1 > /sys/.../online
                                         -> lock_device_hotplug_sysfs()
                                            (this is missing in rescan path)
                                         -> device_online()
                                         -> (**) device_lock(new CPU dev)
                                         -> cpu_up()
                                         -> cpu_hotplug_begin()
                                            (loops until refcount == 0)
                                            -> deadlock with (*)
 -> bus_probe_device()
 -> device_attach()
 -> device_lock(new CPU dev)
    -> deadlock with (**)

Fix this by taking the device_hotplug_lock in the CPU rescan path.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/s390/kernel/smp.c          | 4 ++++
 drivers/s390/char/sclp_config.c | 2 ++
 2 files changed, 6 insertions(+)

--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -1032,7 +1032,11 @@ static ssize_t __ref rescan_store(struct
 {
 	int rc;
 
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
 	rc = smp_rescan_cpus();
+	unlock_device_hotplug();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR(rescan, 0200, NULL, rescan_store);
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -43,7 +43,9 @@ static void sclp_cpu_capability_notify(s
 
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
+	lock_device_hotplug();
 	smp_rescan_cpus();
+	unlock_device_hotplug();
 }
 
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)

