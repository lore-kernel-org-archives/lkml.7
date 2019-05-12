Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69492C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3961B20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="D7EZkZWp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfELTnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 15:43:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34360 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbfELTnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:43:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id m20so9845829wmg.1;
        Sun, 12 May 2019 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AqfzzZgYh773xcVhaI6uUR4lAMlHwzAkWA/UkOzUZ64=;
        b=D7EZkZWpd252npUWFhFf2WXhLBZPNYbIIOokNB+eEc385EcmLuDkq/0rM76ytoIXDr
         /IK0+sF2f3Kq+kT3hmPV72GWZQcj3u0QMXdzOgIX3XpNA7ZQpALbltmFzMKv4XQiLK2H
         c1U3v4RL7KyYKkQrVi63+MaDyF9d1Fz60n5I45HUiwBAlRQbCJe8QXCmj7UX8GUzoFek
         daRr9vIwh/67yncmj95i022mp8xph+BoaQoYH3oG34oxJkM7tdK9/vnNfZxjwDCBMxJJ
         bhL2X2He7dHlJSZbLupQWgPQx1EHHRGMLuNJZG7HrF/DYnzx36uAHq5E0EnUvPeFyRCe
         e9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AqfzzZgYh773xcVhaI6uUR4lAMlHwzAkWA/UkOzUZ64=;
        b=RMldcOMvGIdgbHSOEauDRIIcxt1hX6zNWn6v8ei+HubGLTiJpIHBvpd9i5THKWGHOi
         U9KPkFtBdFWt5tyktNwiHSiTLClOu9vdFrWgkuBi+ILnvqMRW8cayZd4h8UPYolrti2g
         GfSDo0khkqzUV8xlVcaOey+4RMhAZMUhzvzx32FYSBLUty8DTzOq1rj7alesKod/bTZR
         yXZrR2VfxWUL8PhUD662XiLf+Xf3JjgfJOPWSsWcJTW6EHhU+lFBdJauZOfqYrsfSowQ
         yxeduLC/9ILHD8Dr3ZtXSN368xKHKs8TV8Q40k1ntQTFPZRU3u/sKk+DFDOcn3mJ4BSU
         629A==
X-Gm-Message-State: APjAAAWAu/ZxkrFsDv/J0O5vyP8+2YJY8ZEAmUrr0X4kne/SomzRJ9Hf
        LlgQTdlxULJ4tHMRdsfLUfc=
X-Google-Smtp-Source: APXvYqxst1IMmq0aCd4wGUOWu4F2rwedBjwlTWWdXmF/1nnjuBDeUJsPP7ROf9mWcgMxqv5G7bnQ2g==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr1518472wmf.132.1557690192455;
        Sun, 12 May 2019 12:43:12 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133C8AD00ECBE9107EA8EB108.dip0.t-ipconnect.de. [2003:f1:33c8:ad00:ecbe:9107:ea8e:b108])
        by smtp.googlemail.com with ESMTPSA id r23sm13685178wmh.29.2019.05.12.12.43.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 12:43:11 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, narmstrong@baylibre.com,
        jbrunet@baylibre.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/1] clk: meson: meson8b: fix a typo in the VPU parent names array variable
Date:   Sun, 12 May 2019 21:43:00 +0200
Message-Id: <20190512194300.7445-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190512194300.7445-1-martin.blumenstingl@googlemail.com>
References: <20190512194300.7445-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable which holds the parent names for the VPU clocks has a typo
in it. Fix this typo to make the variable naming in the driver
consistent. No functional changes.

Fixes: 41785ce562491d ("clk: meson: meson8b: add the VPU clock trees")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 37cf0f01bb5d..62cd3a7f1f65 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -1761,7 +1761,7 @@ static struct clk_regmap meson8m2_gp_pll = {
 	},
 };
 
-static const char * const mmeson8b_vpu_0_1_parent_names[] = {
+static const char * const meson8b_vpu_0_1_parent_names[] = {
 	"fclk_div4", "fclk_div3", "fclk_div5", "fclk_div7"
 };
 
@@ -1778,8 +1778,8 @@ static struct clk_regmap meson8b_vpu_0_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_0_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = mmeson8b_vpu_0_1_parent_names,
-		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
+		.parent_names = meson8b_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vpu_0_1_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
@@ -1837,8 +1837,8 @@ static struct clk_regmap meson8b_vpu_1_sel = {
 	.hw.init = &(struct clk_init_data){
 		.name = "vpu_1_sel",
 		.ops = &clk_regmap_mux_ops,
-		.parent_names = mmeson8b_vpu_0_1_parent_names,
-		.num_parents = ARRAY_SIZE(mmeson8b_vpu_0_1_parent_names),
+		.parent_names = meson8b_vpu_0_1_parent_names,
+		.num_parents = ARRAY_SIZE(meson8b_vpu_0_1_parent_names),
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.21.0

