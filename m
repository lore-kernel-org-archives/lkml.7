Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EFBC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3472721744
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 04:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Za5I32pq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfHYECk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 00:02:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55482 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfHYECi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 00:02:38 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so12346173wmf.5;
        Sat, 24 Aug 2019 21:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VN2qLUPJ6VKX1aGIcYVhw809Zd7AJNllVKXjslGw4q8=;
        b=Za5I32pq80QeFA2QlN9eNKTZqMy9Qq+vvcZe1pjeZeVPbi+hviAcNBkYso27Y/MR2w
         7uOIlNBNpassE2uey3INI3QPwcqkDYcQB7MKtV2yDT04Yo+3hHKvVb+z2uAFJyP+NEXQ
         kJ0E+sBtK/ejAjxNZ8KbgHKKzsKWepT+aZEhdW/pyN6L730ApJ7A+CwHo3zaLk5Jyb6q
         /eJqJp2BJvM94F44X/oH/gRhoWS93g/sKhMv6RGir/BkTgb1kaVJAsR3NSw+ffVoLUyh
         /m1x4nPrNL7vEW04O2CAcLqldC6R+AZAWybCvetqE7qhOs00gkPNLnn3obziGzOfCzHN
         3knQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VN2qLUPJ6VKX1aGIcYVhw809Zd7AJNllVKXjslGw4q8=;
        b=XYP7G8wNwuyZr99Adxf3p0hn5xG43JZDk80MePN2VuvHRtORoynijFm/xrFBhrlKlm
         VU+o9ZeJ2jom7OL9sjqYoYTmuIPmABRt9oUvGrzxr6evjStFd5E+vBD2vBLKj/iJKnfL
         68ySrRcu/RYJcV2lYP3+/h2Fn9GK+emmdJbCtTWgMLA7N0wqjVJMZ91stuoQOIcHXyv2
         KeMLBWYwvLCYedFW1dBmuIRPyLboca+DYX4+DQzazgUB7Z79n8wILrWyESiZgd26iY71
         nj1yHB+Va9J0cGc9pPA4UlEpVL3JK/pCcZ0jkmKLYbyZn7NpD1U9M7i9BWz+s8Q4r9Z8
         ncIw==
X-Gm-Message-State: APjAAAXPtGhAori7D1zK/ftY26PP4StEgWuyrXbePHL4Ss+yi9d8jdSY
        BAIwGXWgpI4vNm73UBlnUNs=
X-Google-Smtp-Source: APXvYqwE8fQkbgsLZou7MaC4xJa1Tgjho5p7QMokyP/C75xx69LIUugw3ZFA2aH0SNV6nB5N6/xdEg==
X-Received: by 2002:a7b:cf11:: with SMTP id l17mr13425743wmg.158.1566705756007;
        Sat, 24 Aug 2019 21:02:36 -0700 (PDT)
Received: from localhost.localdomain ([94.204.252.234])
        by smtp.gmail.com with ESMTPSA id a6sm6820985wmj.15.2019.08.24.21.02.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 24 Aug 2019 21:02:35 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Chrisitian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 7/7] arm64: dts: meson-gxm-khadas-vim2: use rc-khadas keymap
Date:   Sun, 25 Aug 2019 08:01:28 +0400
Message-Id: <1566705688-18442-8-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
References: <1566705688-18442-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Swap to the rc-khadas keymap that maps the mouse button to KEY_MUTE.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index 989d33a..f25ddd1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -299,7 +299,7 @@
 	status = "okay";
 	pinctrl-0 = <&remote_input_ao_pins>;
 	pinctrl-names = "default";
-	linux,rc-map-name = "rc-geekbox";
+	linux,rc-map-name = "rc-khadas";
 };
 
 &pwm_AO_ab {
-- 
2.7.4

