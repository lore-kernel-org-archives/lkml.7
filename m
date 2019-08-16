Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF356C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD4D205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 11:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1niofBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbfHPLon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 07:44:43 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37011 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbfHPLon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 07:44:43 -0400
Received: by mail-pl1-f195.google.com with SMTP id bj8so2362948plb.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 04:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Dgm6VT8fTmmCb1jZnEdSW+leRgGmCydPnLOI7W3wDlI=;
        b=N1niofBkE6D2I0syRjQZNDQD+QG1NnGlLTO1FvgUnskj2HhRzVPZMqKp2GO/Fq7oRG
         sBe7bvSUvHXuQMg7nRGg4MpN06IcAgnktpN/UMDveI7dzz/f7D7KfwaZH+gv0VFThGqb
         jFGURPxxDqKA0rjA9t0tqca11eXl1q5DHLf84jTMopb3VMsKKRAovR+78tmKDANXnc+T
         pjocQbXPaeqR3MvJY8Dl2LJ1Xkht890homiEa5+U7wlMQyL7TIxV9YzCpC7OK2a5tY6s
         nBxhdl1gXFuIMpfEiqdKEMM9Iu+aYK9YwONzgLAifR1fyewFXcgsa2d8YelJxdb/7S4t
         FV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Dgm6VT8fTmmCb1jZnEdSW+leRgGmCydPnLOI7W3wDlI=;
        b=oagphCPSooa7hAUlf1kovgGtZeHoAsStiAWf3Z2WTZ2QkUbKmyFxvrslmts28wSJpD
         vmR3M8vBtuczJRtgEYdIT0gAweHbl29VfOT1cN78bmknZ8oJoaEPl/3qLpPrH3X79H3Z
         r8TtWB76IshhGzt+IOBoyuQh061jcdyVQGZIZeBeBdIVkuQAVHIlqlJu/OijkqwN5uYK
         XE10Ak2I4OTfmPFLz96c7UGTFSDauv/MhmZnTDCQYgKdCdo3rnSZkf6bOJl9DUXZI9JK
         NUC2VuISCCPGYT0T6gFj9+CC0TcQmALK4IwJ/aQCBcg9IAq8Rm31bixNg5imdqdIMqv2
         e3yg==
X-Gm-Message-State: APjAAAVqEwCPUI5/cVjDH6CSc7YqWKBIm6ZaVylkObGN6ZXueh6vS3LX
        qYizCy/c0tEvyo5ML8APrPLKzw==
X-Google-Smtp-Source: APXvYqzvj74KbwruABpcHy06jN1+C098iteIL/Dmwbg2X2HoCetV/Ni0GGlOmWZEv91KlAvEugd16Q==
X-Received: by 2002:a17:902:5a1:: with SMTP id f30mr9045760plf.64.1565955882050;
        Fri, 16 Aug 2019 04:44:42 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id v22sm4693952pgk.69.2019.08.16.04.44.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Aug 2019 04:44:41 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        freeman.liu@unisoc.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nvmem: Add Spreadtrum eFuse controller documentation
Date:   Fri, 16 Aug 2019 19:44:16 +0800
Message-Id: <80b6cf41d2dc2660a710e611e06faae753e2e09a.1565955745.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

This patch adds the binding documentation for Spreadtrum eFuse controller.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

