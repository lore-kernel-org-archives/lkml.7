Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398CBC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4C2177E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vdV2+uSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCMOKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:10:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbfCMOKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:10:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id k1so1643482wre.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 07:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ThcgAgIUY7O9XrYBBGUA2/BNqnwBcO+6XZhgqe7dvP8=;
        b=vdV2+uSoABqhZNGN1NH73leBNm+arX+U7uoFv85P38h3Npfnj01HxniEctHAmIZmAK
         EfAMIZPOzr1BGwG7B9bA807q7AtQsWzSQr2ahSWcF/yJ6K1CRvlXF0/uy6Gdc9C8XMSp
         wQFEeA8x4lje8DpUZfWoMTFmVbLncHtuug3g2gM6MoY/4SibvDPd/Ja//NE4r8dcUJxp
         XkOQlsFI3eHnchhRtaZQZftJ1KSLY7VkUVjW0JEzRWVyTlYObGdGrXnnACPpqTKazINA
         NxAMZb4EX01bEUTHL66bKDtprrxZ+U5OFa16DtRHxye6HlNyqHM+5MY/S6hLaiu/SloT
         2usg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ThcgAgIUY7O9XrYBBGUA2/BNqnwBcO+6XZhgqe7dvP8=;
        b=sBbZPqpcDxehecK8UEEJY30jXLbGJ0374LbLQVpi23kTWrsMras4OZujwT3DOedosP
         5kiWjVIl3NJqFSBMawFLiQ/kFuJqYImHJAYreD6YVajdfcqqDkyYf41/SmUuR6J6fyqb
         xbsTJ/dFW+6yI9ssl/LhIKQ9MydjHYyL+gUxKYRUjKEVIdAGFj3hJnkbsV+KUjuKtJD5
         k72h6D9ZDBl4sKd1+AeU9Oda32fn3cuEMBE+Nw79t4CweXdpgUAcKu4MwJF+in6+la4s
         n0fLoCfz3WgbwIVLkx2wEeNzGCAKz/mv17R4DY5b1Vf40MtJC6+4MR55j9r8N2N+AP56
         95Fw==
X-Gm-Message-State: APjAAAX25HC1Fxy3xBK38gEh9xllO9SHmEkreMzeVSw8GrpLhA6Bi02+
        dYcWh2ue3NCZePfG0MQ4PTcNFg==
X-Google-Smtp-Source: APXvYqxaEom5QURSmM3fg10ekFXL8LbuNi6nQRx/kLqvUFBGS107JotP3BrddQ8QQ6VnXmt2qRBuGg==
X-Received: by 2002:a05:6000:1152:: with SMTP id d18mr29214463wrx.128.1552486234424;
        Wed, 13 Mar 2019 07:10:34 -0700 (PDT)
Received: from localhost.localdomain (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id u17sm37300087wrg.71.2019.03.13.07.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 07:10:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: display: amlogic,meson-vpu: Add G12A compatible and ports
Date:   Wed, 13 Mar 2019 15:10:28 +0100
Message-Id: <20190313141030.5958-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313141030.5958-1-narmstrong@baylibre.com>
References: <20190313141030.5958-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A VPU is very similar to the Amlogic GXM VPU but with :
- an enhanced plane blender, with up to 3 OSD planes
- support for AFBC 1.2 decoder (for Bifrost GPU)
- support display mode up to 4k60@75Hz

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/amlogic,meson-vpu.txt         | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
index 419444e2b4d3..be40a780501c 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-vpu.txt
@@ -57,6 +57,7 @@ Required properties:
 	- GXL (S905X, S905D) : "amlogic,meson-gxl-vpu"
 	- GXM (S912) : "amlogic,meson-gxm-vpu"
 	followed by the common "amlogic,meson-gx-vpu"
+	- G12A (S905X2, S905Y2, S905D2) : "amlogic,meson-g12a-vpu"
 - reg: base address and size of he following memory-mapped regions :
 	- vpu
 	- hhi
@@ -83,6 +84,9 @@ corresponding to each VPU output.
  S905X (GXL)	CVBS VDAC	HDMI-TX
  S905D (GXL)	CVBS VDAC	HDMI-TX
  S912 (GXM)	CVBS VDAC	HDMI-TX
+ S905X2 (G12A)	CVBS VDAC	HDMI-TX
+ S905Y2 (G12A)	CVBS VDAC	HDMI-TX
+ S905D2 (G12A)	CVBS VDAC	HDMI-TX
 
 Example:
 
-- 
2.20.1

