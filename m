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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D582C04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12AA820872
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 15:24:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BtXqZsPg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfERPYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 11:24:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45164 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729849AbfERPYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 11:24:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so9961813wrq.12;
        Sat, 18 May 2019 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hGVC97kr/8/BngU9FjmbWaxR7LHVSKdzb8qIb3rfhLw=;
        b=BtXqZsPgI4WM70yIJTRcoOW/v1fHPTQ93blqEPfY62Z0eCoo1omvj12jxcouniHVav
         RWUwM8ayTu/1lelHgxgyVv/r3oNEOc80PvKVxuCHjdnBpDeDYklt51R5ttVrCYjW9wfy
         VBta0i3i+wa4GqaxtZGskmdJHQPoTLX4k4oAaghWp8yCaddmmJm5Ea5MqcX0iZIbYqxe
         cJ1lGMTQltgYA4KHE+Djl8LQl/X8Tz+IJs5WfJ6LrgPQRTJ7ztQHBaaEhYmOr5JH3q1P
         VWEjaCVhqAW5Fi1bRATi2/ScbR5HrO86rLKXlvxN68pNKXvBM/rnR/7GnmOFYghOr8Hd
         vUaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hGVC97kr/8/BngU9FjmbWaxR7LHVSKdzb8qIb3rfhLw=;
        b=Asz0xwt3naytOmQnfvWOW/imngOiEAHTykI9m5e2sSZY656bhS+KlZSJ15WvyQ2f5e
         X7aK7uFsjRn8b0tO11KbT8ViQZa+QFBrJU1E60K4uYxNFxTWKREp3sJ4cLj0N+x4ders
         BoHecfdjwUtIwXx4jIqN+ouVUc4/pjLjV4FyFQKxjReLHfBRwRbE89bxLafGt0TprqSJ
         dMe3McHwRV6hAQv5a5AXbCHnOazqHaROd2BDMz1jnI6uIB1TRdOadFsTxgNgZWZduELg
         32oyBGZqujHW2gNs8g5SjcyWv1KiiYCXsx2vOlEmfyS4SkW3sTWJm3t57YxjGfhk75+f
         Sm6g==
X-Gm-Message-State: APjAAAVMoQ8oRJ1nSZhWqerDeWBIKpj+5DMHeo3idWxD9ppw2i8JslhV
        oUtyWzMoxPIw+0BXwuieSFE=
X-Google-Smtp-Source: APXvYqxWCD6w353QbYqhVWkd+Dn2oVl6fxAxPkAkutmksHJUDijWPOUywy0u0pjrcZn1TcL3nbhdyg==
X-Received: by 2002:adf:cf0e:: with SMTP id o14mr3328031wrj.230.1558193046204;
        Sat, 18 May 2019 08:24:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id j190sm12934836wmb.19.2019.05.18.08.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 08:24:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/4] arm64: defconfig: enable sunxi watchdog
Date:   Sat, 18 May 2019 17:23:55 +0200
Message-Id: <20190518152355.11134-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190518152355.11134-1-peron.clem@gmail.com>
References: <20190518152355.11134-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SUNXI_WATCHDOG option is required to make the
watchdog available on Allwinner H6.

Enable this option as a module.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 4d583514258c..fc51dd4decb1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
 CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
+CONFIG_SUNXI_WATCHDOG=m
 CONFIG_IMX2_WDT=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.17.1

