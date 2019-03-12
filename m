Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6729DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A43206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552411748;
	bh=VbUpxJ5Bjyp2hpXQcTOEFyuAatquUd/vhoGhLMN3u6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ArXtYU8ig1RItQ4LymJvvi44njKDZhn4bWradObhvb180/utL8VRF0+mu/BnJJZB+
	 yIoDsykE0iIfa9mK4v41z/ORQQx8H+UBI3v4UF2aSkjRtQsLuctZ/vApWy1X8jyAe7
	 wA4/qcH2/9jsSGmp6qZvb5uG3BwJT0v/jrEgNpdk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbfCLR3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:29:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbfCLRR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:17:28 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 816D4217F5;
        Tue, 12 Mar 2019 17:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552411047;
        bh=VbUpxJ5Bjyp2hpXQcTOEFyuAatquUd/vhoGhLMN3u6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YzkHtWkWRGSBaUvXWNuuagsWuhDpB/SIxcQEbgkAzTgwOh7fM5RcW+6swBFD454oF
         v/R69BuJEOAqE0995yk0pKlWoEQsChHjE6nCWUi+4qAIBWTFPWHoUaOb6MbF2S4TTO
         bN6bYO6Yf/y7qhAFp4AWUjcYnaCNZZN6B8RIlNtY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Xiang <liu.xiang6@zte.com.cn>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 4.9 30/96] MIPS: irq: Allocate accurate order pages for irq stack
Date:   Tue, 12 Mar 2019 10:09:48 -0700
Message-Id: <20190312171036.781873559@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312171034.530434962@linuxfoundation.org>
References: <20190312171034.530434962@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Xiang <liu.xiang6@zte.com.cn>

commit 72faa7a773ca59336f3c889e878de81445c5a85c upstream.

The irq_pages is the number of pages for irq stack, but not the
order which is needed by __get_free_pages().
We can use get_order() to calculate the accurate order.

Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Fixes: fe8bd18ffea5 ("MIPS: Introduce irq_stack")
Cc: linux-mips@vger.kernel.org
Cc: stable@vger.kernel.org # v4.11+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/irq.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -52,6 +52,7 @@ asmlinkage void spurious_interrupt(void)
 void __init init_IRQ(void)
 {
 	int i;
+	unsigned int order = get_order(IRQ_STACK_SIZE);
 
 	for (i = 0; i < NR_IRQS; i++)
 		irq_set_noprobe(i);
@@ -62,8 +63,7 @@ void __init init_IRQ(void)
 	arch_init_irq();
 
 	for_each_possible_cpu(i) {
-		int irq_pages = IRQ_STACK_SIZE / PAGE_SIZE;
-		void *s = (void *)__get_free_pages(GFP_KERNEL, irq_pages);
+		void *s = (void *)__get_free_pages(GFP_KERNEL, order);
 
 		irq_stack[i] = s;
 		pr_debug("CPU%d IRQ stack at 0x%p - 0x%p\n", i,


