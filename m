Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153B6ECE588
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04652086A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 14:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZXZGHlL6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733086AbfJOOv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 10:51:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34023 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732956AbfJOOvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:51:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id j11so24274558wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 07:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sOwxqSgHZxMZdu9ssMgHTsDS+mnGgiLSMmbVloE6vbY=;
        b=ZXZGHlL63ydImQPyc4zgxHXLABtnTrA0ujmNUW/5fSN9oX2fgDJSdZct1rKiZq7U6w
         qK7ocDo8F6PsS3WS/8igClWmBijsp9y4xSSGTu2SDlfrwYyfYIHS8JSOqblUoAmiR65+
         lnvQvkShhanpn9Zi6Yl+6rkavRryE3gcMiUXT/irG7lJavQQr8AeLFoavXaFugKAvE8B
         /UzwRDzUCjBeORDi/EQ7rvWvuw5xQp9ytTFZhRMLxGNLfTlc30zm28e1cFAVH30R4xlr
         QIBVMzo5EwnXWkwhWgqcRGuEJeXdcq0BbrQ2zk0S9iLZuQJQhaWm98vxgoH5M+UfEmrs
         FG/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sOwxqSgHZxMZdu9ssMgHTsDS+mnGgiLSMmbVloE6vbY=;
        b=IT/V+lG0BqGGfZACqthot/y8L84uyHRRuqlpKaKWJZ7G78NW0ZBO5kod7KkgzpBZd0
         xzlgJO4SPnuIXEgbsexp8JZ7YRmEuXaXsc4kGJavO2vIRSbPZS6y6u9R8voVR1f8RuYQ
         VEGt1r5wDVw6bktQ8OnUp/FffTh05EiwMW9fkYiAYaGYVhRmr5W9nLPyvCFPsduTWgRr
         Dua1AL1HZLVS4dE8+wCrKbMP1x7VHoMhoLMVhxnHn1AiYt8dKEgyb1HbCqlmHiWZUVES
         QMSM1FGBTQGda3iZEIvfSrsdGzJSSPkw5Py6yc1VL9JBYX6tIH3Owe0hvTqp0OfzVJHR
         TM7w==
X-Gm-Message-State: APjAAAUeUd4VIA87abYIsm3h681ijegPgYbpRl9za9ZfKIMDS5xhYN/L
        S6rOozS/SyQTCcNWL8pkqPZshTLQ
X-Google-Smtp-Source: APXvYqz/BdsRzyqG3XrQgmIgTu/QqiScZaC1zr9bB3ppKgDcu54YcJ7GSRiIiKWZTmmy2eliI4ExaQ==
X-Received: by 2002:adf:a497:: with SMTP id g23mr14202920wrb.135.1571151112765;
        Tue, 15 Oct 2019 07:51:52 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id n18sm19111771wmi.20.2019.10.15.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 07:51:51 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Russell King <linux@armlinux.org.uk>, arm@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] ARM: prima2: Register with kernel restart handler
Date:   Tue, 15 Oct 2019 16:51:42 +0200
Message-Id: <20191015145147.1106247-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015145147.1106247-1-thierry.reding@gmail.com>
References: <20191015145147.1106247-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Register with kernel restart handler instead of setting arm_pm_restart
directly. By doing this, the prima2 reset handler can be prioritized
among other restart methods available on a particular board.

Select a high priority of 192 since the original code overwrites the
default arm restart handler.

Acked-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/mach-prima2/rstc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-prima2/rstc.c b/arch/arm/mach-prima2/rstc.c
index 9d56606ac87f..825dd5fcc37b 100644
--- a/arch/arm/mach-prima2/rstc.c
+++ b/arch/arm/mach-prima2/rstc.c
@@ -64,11 +64,18 @@ static struct reset_controller_dev sirfsoc_reset_controller = {
 
 #define SIRFSOC_SYS_RST_BIT  BIT(31)
 
-static void sirfsoc_restart(enum reboot_mode mode, const char *cmd)
+static int sirfsoc_restart(struct notifier_block *nb, unsigned long action,
+			   void *data)
 {
 	writel(SIRFSOC_SYS_RST_BIT, sirfsoc_rstc_base);
+	return NOTIFY_DONE;
 }
 
+static struct notifier_block sirfsoc_restart_nb = {
+	.notifier_call  = sirfsoc_restart,
+	.priority       = 192,
+};
+
 static int sirfsoc_rstc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -79,7 +86,7 @@ static int sirfsoc_rstc_probe(struct platform_device *pdev)
 	}
 
 	sirfsoc_reset_controller.of_node = np;
-	arm_pm_restart = sirfsoc_restart;
+	register_restart_handler(&sirfsoc_restart_nb);
 
 	if (IS_ENABLED(CONFIG_RESET_CONTROLLER))
 		reset_controller_register(&sirfsoc_reset_controller);
-- 
2.23.0

