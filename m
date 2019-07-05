Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F91C46499
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE42089C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 18:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="UJ+MQXfQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfGESaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jul 2019 14:30:12 -0400
Received: from mout.web.de ([212.227.15.14]:33947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbfGESaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jul 2019 14:30:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562351409;
        bh=oRoF4Y67u/o/9d4l2z4cNBxWdD6InCu64bqMKeG6WWM=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=UJ+MQXfQwFfrmYAnQrolKd06Vtjn0mZjXhIjW2M3WtsIRCOmOX7UcGz41of1gWgCq
         mPrKY86nqDYcbpWIiU7NxIyLDYcbhECLvsyUGKGdM1CAJWY5Er+kbmzQj6hVVLBbya
         VOeuklt3ZTc4ZDGMfyH7i8f/M2h3A0TrDNjQ0KIw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.45.164]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOlTq-1hdOQZ0aZC-0066z9; Fri, 05
 Jul 2019 20:30:09 +0200
To:     kernel-janitors@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] mfd: asic3: One function call less in asic3_irq_probe()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <01f6a8cd-0205-8d34-2aa3-e4b691e7eb95@web.de>
Date:   Fri, 5 Jul 2019 20:30:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbt4yYAA0X7TNULvX7YmfR5oUpqCLYcFsj3HN26gKSQcZqfZV+c
 kRQfhB4exsxm7uxNaR8by+7VZa7SMxAB2OCqWsA37VyeUQ3RuzH8L+jz18H91mCUokUpV+K
 r+Zmh0jkIkFznV2eozw02cISFRECME1G8oDsXVxCaIIVF2QYU7d+ERXHwK/Fcu+WK1EOAiP
 TI8cj7yEHZ0PzNr6NmFfg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bzI/iKHb63g=:JxlnzrFaoSzg4OGBkTH0gy
 /GLv9SuYEYmlHgUw9TpWs3L6TyGw0lX5QsH1Xg5uqXbYTOFVjtgeuE0dD8t9uYSO6n10xZd+B
 xCqDxfu7JxuoyY6o558y39m4AoHWi16NTvajC2Y3i+VeETF0/2kOWIO0JfmicYj8XNlJPN55h
 6HBzaKOAYs4PMdjhde0ywJWEBB+vG4M1ZEH1SNnHGm5Yl3Tx7ar+FYMXRGHvmzdEyMnEjVSBc
 azIsb1VTCoxnzvbAmGUFIYYW44jF/JlXkrmDACmMG8/AD2L14lIVMJ4sqL1Rw4pNod4dFWOHW
 ZlAOMt6I951cnBCdt/funhakGTO0T0oQ5HyR+Wk36VUCdqZz64rSsq9QjNfSJdWcTKY/d57pm
 BlkxkMgO2OzlQbuL5VC4Va9RmpqNTYeDcZrXw5e3bNdL8/hO4qz1XC6tUu/iCcW+XvaYrGh9/
 hXoxGPtAtfb5N2MXeyS45HT6OnLtCA7+/E72irqvDg0kqoMwqiglpeWcYxH1SqqfKqyq0E/vJ
 RO7T7fWJTDHCoHkzffzaqzHrGhPqbeQoeQ58dVd1DAl/mTtvm7Ue6nCR40/JSIUVBuWyXFTy3
 Cudv1SfSGmjnVsMrTUbwv2QRHpMLRsmOfwRuk9CgUrstKwJaUm2c/YTrEhS9IV6QzUtxLu3pB
 8EbhC2WoIKAwtQOzLQKwOtS1FlchKWUxtiAs9wq9qurvE+lU96YgypfsJrVQDJfd1nAXmRvvX
 67tSbzEudCy6SsLFJMOtXzeA3Uta6kQlkj6Qi2lMOQeLjfyILawOkG06xnmSJfQn6q85Jvkyz
 KY7NnSCTIsf3/5hLygMV1hJQcxEHRfDIFZMU0a1hUd3wtml/S7mFssj3XVpZlflO7u3VXtiNx
 m/KbS2t3jtnQGtokOm0dtcbNBQo79JOJOe2hPKU9/a6eAUqLZpLQe54J1JuramfTM3mOo01uD
 tIpgizXIW2FWDfTzKadyxYXB4cVb3j5EuEs7B/NDBTc6fcWUOSTABAJdtYb0YH0nWye9RE4wz
 LVgoXDbw7OKVaHfw2BkpiTw7QsL/6WsQx7rNea5KwbAtDVksqBwSbjmBXxFIK2znjM8s+9+50
 +nH/qKIlYWY3O5D1MFnZc0Rqxfo0D2zHLne
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 5 Jul 2019 20:22:26 +0200

Avoid an extra function call by using a ternary operator instead of
a conditional statement.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mfd/asic3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/asic3.c b/drivers/mfd/asic3.c
index 83b18c998d6f..50f5368fb170 100644
=2D-- a/drivers/mfd/asic3.c
+++ b/drivers/mfd/asic3.c
@@ -401,11 +401,10 @@ static int __init asic3_irq_probe(struct platform_de=
vice *pdev)
 	irq_base =3D asic->irq_base;

 	for (irq =3D irq_base; irq < irq_base + ASIC3_NR_IRQS; irq++) {
-		if (irq < asic->irq_base + ASIC3_NUM_GPIOS)
-			irq_set_chip(irq, &asic3_gpio_irq_chip);
-		else
-			irq_set_chip(irq, &asic3_irq_chip);
-
+		irq_set_chip(irq,
+			     (irq < asic->irq_base + ASIC3_NUM_GPIOS)
+			     ? &asic3_gpio_irq_chip
+			     : &asic3_irq_chip);
 		irq_set_chip_data(irq, asic);
 		irq_set_handler(irq, handle_level_irq);
 		irq_clear_status_flags(irq, IRQ_NOREQUEST | IRQ_NOPROBE);
=2D-
2.22.0

