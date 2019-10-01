Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095F3ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D000820640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1TOMxkxe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387482AbfJALzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:55:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38763 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732634AbfJALzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:55:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id w12so15143347wro.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FPzLmAFxVlvoWlrn/cPfzD8ybuBQrABYqNe+NltmaKc=;
        b=1TOMxkxerDcDdYyn/c1uIZ/uj0DzxKShl5K/0P2F20uXlMC/bcb2a9kp/Ml83JiaM/
         nStHdsK13vmQlXn9VMOR42LNGxNuIbd8C3RKY01DILSPwTnSJZGR/oJIbJif6Wsh5K5B
         azww9ja9DlPp8yQY9HjnEPBlvy4DWPiYKLg4WD4eZmfBdUH7IKfDnl9/afRBKvTL9JoS
         I0qZQcB7YwdBvXDPz9CxLqkjhUpsGmE5Dm2/jfNx7d7WqswIM7mGP7KGU7BJswOv3zbm
         mC8y5kAP2rEd71fMe+wi1MWU02bTa8H/oiQ8VPSsSJ4pQVJfnNM9KrTe0bImFosGuLx7
         vnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FPzLmAFxVlvoWlrn/cPfzD8ybuBQrABYqNe+NltmaKc=;
        b=jF+XitLg04lru4jEt6EeVO2G72RLErGLEnQOG2vUsas9tWDng+rjcs/wSDw5Ld0Fk/
         Na/+5Kd8HR04xx1KHsz6llWhwaOGWjGthB6oOY67xuOxrby1in/+EjBaasMG0kBYvrCf
         Z8FTF+HWEUem5YTFE4GsJGDpM3YKzPc0CTwfFHnwocmV6OOeIbmZWoDOzB0uNxYf2qpz
         FlXWIR58MmM/6D99aX8LenOHxJ2LDbq2vjdW/J6cZLL3bNgwxSDCDxvKYMH61KSxpqMY
         bJyYmo6Py5myEAwiHhIAN4GhoB12SFpuGKxV0F4+DHzly1ZLxVC4DP7gALmSEv7yh493
         aLqw==
X-Gm-Message-State: APjAAAXPsHsBH5U7ZYxcdlh1KuIZOK77bKOaK5eiwEAgHTsA9guHwjFu
        GxnEHBDFfg88ak1Cs+qNvIqCQw==
X-Google-Smtp-Source: APXvYqwRX3j5tvwuz4L808TXtlgd4FkFR2XCdK6+VapPQ5njw/IymdIRWI98q3TvnLuFXi6YyC6Whg==
X-Received: by 2002:adf:cd81:: with SMTP id q1mr18294507wrj.185.1569930916922;
        Tue, 01 Oct 2019 04:55:16 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p85sm4052171wme.23.2019.10.01.04.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:55:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: clock: meson: add sm1 resets to the axg-audio controller
Date:   Tue,  1 Oct 2019 13:55:05 +0200
Message-Id: <20191001115511.17357-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001115511.17357-1-jbrunet@baylibre.com>
References: <20191001115511.17357-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the reset id of the sm1 audio clock controller

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../reset/amlogic,meson-g12a-audio-reset.h        | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
index 14b78dabed0e..f805129ca7af 100644
--- a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
@@ -35,4 +35,19 @@
 #define AUD_RESET_TOHDMITX	24
 #define AUD_RESET_CLKTREE	25
 
+/* SM1 added resets */
+#define AUD_RESET_RESAMPLE_B	26
+#define AUD_RESET_TOVAD		27
+#define AUD_RESET_LOCKER	28
+#define AUD_RESET_SPDIFIN_LB	29
+#define AUD_RESET_FRATV		30
+#define AUD_RESET_FRHDMIRX	31
+#define AUD_RESET_FRDDR_D	32
+#define AUD_RESET_TODDR_D	33
+#define AUD_RESET_LOOPBACK_B	34
+#define AUD_RESET_EARCTX	35
+#define AUD_RESET_EARCRX	36
+#define AUD_RESET_FRDDR_E	37
+#define AUD_RESET_TODDR_E	38
+
 #endif
-- 
2.21.0

