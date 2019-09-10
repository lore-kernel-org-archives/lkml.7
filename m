Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3665C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 05:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE6732171F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 05:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SglGk7Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404416AbfIJFw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 01:52:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41890 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390452AbfIJFw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 01:52:58 -0400
Received: by mail-pf1-f196.google.com with SMTP id b13so10853596pfo.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QRoaigyAjs5h91B30G11QGcUasyv51Jz7B4F6B0hdm0=;
        b=SglGk7CuPhqxEI7xwpMa5d33F8KaDAKlwc8PlUqMt1NE+kj0qQaUz9UVK8/XFqmQDO
         pGBlSLD1YnX4ys1+tmh5OV7Q1/9Q08CnrEslUDRRa+tvs5iY1RxwM94K7xHsGSND91XL
         SzouiZjOpvzeE01FhCZq6QrIcnztIDEHk8oVpv1+d4iHik7HTtP6uhsGYX1M3d/xNAux
         5X6hAk7Da9dTdS7hjERqpmmPZlCX0JQDCBa/xxaPG8na5/hyfHA4OOrPRrHJ5LgvsReN
         xocpsC8qUHiAEOMYRKACMSFEFlbody6Af8PjPFLU2yhuhqTeEFTz+tyJEdnqXAE3Y9x3
         nwmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QRoaigyAjs5h91B30G11QGcUasyv51Jz7B4F6B0hdm0=;
        b=GzUzmM1DtN85JZzOtsc+G4VEW+i8B4pe7kDjqK70fQE6fpjKAKhx6Nbzh/ic467L76
         k2J2W/XB4cJO/HlkMHHrJ+ZGs+VfsQgNViLNw+mZ1vaPI6POXSl1+GbtFM0cBT3qwmju
         S+RsflPE4vtVG2rCGNNjfGaGJTz6sNXhjTXkYuSD5uH+z2pIrZekxjdKUTy7e4Tjfc9z
         Rvy5VDRgLIfZ/lIqq5zMJBoRS1IHIfal1MtKjYU0RYh4J5IKFc5d0OcjVsoW69WNECxK
         y7XU9B80ZHXnru8NpNKBZ1sF+3JY03ORTrdR1H7qsN0o5eSSiX1l1PeIBTdyRXy3XAQd
         iraA==
X-Gm-Message-State: APjAAAXnLOgqeeYp240wBcTqAEgX22gKpYNr6bOpH+3Tx47uBSg74VoI
        0GempyRil6wgCnAwOemKCkd1hw==
X-Google-Smtp-Source: APXvYqzySfLlPU5K/hZcSvzFd1BbmHrVA8I7sp3khxJaLnP5X76s9BuTr36ES5Ae7rJKJiaN0Oj1Rw==
X-Received: by 2002:a63:2a87:: with SMTP id q129mr26549610pgq.101.1568094777634;
        Mon, 09 Sep 2019 22:52:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w69sm22264550pgd.91.2019.09.09.22.52.53
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 09 Sep 2019 22:52:56 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: Add Spreadtrum eFuse controller documentation
Date:   Tue, 10 Sep 2019 13:52:22 +0800
Message-Id: <20f750aab0e16e45fa2d4e32843cee08395c7350.1568094534.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

This patch adds the binding documentation for Spreadtrum eFuse controller.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes from v1:
 - Add reviewed tag from Rob.
---
 .../devicetree/bindings/nvmem/sprd-efuse.txt       |   39 ++++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
new file mode 100644
index 0000000..96b6fee
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
@@ -0,0 +1,39 @@
+= Spreadtrum eFuse device tree bindings =
+
+Required properties:
+- compatible: Should be "sprd,ums312-efuse".
+- reg: Specify the address offset of efuse controller.
+- clock-names: Should be "enable".
+- clocks: The phandle and specifier referencing the controller's clock.
+- hwlocks: Reference to a phandle of a hwlock provider node.
+
+= Data cells =
+Are child nodes of eFuse, bindings of which as described in
+bindings/nvmem/nvmem.txt
+
+Example:
+
+	ap_efuse: efuse@32240000 {
+		compatible = "sprd,ums312-efuse";
+		reg = <0 0x32240000 0 0x10000>;
+		clock-names = "enable";
+		hwlocks = <&hwlock 8>;
+		clocks = <&aonapb_gate CLK_EFUSE_EB>;
+
+		/* Data cells */
+		thermal_calib: calib@10 {
+			reg = <0x10 0x2>;
+		};
+	};
+
+= Data consumers =
+Are device nodes which consume nvmem data cells.
+
+Example:
+
+	thermal {
+		...
+
+		nvmem-cells = <&thermal_calib>;
+		nvmem-cell-names = "calibration";
+	};
-- 
1.7.9.5

