Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0758C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A316920836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZdxwmex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbfLKNuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:50:18 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38119 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbfLKNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:50:18 -0500
Received: by mail-pj1-f65.google.com with SMTP id l4so8968124pjt.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 05:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vwhN/yt2WmtrREcyUuWcQxe7CbFit8CvDpGIHKC3OU=;
        b=hZdxwmexnI6K29c6yjOIdnCuBaZYA8NWSass4fzFRgZPrBpxbcZ28+YOvnRUKpiERz
         J6MijJuv8l40HNn+/PPucW9ktHd/3pkFlknxAviQcC3NYr7UF6Nw6Fl0/KhLoiLchrZG
         pJ1FlCgJKsBQE+dRQAhhxkNhKXIW+Sc64Pc50MmhjTH6cnO0DE1tRyaY7TDtL01HQ4qr
         FTELqs3L7qJd7wdv8bpgRA7UHTxJTstqz8Knqt7YLdU2kpHombgT5MDNWUnzb5iAJQfj
         q8zMilSD/gsPGgHZCVIIlhZaomzp3Le/r2rK6BfoyolPf5ruCuRtfoxMy8yQ2/sKJVId
         qbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+vwhN/yt2WmtrREcyUuWcQxe7CbFit8CvDpGIHKC3OU=;
        b=LUhGJt3OYLxL+3EZkxQ/GyfZt5Dwnlo0FQGUFv5/G9VE505uWqoKuinHJXamLvrU9D
         M9KEED4QSaWUGpO/Zq085ScsXcs64QyXA+Pz4gxUy03WVVbs58irATeg77DOa6ptBAI6
         ZUkAYJA4zwWrxohfi81b6LUMkAAsTfEEQS3i5NIf1n3oVziPfs/2SI3Zfqg6aKtdrSZ4
         yHcBrD5IVQ+1GG7dsgY5xqLpDIO11FwAWtvQNsuteLuiS11LmDsoG4Ea+HidQAwhBYNZ
         7mQDa54i2uIUprnl+xRYM7bknfh+D7DDdXiVrKmHFf2duxkm7MwVm+jD7Oe8p+EHXc4r
         5w2A==
X-Gm-Message-State: APjAAAVKvBXAYTNnW+MFu6JLZ375DrsB5/i6ghaNxwFj7vYwBZwH3vJv
        JshrAMRT+E3IChqdOjaTSis=
X-Google-Smtp-Source: APXvYqwsAxWfBEIFCjAdoGJMeISx4//0Y4VVHxiemo0DsbJ+gpBr4l1g18HvOPw3aD0BYmKFgyfHmA==
X-Received: by 2002:a17:90a:1505:: with SMTP id l5mr679336pja.73.1576072217460;
        Wed, 11 Dec 2019 05:50:17 -0800 (PST)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id j3sm3294596pfi.8.2019.12.11.05.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 05:50:16 -0800 (PST)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: vf610-zii-dev-rev-b: Drop redundant I2C properties
Date:   Wed, 11 Dec 2019 05:49:57 -0800
Message-Id: <20191211134957.30587-1-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZII VF610 Board Rev. B is supposed to have exactly the same I2C config
as Rev. C, including I2C bus recovery settings. Drop redundant I2C
properties that are already specified in vf610-zii-dev.dtsi

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Changes since [v1]:

    - Reworded commit message to clarify that I2C recovery setttins
      are supposed to apply to both Dev boards

[v1] lore.kernel.org/lkml/20190820031952.14804-1-andrew.smirnov@gmail.com

 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
index 48086c5e8549..e500911ce0a5 100644
--- a/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
+++ b/arch/arm/boot/dts/vf610-zii-dev-rev-b.dts
@@ -323,11 +323,6 @@
 };
 
 &i2c0 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c0>;
-	status = "okay";
-
 	gpio5: io-expander@20 {
 		compatible = "nxp,pca9554";
 		reg = <0x20>;
@@ -350,11 +345,6 @@
 };
 
 &i2c2 {
-	clock-frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-
 	tca9548@70 {
 		compatible = "nxp,pca9548";
 		pinctrl-0 = <&pinctrl_i2c_mux_reset>;
-- 
2.21.0

