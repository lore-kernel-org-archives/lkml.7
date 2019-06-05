Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA666C28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80ECA20870
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 16:19:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="I6iYtRyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfFEQTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 12:19:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728577AbfFEQTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 12:19:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so1248009wmm.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvJtQg+661w+5Ir5BueWWyrmozrX3JR+SPJBE4ojBNo=;
        b=I6iYtRyHkalxDasmwHTdxIbaUYx8OfE1WKuOCK2uL3QagvAB9yZIe6HMa5tvN5XsKT
         As6+duPxxJm3c2Q2nsfdJOGlLxJ0ydJ9jDa+Ct6VYzHKmXaqObbRZYRgB9mh0xRMkhXb
         HMBFRwsRYKkMe5vhIXC9pq9x7WDsBvgJI/PWEZx+PLhE1G12JZGWx8ZB4lR59JwVk0QL
         uhmJ03bX50kVC0zfqS+0kgBNYuQWzOqLojgde1tokB1BH2hcmoZaC621q2mnQ/nHMKaA
         kEn0pbZoGkvqwtD40Ti7cr4enuhs7K2bpq39yahHvTEiVFOTUGGJY4eHA1VDXpV8BeZh
         CDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvJtQg+661w+5Ir5BueWWyrmozrX3JR+SPJBE4ojBNo=;
        b=neWFkhlC4p0ArsTArxWRNGRrR1EPyzJYxv2LM959fGPSAEG2s4Z4cTZJT2xwF6wemb
         qfo6T+195h9UiL/izOlbFkxKe1EzH9Kpx/Q2Ld77OHAT6s/pKyQynAXz3NOMI9EFCVpQ
         JrTrwBVmxsoyIE+ND6DHZlFytx3wHreBZQSQUpsRai3K2eC7ipWU3OCitMyPbsJZQXos
         oTcAhMmzJw0YAu/9l6Szbh+HZQ7B9+WADDoM6NQvnpJ0D+Q96+2nJDfMZpXAooa+jRf+
         QNe6QJJfUmkW0KjwLAxyVIRIE48Rqy/A+aPokCnAJ2sB0qsg0CQhPT1wtuJJ2qJUasWq
         BSOw==
X-Gm-Message-State: APjAAAX5Pi5R6ZnQmp32GNlsYZz4ExyyygjnoWCwecAhF/fDUiDEMR4d
        PBJE4P8nzJLokgVeC3Kv49yIAw==
X-Google-Smtp-Source: APXvYqzNN46ciP4tkUC+7w5n/SiNmnbfs0fixCv7UV8/x5/Fyd3IoKD7kC2MipfY04SoR8aerHOa8A==
X-Received: by 2002:a05:600c:2116:: with SMTP id u22mr10861468wml.58.1559751580910;
        Wed, 05 Jun 2019 09:19:40 -0700 (PDT)
Received: from mjourdan-pc.numericable.fr (abo-99-183-68.mtp.modulonet.fr. [85.68.183.99])
        by smtp.gmail.com with ESMTPSA id 95sm40062336wrk.70.2019.06.05.09.19.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 05 Jun 2019 09:19:40 -0700 (PDT)
From:   Maxime Jourdan <mjourdan@baylibre.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v8 1/3] dt-bindings: media: add Amlogic Video Decoder Bindings
Date:   Wed,  5 Jun 2019 18:18:56 +0200
Message-Id: <20190605161858.29372-2-mjourdan@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190605161858.29372-1-mjourdan@baylibre.com>
References: <20190605161858.29372-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the meson vdec dts node.

Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/amlogic,vdec.txt           | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/amlogic,vdec.txt

diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
new file mode 100644
index 000000000000..aabdd01bcf32
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
@@ -0,0 +1,71 @@
+Amlogic Video Decoder
+================================
+
+The video decoding IP lies within the DOS memory region,
+except for the hardware bitstream parser that makes use of an undocumented
+region.
+
+It makes use of the following blocks:
+
+- ESPARSER is a bitstream parser that outputs to a VIFIFO. Further VDEC blocks
+then feed from this VIFIFO.
+- VDEC_1 can decode MPEG-1, MPEG-2, MPEG-4 part 2, MJPEG, H.263, H.264, VC-1.
+- VDEC_HEVC can decode HEVC and VP9.
+
+Both VDEC_1 and VDEC_HEVC share the "vdec" IRQ and as such cannot run
+concurrently.
+
+Device Tree Bindings:
+---------------------
+
+VDEC: Video Decoder
+--------------------------
+
+Required properties:
+- compatible: value should be different for each SoC family as :
+	- GXBB (S905) : "amlogic,gxbb-vdec"
+	- GXL (S905X, S905D) : "amlogic,gxl-vdec"
+	- GXM (S912) : "amlogic,gxm-vdec"
+- reg: base address and size of he following memory-mapped regions :
+	- dos
+	- esparser
+- reg-names: should contain the names of the previous memory regions
+- interrupts: should contain the following IRQs:
+	- vdec
+	- esparser
+- interrupt-names: should contain the names of the previous interrupts
+- amlogic,ao-sysctrl: should point to the AOBUS sysctrl node
+- amlogic,canvas: should point to a canvas provider node
+- clocks: should contain the following clocks :
+	- dos_parser
+	- dos
+	- vdec_1
+	- vdec_hevc
+- clock-names: should contain the names of the previous clocks
+- resets: should contain the parser reset
+- reset-names: should be "esparser"
+
+Example:
+
+vdec: video-decoder@c8820000 {
+	compatible = "amlogic,gxbb-vdec";
+	reg = <0x0 0xc8820000 0x0 0x10000>,
+	      <0x0 0xc110a580 0x0 0xe4>;
+	reg-names = "dos", "esparser";
+
+	interrupts = <GIC_SPI 44 IRQ_TYPE_EDGE_RISING>,
+		     <GIC_SPI 32 IRQ_TYPE_EDGE_RISING>;
+	interrupt-names = "vdec", "esparser";
+
+	amlogic,ao-sysctrl = <&sysctrl_AO>;
+	amlogic,canvas = <&canvas>;
+
+	clocks = <&clkc CLKID_DOS_PARSER>,
+		 <&clkc CLKID_DOS>,
+		 <&clkc CLKID_VDEC_1>,
+		 <&clkc CLKID_VDEC_HEVC>;
+	clock-names = "dos_parser", "dos", "vdec_1", "vdec_hevc";
+
+	resets = <&reset RESET_PARSER>;
+	reset-names = "esparser";
+};
-- 
2.21.0

