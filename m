Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7735AC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B3820661
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 13:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552050509;
	bh=HcAQ9KReJXHtSCy5A8LE+albqNexo90n5h1gWpgOZBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wxESKm/Lxqi/6ASjZF0crp7/iX05XPawurIo/etNqA59k0NloxfHzIkb/C7PibCZO
	 qu8gQa2KmryY4iLaiPJzxBYN+1znXJc4pK5nv0BPa49M/iDiDGfPdHK8cnDdq61Oym
	 L2kU0pukMpx0CB/sXWN4uboBFfhe8uCNXWx1En3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfCHNI2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 08:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726640AbfCHMxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:53:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A61862087C;
        Fri,  8 Mar 2019 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049580;
        bh=HcAQ9KReJXHtSCy5A8LE+albqNexo90n5h1gWpgOZBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t76qVD1/urNTpDznvFIBgnJeloQbjd6Id/6GIEu0F1dobMZhE4RgbOEP/mt331NJy
         B3IBkylmTKtAJ8jA0+s6RTyoRF3/56b4r7gEObKYoRKhnKzLPbnez+HdZNdD9ZKM5v
         FjtK7FdnFs846Ti14EP2UiCLDa7xU27Aw3VA+TUg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Xiang <liu.xiang6@zte.com.cn>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org
Subject: [PATCH 5.0 36/46] MIPS: irq: Allocate accurate order pages for irq stack
Date:   Fri,  8 Mar 2019 13:50:09 +0100
Message-Id: <20190308124904.584345584@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124902.257040783@linuxfoundation.org>
References: <20190308124902.257040783@linuxfoundation.org>
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


