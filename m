Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B582C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70AFF20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 00:56:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfLQA4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 19:56:09 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35162 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726967AbfLQAvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 19:51:42 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15K-0003MS-HT; Tue, 17 Dec 2019 00:51:34 +0000
Received: from ben by deadeye with local (Exim 4.93-RC7)
        (envelope-from <ben@decadent.org.uk>)
        id 1ih15J-0005b7-M6; Tue, 17 Dec 2019 00:51:33 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Himanshu Madhani" <hmadhani@marvell.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Date:   Tue, 17 Dec 2019 00:47:15 +0000
Message-ID: <lsq.1576543535.640379191@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 101/136] scsi: qla2xxx: stop timer in shutdown path
In-Reply-To: <lsq.1576543534.33060804@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.80-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nicholas Piggin <npiggin@gmail.com>

commit d3566abb1a1e7772116e4d50fb6a58d19c9802e5 upstream.

In shutdown/reboot paths, the timer is not stopped:

  qla2x00_shutdown
  pci_device_shutdown
  device_shutdown
  kernel_restart_prepare
  kernel_restart
  sys_reboot

This causes lockups (on powerpc) when firmware config space access calls
are interrupted by smp_send_stop later in reboot.

Fixes: e30d1756480dc ("[SCSI] qla2xxx: Addition of shutdown callback handler.")
Link: https://lore.kernel.org/r/20191024063804.14538-1-npiggin@gmail.com
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Acked-by: Himanshu Madhani <hmadhani@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/scsi/qla2xxx/qla_os.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -3006,6 +3006,10 @@ qla2x00_shutdown(struct pci_dev *pdev)
 	/* Stop currently executing firmware. */
 	qla2x00_try_to_stop_firmware(vha);
 
+	/* Disable timer */
+	if (vha->timer_active)
+		qla2x00_stop_timer(vha);
+
 	/* Turn adapter off line */
 	vha->flags.online = 0;
 

