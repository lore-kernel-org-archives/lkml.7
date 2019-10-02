Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D64BC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D540E20815
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 00:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3c6aFkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbfJBAUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 20:20:37 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37216 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729509AbfJBAUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 20:20:37 -0400
Received: by mail-io1-f67.google.com with SMTP id b19so24717891iob.4;
        Tue, 01 Oct 2019 17:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=E7akn3KWbgNnmMpTo3GpAawa2GrmFKU67ai1nYZy4h8=;
        b=F3c6aFkkT9udTeRsQq65f8rfAAgP1ivklKvMzWsaHAEsYa4XU61XzysDKiiFs1GIce
         y9tDnJZi07BVq3ak1k/ck57w5vdGWOdnRrY0imEpxxoMZJNvu/kIQ3IsIScOidtYiFu2
         Zw/V8Aw36OocuVQt1ulbuDbZh8OhWPkhsNMNa3b8BBkOzLKt0wTcs1hW/LD3+CTxTtdx
         9YDTkHPkNQs+wBc3tJo0O5T8hvFqYmxv5kpQeX/dZ1ZsT43q3hms+WCgPnB/UBVuSaHo
         2+jnUGndHbJ22tlzhxNM373PBIY5Njg8J5Dju2OL0+iH/pyBxiHbWkPioOEULvHu6xFx
         HIHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E7akn3KWbgNnmMpTo3GpAawa2GrmFKU67ai1nYZy4h8=;
        b=dSWfWwjSwEtvIlmhFaDb1/oCZAKPD6PH+lnLjGLgxVyWXak/fIUivPAF2Z0dOGRyz4
         6Xm3xrAS4CtOIqJJSW/fp3DnNDuNom7VTUBG3uqB4FL8gHmhrPxd1EbzQrkPQlQZ0wBl
         JEHfL9vud4uSsFn02Ln7IEtoDVNO6Ulw54sehejyW0X/yDHgITx2TivdvNJor/X4qjnU
         2wgiOxRIqYvf047gEVfpOqOgkF1QEQiy8wfcZebUCRyWm5zWGOzW82wilNVYRm0fqdra
         8zhm7OM34eFETo4b36LHRgE697gElLvgD8EjEfXN0J2DiuMQoG4QrjmkIMf2GpFUHiNV
         5/Sg==
X-Gm-Message-State: APjAAAWwI5tJUa5Pjj+PRR2lhJHpmXw+2yQNceQGfGYBjM55hnSSDQD1
        MOUBj4Rc+ooYzJefCRsfW7o=
X-Google-Smtp-Source: APXvYqz4A/KOLM0TIzmmQxVPsPwNSr7qx9lzpyTV4UAEwH9hZCGAdGpdtb2S4AEc3Ugu8biyi6Gcbg==
X-Received: by 2002:a6b:1646:: with SMTP id 67mr879880iow.11.1569975635262;
        Tue, 01 Oct 2019 17:20:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id i13sm6703646ils.16.2019.10.01.17.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 17:20:34 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     adam.ford@logicpd.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: imx6q-logicpd: Re-Enable SNVS power key
Date:   Tue,  1 Oct 2019 19:20:28 -0500
Message-Id: <20191002002029.19189-1-aford173@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A previous patch disabled the SNVS power key by default which
breaks the ability for the imx6q-logicpd board to wake from sleep.
This patch re-enables this feature for this board.

Fixes: 770856f0da5d ("ARM: dts: imx6qdl: Enable SNVS power key according to board design")

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/arch/arm/boot/dts/imx6-logicpd-som.dtsi b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
index 7ceae3573248..547fb141ec0c 100644
--- a/arch/arm/boot/dts/imx6-logicpd-som.dtsi
+++ b/arch/arm/boot/dts/imx6-logicpd-som.dtsi
@@ -207,6 +207,10 @@
 	vin-supply = <&sw1c_reg>;
 };
 
+&snvs_poweroff {
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
2.17.1

