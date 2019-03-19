Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C2F6C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 191D62085A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZxUKT2TS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbfCSWAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:00:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33482 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727579AbfCSWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:00:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1so571109wrp.0;
        Tue, 19 Mar 2019 15:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HPJWUCkniYvFY+imhTP05E2QTQFEXxZDTbw3Sd6sRqw=;
        b=ZxUKT2TSevAgrqWAeyDkL7kMnPgX9wG76QY78B/j1EFVaRVoqp/cIhSXZp7ObYXR83
         hmjVm5rLdROjVoNWpFWljkxYe2FOli92vg4kXGFlfkiRzmWI/G0sVf+Me4bVrFp/rMzg
         sTuZz4Xl8qIaPutzTiyDK2Ei1+3eW6hwisAbSyIlfG/Hafnf6H2PWA/lfqz5BvQrzLnf
         Hda+HR9mCkFwvS8e0np25pX5vtbJErS0qCejHZ/j8nccgqbNGPMh+2JmV3sZ0t192lPJ
         WtSPVdz/ndMzxI6XQXIPOEiv75da3aPh8y5XHlJif+BfeYkoVMbEDSD3R5RhdDmly1BB
         GV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HPJWUCkniYvFY+imhTP05E2QTQFEXxZDTbw3Sd6sRqw=;
        b=shif7Hv4qXLstL/zIfwUkIH1ULtAfYjCNq6a42137lsUNfgP1S/Jes6UHE20Ei4hLC
         OK0++oEOOY/+8uKiyxXIWfR6YtsdCdziYKyuLd7onoVrpw9zF3J4cwtLF/UHtHv1J58p
         RvQy2zrTyj8wZ0c/ayKs1MlBjG+ylph0R2IqtzDNcELG2F1e90qTR0X4jk9xnWvDZjGo
         2aHPIfPLiSVODngzfxX0BPCzQsstFBuK+Nf59nz7vr7vsu0/F387dWOGo8d4gs2viklt
         VghNLRlGb5qWJQyHWBRnB+GU7n08JwHDy27uZLcKxSgtFwtvnZe203VJBIrNccVxWLH/
         dd4Q==
X-Gm-Message-State: APjAAAWtNhq2QDYlT23xFwdHj1vjmdjBr5YnMglarSpi16spRMl1gVoI
        cPP8PrjnnFidCsat1u321TY=
X-Google-Smtp-Source: APXvYqzK2qpxgoN6tORX1kKcVUX1G2I4S1haicPGoTAukPQWgW24KWlMGBtWNuc1He4Ymqd907E2cw==
X-Received: by 2002:adf:fecb:: with SMTP id q11mr18099730wrs.252.1553032818090;
        Tue, 19 Mar 2019 15:00:18 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD739990039EE738515149D3E.dip0.t-ipconnect.de. [2003:dc:d739:9900:39ee:7385:1514:9d3e])
        by smtp.googlemail.com with ESMTPSA id t2sm188762wra.9.2019.03.19.15.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 15:00:17 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, mjourdan@baylibre.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] dt-bindings: clock: meson8b: export the video decoder clocks
Date:   Tue, 19 Mar 2019 23:00:11 +0100
Message-Id: <20190319220012.31065-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319220012.31065-1-martin.blumenstingl@googlemail.com>
References: <20190319220012.31065-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the four video decoder clocks so they can be used by the video
decoder driver:
- VDEC_1
- VDEC_HCODEC
- VDEC_2
- VDEC_HEVC

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index 2ac9469a1c27..47556539f0ee 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -108,5 +108,9 @@
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
 #define CLKID_VPU		190
+#define CLKID_VDEC_1		196
+#define CLKID_VDEC_HCODEC	199
+#define CLKID_VDEC_2		202
+#define CLKID_VDEC_HEVC		206
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.21.0

