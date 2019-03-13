Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34208C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 027A12177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="gPh/b2mA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfCMOKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:10:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41186 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfCMOKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:10:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id p1so2164149wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dFltVTTIBZgf7EPxKhmfyxB1paniCagV+jr7vZ0xeU=;
        b=gPh/b2mAyu9iIO8e5FmSEEeNsZU+k4ABUhcz6taosG+W/43FzjuesTbT/xbF8LG0N3
         +d4b+8EwFQYpBAXYQhd+v0QqLYUZVxyyynrM2WGQC60Uc8OYYs/Za6hBBodbfC4eqwat
         MbJU2u0rPmFEHGonKqXvvD40Xf8LkqGU8xMI73ZIpS3Z21LjzQwpcSkP2whiU8FcrUPV
         0hNU4lMTzxaO4V1nxI2+PHdz4jB7E9TAmv7MN/hi9beLMDl98VNCYNcdVoEXM8b2Kdm5
         rNRUu6zwkLi2niw5TmPaxzOXbKlWPguJarqxiL/mNKR2zEdXpKMIQs3FUN/yRctSJNCA
         hDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dFltVTTIBZgf7EPxKhmfyxB1paniCagV+jr7vZ0xeU=;
        b=EhqbzeGVXHapFqtfPt5e+5tq+92KEkLqHwD9IenVGgYTN6vxe518XpnWcddi2LuchM
         P1IH4YlS30/KsKTGS6azoZwi4azQDiuU4cS2TDzq3Nmn89oAWw+hE8LouRjMYea2W5GM
         wgz8UmHhddaeeuCxowMtH7E6IihUx12LjYau85FJybGy5ttz8x9J7LXNMXaYvlEM+XEw
         E4k0mUl+ttau/TvoxMk68gIJf4ugRRtECg82KSVOeqqZs3js0ceebQSTRuMjbLai+oUg
         Y+Et5UIE1BLqXvQCdvzL0XGbDkypIzHJjAsPKR7qRVXDRR80Wh0fDCkYJGE82nvaUwum
         jdlw==
X-Gm-Message-State: APjAAAUPZPKEacHw5MSov3Ux+Fx4vpmfbembCX7q0Tbftb5A4KhrVo8i
        tXzKeeU+9G+/Z8MWl/r1e46Peg==
X-Google-Smtp-Source: APXvYqzZZRuTFtwlSlR1qsDLjb0r8Rqez2To1LrA4h6BhkSGzv/axIEFgfSG439pWnhQot8ngreNSg==
X-Received: by 2002:adf:9cc3:: with SMTP id h3mr26711989wre.47.1552486238169;
        Wed, 13 Mar 2019 07:10:38 -0700 (PDT)
Received: from localhost.localdomain (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u17sm37300087wrg.71.2019.03.13.07.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 07:10:37 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt-bindings: power: amlogic,meson-gx-pwrc: Add G12A compatible
Date:   Wed, 13 Mar 2019 15:10:30 +0100
Message-Id: <20190313141030.5958-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313141030.5958-1-narmstrong@baylibre.com>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A has a slighly different Power Control, but uses the
same address space and sysctrl registers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/power/amlogic,meson-gx-pwrc.txt       | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
index 1cd050b4054c..0fdc3dd1125e 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-gx-pwrc.txt
@@ -16,7 +16,9 @@ Device Tree Bindings:
 ---------------------
 
 Required properties:
-- compatible: should be "amlogic,meson-gx-pwrc-vpu" for the Meson GX SoCs
+- compatible: should be one of the following :
+	- "amlogic,meson-gx-pwrc-vpu" for the Meson GX SoCs
+	- "amlogic,meson-g12a-pwrc-vpu" for the Meson G12A SoCs
 - #power-domain-cells: should be 0
 - amlogic,hhi-sysctrl: phandle to the HHI sysctrl node
 - resets: phandles to the reset lines needed for this power demain sequence
-- 
2.20.1

