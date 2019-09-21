Return-Path: <SRS0=64FT=XQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A908C4CEC4
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 517BA2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tyKJBdOM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438099AbfIUPMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:12:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37774 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438044AbfIUPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:12:48 -0400
Received: by mail-wr1-f67.google.com with SMTP id i1so9599659wro.4;
        Sat, 21 Sep 2019 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPQNzivuVZNWDtPwgDvWYp9o/YTaW3TY1ny0gNcTyh8=;
        b=tyKJBdOMcUtbyFEEuDYriQySbMRUnzXuTDnHyk5sSVY9vIyXw98fB0hQyP6qVFJ819
         DfquyskfRywLFLSYTc4YKTG24fIDU9iNeW3oT3mQyd4k/jSF63Gc80ivqn1BpQzJ8NDC
         Cm6xzIST6MSIpYsoLgu6bkosOUGBDKvWKf5IX7aX6bljDyWXSMafPMACH/PZIZeC9Bjz
         yW18+/FdXg4beschyz7151ft/qab39sCKXnygfB7RmGcCLjddnDATjrI3w7hiqsTboo9
         dRcPgHweDogzdhcO2WbGaTDqIGsedGomszlBQYyR8RQd+fa4D1NzjHWhYU/0+2LY8+Qa
         FNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPQNzivuVZNWDtPwgDvWYp9o/YTaW3TY1ny0gNcTyh8=;
        b=oZPNFRj7nXKr4pCO2t8h8RQcQsFH+2fOJqtUNgrVJq153SEI7+Df5lwjGTAhD14jSg
         w3bqmM3OhN8YT0MvptHxx9P5wX0PVd5xcxjuvdlskH/ouAOCfWr4I+b3dwrTpXc+GdLH
         BNY2OabNVPAjytKkfhE5Sykt67rWvH3IZ1qQngUumKubzD7675I1D57guiCQxzZF/K+k
         AqXV0pEy5YxmCMP+P8+H07Q3KXAm73Tarn0KUlOa+zOV8DzdRzHWyXGpcxO6ZNxg9yOB
         AiHtQX6WEMkM9jgnrMPfsi2Gcd3biicPn34wNaALVUy1QGlt9fCdfHIzVPYcjRyutAb1
         pWUQ==
X-Gm-Message-State: APjAAAVy+HR2l9uRr/+amvTtZnAFJ0rhBQy7lqQY19PsYPRFeY7j9NfY
        ezT578lhpgBjFhaNRMGKUjU=
X-Google-Smtp-Source: APXvYqwnd+5qIx487C1bZirqZ9rqerQUlrUb7EkYpyDE0y3bXL3OIoYGID3wBEp9e0T8xvje4DoNEQ==
X-Received: by 2002:a5d:5592:: with SMTP id i18mr15044038wrv.316.1569078766284;
        Sat, 21 Sep 2019 08:12:46 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id y186sm10712491wmb.41.2019.09.21.08.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:12:45 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/5] clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
Date:   Sat, 21 Sep 2019 17:12:20 +0200
Message-Id: <20190921151223.768842-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from clk_set_parent() to clk_hw_set_parent() now that we have a
way to configure a mux clock based on clk_hw pointers. This simplifies
the meson8b_cpu_clk_notifier_cb logic. No functional changes.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 67e6691e080c..d376f80e806d 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3585,7 +3585,7 @@ static const struct reset_control_ops meson8b_clk_reset_ops = {
 
 struct meson8b_nb_data {
 	struct notifier_block nb;
-	struct clk_hw_onecell_data *onecell_data;
+	struct clk_hw *cpu_clk;
 };
 
 static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
@@ -3593,30 +3593,25 @@ static int meson8b_cpu_clk_notifier_cb(struct notifier_block *nb,
 {
 	struct meson8b_nb_data *nb_data =
 		container_of(nb, struct meson8b_nb_data, nb);
-	struct clk_hw **hws = nb_data->onecell_data->hws;
-	struct clk_hw *cpu_clk_hw, *parent_clk_hw;
-	struct clk *cpu_clk, *parent_clk;
+	struct clk_hw *parent_clk;
 	int ret;
 
 	switch (event) {
 	case PRE_RATE_CHANGE:
-		parent_clk_hw = hws[CLKID_XTAL];
+		/* xtal */
+		parent_clk = clk_hw_get_parent_by_index(nb_data->cpu_clk, 0);
 		break;
 
 	case POST_RATE_CHANGE:
-		parent_clk_hw = hws[CLKID_CPU_SCALE_OUT_SEL];
+		/* cpu_scale_out_sel */
+		parent_clk = clk_hw_get_parent_by_index(nb_data->cpu_clk, 1);
 		break;
 
 	default:
 		return NOTIFY_DONE;
 	}
 
-	cpu_clk_hw = hws[CLKID_CPUCLK];
-	cpu_clk = __clk_lookup(clk_hw_get_name(cpu_clk_hw));
-
-	parent_clk = __clk_lookup(clk_hw_get_name(parent_clk_hw));
-
-	ret = clk_set_parent(cpu_clk, parent_clk);
+	ret = clk_hw_set_parent(nb_data->cpu_clk, parent_clk);
 	if (ret)
 		return notifier_from_errno(ret);
 
@@ -3695,7 +3690,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 			return;
 	}
 
-	meson8b_cpu_nb_data.onecell_data = clk_hw_onecell_data;
+	meson8b_cpu_nb_data.cpu_clk = clk_hw_onecell_data->hws[CLKID_CPUCLK];
 
 	/*
 	 * FIXME we shouldn't program the muxes in notifier handlers. The
-- 
2.23.0

