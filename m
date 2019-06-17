Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6240C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A047D20B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 21:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560806615;
	bh=7Me4YDXtq3Ko/Z5bQvpB2hZkSF9YjldJMQmQmv0GEcw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ehXMsIyVqi+LV3/pz6vS4Mex0UNG+Qfz8jereq3+zUvPY5PBcEAmo639Qm7bj51qG
	 H1yc6V16CHcAODT0EdY67d1POgrJWAd6x+wIltlwFJBl34L+Z1uG7sQrk5n+aEIaC2
	 mcl/zMWBFixTptYydeIT8R9yyweONopNFFUijDy8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbfFQVXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 17:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729729AbfFQVXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 17:23:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05A3E20861;
        Mon, 17 Jun 2019 21:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560806609;
        bh=7Me4YDXtq3Ko/Z5bQvpB2hZkSF9YjldJMQmQmv0GEcw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rURX726NgU5Pxd70bRs7UQLqx02wXtxP0kFBXkRdBEWA/dMu/fudePgY9xAxeKPIj
         NhW1h/BbuvMS53A4rLGflnmUPlUBP+LNyRKYdLc2U6Zvwm26sWs8mIAUryQlpiKzIo
         xV3JxcdYdQ5Yj7y2FUf5wwOnDj7AEqjWPq2LzDTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Prarit Bhargava <prarit@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 5.1 111/115] x86/resctrl: Prevent NULL pointer dereference when local MBM is disabled
Date:   Mon, 17 Jun 2019 23:10:11 +0200
Message-Id: <20190617210805.558099459@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190617210759.929316339@linuxfoundation.org>
References: <20190617210759.929316339@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Prarit Bhargava <prarit@redhat.com>

commit c7563e62a6d720aa3b068e26ddffab5f0df29263 upstream.

Booting with kernel parameter "rdt=cmt,mbmtotal,memlocal,l3cat,mba" and
executing "mount -t resctrl resctrl -o mba_MBps /sys/fs/resctrl" results in
a NULL pointer dereference on systems which do not have local MBM support
enabled..

BUG: kernel NULL pointer dereference, address: 0000000000000020
PGD 0 P4D 0
Oops: 0000 [#1] SMP PTI
CPU: 0 PID: 722 Comm: kworker/0:3 Not tainted 5.2.0-0.rc3.git0.1.el7_UNSUPPORTED.x86_64 #2
Workqueue: events mbm_handle_overflow
RIP: 0010:mbm_handle_overflow+0x150/0x2b0

Only enter the bandwith update loop if the system has local MBM enabled.

Fixes: de73f38f7680 ("x86/intel_rdt/mba_sc: Feedback loop to dynamically update mem bandwidth")
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190610171544.13474-1-prarit@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/cpu/resctrl/monitor.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -368,6 +368,9 @@ static void update_mba_bw(struct rdtgrou
 	struct list_head *head;
 	struct rdtgroup *entry;
 
+	if (!is_mbm_local_enabled())
+		return;
+
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;


