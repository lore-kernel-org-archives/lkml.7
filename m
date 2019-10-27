Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD093CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E2B214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="eh1WeQJU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbfJ0QST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:18:19 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36339 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbfJ0QSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:18:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id c22so6694626wmd.1;
        Sun, 27 Oct 2019 09:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CPQNzivuVZNWDtPwgDvWYp9o/YTaW3TY1ny0gNcTyh8=;
        b=eh1WeQJUqLqmNq7P5g77WEfxAuW9neRhh+Met5oYqfM/347j8sLtzsTSeh334FZcke
         mdSDPnwhvk9xiHA8r404dwDpMZQfA+3v7HOFnzcNVF01PiBTcW7xaRUBKAAVPPffJWUp
         n8TH/PSO82uFK1dIBcVzajImWj23r6JJmJOMKLXqwoXG7ycIbJj2vbn/2K5OInyOFCMc
         e4ePBKVK8O5xCHy8FQoUhdTP0Hz9TL4fFH0sLCzwsorlgV9cD3GbHGCnv9Qw9Bv/Mvd8
         TAjg0bZuKIGThrBMSx2Wj03CnIsphlJsMouXd2kqscALnb1TFq/oDfoZHP8HdCOJCYRX
         8Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CPQNzivuVZNWDtPwgDvWYp9o/YTaW3TY1ny0gNcTyh8=;
        b=eogpjbzX8qnPiypKVhb4O6j/HLSiFkLLA1/LM3wLLrUxueQhvCFofzko6z7+af5+LU
         FP/PFte15i6NyjKgTrX00/uIvXK5pkJl4tGBY495illKZswdrOV9mJ+O/6jPZS5IXwbc
         zVnUZq1RzZwk8J78qIqXb6QCyMCaXKszVeyohjOJmzG4AXVox/5mAYrwkUHBLR0D/n87
         p2xspfoLI+34EVsRFKd9pYmh53n39w0aRGMQVyS7t3kXMaDLw2uqRe3WWZMgfzeIX7NJ
         8Qmg3bcWhlEjk5PLPHZEK2zCTFYMl1Wzkim9Ykb2kZFp+MGNLI0k0SdMJ+jbeRRrqfCV
         O5uw==
X-Gm-Message-State: APjAAAUo7QKr3qcwHMfHEc9DEhmBidMAw1cxmYSvvEmoZuQXerfTn9ve
        Tiz4G+cH+25N85gOZA2gcas=
X-Google-Smtp-Source: APXvYqz30NtrWX/wc/G4NZzRKZdUoiVvN3FqVKpNKl42zjz3/qQTlrYB1xwMJ+Fi2jVmhppWcoPaMQ==
X-Received: by 2002:a1c:b4c2:: with SMTP id d185mr11147241wmf.159.1572193094673;
        Sun, 27 Oct 2019 09:18:14 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j14sm9585014wrj.35.2019.10.27.09.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:18:14 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/5] clk: meson: meson8b: use clk_hw_set_parent in the CPU clock notifier
Date:   Sun, 27 Oct 2019 17:18:02 +0100
Message-Id: <20191027161805.1176321-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
References: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
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

