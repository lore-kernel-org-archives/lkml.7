Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E211BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A967F21917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="OMCf6GaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfCUWQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:16:01 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33719 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfCUWP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:15:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id k14so481940qtb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0L6pXJZ0e75bqx2mujAz7nIQyHFH4GSrwd10wKDOHxg=;
        b=OMCf6GaPjHgVkOGH1sbY6yZrV6o6klze5++h0tE27BvIi8uZYEg5/NTeNPDzovZVox
         6uuowY9xuqoNuDmtDF96qYMrlYaepPGx1T25h//xamTclB99NYPGyMYT0Y+sSIZAAga5
         7n0Jy/Pc78mqh+73qJYcIcDh2gRYl7B8LdK5Kcl+a10q+YDm8srhCxyOlG6p4ao/WwPM
         TyMvUUlFqI7kT6C+ciW2/2sk+EHkhpVnTOnYhYtrpZKX+sw8OgBxVh0EQHT59pLvoEuM
         MVq2mPxqgvtbZ9CWhn7q+6DuQ3Acof4ilnkPT/LFoWMb7nJWJwdLbkIOt1SC3LrRKERQ
         xUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0L6pXJZ0e75bqx2mujAz7nIQyHFH4GSrwd10wKDOHxg=;
        b=HPkLivygT2bXn0unmvyjvt6VlUEBkuZNDnfz+QIcLmeNY295EtnsWWr/xccLwkC+TQ
         WSTMpmxcwS0ffXrhkLb/eEn8Bm/gRS2OW7Ztt6c0O2oceQShCc9RPPJYcssl/GVyYtT9
         jf1zwlSijPMi1dN0p4yasG0M6vmA7CwfhFbCwuHjLAqMFCoyM9Ohuhw3xVwhM//dP+Z0
         NhhkNgvUjvkL+OcBxTTortdxlHPZA7l5ItXQF7SYnKNC75fSzLfZOVtVBUfyif/vkRH1
         2/v4+aTBtagIf1HCsZ3HGVCRwgg9HJfVhbRnMSkjCuL3QgNg3LJHYPlkLItrFvXPAEhd
         ACLA==
X-Gm-Message-State: APjAAAWw6zMlrFn37Xav/aTNqTMu5n4Qc94f2hCXw2RDKuXwl3RT3+cs
        ZgKTABxGUbKOt3TFEtUt1VVapV/UYalkoYIT
X-Google-Smtp-Source: APXvYqx1o1DtNNRTcTBhLNI23ehxQ4CdCWRjmqnhH15kg0/eUecIs13rZ58FggoZBmX6HL/rpShgIg==
X-Received: by 2002:a0c:8a54:: with SMTP id 20mr5273084qvu.167.1553206558613;
        Thu, 21 Mar 2019 15:15:58 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:15:57 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: ASoC: tlv320aic26: Add device tree binding
Date:   Thu, 21 Mar 2019 18:15:44 -0400
Message-Id: <20190321221549.13765-3-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190321221549.13765-1-jcormier@criticallink.com>
References: <20190321221549.13765-1-jcormier@criticallink.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the TI tlv320aic26 sound codec

Signed-off-by: Cormier, Jonathan <jcormier@criticallink.com>
---
 .../devicetree/bindings/sound/tlv320aic26.txt | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic26.txt b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
new file mode 100644
index 000000000000..93aa0f76ec0d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/tlv320aic26.txt
@@ -0,0 +1,65 @@
+Texas Instruments - tlv320aic26 Codec module
+
+The tlv320aic26 serial control bus communicates through I2C protocols
+
+Required properties:
+
+- compatible - "string" - One of:
+    "ti,tlv320aic26" - TLV320AIC26
+- reg - <int> -  SPI chip select
+
+CODEC input pins:
+  * MICIN
+  * AUX
+
+CODEC output pins:
+  * HPL
+  * HPR
+
+The pins can be used in referring sound node's audio-routing property.
+
+Example:
+
+tlv320aic26: tlv320aic26@0 {
+	compatible = "ti,tlv320aic26";
+	reg = <0>;
+};
+
+&spi0 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-1 = <&spi0_sleep_pins>;
+
+	status = "okay";
+	ti,pindir-d0-out-d1-in = <1>;
+
+	tlv320aic26: tlv320aic26@1 {
+		compatible = "ti,tlv320aic26";
+		reg = <0x1>;
+		status = "okay";
+
+		spi-max-frequency = <2000000>;
+		spi-cpha;
+	};
+};
+
+sound {
+	compatible = "simple-audio-card";
+	simple-audio-card,name = "AM335x_SND";
+	simple-audio-card,format = "dsp_b";
+	/* SND_SOC_DAIFMT_CBM_CFM */
+	simple-audio-card,bitclock-master = <&tlv320aic26_codec>;
+	simple-audio-card,frame-master = <&tlv320aic26_codec>;
+	/* SND_SOC_DAIFMT_IB_NF */
+	simple-audio-card,bitclock-inversion;
+
+	simple-audio-card,cpu {
+		sound-dai = <&mcasp1>;
+		system-clock-frequency = <24576000>;
+	};
+
+	tlv320aic26_codec: simple-audio-card,codec {
+		sound-dai = <&tlv320aic26>;
+		system-clock-frequency = <24576000>;
+	};
+};
-- 
2.21.0

