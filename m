Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F9CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890DF20866
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582025;
	bh=wjFTetixX7mQL1O+pWsG91TjqIbGxV7uBpjFojrfueo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0Bf7ETl3Y4AAehsy4MBewTIp79PbVSnaWEhlYxDSDkrcwPug4yZ0c6+exjbZJK7/g
	 7pxdKHZGqZBNsTa3VDv83RYCppqEj2OXUdNmFCkUk0oIXTYowi+4VCURTrxGtl6Ed9
	 /v40cfcKdVl7kbarwmIMvY3rjC9tUV+d0ODIDVhY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731729AbfCZGdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:33:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731179AbfCZGdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:33:42 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B135D20857;
        Tue, 26 Mar 2019 06:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582021;
        bh=wjFTetixX7mQL1O+pWsG91TjqIbGxV7uBpjFojrfueo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SajrVh1+wFMRcKCI0pODELE/4tR+p7ty5pJq74k3Y3kP6FJD3B2pTJSHeEYln9PjJ
         htZ1UF1Jsj1TklGXspO6V+Fy3Cni65BZxYhuRDXgE0QPgf/rIhQn/hYQQb7XW4PrvK
         dkPeX3ba5xoiSOV7t1sQ0P2XtqfuDz9iwv6z5WYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 06/41] mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.
Date:   Tue, 26 Mar 2019 15:29:43 +0900
Message-Id: <20190326042650.194435365@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yifeng Li <tomli@tomli.me>

commit 5f5f67da9781770df0403269bc57d7aae608fecd upstream.

Timekeeping IRQs from CS5536 MFGPT are routed to i8259, which then
triggers the "cascade" IRQ on MIPS CPU. Without IRQF_NO_SUSPEND in
cascade_irqaction, MFGPT interrupts will be masked in suspend mode,
and the machine would be unable to resume once suspended.

Previously, MIPS IRQs were not disabled properly, so the original
code appeared to work. Commit a3e6c1eff5 ("MIPS: IRQ: Fix disable_irq on
CPU IRQs") uncovers the bug. To fix it, add IRQF_NO_SUSPEND to
cascade_irqaction.

This commit is functionally identical to 0add9c2f1cff ("MIPS:
Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction"), but it forgot
to apply the same fix to Loongson2.

Signed-off-by: Yifeng Li <tomli@tomli.me>
Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@vger.kernel.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: James Hogan <jhogan@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org # v3.19+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/lemote-2f/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/loongson64/lemote-2f/irq.c
+++ b/arch/mips/loongson64/lemote-2f/irq.c
@@ -103,7 +103,7 @@ static struct irqaction ip6_irqaction =
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
+	.flags = IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 };
 
 void __init mach_init_irq(void)


