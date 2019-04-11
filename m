Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F37C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6394F2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHeSqyuH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbfDKKrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:47:48 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40764 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbfDKKrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:47:46 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so6085582wmi.5;
        Thu, 11 Apr 2019 03:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=oHeSqyuH5jJPFQUArGKlW44jzK9aFVTiZD718T1M+MYtXyCY2g7N1XUf8r8PMhuSRv
         eRkcLgkLC2UsKzmIu2j5PlogWBZSt7yBJMTvFGGfzNu2iydqdmDW7ekZq9qX85n0OVqg
         lwkFmt/SZKtE6eFhfQ71UUKQgMURFlwnWVrh5QPT2bbf9iZjP/b/sztGZKhXMD5OGHVZ
         avIx6lZGwyn9Tgkr2D5RhkjkN1HpPNqbuXKTXJA6NnlLvwTXZvfxq3kEikS6G/9CrSIX
         EJdveOuoWqtkE8LCsaCRkUPNMzJJODtU9YUx9r+juxevSBGA9iOYILYW+2bpwLSonBI5
         g8lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+4rEQwoh/x6L1vMEfLnhjWMCaYNdunEelwJgclnNME=;
        b=d6QtO7zbJfWxIp1ybNozeC8DL07cLrFI1nssaIGioJ8Gb/G/PASA34e4Yg+ewMv53J
         1z25fd4vnFFUP3lvlu65c+3gjh24n7CJ4aTepofExUfHL+6Z+NdlR4L/XIm4EEUvEes9
         RB6idJPAsGtUwDNNGmrtgtKu+ZHiWfZh+qOQR5uF/CEw+pZ8Hm/tcEy+IiPOlVR9K166
         HEqFL01noGhYFLy6X7dJAwJDSFSoNindhftmZymkMAzoM6Z+L4VyHocPDQOMoZl9bgvx
         koMDs54LaqcMWRIZg/OTmRIXx0+sHkaMTWHVrrF817sc9bpkQ9G76TbMk9dzD0EjQzIC
         GKew==
X-Gm-Message-State: APjAAAUCOkTKkVgdbNOX4NVo+LT8MSL+okxhO45pV8JXUSWgg3FHUyZV
        iWgirxOvImN85Zjdx+HrpkU=
X-Google-Smtp-Source: APXvYqx3DknNYL3cRdn3yE4zCPUJDK0NpJglQVNKpvMRJSZwus4bSWeW55pMqf5kQseRWkAgzXVF1A==
X-Received: by 2002:a1c:4d10:: with SMTP id o16mr5964056wmh.59.1554979664468;
        Thu, 11 Apr 2019 03:47:44 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id k4sm54987587wro.33.2019.04.11.03.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 03:47:43 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 7/8] arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
Date:   Thu, 11 Apr 2019 12:57:19 +0200
Message-Id: <20190411105720.32357-8-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411105720.32357-1-peron.clem@gmail.com>
References: <20190411105720.32357-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable and add supply to the Mali GPU node on the
Orange Pi One Plus and Lite2 boards.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index 62e27948a3fa..bd13297555ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -55,6 +55,11 @@
 	status = "okay";
 };
 
+&gpu {
+	mali-supply = <&reg_dcdcc>;
+	status = "okay";
+};
+
 &mmc0 {
 	vmmc-supply = <&reg_cldo1>;
 	cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
-- 
2.17.1

