Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8481EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5057F213F2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 20:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6s9im/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbfCSUUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 16:20:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38588 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfCSUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 16:20:00 -0400
Received: by mail-lj1-f194.google.com with SMTP id x13so250878ljj.5;
        Tue, 19 Mar 2019 13:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAp0KuCd+VwXHGjzKhbOPSvfhdsI4XdE3B+BZLnU0mk=;
        b=j6s9im/uW0PjIPrC7LisBb4yt4hAP9QE0ccseZ//LilK2ZfaIxgGcC8Tgobaztjlln
         Nyi9NePlyThsQ4U3Ie6sjGo0+OklAqXc21M1zUbC10pqUIhlqCA7S07H/qMdD5egUjk0
         nNN9BzCUvIKsVdPUBn81Bkn69N3nmmlSYUjQjccWbG9Q38tlLjIGdnZZK+bXY1ZPon7I
         L0wGnqXiPWcMRjFQr9z0NOW7AMQc2/18EQqQBE2k6IlSmkIvmlTiW/i2UZ8Ide6BEX6V
         T0L/zZAP16pUdtHOjs0zJDd4A/JW+cbdoKn5wueQhFC4AMKznsPxS5yA3HSeCsYzHpyw
         7ohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QAp0KuCd+VwXHGjzKhbOPSvfhdsI4XdE3B+BZLnU0mk=;
        b=Nlf79ZwyNn3KpJFpG8MqD5FA1a3up3jDdu9DQgI2Hz4v8FEsRpQYteFv3qVvKLqOlN
         Qka6XX6D7AAUwzYA4eNoCGTXU22EyUkLTRzdaS6u1J1SPt1d1UQSzebtg0ibJRuaXnEg
         QcCE84/6RaxRF7NY3q9g3RxkfvWMC8QsIgDjVyHh2Txpr9i9y3XQ9xJpo9HzT839828c
         d9sGqqzxVgKvB0pXRm731UeRr8iC7mIZeY1fcjZqQn2Gs9EP8Y//s5Di312+jt6cCHId
         o3yjBMuOJtvcQtE0AqXhL3l/nuF/H+eJiccuTbj7GCAWWhjkZVICVm6tMBE40b1pPSZQ
         2EJA==
X-Gm-Message-State: APjAAAV72EM0i/U1TMyClw3NxZm4rG9YoGD4UdBA5LVW4TcE253mo+kS
        +gUO0iE+0Qxqvhf2a4nqWhI=
X-Google-Smtp-Source: APXvYqygDDUfXYqH+4ugtLxN68Uudfb9H3IzyKHm/PL3yUCwrxxR86FDcwIcbV7LqN/S4wCBQg8TgA==
X-Received: by 2002:a2e:899a:: with SMTP id c26mr13444322lji.192.1553026798116;
        Tue, 19 Mar 2019 13:19:58 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id i24sm2864410lfl.73.2019.03.19.13.19.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 13:19:57 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        stable@vger.kernel.org
Subject: [PATCH] ARM: OMAP1: ams-delta: Fix broken GPIO ID allocation
Date:   Tue, 19 Mar 2019 21:19:52 +0100
Message-Id: <20190319201952.1309-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to request dynamic allocationn of GPIO IDs, a negative number
should be passed as a base GPIO ID via platform data.  Unfortuntely,
commit 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global
GPIO numbers") didn't follow that rule while switching to dynamically
allocated GPIO IDs for Amstrad Delta latches, making their IDs
overlapping with those already assigned to OMAP GPIO devices.  Fix it.

Fixes: 771e53c4d1a1 ("ARM: OMAP1: ams-delta: Drop board specific global GPIO numbers")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/arm/mach-omap1/board-ams-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index be30c3c061b4..1b15d593837e 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -182,6 +182,7 @@ static struct resource latch1_resources[] = {
 
 static struct bgpio_pdata latch1_pdata = {
 	.label	= LATCH1_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH1_NGPIO,
 };
 
@@ -219,6 +220,7 @@ static struct resource latch2_resources[] = {
 
 static struct bgpio_pdata latch2_pdata = {
 	.label	= LATCH2_LABEL,
+	.base	= -1,
 	.ngpio	= LATCH2_NGPIO,
 };
 
-- 
2.19.2

