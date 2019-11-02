Return-Path: <SRS0=TDlZ=Y2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA129CA9ED1
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140120679
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Nov 2019 12:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAEU5z4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfKBMEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 08:04:37 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55280 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbfKBMEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 08:04:36 -0400
Received: by mail-wm1-f67.google.com with SMTP id c12so7432393wml.4;
        Sat, 02 Nov 2019 05:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRF6soD2g7xvJ30XDDz/0MGN7A3BH2BkkuXZbRs4kCo=;
        b=aAEU5z4+aRVnyRNtP/pnpe3X94NWIZQKo0zfBG1bAX/c+4yZHpzsHaPfd1KlF+86qV
         A0MqAbVpTrEueiSxpGDOVq8z3k+p7RpbUZW/Z4hvd9glNMJyVKfruic3rSaifuqdgVQb
         Y5BchvHhEXjYY6NFqwWZu0cIXLwZuCGSFw1YaQV6uH7TP43efer2CVYUBwK80QXKe6TD
         DED/6TmCEIJ+u2fMDrMpfTOvGELERlfCi3+s3rL5W6izrw228Wui1qoZ0JDD0thDpvO0
         sJk5pG3asfA2Jl8O1MPvi2kwVoBHybnqAdSwQMpt599mIDWf6mNGCk9kSBufuL01fEOU
         Gudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KRF6soD2g7xvJ30XDDz/0MGN7A3BH2BkkuXZbRs4kCo=;
        b=p9q5iuNqTsqLidOeK9Z3VIyzOejWB5Ts0FiR0ugdtWezTiSFVf2BohsVq0t1RdT23q
         VABoCc6i9DFtwItuNsbr1LyU31GvML9AhCn2iZq8rrlj0DmY7of6gxfXWWdx9hX0v/AS
         Cz+vidkXdM48CF0NTygK4HAWpL0O2W/zah+yCErO3Eq9+ZgLpPVkQxENS1Jo50LngaqF
         QWlljIX5UpkihJNflmC3QO0VvPBJty/2bcqpQUJ5HJpMwpig4QS1DnNRdGEKSAhuOsAM
         gkc0/KaFqvvHbCHPNnXZzWJa0pLv/WxD112dAaSpWD8GkWfzVFTEIV29cVpwWL0l4uoq
         JXkA==
X-Gm-Message-State: APjAAAUWdHdi2DOSZ5sdDa/m6ii0xQ3CXiN0teUiyqbTZSKBoB2wv7Uv
        XrMnW5hPtToVBJVm1qLARcI=
X-Google-Smtp-Source: APXvYqwz3x2ZjwhFLd2hLmE3ztByvTIwFUK1SdPMDbu0KHTbSwhBf7hj4LLTa3tNeN+XCOEQeYkMDQ==
X-Received: by 2002:a1c:e404:: with SMTP id b4mr16009804wmh.90.1572696274241;
        Sat, 02 Nov 2019 05:04:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id c144sm9680533wmd.1.2019.11.02.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2019 05:04:33 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>,
        =?UTF-8?q?Jernej=20=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] arm64: allwinner: h6: Enable GPU node for Tanix TX6
Date:   Sat,  2 Nov 2019 13:04:27 +0100
Message-Id: <20191102120427.19350-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike other H6 boards, Tanix TX6 doesn't have a PMIC so we can enable
the GPU without providing a specific power supply.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 7e7cb10e3d96..bccfe1e65b6a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -53,6 +53,10 @@
 	status = "okay";
 };
 
+&gpu {
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.20.1

