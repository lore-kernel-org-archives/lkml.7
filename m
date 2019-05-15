Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420E4C04AB4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7A920862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 00:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MO0L1yuA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfEOAad (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 20:30:33 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.61.142]:38848 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726838AbfEOAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:32 -0400
Received: from mailhost.synopsys.com (dc8-mailhost2.synopsys.com [10.13.135.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 98629C0A74;
        Wed, 15 May 2019 00:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1557880222; bh=4Uok3nJEPZvjzWu786MUXGhW5I+RXAihVDhKrqpraSM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MO0L1yuAeVCJb8LJ/JMkMGL3IDUc9f+b2ft1UasnB9zCjzE/pctSfIV6la9jxUpqk
         ctcKo/Kkcq7G7NPrrCrk62eXOy3SgGjfOHGeuDYVeJxo0wVpBfMotMHnUl2fbZoDiG
         vfr8a5y+pMeDPr0K8NXdxUTjSu5R0keHtK4PBa1nWhKsa/Wywevb/73sGKdxjl0NLY
         HmQs6zqqJSKXOYq1DKvCQkbD5YjsKpayZKh9S6FH4QI7AUFQpeKBzEPJdPxsTk5uTy
         DXkY+u29aQ2wMWjlH/ZkKI1osXYtfJlPE68XNm98wYCcNFGpru03wjks3E8h8jCSs1
         io6ufqVh6GxSQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1DA85A0069;
        Wed, 15 May 2019 00:30:32 +0000 (UTC)
Received: from IN01WEHTCB.internal.synopsys.com (10.144.199.106) by
 us01wehtc1.internal.synopsys.com (10.12.239.235) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 14 May 2019 17:30:18 -0700
Received: from IN01WEHTCA.internal.synopsys.com (10.144.199.103) by
 IN01WEHTCB.internal.synopsys.com (10.144.199.105) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:14 +0530
Received: from vineetg-Latitude-E7450.internal.synopsys.com (10.13.182.230) by
 IN01WEHTCA.internal.synopsys.com (10.144.199.243) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 15 May 2019 06:00:26 +0530
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     <linux-snps-arc@lists.infradead.org>
CC:     <paltsev@snyopsys.com>, <linux-kernel@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH 7/9] ARC: mm: do_page_fault refactor #6: error handlers to use same pattern
Date:   Tue, 14 May 2019 17:29:34 -0700
Message-ID: <1557880176-24964-8-git-send-email-vgupta@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
References: <1557880176-24964-1-git-send-email-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.13.182.230]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 - up_read
 - if !user_mode
 - whatever error handling

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/mm/fault.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/arch/arc/mm/fault.c b/arch/arc/mm/fault.c
index c0a60aeb4abd..0e1a222a97ad 100644
--- a/arch/arc/mm/fault.c
+++ b/arch/arc/mm/fault.c
@@ -194,22 +194,21 @@ void do_page_fault(unsigned long address, struct pt_regs *regs)
 bad_area:
 	up_read(&mm->mmap_sem);
 
-	/* User mode accesses just cause a SIGSEGV */
-	if (user_mode(regs)) {
-		tsk->thread.fault_address = address;
-		force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
-		return;
-	}
+	if (!user_mode(regs))
+		goto no_context;
+
+	tsk->thread.fault_address = address;
+	force_sig_fault(SIGSEGV, si_code, (void __user *)address, tsk);
+	return;
 
 out_of_memory:
 	up_read(&mm->mmap_sem);
 
-	if (user_mode(regs)) {
-		pagefault_out_of_memory();
-		return;
-	}
+	if (!user_mode(regs))
+		goto no_context;
 
-	goto no_context;
+	pagefault_out_of_memory();
+	return;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
-- 
2.7.4

