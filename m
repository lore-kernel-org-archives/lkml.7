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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB9CA9EBE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE41E21850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Y8fcd9UW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfJ0QSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:18:20 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40519 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfJ0QST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:18:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id o28so7367722wro.7;
        Sun, 27 Oct 2019 09:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bQ1b11JrQMPNCzMJaz+y6q1nSpUtkZ5R8/joJD6Qz18=;
        b=Y8fcd9UWEz8ZhI1HAXrUApECbzToLMV/0EZ4fsDzW1oo4Ol5ePz6Mm0IxAvoezYzkd
         s2HnNydcCJv30Wka6Ei4vvbv3sGYXS3vGn+EIkzxzyoLPVuQLSHdgpH1Wt2d4Z/B8BdC
         vwy9UVXLVY+1ivTt5j5Mrczx1aYKocrKk/+TbT1TbTqnhFBbm4pt41AwNWMWy/2loU6R
         8MwwkEwMHjYrTq9P+STJ9fu5Khe5PQf3VSDGkdNDMRq8nQGh21rnLrjwEztWyVtuhWfP
         6ktxynw0Cn3bBFAzb+sXi8HpEnJ81eQ/yyXQHCve4AtjTzyGmCGDpVzZGdFqSRzriwA7
         Sz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bQ1b11JrQMPNCzMJaz+y6q1nSpUtkZ5R8/joJD6Qz18=;
        b=Rr/pFyba/EcsSziZ9hOPFcOPbPMVQLkQU0xEg85FHmUvY2rO6NUPNtOxxBtU0ACpLV
         eWhZaJ8AveDxAScrzcKAbIAOpaY66wogtS0mB15ffssXz00wWGeZO/wC3H5WsTNGckU9
         Vx27S4u3XbsorDVQtOxuiLEw09YIbEfv1vmIPfi/bee0aPkC1pUsLfK46dbHoHGa/Gpl
         NZ2SeEYqGBDRjBrD5VhjDSxWj3saX/BZJ5stLiMuYiV3rTgY2rGAPq7CvPPoZ5GNDV5Z
         Q3d0KXaZOwQp50M+Jt61c2+b3QCMs5WDYBBJX2kVlDISO/Sfw4ry3ndD7Lr/FK64n5R2
         YvrA==
X-Gm-Message-State: APjAAAWK1N3LzTxHtYLgN8JrhBm59oaOock/WqM8T+llyY7FVHwxerHK
        I5CqeSjaFMNE5ls2QaJDkIs7+Zlb94UEpg==
X-Google-Smtp-Source: APXvYqysISP879oRde/djghIAdFy/7j14R2KbsTb23U1GvaSj/8vP8LRd3LHDN3ZcXn4lnSWEN3ZWg==
X-Received: by 2002:adf:dec7:: with SMTP id i7mr2473253wrn.134.1572193096993;
        Sun, 27 Oct 2019 09:18:16 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id j14sm9585014wrj.35.2019.10.27.09.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:18:16 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 4/5] clk: meson: meson8b: don't register the XTAL clock when provided via OF
Date:   Sun, 27 Oct 2019 17:18:04 +0100
Message-Id: <20191027161805.1176321-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
References: <20191027161805.1176321-1-martin.blumenstingl@googlemail.com>
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
index b785b67baf2b..70ac6755607e 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3682,10 +3682,16 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
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
2.23.0

