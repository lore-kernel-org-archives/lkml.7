Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D513C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8C3B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 12:27:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qxoaAlGV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438902AbfFLM1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 08:27:33 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40333 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438842AbfFLM1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 08:27:32 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5CCQsjc684780
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 12 Jun 2019 05:26:54 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5CCQsjc684780
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560342415;
        bh=Alv9MRLP1mGRljy7+QwagBIBcl0cQij3a3UMVqGNvdk=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qxoaAlGV6+kE9AQnm6WE8abQbghQLcCfbXhb8DkR8bTNigy7F7lNTx+UPkV7Eqe4h
         cqEK8o8ielQpHC7SDsSUpnFS/JEM6p20lj8W7PtPNRi1BFZ/kxv/bQgPg2FHiysRI9
         snLC5JGXPeLXr9vM6IXB6E9eFvJPC0gZooUCP/GfEeeID8dEtx3JKjZAbq3G09omxo
         dYSvqeqJKDSoTAAn9BtkF65MsYaAB0GD4MJ+HhCVy2FeNKNo0phmC1T0+8xPwaZouN
         dWnIosOudmDPnljm1Vauw42vi44H3DWm8gm7ch9roYg9/nirmyWoq9mVwFOY0NOZqG
         GJ9ctKKtlxfjQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5CCQrP3684777;
        Wed, 12 Jun 2019 05:26:53 -0700
Date:   Wed, 12 Jun 2019 05:26:53 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Prarit Bhargava <tipbot@zytor.com>
Message-ID: <tip-c7563e62a6d720aa3b068e26ddffab5f0df29263@git.kernel.org>
Cc:     mingo@kernel.org, prarit@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        reinette.chatre@intel.com, fenghua.yu@intel.com, bp@alien8.de
Reply-To: prarit@redhat.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com,
          reinette.chatre@intel.com, tglx@linutronix.de,
          fenghua.yu@intel.com, bp@alien8.de
In-Reply-To: <20190610171544.13474-1-prarit@redhat.com>
References: <20190610171544.13474-1-prarit@redhat.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/resctrl: Prevent NULL pointer dereference when
 local MBM is disabled
Git-Commit-ID: c7563e62a6d720aa3b068e26ddffab5f0df29263
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  c7563e62a6d720aa3b068e26ddffab5f0df29263
Gitweb:     https://git.kernel.org/tip/c7563e62a6d720aa3b068e26ddffab5f0df29263
Author:     Prarit Bhargava <prarit@redhat.com>
AuthorDate: Mon, 10 Jun 2019 13:15:44 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 12 Jun 2019 10:31:50 +0200

x86/resctrl: Prevent NULL pointer dereference when local MBM is disabled

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

---
 arch/x86/kernel/cpu/resctrl/monitor.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 1573a0a6b525..ff6e8e561405 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -368,6 +368,9 @@ static void update_mba_bw(struct rdtgroup *rgrp, struct rdt_domain *dom_mbm)
 	struct list_head *head;
 	struct rdtgroup *entry;
 
+	if (!is_mbm_local_enabled())
+		return;
+
 	r_mba = &rdt_resources_all[RDT_RESOURCE_MBA];
 	closid = rgrp->closid;
 	rmid = rgrp->mon.rmid;
