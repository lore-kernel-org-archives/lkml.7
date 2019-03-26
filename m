Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C63CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377942086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582306;
	bh=MIWFpi4T1Wo5YerruYS2bRgHn2nT/C4s1/17QpGVbg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p7I2G8SLNvWcxvjfxJNc32g6+1qfTxsQE7rOBrK9LfsZZI2ra2yj7TZIZFNKoTsV0
	 2xyYCLoEWbYjQ7nooGnXDPd+52V6/7SJ/C9ePEXYh2D3d7nTiJAsAXQNdUg+8KyMjZ
	 VQw7+U0jMdJig2Rn9CRJZ/K+Gm5EHXhagnwpaR64=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732197AbfCZGiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732519AbfCZGiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:38:21 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5BA42070B;
        Tue, 26 Mar 2019 06:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582300;
        bh=MIWFpi4T1Wo5YerruYS2bRgHn2nT/C4s1/17QpGVbg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXADpNy43RA9ReW8qjxWEL/1XDXQXzO33PDEyL5wQBeOcNiSRjcnxCTX17EanNg2D
         kjZwFNlTEJdPIB0dVMwg7lZuM8HgvymLsCnBTXxVj6Ynko9kZt8x5Qb9Sqfkn3FVP6
         t/YvRRu/JoGBbIsWE8QnYLbluSccosr3JtNEdtLs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yifeng Li <tomli@tomli.me>,
        Paul Burton <paul.burton@mips.com>, linux-mips@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 5.0 14/52] mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.
Date:   Tue, 26 Mar 2019 15:30:01 +0900
Message-Id: <20190326042701.634116895@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042700.963224437@linuxfoundation.org>
References: <20190326042700.963224437@linuxfoundation.org>
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


