Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931C4C31E47
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6798620861
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 10:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="R0yBQos5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfFOKoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 06:44:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46780 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfFOKoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 06:44:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id n4so4995693wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 03:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zdNw3j26hIKq9Pkw7umZ9fm4rrocSNYRpSOLSmy3DE=;
        b=R0yBQos50xrtqq39b46j5ApodBRZ1gOp0Na7tJgbgmkwJUPpA/J2uXAOXt0TRyVxPd
         Xa9ZjBRz5vYE5JbPzrAY4P+zr1US9qbBCKPsC+8hWiHsTz+RIKKhW8JsI22KF8Lgm1xK
         A+Z8fcPsVWRq9/rp6nh64m+N9KmAWLVDLrSfTh84k2MqAe1vllIKrQMVF9cXaYsxDEXc
         jtd//zYqRKREXCa3jzGFK2LZzufmOE9xq8NSU9SXiBO8fpEkjMbtTfw9l4GwHQKdsq0t
         q8D4WZNMtc/kgZmcXMBkWCLcfv4cngx7UVh8MoNsh2uqNBH8QTsejWy2qeT+K1D+yP+v
         P0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zdNw3j26hIKq9Pkw7umZ9fm4rrocSNYRpSOLSmy3DE=;
        b=SAPkPFSOFOyCJqXMq0LerTroL7ddJss8GDW8ixI/F9XE+ainM7VfLTGXNZolsZKG/Y
         bxa7eInAMTcOt1e3ZyR1qjd4cZya3+aH6jSoo9DIbHiCtT71ZGV10hk8fxE8NmsQH45B
         6AnklR165mLHsi/pnzWjfvaPM+A4+ITOkm5IDRt6e2QriYI4TkPfX0e4DcDVOMLvd5di
         QRZsVCEqpclUM4bJnFv7N3SSPEuNRmvqxzbBb9V2bvC7V0bQD1NtlSyYjMVwizjRDDiM
         NN+Ki41oT4Vpsfib/H3FjJ2IQyhRH0+uepdOMBvG3pw40rho9lZqm5Q5pd52ypGvtPn7
         o1gg==
X-Gm-Message-State: APjAAAVyL9iUlUyVoOzesndTsi3kaSYl6YDRc0PiwWFBIO5iDxBFmG4g
        to7yJeHfiUViMW2/7Kv3O6il44kBVLk=
X-Google-Smtp-Source: APXvYqx5Cjb4em34zJEgLyQgg3ezxWmywZodf6qeyk0GQ79btKvMPPOP3Lybn8sH7D3sDJWK2rdbfQ==
X-Received: by 2002:adf:e2cb:: with SMTP id d11mr59054829wrj.66.1560595443825;
        Sat, 15 Jun 2019 03:44:03 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C20E00A9A405DFDBBC0790.dip0.t-ipconnect.de. [2003:f1:33c2:e00:a9a4:5df:dbbc:790])
        by smtp.googlemail.com with ESMTPSA id l12sm16761120wrb.81.2019.06.15.03.44.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 15 Jun 2019 03:44:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        narmstrong@baylibre.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] arm64: dts: meson: g12b: odroid-n2: add the Ethernet PHY interrupt line
Date:   Sat, 15 Jun 2019 12:43:50 +0200
Message-Id: <20190615104351.6844-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
References: <20190615104351.6844-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupt line of the RTL8211F PHY is routed to the GPIOZ_14 pad.
Describe this in the device tree so the PHY framework doesn't have to
poll the PHY status.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index 82b42c073c5e..81780ffcc7f0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -254,6 +254,10 @@
 		reset-assert-us = <10000>;
 		reset-deassert-us = <30000>;
 		reset-gpios = <&gpio GPIOZ_15 (GPIO_ACTIVE_LOW | GPIO_OPEN_DRAIN)>;
+
+		interrupt-parent = <&gpio_intc>;
+		/* MAC_INTR on GPIOZ_14 */
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
-- 
2.22.0

