Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A3DDC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE08217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isK713ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390257AbfDRT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:58:50 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39474 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390190AbfDRT6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:58:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id l18so1530639pgj.6;
        Thu, 18 Apr 2019 12:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Dg22N7ij5CbFARw1/POY95wKTQwDv4ke41HQVemNXb0=;
        b=isK713otpnbCLzfyYP0C/L3CQGDivEgxsaQsNLJKL0LOP5j2LZQ55TosA655bgf6PU
         zPg89A27hwGa2tIdK9OwiKC05C1xC51XZEam1A4CWPhzydraLi0oy7R1yAYwVqzKYBLl
         hLaQ+KR8diIcxJt/+4OLQvspgp0aOXuAFWIbBR8cjCWOSiOIz6iDE11+D06uATslKbDE
         4WL8KelALI9n9BakzeTJDgKfyQ1NYPi8B9MpU6H4QiTjgMnOgWyQKLsXqAsbSrexWnek
         BNeGnr1KHohFWbxYeXBtt2I3g+L4ATaKgedtzqkI1bRRVrLqpGmuLyqJmUfZJDKE2XsD
         e9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=Dg22N7ij5CbFARw1/POY95wKTQwDv4ke41HQVemNXb0=;
        b=fiNB8GIVV0+iAFofKpzqgfNVLFSom3owfQQS4QcflJrXdjmTddzHWCW9BzbXesg5Ag
         nu+CtKppYL1ev7TxZBy1Y+xy6aJYs3PbcC1DeZlaZtp38q79iL5DhOOCoJ087V9sXjuL
         a5xbupuLvMoY5wHKK70udwllaoWPb3ncqCZ+oA2rezfDZYDLASeEENTNGncKiVnlr/JT
         VRLqsradtyoVd14hjtsbb70fIET+p6ZyCXmODCK8Ozu5eudAU/9agcAxzbpUjR6Tp3Ga
         rGwEw9tPYvNYXmiTQnlxfWL5QYKK3jU/ymzt/V53/jLtZ0/n6KSej/+QrIOLZegQBaD0
         lvug==
X-Gm-Message-State: APjAAAWCKt+tKPKvxn0mKHFnCcrxiHyUi7xRHRKA4/FwDNW4SZFYS5QW
        9Ec9wuqNJk0Wh5B1rRNAnwbnKQ4BN+A=
X-Google-Smtp-Source: APXvYqzdpywDRRWK/t1CrguxPsh3QuvMjM/1PBlC1eJQcZ9pAW6iwz4VRB6e4iZFShYWRIg6RJRx1w==
X-Received: by 2002:aa7:9a89:: with SMTP id w9mr90410001pfi.213.1555617510960;
        Thu, 18 Apr 2019 12:58:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 128sm3058432pgb.47.2019.04.18.12.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:58:30 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-pm@vger.kernel.org
Cc:     Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 5/6] hwmon: (npcm750-pwm-fan) Use devm_thermal_of_cooling_device_register
Date:   Thu, 18 Apr 2019 12:58:19 -0700
Message-Id: <1555617500-10862-6-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
References: <1555617500-10862-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_thermal_of_cooling_device_register() to register the cooling
device. As a side effect, this fixes a driver bug:
thermal_cooling_device_unregister() was not called on device removal.

Fixes: f1fd4a4db777 ("hwmon: Add NPCM7xx PWM and Fan driver")
Cc: Tomer Maimon <tmaimon77@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/npcm750-pwm-fan.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/npcm750-pwm-fan.c b/drivers/hwmon/npcm750-pwm-fan.c
index b3b907bdfb63..f24cc00caba9 100644
--- a/drivers/hwmon/npcm750-pwm-fan.c
+++ b/drivers/hwmon/npcm750-pwm-fan.c
@@ -864,10 +864,8 @@ static int npcm7xx_create_pwm_cooling(struct device *dev,
 	snprintf(cdev->name, THERMAL_NAME_LENGTH, "%pOFn%d", child,
 		 pwm_port);
 
-	cdev->tcdev = thermal_of_cooling_device_register(child,
-							 cdev->name,
-							 cdev,
-							 &npcm7xx_pwm_cool_ops);
+	cdev->tcdev = devm_thermal_of_cooling_device_register(dev, child,
+				cdev->name, cdev, &npcm7xx_pwm_cool_ops);
 	if (IS_ERR(cdev->tcdev))
 		return PTR_ERR(cdev->tcdev);
 
-- 
2.7.4

