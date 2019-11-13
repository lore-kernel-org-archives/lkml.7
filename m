Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10049C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7EDC222CD
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 11:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbfKMLrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Nov 2019 06:47:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37477 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbfKMLrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 06:47:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUr75-0003gc-Ge; Wed, 13 Nov 2019 12:47:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F2D731C0092;
        Wed, 13 Nov 2019 12:47:06 +0100 (CET)
Date:   Wed, 13 Nov 2019 11:47:06 -0000
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix potential lockdep warning
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        pei.p.jia@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        "x86-ml" <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
References: <1573079796-11713-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <157364562654.29376.17634958855166579949.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c8eafe1495303bfd0eedaa8156b1ee9082ee9642
Gitweb:        https://git.kernel.org/tip/c8eafe1495303bfd0eedaa8156b1ee9082ee9642
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Thu, 07 Nov 2019 06:36:36 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 13 Nov 2019 12:34:44 +01:00

x86/resctrl: Fix potential lockdep warning

rdtgroup_cpus_write() and mkdir_rdt_prepare() call
rdtgroup_kn_lock_live() -> kernfs_to_rdtgroup() to get 'rdtgrp', and
then call the rdt_last_cmd_{clear,puts,...}() functions which will check
if rdtgroup_mutex is held/requires its caller to hold rdtgroup_mutex.

But if 'rdtgrp' returned from kernfs_to_rdtgroup() is NULL,
rdtgroup_mutex is not held and calling rdt_last_cmd_{clear,puts,...}()
will result in a self-incurred, potential lockdep warning.

Remove the rdt_last_cmd_{clear,puts,...}() calls in these two paths.
Just returning error should be sufficient to report to the user that the
entry doesn't exist any more.

 [ bp: Massage. ]

Fixes: 94457b36e8a5 ("x86/intel_rdt: Add diagnostics when writing the cpus file")
Fixes: cfd0f34e4cd5 ("x86/intel_rdt: Add diagnostics when making directories")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1573079796-11713-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index a46dee8..2e3b06d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -461,10 +461,8 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
 	}
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
-	rdt_last_cmd_clear();
 	if (!rdtgrp) {
 		ret = -ENOENT;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto unlock;
 	}
 
@@ -2648,10 +2646,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
 	int ret;
 
 	prdtgrp = rdtgroup_kn_lock_live(prgrp_kn);
-	rdt_last_cmd_clear();
 	if (!prdtgrp) {
 		ret = -ENODEV;
-		rdt_last_cmd_puts("Directory was removed\n");
 		goto out_unlock;
 	}
 
