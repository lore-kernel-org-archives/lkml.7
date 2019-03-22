Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AAEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38DC2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257875;
	bh=VASFaOLZS6DU0NrfQenMVVhIXMRoHk0m8m64wva2ODE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KxTAzmyoqGdo0SP3dJg9TjJZAo4hqJdq6c/MpGYL1uXp8+fUJvQcobmdkJvC9K54P
	 EsFjGxw1RnQhN46+U0r0sZkGmDAU1n1BEZvVfCFHa+/9y41PGSIAOwsrtN9x1A4MGK
	 bbnE0Mi87IILHY5+4SyNgbFpV2CYEiXA4QUITs5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390373AbfCVMRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390130AbfCVMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:17:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB99821939;
        Fri, 22 Mar 2019 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257046;
        bh=VASFaOLZS6DU0NrfQenMVVhIXMRoHk0m8m64wva2ODE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jGzec+0gG8PAZtjsxWjUP3ITSmkzEX4AqVuXLXYzIxsg/w7+DH5Cht4so1Rji0dF0
         HgAIxfAoRF5duwtM4umNjKTRgLEqlB2knTCN3klZ1Vbg+x6scMeIlkGSHcWWDysrpv
         GJrg6bNWw204oW5IKCJEncruxtnGL3jLeecoZmjI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ammy Yi <ammy.yi@intel.com>
Subject: [PATCH 5.0 115/238] intel_th: Dont reference unassigned outputs
Date:   Fri, 22 Mar 2019 12:15:34 +0100
Message-Id: <20190322111305.298274565@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Shishkin <alexander.shishkin@linux.intel.com>

commit 9ed3f22223c33347ed963e7c7019cf2956dd4e37 upstream.

When an output port driver is removed, also remove references to it from
any masters. Failing to do this causes a NULL ptr dereference when
configuring another output port:

> BUG: unable to handle kernel NULL pointer dereference at 000000000000000d
> RIP: 0010:master_attr_store+0x9d/0x160 [intel_th_gth]
> Call Trace:
> dev_attr_store+0x1b/0x30
> sysfs_kf_write+0x3c/0x50
> kernfs_fop_write+0x125/0x1a0
> __vfs_write+0x3a/0x190
> ? __vfs_write+0x5/0x190
> ? _cond_resched+0x1a/0x50
> ? rcu_all_qs+0x5/0xb0
> ? __vfs_write+0x5/0x190
> vfs_write+0xb8/0x1b0
> ksys_write+0x55/0xc0
> __x64_sys_write+0x1a/0x20
> do_syscall_64+0x5a/0x140
> entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Fixes: b27a6a3f97b9 ("intel_th: Add Global Trace Hub driver")
CC: stable@vger.kernel.org # v4.4+
Reported-by: Ammy Yi <ammy.yi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/hwtracing/intel_th/gth.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/hwtracing/intel_th/gth.c
+++ b/drivers/hwtracing/intel_th/gth.c
@@ -607,6 +607,7 @@ static void intel_th_gth_unassign(struct
 {
 	struct gth_device *gth = dev_get_drvdata(&thdev->dev);
 	int port = othdev->output.port;
+	int master;
 
 	if (thdev->host_mode)
 		return;
@@ -615,6 +616,9 @@ static void intel_th_gth_unassign(struct
 	othdev->output.port = -1;
 	othdev->output.active = false;
 	gth->output[port].output = NULL;
+	for (master = 0; master < TH_CONFIGURABLE_MASTERS; master++)
+		if (gth->master[master] == port)
+			gth->master[master] = -1;
 	spin_unlock(&gth->gth_lock);
 }
 


