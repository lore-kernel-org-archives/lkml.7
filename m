Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25709C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC423206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 11:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJKCzsXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfGaLTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 07:19:51 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:35111 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbfGaLTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 07:19:48 -0400
Received: by mail-wr1-f42.google.com with SMTP id y4so69253571wrm.2;
        Wed, 31 Jul 2019 04:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iwm4409GkWSovNI5a28ZeCS8PpOJ5Po1sAR5h0Q4NOk=;
        b=PJKCzsXg02GfsV86/cw/f0DH7KxeKUmb+cOQqTvmpYx2AMUeoD1o0XZsGpzMELUNQX
         4/QZ5OFf5xGIuBMSzaDjOFymvkKZ3nXAD4JrzDt8V3sqZ8/656TN+XigWvf/ooS7BdOz
         EdfAY7IXmfQo91bXW8Wg7H/yjbNJwNCSfJsGOSHv0y6f4BbZtlcGB0j4iXAqk0TWOQGe
         EhHIFkDrm/q1K++ZrnJEw/60WVMs4DRqgyOYh3M2vhuSkQEX2HEBzagXdUF2OWPDdwEr
         +VOQLU1LOzaifKYyHgAFCEznHO3/HUWiT6T5VvP4m17Mla0g556Gt2RS6HAhub8xSRPW
         R7eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iwm4409GkWSovNI5a28ZeCS8PpOJ5Po1sAR5h0Q4NOk=;
        b=o+rep3++3SD48dit6/fINDhYF4/tah/96kFAQ8/S7IAqsZj7HxMla9T68TnCEsvsLc
         TG0dxSvFd6KymILd9ly7oD06sXid6m1HHQ0XHMdPhV5yx6/6gb+HPI1iOPr/2AjgDU80
         kFa9AIoEtmX03Yuv7YLqhIKhTsQ/xiCTn9doRl46kVBvccghb5Hz+Ee+sLHnccaIsj5O
         WdzWMM5Kya1EePCi31nfBLtfFygW9582CURBNYR9ivMjZuKNuNhxmP7EKrmOyrQnwPi+
         XIZasGuqIlY+i0x6gqrZum3q/3ukC+OFIgcEFGVm8+KyaKVOyJldJYwip4B7C2IPkVHf
         Y4jQ==
X-Gm-Message-State: APjAAAXX3j22EwkY/nvQ5VpqdwN3L43Twb6LFVFHkCVPkhpIn/jy/UQT
        jHDfkIASDIgdTZJxMsOnSY0=
X-Google-Smtp-Source: APXvYqyusirBoYaJR6jtqQDE+MJXX+qRWwQpfIKjRG9oNIFQoc6F7W7Yrb2A9IBm1sQmBxCcX0qtQw==
X-Received: by 2002:adf:df8b:: with SMTP id z11mr77357896wrl.62.1564571985817;
        Wed, 31 Jul 2019 04:19:45 -0700 (PDT)
Received: from localhost.localdomain ([212.146.100.6])
        by smtp.gmail.com with ESMTPSA id b8sm88035205wmh.46.2019.07.31.04.19.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 04:19:45 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com,
        rf@opensource.wolfsonmicro.com, srinivas.kandagatla@linaro.org,
        piotrs@opensource.cirrus.com, paul@crapouillou.net,
        kmarinushkin@birdec.tech, anders.roxell@linaro.org,
        jbrunet@baylibre.com, m.felsch@pengutronix.de, vkoul@kernel.org,
        nh6z@nh6z.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.baluta@nxp.com
Subject: [PATCH 1/2] dt-bindings: sound: Add bindings for UDA1334 codec
Date:   Wed, 31 Jul 2019 14:19:29 +0300
Message-Id: <20190731111930.20230-2-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190731111930.20230-1-andradanciu1997@gmail.com>
References: <20190731111930.20230-1-andradanciu1997@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The UDA1334 is an NXP audio codec, supports the I2S-bus data format
and has basic features such as de-emphasis (at 44.1 kHz sampling
rate) and mute. Product information can be found at:
https://www.nxp.com/pages/low-power-audio-dac-with-pll:UDA1334

Cc: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Andra Danciu <andradanciu1997@gmail.com>
---
 Documentation/devicetree/bindings/sound/uda1334.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/uda1334.txt

diff --git a/Documentation/devicetree/bindings/sound/uda1334.txt b/Documentation/devicetree/bindings/sound/uda1334.txt
new file mode 100644
index 000000000000..f64071b25e8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/uda1334.txt
@@ -0,0 +1,17 @@
+UDA1334 audio CODEC
+
+This device uses simple GPIO pins for controlling codec settings.
+
+Required properties:
+
+  - compatible : "nxp,uda1334"
+  - nxp,mute-gpios: a GPIO spec for the MUTE pin.
+  - nxp,deemph-gpios: a GPIO spec for the De-emphasis pin
+
+Example:
+
+uda1334: audio-codec {
+	compatible = "nxp,uda1334";
+	nxp,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
+	nxp,deemph-gpios = <&gpio3 3 GPIO_ACTIVE_LOW>;
+};
-- 
2.11.0

