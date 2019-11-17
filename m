Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC57C33C9A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A320E20740
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 14:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bOVqlywY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfKQOAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 09:00:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46890 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfKQOAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 09:00:02 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so16355789wrs.13;
        Sun, 17 Nov 2019 06:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALb0D3ZQCosHbu3XTz0Zl3zN169Kwv6XSNmMst3JsiU=;
        b=bOVqlywY/TN2WcGCQ6kihefkhnThvBvgSgqVpzw1sHaJcCOhgj31mlHerwO7cQ4tDE
         xEPorDMERAqXbU5AyaDE+rTC8v1wbzAmprTg99RL5u8dtY7wPnA2M+1ChWzbA/WTlR2T
         tdsgK1XJYDXFnfRcJiqjnjFq2lg9tlf3rReuufmQnWmjrxkYmr5pnFWi21Di7Rr9ShNK
         lHfiUgTZqGoxlh7P2o6vb9embjtkJzSwIaDd4hZ+g7fCnV4C87Q/N+S+zJBUa4OOXaUN
         kXJirZOOQzYLMuAUfbclBvw7S7Z5Xu34TSpiVa/+BbsRgosW9FWI3qu1+NDndwtvh6Qn
         z23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALb0D3ZQCosHbu3XTz0Zl3zN169Kwv6XSNmMst3JsiU=;
        b=kGn+6LBlTehK7BNw2Od/x1VNkyDdQb+K4tBbOc5psDPkbia3+YtMmmRNKnoQVsX1RE
         rbWssRsArYjoQywoSuIDNFX1A2Aeg/cT3+NSX7AVFdYxN6myd54wn7+xANARcHjvW4a2
         RjFYNj2jTezBCWcwNMJ9ojfMFksYi2euP/FS3jrYSSz4KgnjPxYWZLU7IdwXxtbI/Om/
         +zIJm0CV79hWis1DjbX65Up3zVoNcelYrAgAsydRTqhP42emBiORc+mCuknlpz78JFTK
         nsWP+oIenxMG/1Vg6R/pK9zp7Z/Hh4yGaowYLsNZp/mSA1KmRoN3lQXiKGeSnCFJM4Pr
         W53A==
X-Gm-Message-State: APjAAAXq10VAliDKVMH8xLw80R8/1bY/0pfnJx82EpaqPdMu+6+kZTyZ
        QP6G5uwG+bmFjOZdjqqExeo=
X-Google-Smtp-Source: APXvYqxodTdB4qW5P1m2ak/Tvv3QB8ZeIwlDZopM35wEeu5DhwcBl7avlGwHw4rIhIcjP9Ki91UvDg==
X-Received: by 2002:adf:a119:: with SMTP id o25mr16461312wro.74.1573999200043;
        Sun, 17 Nov 2019 06:00:00 -0800 (PST)
Received: from localhost.localdomain (p200300F1371CB100428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:371c:b100:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id n65sm18004803wmf.28.2019.11.17.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Nov 2019 05:59:59 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 4/5] clk: meson: meson8b: don't register the XTAL clock when provided via OF
Date:   Sun, 17 Nov 2019 14:59:26 +0100
Message-Id: <20191117135927.135428-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
References: <20191117135927.135428-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The XTAL clock is an actual crystal on the PCB. Thus the meson8b clock
driver should not register the XTAL clock - instead it should be
provided via .dts and then passed to the clock controller.

Skip the registration of the XTAL clock if a parent clock is provided
via OF. Fall back to registering the XTAL clock if this is not the case
to keep support for old .dtbs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index f857a2c4d025..44e97bacd628 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3687,10 +3687,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		meson8b_clk_regmaps[i]->map = map;
 
 	/*
-	 * register all clks
-	 * CLKID_UNUSED = 0, so skip it and start with CLKID_XTAL = 1
+	 * always skip CLKID_UNUSED and also skip XTAL if the .dtb provides the
+	 * XTAL clock as input.
 	 */
-	for (i = CLKID_XTAL; i < CLK_NR_CLKS; i++) {
+	if (!IS_ERR(of_clk_get_by_name(np, "xtal")))
+		i = CLKID_PLL_FIXED;
+	else
+		i = CLKID_XTAL;
+
+	/* register all clks */
+	for (; i < CLK_NR_CLKS; i++) {
 		/* array might be sparse */
 		if (!clk_hw_onecell_data->hws[i])
 			continue;
-- 
2.24.0

