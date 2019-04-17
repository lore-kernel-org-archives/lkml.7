Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5817C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F3D20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti90VxeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733129AbfDQRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51627 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733072AbfDQRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id 4so4351994wmf.1;
        Wed, 17 Apr 2019 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=Ti90VxeHj9P5J0cmBUmvu6v0UgWENZrHn0HSPr4mQ/MsYGmE3IqDtLPMKwVoGRkOKR
         ca+NjAw7cGlFgQ2e85ZHjM4SAgX7UpR1+WV9ZZuspFRKgcAAy+aTXPxqbee/43bOixkq
         Aerowi0fWcEYRfb9wTpyjAEtHpnHzPA88AsmagBMc6KXnCF9WbXB5TsnM8pIw2DXlyKz
         k12k5mKw2rsuozDxSmlapfsdR+kQaVWyo8nhfP6UaOGrnS+Clp1dvKw6YOQp5Us39OMn
         2yit0pXf2FMNsE/uQMM+QeaRVhYT7vMREbXWc1+AholDl5U8b1cuP44d83mNMATlROUD
         3LsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgaCObQyxyHYTX1YXpu+MjtXHmBUZKNVey1+WmtN8oM=;
        b=bi2qfoVr4tv7Zm9jjWGJuYcxBXW3VklbwXEok1o7zDAOJFuyAOwKSINhYU4kYh2Szx
         ODPzYsVXVE/whzVqGQPP+uK8PjHHI6kI1W+/i3faGmiYCZQ7P2A6MMTiJ4k1NViSY1Ff
         INM2FbdFGHIqOD/GVQ1UoGqEiBZ2kHEsCGJo1fQ4zjiS8PbnODH9seaCs70kHg2LKCnp
         kWZa9ViBjfghVk5gYkmXmF1yNihehXGAKWAseFIHYIYSj8MFtHO3Oyd27KMkxP1j5Odl
         0utpMcKFNAQ0z4MC8lL42z40UPHSfFP3nEDahiSzMeXfvinJUoNKyV3vWZW0Ui5b56M/
         NNhA==
X-Gm-Message-State: APjAAAVZXyLIk16pYjlr8L6A969+yvZ5Yl/EHCRivnv2xZ4TxSrKwY4R
        bs7g2u1WDi+2fYLfQxg9Bdk=
X-Google-Smtp-Source: APXvYqwbCrq0X7yIuoT4rZ+4U8INkGO6e3/MpFA4lyzqTR2Y3bc973r19myPgGcIvDec7dQOSe5njw==
X-Received: by 2002:a1c:244:: with SMTP id 65mr602135wmc.42.1555522231464;
        Wed, 17 Apr 2019 10:30:31 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:30 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 8/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi 3
Date:   Wed, 17 Apr 2019 19:30:31 +0200
Message-Id: <20190417173031.9920-9-peron.clem@gmail.com>
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
Orange Pi 3 board.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 17d496990108..d4c989cc92a7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -58,6 +58,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>; /* PF6 */
-- 
2.17.1

