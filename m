Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6FFC282DC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA41B217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFL7cQMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbfDQRag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:36 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55530 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733042AbfDQRaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:30 -0400
Received: by mail-wm1-f65.google.com with SMTP id o25so4330658wmf.5;
        Wed, 17 Apr 2019 10:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=SFL7cQMOqL8/xmZdVyzNV5oZR5psQkoWYoTL3WuL8B7A6gFTEnbrI9E3aQThUX6jxi
         T1wpkN2WkkVgn79KEF5BfeTGCw+mdJC9CTtcPMrFM+2LCz0pPXSOpFEGWVC0FviP3pAn
         M8CZ7us99WpV7FhpZ7oXYIe8i4WA1ny0xyTjlUG2gKbPFxYygFRkaHNl/zWkazMWFqC1
         Lxlk/X4PUfgtIWoNWD9Z3jYrqKHGtI4Sv33LQUazATB0TMv2L2tg7uZsrNPlqcZ8XhOc
         JDMoqXthNl9e8aN8Bfz6xLcOC6nHwpn5z8dOIvm1sV93A64+mkD8q2zSqD4CUzEQ5bZy
         hO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mlzb91vv83xS6UoRv6kQTj2/DAjCHH1E4jjakjsuiwg=;
        b=B9A/506ltOvlNw+KiSKFQpIJNUhmNyxfhJxYknSm/B8lUEmVvbD7diK3mlNsfZEPm7
         wPtx/lymWZtfC3lMSKIeyRS8p9Ih87MaigtWiUi4HT1HnFoSYdY1cAEVhsgjxOKCGT30
         npSx8x6uMoWSwM+ORnCiayGu1wzHsWaQaWr29OUkfS0SZqXmtTTWFLToBcWGjx2kR1ps
         OcdLQAnIj52XVcVADidPy7fwXw1jObOZyyrcjVCu5oCs7zjxsBGorMS/WQlxBA5qA5qC
         oTSN8y80kctdRLgMvh6hm9esF/BDlV3Wx6kPDr+1uNp7I1qHtObVEIBPA/wQT+YOOr0o
         Il/w==
X-Gm-Message-State: APjAAAUtyBZprMvMhlK++FNRbVsGqWm3g8tyD210YTUeVcAmKKOyVKm/
        LCRDhetYX7TFHGvQoQSN2N0MCZfZ588=
X-Google-Smtp-Source: APXvYqzx4OkK8hhtMsoodJwzcIGfn4vw0pOb7xwbVi8L30ibW5of9PBtD8lBrnDOBQ3CVnd74Qalxw==
X-Received: by 2002:a1c:1aca:: with SMTP id a193mr630813wma.40.1555522228103;
        Wed, 17 Apr 2019 10:30:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:26 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 6/8] arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
Date:   Wed, 17 Apr 2019 19:30:29 +0200
Message-Id: <20190417173031.9920-7-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190417173031.9920-1-peron.clem@gmail.com>
References: <20190417173031.9920-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Beelink GS1 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 0dc33c90dd60..21440d572f0a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -70,6 +70,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &hdmi {
 	status = "okay";
 };
-- 
2.17.1

