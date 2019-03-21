Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C2C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A08218D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbfCULaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:30:46 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51605 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfCULaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:30:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2LBUNad107530
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 21 Mar 2019 04:30:23 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2LBUMpR107527;
        Thu, 21 Mar 2019 04:30:22 -0700
Date:   Thu, 21 Mar 2019 04:30:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kangjie Lu <tipbot@zytor.com>
Message-ID: <tip-534c89c22e26b183d838294f0937ee092c82ad3a@git.kernel.org>
Cc:     sashal@kernel.org, mojha@codeaurora.org, hpa@zytor.com,
        kys@microsoft.com, sthemmin@microsoft.com, kjlu@umn.edu,
        linux-kernel@vger.kernel.org, mingo@kernel.org, bp@alien8.de,
        tglx@linutronix.de, haiyangz@microsoft.com
Reply-To: tglx@linutronix.de, bp@alien8.de, haiyangz@microsoft.com,
          kjlu@umn.edu, linux-kernel@vger.kernel.org, mingo@kernel.org,
          mojha@codeaurora.org, hpa@zytor.com, kys@microsoft.com,
          sthemmin@microsoft.com, sashal@kernel.org
In-Reply-To: <20190314054651.1315-1-kjlu@umn.edu>
References: <20190314054651.1315-1-kjlu@umn.edu>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/hyperv: Prevent potential NULL pointer
 dereference
Git-Commit-ID: 534c89c22e26b183d838294f0937ee092c82ad3a
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

Commit-ID:  534c89c22e26b183d838294f0937ee092c82ad3a
Gitweb:     https://git.kernel.org/tip/534c89c22e26b183d838294f0937ee092c82ad3a
Author:     Kangjie Lu <kjlu@umn.edu>
AuthorDate: Thu, 14 Mar 2019 00:46:51 -0500
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Thu, 21 Mar 2019 12:24:39 +0100

x86/hyperv: Prevent potential NULL pointer dereference

The page allocation in hv_cpu_init() can fail, but the code does not
have a check for that.

Add a check and return -ENOMEM when the allocation fails.

[ tglx: Massaged changelog ]

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Acked-by: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: pakki001@umn.edu
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-hyperv@vger.kernel.org
Link: https://lkml.kernel.org/r/20190314054651.1315-1-kjlu@umn.edu

---
 arch/x86/hyperv/hv_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6461a16b4559..e4ba467a9fc6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -103,9 +103,13 @@ static int hv_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	struct hv_vp_assist_page **hvp = &hv_vp_assist_page[smp_processor_id()];
 	void **input_arg;
+	struct page *pg;
 
 	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
-	*input_arg = page_address(alloc_page(GFP_KERNEL));
+	pg = alloc_page(GFP_KERNEL);
+	if (unlikely(!pg))
+		return -ENOMEM;
+	*input_arg = page_address(pg);
 
 	hv_get_vp_index(msr_vp_index);
 
