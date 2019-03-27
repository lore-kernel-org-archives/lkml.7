Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C16C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163D72075D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 06:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzDZu/ub"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfC0GnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 02:43:06 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44033 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387512AbfC0GnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 02:43:02 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so2855120pll.11;
        Tue, 26 Mar 2019 23:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frjGhiJJMFqcB474kkUxeMS2hJxQyCfF39S1eqNxpTQ=;
        b=mzDZu/ub2HSd6X7sfIOFmlSHGCqLc4jd/rR57ZokZ+uA2VSlhFZychlwimZ1kf1Xb+
         j9dMQ9BdupPpmP82htNH+4oA4a7yzBBGf3rSGQCSEGwnTTUnHTsLdrZ4SsEvRazIT7ol
         1nb3oQYXbcUI2+TGX4/n1YR6Uq+7JlYygloSknjDY5Z0JxDJJmnfvae0qCUpHdHimejf
         vqNCsxA/A3+8Qs7rB+e6BuJXmsmTYS7PAdOIlF4PTYRZDBAnDzOB1tz13Jxiaxj3enHI
         UQ/GhRsegLIN6frCiH+nGj7M7hMewuKTrJ15OE0MWuNlSFlV1pzDsHZwsTTvER2LC60o
         qVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frjGhiJJMFqcB474kkUxeMS2hJxQyCfF39S1eqNxpTQ=;
        b=GgtY/BDX/ucC2fiGKRvy2clb7fEmSgbeaD0M3NniRcSsLEzJ9siFD5dMEoRymMqOVN
         7rtPmh04zCfvVpQDxRGMZZBiIYeNooUpS0sYf52lZcsE9daUhT8gATMsBb7fQ627iK/P
         iMYBvLHX8d0TwczJff5ty7OVqs2cIHA08q9UcuEXahhPogA3qnF4ZgURtiNO7ypivykL
         ujt0ByOKr0cD2+mLZI9godEbrapaW55Rend1IXwaKrMlKGMDgsbA/FxxbRkdGlH8nU6L
         FVt2PuicvLm58CJTofzG+cnIjqZCfMGKmZK7hKkSeXv6lZ1Oe13IwORPtCho4KeSi5Uc
         PIDA==
X-Gm-Message-State: APjAAAXMxhWQ+JekHErzbIBFKbYeQ9hGmQ8d11yljoGh5iSFDDUeiowH
        TGRQ/DgJvCoLLl5yj++HfstINtNf
X-Google-Smtp-Source: APXvYqwVfAXa/CemrIQaOjV13PEghdOiD0MGo9ce0iyBVWNiODPUrvFvpgf/NdeYliFHqRXpOh4FpA==
X-Received: by 2002:a17:902:e60e:: with SMTP id cm14mr35333879plb.192.1553668981919;
        Tue, 26 Mar 2019 23:43:01 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id u13sm42836769pfa.169.2019.03.26.23.43.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 23:43:01 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     peter_hong@fintek.com.tw, wim@linux-watchdog.org,
        linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V2 2/2] watchdog: f71808e_wdt: fix F81866 bit operation
Date:   Wed, 27 Mar 2019 14:42:51 +0800
Message-Id: <1553668971-18801-2-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
References: <1553668971-18801-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error bit operation in watchdog_start()

Fixes: 14b24a88a3660 ("watchdog: f71808e_wdt: Add F81866 support")
Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index bd2ced9f39f4..afd1446241b3 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -339,6 +339,7 @@ static int f71862fg_pin_configure(unsigned short ioaddr)
 static int watchdog_start(void)
 {
 	int err;
+	u8 tmp;
 
 	/* Make sure we don't die as soon as the watchdog is enabled below */
 	err = watchdog_keepalive();
@@ -388,19 +389,18 @@ static int watchdog_start(void)
 		break;
 
 	case f81866:
-		/* Set pin 70 to WDTRST# */
-		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
-				  BIT(3) | BIT(0));
-		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
-				BIT(2));
 		/*
 		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
 		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
 		 *     BIT5: 0 -> WDTRST#
 		 *           1 -> GPIO15
 		 */
-		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
-				  BIT(5));
+		tmp = superio_inb(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL);
+		tmp &= ~(BIT(3) | BIT(0));
+		tmp |= BIT(2);
+		superio_outb(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, tmp);
+
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1, 5);
 		break;
 
 	default:
-- 
2.7.4

