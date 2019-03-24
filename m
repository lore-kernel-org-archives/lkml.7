Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2456222F1
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 15:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="VEk475Mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbfCXPLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 11:11:39 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38298 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726743AbfCXPLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 11:11:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id g12so7285585wrm.5;
        Sun, 24 Mar 2019 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/aX+bb8PFceeKnvljRRNWRZVPF9zpndQkTw/LqXznMw=;
        b=VEk475Mgy7dLwJk30j06KI9541LPbsq8gvsrWCdXCZpPYZUS0Wtg6M2j0/RS68li/v
         RTvKOhrNLE3VnmOCWPNk6j4GcKqo2wsdc6PI/nGZmWPBegFy8tnSULpVXtFYKZCZ/M4L
         B16um84ARIIDSa6jdw3hn/O690DhMuwJXkW4kaB1eBzQ3WcAlzbN0i50tQPZjuVVVyJa
         2dSTgx31QNj/IZEdQ7Bw93HaUNV1EBH4LLBeohUdMxA5ZbyUTxRnIW7M/fA27BF4u5yM
         kBPiMmIg++r7WPyCM+U+j/YoLBBVUgc3baXVdAd/v56VDW+dwMDR8Zg4NiiYvqja6B5x
         SG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/aX+bb8PFceeKnvljRRNWRZVPF9zpndQkTw/LqXznMw=;
        b=TDyjMcoEH7uCuSIxPjujg9A5hoRamdz9ZWzgG0TQ1Z5zdC5Q16H77QZlPGyrpSWJWp
         mBA9ph+7ZoDYEUgZpEeVJznhFcmDzLFStwVDxyvqBd/RHc4nD44TJIqzyjTnIwpY43hy
         BnyBcTDHfpVhUmrP66ZBYeiXU3lnUCnFzUXHukvfzK1i6VQowtwwmR2PP1Y18HIDD6EN
         8Qap0ml3k72d9o4DvhDcLEf++znlC4u3fH1qTvdx3NVFTT4LnVRZgW3MOf9xoGP2T97u
         REdhnz+VZqAEHKh92BFlJhlkpPaMdoHzmnrjsN9snWJBNJhhCpYvsJpMu2XBaoXZazsT
         4irg==
X-Gm-Message-State: APjAAAX3qSSMG88bgJkPMQWwKHWgAglCRsa5IbqL++031MAjjeaRrkZR
        Y89GPDh7q2LdYF5kZCQ6dck=
X-Google-Smtp-Source: APXvYqxScdwrM4eIEsBPhkRN5sSNAwwKtmhAIR2fLlKj8HN8jHEN5luPKHUVA8y9/ShP4v4ACpzGfw==
X-Received: by 2002:a05:6000:1286:: with SMTP id f6mr12715748wrx.93.1553440294374;
        Sun, 24 Mar 2019 08:11:34 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 66sm13697730wmd.3.2019.03.24.08.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 08:11:33 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/4] dt-bindings: clock: meson8b: export the VPU clock
Date:   Sun, 24 Mar 2019 16:11:01 +0100
Message-Id: <20190324151104.18397-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
References: <20190324151104.18397-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VPU clock is an input the the "VPU" (Video Processing Unit), which is
one of the components of the display controller.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 include/dt-bindings/clock/meson8b-clkc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/meson8b-clkc.h b/include/dt-bindings/clock/meson8b-clkc.h
index cd11628f50f8..2ac9469a1c27 100644
--- a/include/dt-bindings/clock/meson8b-clkc.h
+++ b/include/dt-bindings/clock/meson8b-clkc.h
@@ -107,5 +107,6 @@
 #define CLKID_PERIPH		126
 #define CLKID_AXI		128
 #define CLKID_L2_DRAM		130
+#define CLKID_VPU		190
 
 #endif /* __MESON8B_CLKC_H */
-- 
2.21.0

