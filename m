Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A7C76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71B62199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 09:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1yhteVtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbfGVJzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 05:55:05 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39216 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbfGVJyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 05:54:35 -0400
Received: by mail-wr1-f68.google.com with SMTP id x4so38679417wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 02:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FzybNdR15Qijg3J4fYjrwfuwdELElwLJSXj8hs/YBLw=;
        b=1yhteVtcPtFx4Ow5mRS1dEYidbu/9IxM9sPWNJNT45dOEo7E8OXzf6gEVZ9WGA/MTn
         I6w+jBuWDmggTJxDLUZlYKS8Y2muvq7EDEKDwEfO+CMDLCbuV6nKIOQBVICUfHRX7Lcj
         xBKAhXLscNeyht23Rn1AkeBZlgfokWedeKrfQICGs0WYR/wEEup+xhNjyD3dULRQ1aT+
         rMg9Z6IkCygJZK2Vf6/Jx8lsKQH/6drWnK4otqUQr7DjG6srtxP3MhLrxDXi0H4tAHno
         oSo6NRsyq7/rsUJLATSY+F9m+FXBVJmbUUrG3DYGA3hJh9sWT4Yn8VZG1KtSlzh8kBqd
         v4cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FzybNdR15Qijg3J4fYjrwfuwdELElwLJSXj8hs/YBLw=;
        b=fFuaYQrNrUHHN9zbCb4ElRi7f9NgjOGo68IDEFy55sWsulz9+CnlzbL7JbZ6lIy15z
         GutiLNq2NWlacwN4HvyW80IrKWTFmdKEGe0ErhfxCG+ulNwmXYtIhxQq6qHZBijl1NvB
         6eSfF8AHQL6Dhl/WRr30kpwbfxJeC/DRG6+9MIFeV0uoB0slQakbJCpGPh3C2ekchpHJ
         7e+wqhhqXVv4Vm1cpkymvB9qvWi2zGpR30TtLZBZocEoINW2WD4P58hrQ4qd5RIIh+xI
         qPNBSuOJ6p9ctR92Rvn5N1gnNpe7c3MrWAYRo4AUsyCk9Tv6y37LdTrN2jor/dCEBldM
         +udw==
X-Gm-Message-State: APjAAAUHCFiyEBTdhUjpNutU10+HSGxu5H5rwfwSshibiXs7DJZlVDhQ
        5TEB82fMf00eMMIGvulEI234i4YCCiM=
X-Google-Smtp-Source: APXvYqxz7bBeXcmL7PjwbF/jjbnawlFtyOHeGm6cHqounIFe8r151Sq4YxwMsZm5483RpcF7MmPOGg==
X-Received: by 2002:adf:f1d1:: with SMTP id z17mr895976wro.190.1563789274244;
        Mon, 22 Jul 2019 02:54:34 -0700 (PDT)
Received: from pop-os.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 91sm83158469wrp.3.2019.07.22.02.54.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 02:54:33 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     khilman@baylibre.com, sboyd@kernel.org, narmstrong@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        baylibre-upstreaming@groups.io,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH 6/8] clk: meson: clk-regmap: migrate to new parent description method
Date:   Mon, 22 Jul 2019 11:54:23 +0200
Message-Id: <20190722095425.14193-7-amergnat@baylibre.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190722095425.14193-1-amergnat@baylibre.com>
References: <20190722095425.14193-1-amergnat@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This clock controller use the string comparison method to describe parent
relation between the clocks, which is not optimized.

Migrate to the new way by using .parent_hws where possible (ie. when
all clocks are local to the controller) and use .parent_data otherwise.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 drivers/clk/meson/axg.c        |  3 +++
 drivers/clk/meson/clk-regmap.h | 12 ++++++------
 drivers/clk/meson/g12a.c       |  6 ++++++
 drivers/clk/meson/gxbb.c       |  3 +++
 drivers/clk/meson/meson8b.c    |  3 +++
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index 7a3d795cc614..13fc0006f63d 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -1096,6 +1096,9 @@ static struct clk_regmap axg_gen_clk = {
 	},
 };
 
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &axg_clk81.hw)
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(axg_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(axg_audio_locker, HHI_GCLK_MPEG0, 2);
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index 1dd0abe3ba91..c4a39604cffd 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -111,7 +111,7 @@ clk_get_regmap_mux_data(struct clk_regmap *clk)
 extern const struct clk_ops clk_regmap_mux_ops;
 extern const struct clk_ops clk_regmap_mux_ro_ops;
 
-#define __MESON_GATE(_name, _reg, _bit, _ops)				\
+#define __MESON_PCLK(_name, _reg, _bit, _ops, _pname)			\
 struct clk_regmap _name = {						\
 	.data = &(struct clk_regmap_gate_data){				\
 		.offset = (_reg),					\
@@ -120,15 +120,15 @@ struct clk_regmap _name = {						\
 	.hw.init = &(struct clk_init_data) {				\
 		.name = #_name,						\
 		.ops = _ops,						\
-		.parent_names = (const char *[]){ "clk81" },		\
+		.parent_hws = (const struct clk_hw *[]) { _pname },	\
 		.num_parents = 1,					\
 		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
 	},								\
 }
 
-#define MESON_GATE(_name, _reg, _bit)	\
-	__MESON_GATE(_name, _reg, _bit, &clk_regmap_gate_ops)
+#define MESON_PCLK(_name, _reg, _bit, _pname)	\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ops, _pname)
 
-#define MESON_GATE_RO(_name, _reg, _bit)	\
-	__MESON_GATE(_name, _reg, _bit, &clk_regmap_gate_ro_ops)
+#define MESON_PCLK_RO(_name, _reg, _bit, _pname)	\
+	__MESON_PCLK(_name, _reg, _bit, &clk_regmap_gate_ro_ops, _pname)
 #endif /* __CLK_REGMAP_H */
diff --git a/drivers/clk/meson/g12a.c b/drivers/clk/meson/g12a.c
index 5cad8cee142b..891140eaeefb 100644
--- a/drivers/clk/meson/g12a.c
+++ b/drivers/clk/meson/g12a.c
@@ -3318,6 +3318,12 @@ static struct clk_regmap g12a_ts = {
 	},
 };
 
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &g12a_clk81.hw)
+
+#define MESON_GATE_RO(_name, _reg, _bit) \
+	MESON_PCLK_RO(_name, _reg, _bit, &g12a_clk81.hw)
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(g12a_ddr,			HHI_GCLK_MPEG0,	0);
 static MESON_GATE(g12a_dos,			HHI_GCLK_MPEG0,	1);
diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 65ba08c210d2..45b4c0e62d7a 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -2576,6 +2576,9 @@ static struct clk_regmap gxbb_gen_clk = {
 	},
 };
 
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &gxbb_clk81.hw)
+
 /* Everything Else (EE) domain gates */
 static MESON_GATE(gxbb_ddr, HHI_GCLK_MPEG0, 0);
 static MESON_GATE(gxbb_dos, HHI_GCLK_MPEG0, 1);
diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 8d0e362d750d..3414e573b8a1 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2550,6 +2550,9 @@ static struct clk_regmap meson8b_cts_i958 = {
 	},
 };
 
+#define MESON_GATE(_name, _reg, _bit) \
+	MESON_PCLK(_name, _reg, _bit, &meson8b_clk81.hw)
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
-- 
2.17.1

