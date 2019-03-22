Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1F9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A11521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 03:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGLjy0IG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfCVDhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 23:37:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37081 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCVDhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 23:37:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id q206so518222pgq.4;
        Thu, 21 Mar 2019 20:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Zpd68iHF+h74ftS2xRlX/CcDN+gZBWzsxg/Xi8TxCoE=;
        b=eGLjy0IGplxrYvynOzxuaLoj1UUDr8kxTtpyIrTfv3Z8AczC2WssFw2ifVRQL1Wn0r
         MAEm77ibdHXtksT5f5sIVLfxif5NGrAmJBZgCq7NGlY5JWB8SaCJVLXXJifK/KDVtwVs
         j/F1GRiNf03TF3JXkCODDFznoLlfVT4N3pAw3NhOJKC6mVrruXt51cKOzRlkZNu6TRUO
         4n91vYGtI69kErEKYqd3tTmFS74JxZ/HStioE8Nr0fcBX3IKcetpPslwsGVJJe62pXKt
         Aj1cfGo3HcyKvn7O9FRw/hvL+VPbOC1TGqohsf62C6PaQKFQc1kImgovjZNMjaC2MoJF
         ko9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Zpd68iHF+h74ftS2xRlX/CcDN+gZBWzsxg/Xi8TxCoE=;
        b=IrOy/X5GlXbYTnsCfIYDeF25/7DI/SWTF9nc4Buh1Nrhcf/oKNiG2KgQpuEXE7siQL
         m86w2wMVGWOQz0oY0bJDVRNfB9oMmMUVrKGHMZIJQJrew79BfrjbwYOr3g0sTNNNUefB
         JYhaqCZuRrUeSBvmBNyY6Lws9t8vQip2pbM2btaMlZZbzBnxwXx6Z+rIy7Ag5F4zJcdq
         7JT+00b4sYn0xZM2quufpJ7mVJYnC0OlNEwYTWDuKoePW3cu0eOr2RFaRro5Ts1bGRzG
         wFWRD8REJrxJjFcBILTBp2JSx0+EzLkSk6Vf3uJ3tVlYi51LnaT8OFI7qhPxK5MQE0FT
         8i6Q==
X-Gm-Message-State: APjAAAXeHYGyiUl30WyTg/0c35Pwmx7vGd4h0WWtfNl5mGvxWHlU4rkR
        C3p1CiCq0FZF1UVOL/204So=
X-Google-Smtp-Source: APXvYqxcrrTKv+pq+7qzPGEOlwIcvxh2A8kWfaTpW7Iyq+Rae7B9TF01w7MPN7tiyCdNaelKlbhP9g==
X-Received: by 2002:a17:902:848f:: with SMTP id c15mr7228852plo.240.1553225836874;
        Thu, 21 Mar 2019 20:37:16 -0700 (PDT)
Received: from localhost (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id y26sm7520627pfe.93.2019.03.21.20.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 20:37:16 -0700 (PDT)
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
X-Google-Original-From: "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
To:     wim@linux-watchdog.orgw, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
Subject: [PATCH V1 1/1] watchdog: f71808e_wdt: fix F81866 bit operation
Date:   Fri, 22 Mar 2019 11:36:56 +0800
Message-Id: <1553225816-24375-1-git-send-email-hpeter+linux_kernel@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error bit operation in watchdog_start()

Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
---
 drivers/watchdog/f71808e_wdt.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/watchdog/f71808e_wdt.c b/drivers/watchdog/f71808e_wdt.c
index 9a1c761258ce..9129485732c7 100644
--- a/drivers/watchdog/f71808e_wdt.c
+++ b/drivers/watchdog/f71808e_wdt.c
@@ -387,18 +387,17 @@ static int watchdog_start(void)
 
 	case f81866:
 		/* Set pin 70 to WDTRST# */
-		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
-				  BIT(3) | BIT(0));
-		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL,
-				BIT(2));
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 3);
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 0);
+		superio_set_bit(watchdog.sioaddr, SIO_F81866_REG_PORT_SEL, 2);
+
 		/*
 		 * GPIO1 Control Register when 27h BIT3:2 = 01 & BIT0 = 0.
 		 * The PIN 70(GPIO15/WDTRST) is controlled by 2Ch:
 		 *     BIT5: 0 -> WDTRST#
 		 *           1 -> GPIO15
 		 */
-		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1,
-				  BIT(5));
+		superio_clear_bit(watchdog.sioaddr, SIO_F81866_REG_GPIO1, 5);
 		break;
 
 	default:
-- 
2.7.4

