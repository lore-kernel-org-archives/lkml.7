Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8145C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1BA205ED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 15:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6ES8kQW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfDYPeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 11:34:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36257 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfDYPes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 11:34:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id b1so73915wru.3;
        Thu, 25 Apr 2019 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0RLkch3swe+twhnzUCHSiAt0akO5s1guvZ5QxA/SCg=;
        b=X6ES8kQWi9dP/UZ8ZQ953wKu94SoKUNeX6aRIciVWm7Pw42qMedI2qSuuY8VFao0Co
         Yoc5Us2rSC59giYtrjLL28Wz0CSy3s+yyZzKr7gglKKFsU+Ygi6Kdhbph9jCQNBmWZS+
         mZRD0JpY/9W2MmfRTUjJJjEICUz9nybIIvd3BCzfUkciTZA+ueJ+QplU0fOfPq8nEmoz
         07IIKEakD/nT/EYdCJoHkxPfXSmz4wQTiCLkN1rprnQOmDL+ufKAMaCYD2GtZDuxQ9NZ
         DMue6qXdfhzwWZit3JhZSn9BnezfjK9M77d02fnnPSC0DBSaw0f1PWScfF8rHW6ncpXD
         /eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U0RLkch3swe+twhnzUCHSiAt0akO5s1guvZ5QxA/SCg=;
        b=eXMnLrk/08geYgQurDUV+KSO7kNmGGhfmz+2Yqncr0g1h+IfajY2DTr7gVGWCUvC3I
         trW+aAQlEe1cCz2Rj1JCp55XsbaTUP1Vr1dc0/SE2OAzwbtEKFAH4QoajQsssrIHvoWe
         ak2eWOCZnCkR11TEGZq8tZNaw/z9jRdozzLwI1rHWv0CCxEEP+L+XqtJ5naZ749bOKOj
         XkVaRhFUlxycd6zly6+xSoGwVLNNBPC3iL+IzGbslKJXSwlQH2uEGph2bj0hhQBJVAfO
         qt3lBAFVXLMJvJfe6Jod8vik1ZjnRIGQ864hxXENXXPYL4zZRD0Fa6Xstcr+WKRwI6u+
         nq1g==
X-Gm-Message-State: APjAAAXDeJehsrpbeOX/G5PQVaVfUw6Nil/dCMdQWlve02R1uvDfXTos
        ruwlr9rV3lqqN67Y1FoLd6w=
X-Google-Smtp-Source: APXvYqyKaH8ZJBdPHi+W2cZ6dGkHMnVgSYqxcaA09FcTtyz6bOfYmFP/QIpo5tV/6KCjO77lR7dAog==
X-Received: by 2002:adf:f2c9:: with SMTP id d9mr4372861wrp.36.1556206486323;
        Thu, 25 Apr 2019 08:34:46 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id z18sm27966361wrr.90.2019.04.25.08.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 08:34:45 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH 1/3] dt-bindings: phy: tegra-xusb: List PLL power supplies
Date:   Thu, 25 Apr 2019 17:34:42 +0200
Message-Id: <20190425153444.6281-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

These power supplies provide power for various PLLs that are set up and
driven by the XUSB pad controller. These power supplies were previously
improperly added to the PCIe and XUSB controllers, but depending on the
driver probe order, power to the PLLs will not be supplied soon enough
and cause initialization to fail.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
This was previously reviewed here:

    https://patchwork.ozlabs.org/patch/1077153/

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt     | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
index daedb15f322e..9fb682e47c29 100644
--- a/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
+++ b/Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt
@@ -42,6 +42,18 @@ Required properties:
 - reset-names: Must include the following entries:
   - "padctl"
 
+For Tegra124:
+- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
+- avdd-pll-erefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
+- avdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
+- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 3.3 V.
+
+For Tegra210:
+- avdd-pll-utmip-supply: UTMI PLL power supply. Must supply 1.8 V.
+- avdd-pll-uerefe-supply: PLLE reference PLL power supply. Must supply 1.05 V.
+- dvdd-pex-pll-supply: PCIe/USB3 PLL power supply. Must supply 1.05 V.
+- hvdd-pex-pll-e-supply: High-voltage PLLE power supply. Must supply 1.8 V.
+
 For Tegra186:
 - avdd-pll-erefeut-supply: UPHY brick and reference clock as well as UTMI PHY
   power supply. Must supply 1.8 V.
-- 
2.21.0

