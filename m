Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4184EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A1420848
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 06:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asRGrqpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfERGfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 02:35:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39392 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbfERGfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 02:35:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id z26so4736291pfg.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 23:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mnwK63y6Dxz7mIJI05T7x97DYFRtJ17NMuTrKIc014M=;
        b=asRGrqpWpdfE+Rc7WtUKB1pcF8teYsALgNKT7TQGybNVqxUP2MmEJceB/zBt/+GeZM
         jYPOzwVuv6N+NgDdtssYNO/zekixpzX4ZytS+5+ggzC0oqUMVdrDwhqSpsdGHT9mGT65
         id5r71CCO6lQW43uiu6ce6gwOe9vq4TGaNLeMtlQ8kLOA4fuH3loWS0n7gkRpBC51iPp
         3P8oiqbomgexqc0jxHYxSLhNfvkJkqVShUgEfa/za74A6006zXFwTprRGxNXqyH/ehU/
         FgU/aml4uEfT3l6fNyM84l2Z+kBhlmW/8KuRvSVV9gJAH+su+MH2D5cSGhtnJWBaA0x2
         EkXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mnwK63y6Dxz7mIJI05T7x97DYFRtJ17NMuTrKIc014M=;
        b=A+l+m4ea5/dUG4sxH4kVxdkETUtsvHWh2KDqxj5mwZOzclki02isnqmP8stsH3EYc6
         ZvfGNTHHujfeLWjlCI7efbhTsZZN14ysFUu8XJMfT2mNrv9vWbQEkrCZc6c/W4SEvmoG
         YUhNTBqVOWeRbZbXRTFLj2VHe1lMON5dzP3yr8SWAgjFkLbHg011VpaE3Cic/h7G0540
         rWAiL1xzFOnxieSJgaTmUI0W/CGMTMnw12VXZd7BUk8n15nD8PXU6/OEOpSnAp1czQAO
         969qfWvQtqeJfBB2I0hpstUuZNIAjragB8wcVTLK3vZetVd+lTc45b2qr5am+KHQgiIO
         7ifQ==
X-Gm-Message-State: APjAAAU3vBMfwT0Gnv6MEzkHm0BBx0EdxU/Aa0V2HboFM6DGbrCZJa5R
        CsG5x2BM7Lmtj0c1fyEN+Nk=
X-Google-Smtp-Source: APXvYqzy0dU1DJkuJies9x8QhHTMqulFVzTwRJrsGIDL21neEEQGcysLNHo1CtlvbkWmKfh15z+Jhg==
X-Received: by 2002:a63:903:: with SMTP id 3mr48670314pgj.400.1558161300803;
        Fri, 17 May 2019 23:35:00 -0700 (PDT)
Received: from localhost.localdomain ([103.227.98.84])
        by smtp.googlemail.com with ESMTPSA id h26sm14347874pgh.26.2019.05.17.23.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 23:35:00 -0700 (PDT)
From:   Moses Christopher <moseschristopherb@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, david.kershner@unisys.com,
        forest@alittletooquiet.net, davem@davemloft.net,
        ruxandra.radulescu@nxp.com, yangbo.lu@nxp.com, arnd@arndb.de,
        christian.gromm@microchip.com, insafonov@gmail.com,
        hdegoede@redhat.com, devel@driverdev.osuosl.org,
        sparmaintainer@unisys.com,
        Moses Christopher <moseschristopherb@gmail.com>
Subject: [PATCH v1 5/6] staging: rtl8723bs: use help instead of ---help--- in Kconfig
Date:   Sat, 18 May 2019 12:03:40 +0530
Message-Id: <20190518063341.11178-6-moseschristopherb@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518063341.11178-1-moseschristopherb@gmail.com>
References: <20190518063341.11178-1-moseschristopherb@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  - Resolve the following warning from the Kconfig,
    "WARNING: prefer 'help' over '---help---' for new help texts"

Signed-off-by: Moses Christopher <moseschristopherb@gmail.com>
---
 drivers/staging/rtl8723bs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/Kconfig b/drivers/staging/rtl8723bs/Kconfig
index 744091d46f4c..a88467334dac 100644
--- a/drivers/staging/rtl8723bs/Kconfig
+++ b/drivers/staging/rtl8723bs/Kconfig
@@ -5,7 +5,7 @@ config RTL8723BS
 	depends on m
 	select WIRELESS_EXT
 	select WEXT_PRIV
-	---help---
+	help
 	This option enables support for RTL8723BS SDIO drivers, such as
 	the wifi found on the 1st gen Intel Compute Stick, the CHIP
 	and many other Intel Atom and ARM based devices.
-- 
2.17.1

