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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFC2C4360D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF69F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Sep 2019 15:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="b0kfoR7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438128AbfIUPM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Sep 2019 11:12:57 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53520 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438034AbfIUPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Sep 2019 11:12:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so5380998wmd.3;
        Sat, 21 Sep 2019 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g3g3V03D6DkRYbYZABMPMLQMCrNMpOQBXxgsvwVk66Y=;
        b=b0kfoR7HMIpmuiYPIzNdtQLx3b8uneVrYYQ+dwHeZiDpi5mt5Spb2BSDtFU3KWKmCx
         +u1uR/rfNujS2PO/A7PdN+r11lDxBjnESvNNS/dmarQN/UssD/3LVpv+Zu9gIMvAVK/q
         kZbRPxGwZvNQAQXQ+twwkL48AU9/uucjb95D+t6jxIpWaaXo4ye0zqMEcbv3dzFUgnS9
         vc9/vEbudhmHO3DOO0tBvjih385+ZFtD3FNE356fvdFXkge7WPluqmIKDEFYE1w0RGXf
         g48+nPKSQhGJKWpCYBCWWr3YFT8kctrGp0e8gNqV6haE7dGgBEushMGaShSexyqtirIo
         ucfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g3g3V03D6DkRYbYZABMPMLQMCrNMpOQBXxgsvwVk66Y=;
        b=CT/Pg9+V2YHUI62FEw4we+QjTraL9C1WijmG7GwsEW/8a9zPsu8P52iwGgDR8W5uER
         qQwT1SjscKCFn7L3wID3RhbsxC6A4HeUx/ymOCCy0xvWpuIWgOwUtjs9L77qt0yypoQR
         DK07HBfJn+QOJMihV+1EilK6MG5IQDcswHFR8CfTpPIag4VFJAbS0bhprKc/5H5/gb/8
         sj2qNf90RZTTgg5S5E32d47uwWqK+kJAHFaQwypQtcT02/dM3Io8cPOy8qqT6WT5+bEC
         Tuz8pIKCiWLVgV35y6Z7UVpC6WRqSCcWEPdmh0hADvWKRmxvSCvNVJzgX+tBkHFkYhxz
         x0Ww==
X-Gm-Message-State: APjAAAWEDrss8Rf1RZyChzIm5XDgpvt6suFzz1HFBXlntjKXOc5ASPH3
        1z2NOQdgcBWJcCasp/LOz/g=
X-Google-Smtp-Source: APXvYqz6hlOksjMhBKLSwZPGPxQ6oqEOuX/QaQonH+2wP07T3D3DBw9L4AZNYrqyscJFSb74nmb3Xg==
X-Received: by 2002:a05:600c:389:: with SMTP id w9mr7047507wmd.139.1569078769146;
        Sat, 21 Sep 2019 08:12:49 -0700 (PDT)
Received: from blackbox.darklights.net (p200300F133CE0B0028BAA8C744A6F562.dip0.t-ipconnect.de. [2003:f1:33ce:b00:28ba:a8c7:44a6:f562])
        by smtp.googlemail.com with ESMTPSA id y186sm10712491wmb.41.2019.09.21.08.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Sep 2019 08:12:48 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-amlogic@lists.infradead.org,
        devicetree@vger.kernel.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 4/5] clk: meson: meson8b: don't register the XTAL clock when provided via OF
Date:   Sat, 21 Sep 2019 17:12:22 +0200
Message-Id: <20190921151223.768842-5-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
References: <20190921151223.768842-1-martin.blumenstingl@googlemail.com>
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
index b785b67baf2b..15ec14fde2a0 100644
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
+	if (of_clk_get_parent_count(np))
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

