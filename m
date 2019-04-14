Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB98C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17BC320693
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 16:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfDNQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 12:41:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33671 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfDNQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 12:41:44 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3EGfNnN2618879
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sun, 14 Apr 2019 09:41:24 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3EGfLA52618870;
        Sun, 14 Apr 2019 09:41:21 -0700
Date:   Sun, 14 Apr 2019 09:41:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Xiaochen Shen <tipbot@zytor.com>
Message-ID: <tip-40fba00ffa431c8597ca785ea1cfa4d9f6503390@git.kernel.org>
Cc:     xiaochen.shen@intel.com, fenghua.yu@intel.com, tglx@linutronix.de,
        reinette.chatre@intel.com, mingo@redhat.com, tony.luck@intel.com,
        mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        bp@suse.de, x86@kernel.org
Reply-To: fenghua.yu@intel.com, xiaochen.shen@intel.com,
          tglx@linutronix.de, mingo@redhat.com, reinette.chatre@intel.com,
          tony.luck@intel.com, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, bp@suse.de, x86@kernel.org
In-Reply-To: <1554839629-5448-1-git-send-email-xiaochen.shen@intel.com>
References: <1554839629-5448-1-git-send-email-xiaochen.shen@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/resctrl: Do not repeat rdtgroup mode
 initialization
Git-Commit-ID: 40fba00ffa431c8597ca785ea1cfa4d9f6503390
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

Commit-ID:  40fba00ffa431c8597ca785ea1cfa4d9f6503390
Gitweb:     https://git.kernel.org/tip/40fba00ffa431c8597ca785ea1cfa4d9f6503390
Author:     Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate: Wed, 10 Apr 2019 03:53:49 +0800
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 14 Apr 2019 18:23:13 +0200

x86/resctrl: Do not repeat rdtgroup mode initialization

When cache allocation is supported and the user creates a new resctrl
resource group, the allocations of the new resource group are
initialized to all regions that it can possibly use. At this time these
regions are all that are shareable by other resource groups as well as
regions that are not currently used. The new resource group's mode is
also initialized to reflect this initialization and set to "shareable".

The new resource group's mode is currently repeatedly initialized within
the loop that configures the hardware with the resource group's default
allocations.

Move the initialization of the resource group's mode outside the
hardware configuration loop. The resource group's mode is now
initialized only once as the final step to reflect that its configured
allocations are "shareable".

Fixes: 95f0b77efa57 ("x86/intel_rdt: Initialize new resource group with sane defaults")
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: pei.p.jia@intel.com
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/1554839629-5448-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 54b9eef3eea9..85212a32b54d 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2610,9 +2610,10 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 			rdt_last_cmd_puts("Failed to initialize allocations\n");
 			return ret;
 		}
-		rdtgrp->mode = RDT_MODE_SHAREABLE;
 	}
 
+	rdtgrp->mode = RDT_MODE_SHAREABLE;
+
 	return 0;
 }
 
