Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1DCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62795218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 11:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="va5cB1Zk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbfJ2LoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 07:44:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34403 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732753AbfJ2Lnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 07:43:41 -0400
Received: by mail-wm1-f66.google.com with SMTP id v3so1797180wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Va6MSqjXMXOuH0/T0+D19S3ciaF7zVif/RgFuA01Sso=;
        b=va5cB1ZklVNGl3C12ght31B13O5YkcCeJWs0i9v0xC8laA4F4Og/WthKoO00k8ZqKO
         qC+/nx2544Jb1mkZL7x7o8T7RucpNp0IQDxN0PSeXqEoYAAb2KxZF+Y4Oide8h2v4oim
         +33SAaifLx8lgHs27Uqd3d0fpBEZ5hjgQWT/vsK2tpec5Re4TgmUfp9XgEGKOf7w39jT
         Io8nWOkZh1LFfQN7fbjJ8TDCLhRK7ogOAL88orEZEjZxf38nXupEd3hh2IbwVc9C8YzD
         FRZmPrNCZWY8BzpLQIEVnSBnp9j4QF71Q02uVptbORMyP/N/sAfIoTN/69ux1KS29gMS
         RGOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Va6MSqjXMXOuH0/T0+D19S3ciaF7zVif/RgFuA01Sso=;
        b=S36SfIU2Dyb8f2uPtPzKMsTg8zMj08ETlRM2Mq8AcFcaGl+DzioVQ/e9CCLDCvxXFe
         Akqx4+Ny7Myr0ezeuUlzjeW4CdlGxXJ1ReHwHV++45yM/ep1jMuztJZxqhD5hA2Rr1eq
         /NEJptMTTCxm6VNgDv+tor2p4JI4o+7E+hJ00i8BWYNkYlFRL+LjKNtyuq71prZkBhB0
         KyubAGJ+DrIi7ZHGYt8h4T2i49DuF6rcFF4XYpjXSsXwAd8W4lomkGB2v5pNRyz8lEjc
         DLSJZEobjC82/Gg87xne0O+NoGOrYIli/sOFKzCxBuWv3Qulwhww9d0w+I7IB6/bZHTp
         bkaw==
X-Gm-Message-State: APjAAAVTjy9XKcldQplJzMLG+nes1rvhsY7hawJD3Mmosyb9fA1Yppqq
        gezV46FZGkrcQskten8bFbVbsQ==
X-Google-Smtp-Source: APXvYqz3aYxKbkVC72uUTOH9Kqm0ueWCz5iTwmcIVoh0eGR3udTgjIv7o1poPw7PYY5lzKv230Uw6w==
X-Received: by 2002:a1c:7911:: with SMTP id l17mr3658550wme.21.1572349419351;
        Tue, 29 Oct 2019 04:43:39 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q25sm26559864wra.3.2019.10.29.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 04:43:38 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 06/10] dt-bindings: nvmem: Add Spreadtrum eFuse controller documentation
Date:   Tue, 29 Oct 2019 11:42:36 +0000
Message-Id: <20191029114240.14905-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
References: <20191029114240.14905-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Freeman Liu <freeman.liu@unisoc.com>

This patch adds the binding documentation for Spreadtrum eFuse controller.

Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/sprd-efuse.txt  | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sprd-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt b/Documentation/devicetree/bindings/nvmem/sprd-efuse.txt
new file mode 100644
index 000000000000..96b6feec27f0
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
2.21.0

