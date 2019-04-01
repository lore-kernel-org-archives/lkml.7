Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE447C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 979D121841
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1PZNLNkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfDAIUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:20:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51466 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbfDAIUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:20:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so9323740wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 01:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LP1GDjllfpczPTet5xNq5bDA1vK9bUccs+ExPgY6qfw=;
        b=1PZNLNkckfq8xTd+uNEY6gpitC2ZtLcwvqHy5dzgaRExsDLdJUAq/Op6HUAjFPwhO8
         RD1dLIFyatxH9znQGQCpUOqBlZAtZB9nYTjKK1h4MoPAsqD/VYenfiseRK6UUabZmahY
         ypfxqVWexc0QxSF5LZ1XWYq7UO2vZFGn0/ooyAXTlSSW05wiHcNk+dpNyNk8BQ1IWxXJ
         kV702bYXTST2nmnl+EaM/VLUqWMHWQjv1rxURPQ2I+CDYUUFtpmcZL7XiwgjWHEzot9g
         a67OSn/5bNmfO398OZ6tjaEOMrYpR0v2eOvW+51mrYCzHYUJSUm8MPY9krzwfNOc6e14
         8JGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LP1GDjllfpczPTet5xNq5bDA1vK9bUccs+ExPgY6qfw=;
        b=qJ49G30bEzrjBL7jJbsSJxrR2X2oZImo7yr2cKLDH+hcvAEVKGugyuKTXD3MDf0I1b
         7w5vOq94uEzo5ANvIpui4LaKWhHC2AxI7JxObE7IZkwB9VhX8QEKcM5baVtOx8KegjHt
         N5l8yoZLRTi4Y8lbXxs4xixI5/CQx0/bSwk5zkhH9TkDv8r+WV1jP7Ayti21X8OPniU4
         euCVOkRI8QudxKaSsBawm0d5DyyXkHbOqHaiecN5//8HiYKhWlDRkwGcA4i9uUJQZgQu
         usnXLajsjZrrXB4S6ySUSv0TtdB+uc/OHbnURLXcVkcSslXxawA46W2/EZZxWYlYk/lq
         Kr6Q==
X-Gm-Message-State: APjAAAVYZ4vpbutN1o4/GIjdxOssjpi8SuXQouUj/+MqgkBlYUpAdcKG
        3v8s5Egf65mlEDuhD5HXhHO1SA==
X-Google-Smtp-Source: APXvYqyjhMOXxDcnRSPa1BeNDjB/ZTcWElG0lMOA/TJpy/8yYNCDEEfa6GeMHcL3EmnfaGltyVFx1g==
X-Received: by 2002:a1c:67c2:: with SMTP id b185mr11730949wmc.68.1554106803091;
        Mon, 01 Apr 2019 01:20:03 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id r196sm10053534wmf.22.2019.04.01.01.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Apr 2019 01:20:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     hverkuil@xs4all.nl, mchehab@kernel.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] media: dt-bindings: media: meson-ao-cec: Add G12A AO-CEC-B Compatible
Date:   Mon,  1 Apr 2019 10:19:57 +0200
Message-Id: <20190401081959.16474-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401081959.16474-1-narmstrong@baylibre.com>
References: <20190401081959.16474-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A embeds a second CEC controller named AO-CEC-B, and
the other one is AO-CEC-A described by the current bindings.

The register interface is very close but the internal architecture
is totally different.

The other difference is the clock source, the AO-CEC-B takes the
"oscin", the Always-On Oscillator clock, as input and embeds a
dual-divider clock divider to provide the precise 32768Hz base
clock for CEC communication.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/media/meson-ao-cec.txt      | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/meson-ao-cec.txt b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
index 8671bdb08080..c67fc41d4aa2 100644
--- a/Documentation/devicetree/bindings/media/meson-ao-cec.txt
+++ b/Documentation/devicetree/bindings/media/meson-ao-cec.txt
@@ -4,16 +4,23 @@ The Amlogic Meson AO-CEC module is present is Amlogic SoCs and its purpose is
 to handle communication between HDMI connected devices over the CEC bus.
 
 Required properties:
-  - compatible : value should be following
+  - compatible : value should be following depending on the SoC :
+	For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
 	"amlogic,meson-gx-ao-cec"
+	For G12A (AO_CEC_B module) :
+	"amlogic,meson-g12a-ao-cec"
 
   - reg : Physical base address of the IP registers and length of memory
 	  mapped region.
 
   - interrupts : AO-CEC interrupt number to the CPU.
   - clocks : from common clock binding: handle to AO-CEC clock.
-  - clock-names : from common clock binding: must contain "core",
-		  corresponding to entry in the clocks property.
+  - clock-names : from common clock binding, must contain :
+		For GXBB, GXL, GXM and G12A (AO_CEC_A module) :
+		- "core"
+		For G12A (AO_CEC_B module) :
+		- "oscin"
+		corresponding to entry in the clocks property.
   - hdmi-phandle: phandle to the HDMI controller
 
 Example:
-- 
2.21.0

