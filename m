Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB74CC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3972084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="SCQbuMXB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfCYOSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:18:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38436 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbfCYOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:18:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id k11so2960294wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wk5eCyYYv31k2oS3w2ZiDp1VuybJTj9k6eSCZMRaQZw=;
        b=SCQbuMXB5jIJeL76+Af2Bo0bADhuPEvmbfzePjCIbGxKi9AD6BwIfAtm/x2N5LnoGw
         cLIzarD0HfS2d1tB6fN5UNnw+Lhv913ZZ9ZSinSThfmVfVGQGABVD6dhgTXXwVFJgLJZ
         Dud+AB+DI+8NDJWzUWqiV677+C0wh/wB06nHk+otX+ylcn4hKddffgEtWKc7/mkXDqS3
         mObj1YKDn4domlVxb2+XgKC2tXRCq4B+I0RfI+gFyE2Wjswk8rdmAKIw+9M8t2HeSjlf
         IFi+GKcg8NJyJIIL9ZcS3QoUunEAHgQtM5qfffyv8dFgoUtxZnmwBXk6wiousy1/29os
         qn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wk5eCyYYv31k2oS3w2ZiDp1VuybJTj9k6eSCZMRaQZw=;
        b=V5yE6MHlHVwjKNsOQ7ADL681gTF20EPIv8D55DvMy19h4r55yFn7mfPxcQBBOeSxqj
         K+5GzK9WpV7wLCOKxAXoYzcjZ0vKuz5h668cPznWOH3U6nKz50QbWpTeWorqnIA6s4uD
         j4WKd4FbF6kY+qrq37ssLL1ghoc0uUDIEzL3kA5jJEBWgFTd8vidYiN/tfAUpAHNyiZl
         YYpddLFRx+V0VgTIz02eanIGPRuWRCcdZLJ4mShMKmn1OENLsM7h+KCgtX6TxSx8PLV2
         Z7Y/JzoeoYmuahvDY9EAQhNh0K+Pwf1S3bkWYtYQnGZZgNhYqQ3mAMSF7+u4Vc/ixZnv
         mcDA==
X-Gm-Message-State: APjAAAVdn9kuG1Ntp/SqgwZW2PN1dTDKBCaGbqSe9tGslPUwhpjaQT9S
        SvNHY5aCisxuHNLx6YEplQcIsg==
X-Google-Smtp-Source: APXvYqz8LLIbUN5C5n2zF5H4AYmB1ystJrAyAxQH1Kht9XphIAFYGviyXT3lZZru5qGA58Z+gEwzuw==
X-Received: by 2002:adf:f1ce:: with SMTP id z14mr15648482wro.152.1553523511285;
        Mon, 25 Mar 2019 07:18:31 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id 132sm26976794wmd.30.2019.03.25.07.18.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:18:30 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] drm/meson: Add G12A Support for VPP setup
Date:   Mon, 25 Mar 2019 15:18:16 +0100
Message-Id: <20190325141824.21259-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190325141824.21259-1-narmstrong@baylibre.com>
References: <20190325141824.21259-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amlogic G12A needs a different VPP setup code, handle it here.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/meson/meson_vpp.c | 51 ++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_vpp.c b/drivers/gpu/drm/meson/meson_vpp.c
index f9efb431e953..8c52a3455ef4 100644
--- a/drivers/gpu/drm/meson/meson_vpp.c
+++ b/drivers/gpu/drm/meson/meson_vpp.c
@@ -112,32 +112,39 @@ void meson_vpp_init(struct meson_drm *priv)
 		writel_relaxed(0x20000, priv->io_base + _REG(VPP_DOLBY_CTRL));
 		writel_relaxed(0x1020080,
 				priv->io_base + _REG(VPP_DUMMY_DATA1));
-	}
+	} else if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		writel_relaxed(0xf, priv->io_base + _REG(DOLBY_PATH_CTRL));
 
 	/* Initialize vpu fifo control registers */
-	writel_relaxed(readl_relaxed(priv->io_base + _REG(VPP_OFIFO_SIZE)) |
-			0x77f, priv->io_base + _REG(VPP_OFIFO_SIZE));
+	if (meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu"))
+		writel_relaxed(0xfff << 20 | 0x1000,
+			       priv->io_base + _REG(VPP_OFIFO_SIZE));
+	else
+		writel_relaxed(readl_relaxed(priv->io_base + _REG(VPP_OFIFO_SIZE)) |
+				0x77f, priv->io_base + _REG(VPP_OFIFO_SIZE));
 	writel_relaxed(0x08080808, priv->io_base + _REG(VPP_HOLD_LINES));
 
-	/* Turn off preblend */
-	writel_bits_relaxed(VPP_PREBLEND_ENABLE, 0,
-			    priv->io_base + _REG(VPP_MISC));
-
-	/* Turn off POSTBLEND */
-	writel_bits_relaxed(VPP_POSTBLEND_ENABLE, 0,
-			    priv->io_base + _REG(VPP_MISC));
-
-	/* Force all planes off */
-	writel_bits_relaxed(VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND |
-			    VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND |
-			    VPP_VD1_PREBLEND | VPP_VD2_PREBLEND, 0,
-			    priv->io_base + _REG(VPP_MISC));
-
-	/* Setup default VD settings */
-	writel_relaxed(4096,
-			priv->io_base + _REG(VPP_PREBLEND_VD1_H_START_END));
-	writel_relaxed(4096,
-			priv->io_base + _REG(VPP_BLEND_VD2_H_START_END));
+	if (!meson_vpu_is_compatible(priv, "amlogic,meson-g12a-vpu")) {
+		/* Turn off preblend */
+		writel_bits_relaxed(VPP_PREBLEND_ENABLE, 0,
+				    priv->io_base + _REG(VPP_MISC));
+
+		/* Turn off POSTBLEND */
+		writel_bits_relaxed(VPP_POSTBLEND_ENABLE, 0,
+				    priv->io_base + _REG(VPP_MISC));
+
+		/* Force all planes off */
+		writel_bits_relaxed(VPP_OSD1_POSTBLEND | VPP_OSD2_POSTBLEND |
+				    VPP_VD1_POSTBLEND | VPP_VD2_POSTBLEND |
+				    VPP_VD1_PREBLEND | VPP_VD2_PREBLEND, 0,
+				    priv->io_base + _REG(VPP_MISC));
+
+		/* Setup default VD settings */
+		writel_relaxed(4096,
+				priv->io_base + _REG(VPP_PREBLEND_VD1_H_START_END));
+		writel_relaxed(4096,
+				priv->io_base + _REG(VPP_BLEND_VD2_H_START_END));
+	}
 
 	/* Disable Scalers */
 	writel_relaxed(0, priv->io_base + _REG(VPP_OSD_SC_CTRL0));
-- 
2.21.0

