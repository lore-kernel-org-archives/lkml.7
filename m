Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A5C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA9EE20863
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 20:03:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IX7WNp2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfETUDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 16:03:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55576 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfETUDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 16:03:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id x64so583464wmb.5;
        Mon, 20 May 2019 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=do0dKBdes1ma1vSqJcaos6AAvi/dpG1xqDF1uEcr96s=;
        b=IX7WNp2h3OoeEP1kMReGf8ZvQsHhieYCtYrGNrzNgPAabFO9RFZj0G2yrehUXRbGdZ
         5RhJq+Lzn4nvDTo+ZTStdwmg8dz7IhlszdHFkksOVKuOgGGhp0aHWq8gDpqhDBDwBhg3
         vf+woIYXk2rmo9VDdDOqHnxVjsuoVnmsK0qYbRRLuFizo/C9BmZ2b7jxtLMqn68T/DnY
         mwFyJ91QdG12cOTPAnglCXosmPh4d79vpsMKAf2rxzvXD0A0MkjsRPe6WlTIaysUyaa8
         cLdU68JcNllPY5GUI5Pa1/eeuH5t/kkjuQOoyDLSrV98ynjAILH2y/MatgPRY+NdaInX
         Apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=do0dKBdes1ma1vSqJcaos6AAvi/dpG1xqDF1uEcr96s=;
        b=tA7/NLL53Rc7OcRCHdzUoUAOq6bRI+fgjGnuX3nHJ2kzGmk6LGV0QMIJn2Vnf5ljZj
         mfEq5saT4x1eDfHWbcA46P/RBOXYLoILKtpcKdITYao3Tt1z74eSnoEC6CDaFlgE8tH6
         nbaTNwXS+5b6JFmd6BxhCqry299+pMf7zpPfocfd0X1mPemqhCJHP+UIge2uJjqnRSf3
         88CejMwQHqwCbhk9YFBC5K0u1UiGEVayCd+l0ljxhqGjX5lFokR4PvKJ3Ye7TUkCcYSw
         8mMlPlJQKTOrCcHm75EfK+3xGNG3NwQziRdbtl1RKOQbega0DubUAfAHE3FRYMlUn9F+
         W7EQ==
X-Gm-Message-State: APjAAAURBFV9WaF7InAYQnjze/d6gTxp9OLHUkEoCy/b4Gcufl0oS6+Z
        JNHlvS25s49oKOSGC7tHaBs=
X-Google-Smtp-Source: APXvYqy9p/CmdbIKMiBY9W6jTMEHHTN6rUdiBTPoRPeTt56omD+TOTEfxBv7/Mwx3XTWgPEXlTjgiA==
X-Received: by 2002:a1c:a846:: with SMTP id r67mr620804wme.24.1558382613169;
        Mon, 20 May 2019 13:03:33 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133EE71009C356FA1F0E19AF9.dip0.t-ipconnect.de. [2003:f1:33ee:7100:9c35:6fa1:f0e1:9af9])
        by smtp.googlemail.com with ESMTPSA id t7sm23583379wrq.76.2019.05.20.13.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 May 2019 13:03:32 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/4] clk: meson: meson8b: add the cts_i958 clock
Date:   Mon, 20 May 2019 22:03:19 +0200
Message-Id: <20190520200319.9265-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
References: <20190520200319.9265-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the cts_i958 clock to control the clock source of the spdif output
block. It is used to select whether the clock source of the spdif output
is cts_amclk (when data are taken from i2s buffer) or the cts_mclk_i958
(when data are taken from the spdif buffer). The setup for this clock is
identical to GXBB, so this ports commit 7eaa44f6207fb6 ("clk: meson:
gxbb: add cts_i958 clock") to the Meson8/Meson8b/Meson8m2 clock driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 24 ++++++++++++++++++++++++
 drivers/clk/meson/meson8b.h |  2 +-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 13ce1783eead..537219fa573e 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -2259,6 +2259,26 @@ static struct clk_regmap meson8b_cts_mclk_i958 = {
 	},
 };
 
+static struct clk_regmap meson8b_cts_i958 = {
+	.data = &(struct clk_regmap_mux_data){
+		.offset = HHI_AUD_CLK_CNTL2,
+		.mask = 0x1,
+		.shift = 27,
+		},
+	.hw.init = &(struct clk_init_data){
+		.name = "cts_i958",
+		.ops = &clk_regmap_mux_ops,
+		.parent_names = (const char *[]){ "cts_amclk",
+						  "cts_mclk_i958" },
+		.num_parents = 2,
+		/*
+		 * The parent is specific to origin of the audio data. Let the
+		 * consumer choose the appropriate parent.
+		 */
+		.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_NO_REPARENT,
+	},
+};
+
 /* Everything Else (EE) domain gates */
 
 static MESON_GATE(meson8b_ddr, HHI_GCLK_MPEG0, 0);
@@ -2544,6 +2564,7 @@ static struct clk_hw_onecell_data meson8_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
+		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2759,6 +2780,7 @@ static struct clk_hw_onecell_data meson8b_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
+		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -2976,6 +2998,7 @@ static struct clk_hw_onecell_data meson8m2_hw_onecell_data = {
 		[CLKID_CTS_MCLK_I958_SEL]   = &meson8b_cts_mclk_i958_sel.hw,
 		[CLKID_CTS_MCLK_I958_DIV]   = &meson8b_cts_mclk_i958_div.hw,
 		[CLKID_CTS_MCLK_I958]	    = &meson8b_cts_mclk_i958.hw,
+		[CLKID_CTS_I958]	    = &meson8b_cts_i958.hw,
 		[CLK_NR_CLKS]		    = NULL,
 	},
 	.num = CLK_NR_CLKS,
@@ -3171,6 +3194,7 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
 	&meson8b_cts_mclk_i958_sel,
 	&meson8b_cts_mclk_i958_div,
 	&meson8b_cts_mclk_i958,
+	&meson8b_cts_i958,
 };
 
 static const struct meson8b_clk_reset_line {
diff --git a/drivers/clk/meson/meson8b.h b/drivers/clk/meson/meson8b.h
index c3787418088e..c889fbeec30f 100644
--- a/drivers/clk/meson/meson8b.h
+++ b/drivers/clk/meson/meson8b.h
@@ -178,7 +178,7 @@
 #define CLKID_CTS_MCLK_I958_SEL	210
 #define CLKID_CTS_MCLK_I958_DIV	211
 
-#define CLK_NR_CLKS		213
+#define CLK_NR_CLKS		214
 
 /*
  * include the CLKID and RESETID that have
-- 
2.21.0

