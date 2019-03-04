Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E013BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB80206DD
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="2EkGocQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfCDWAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:00:38 -0500
Received: from tomli.me ([153.92.126.73]:44100 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbfCDWAi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:00:38 -0500
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 94d04484;
        Mon, 4 Mar 2019 22:00:35 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:72f4:b31)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Mon, 04 Mar 2019 22:00:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:mime-version:content-transfer-encoding; s=1490979754; bh=uieIdADfuGnZgn/vvyEk/SEUq7QDCLA8JwWoh6XOsWk=; b=2EkGocQzGe0bGtC9WY5Z2e7uOGrZoC2Nc9i6mmD+UVEC/Ebe3Q+w1TqAk62ZHR100KQwGlNnWWuzU8y0AO0Odx6DfmYag2bO6RKwpttIRb2Kt4b9TuTJzk2/lSnu3aJ7Nv2VHYkc2EVUJ4In4Eh8kviemFy9BprUVDQXPTcTuFEby+yax0ClQRDlJbCHFGS7WRah2bsl7sJ9vjaiPZciTUmbIG2rVykOp0Dc9Ae8Q1vFc7i2esO9433HEg305SPNQdFDLMHuxIJfSkskvEy+WDixHI2iKVQoKw9t3qqKbVmRZwKX8gk4hvxXM6g4gswfxO+iNPElHehHu+eGL6FGHw==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-mips@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Yifeng Li <tomli@tomli.me>
Subject: [PATCH] mips: loongson64: lemote-2f: Add IRQF_NO_SUSPEND to "cascade" irqaction.
Date:   Tue,  5 Mar 2019 06:00:22 +0800
Message-Id: <20190304220022.20682-1-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Timekeeping IRQs from CS5536 MFGPT are routed to i8259, which then
triggers the "cascade" IRQ on MIPS CPU. Without IRQF_NO_SUSPEND in
cascade_irqaction, MFGPT interrupts will be masked in suspend mode,
and the machine would be unable to resume once suspended.

Previously, MIPS IRQs were not disabled properly, so the original
code appeared to work. Commit a3e6c1eff5 (MIPS: IRQ: Fix disable_irq
on CPU IRQs) uncovers the bug. To fix it, add IRQF_NO_SUSPEND to
cascade_irqaction.

This commit is functionally identical to 0add9c2f1cff ("MIPS:
Loongson-3: Add IRQF_NO_SUSPEND to Cascade irqaction"), but it forgot
to apply the same fix to Loongson2.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 arch/mips/loongson64/lemote-2f/irq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson64/lemote-2f/irq.c b/arch/mips/loongson64/lemote-2f/irq.c
index 9e33e45aa17c..b213cecb8e3a 100644
--- a/arch/mips/loongson64/lemote-2f/irq.c
+++ b/arch/mips/loongson64/lemote-2f/irq.c
@@ -103,7 +103,7 @@ static struct irqaction ip6_irqaction = {
 static struct irqaction cascade_irqaction = {
 	.handler = no_action,
 	.name = "cascade",
-	.flags = IRQF_NO_THREAD,
+	.flags = IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 };
 
 void __init mach_init_irq(void)
-- 
2.20.1

