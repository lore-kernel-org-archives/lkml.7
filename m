Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78CCA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8CD621D7F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 16:23:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="AoVinyap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfJ0QXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 12:23:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37628 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727467AbfJ0QXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 12:23:47 -0400
Received: by mail-wm1-f67.google.com with SMTP id q130so6700281wme.2;
        Sun, 27 Oct 2019 09:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27lV1jSL1pOmY52iA2rX2+BpQ+8jMOYRMeA1UyL2hfM=;
        b=AoVinyap5keVi8HvLp0UH+/Ax8BHjP5n/rdFXmYx38j237nX+kj3HaXZQ1by5mX220
         tbhKnbprieqkKl5RGbhI08Homxfu6hHLXTSXHVGCQAfIyb5MFCeV0SDRXAwfghtEAi7M
         uysvJW9p3hDN4TyOCkRWcCp0QvFzNBSkRtqcFroX/xV9y36BE6q8NW7cLFvv5f4THy2j
         ajNqdk3d+JaAnDtXSF7gqtE/V/uSWkVPYL8d5N1eCj+diuwnUhNd76H0Hw6o5YKd+KLU
         lyjsq17tzYK6Nez7LyXI73gX9Rr/GcgMjNIY72tocZ8x9J5g8xNeVhNdd++HXAoltdD6
         XDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27lV1jSL1pOmY52iA2rX2+BpQ+8jMOYRMeA1UyL2hfM=;
        b=FG8bv6Syl78DE9ozu8mxL8LrJU2kh+dX66JHbmB93TqEUS4VE+Kj6kbU0y6RdAPmsC
         RnfXSqB5Cz7SkZhyI/09hJOi3II4nvMWNBsf/eFz/9oKZ0VfsNrlVjoI//3MRj8v4bMM
         3p9UzoVSTD/ZyXzSQcKUwxlz6kcCcNgr90XjD3KnK0u+Rh6PFVhx3qSJvdeR/BKVEpqT
         HhijPNH7hHunQEa32WtFciIifCw8pYJQXbCaLK6ru0sTHI1FQCpycgzAWvEYWrMGvTPw
         adojgOdq8RD7hdiVEuH9ontlP6QkBqY2vfRvyi+Wp/wyJYBNkAMm/Fat1yZHj/VEQRSv
         yqaA==
X-Gm-Message-State: APjAAAXxC0U8qcf4KETHyIqIyPfbl+BYUESoTt+eVOu9EjM8KUBY8upD
        iF/yeBWMwmsp9igfO8/s7t0nxJFfSIysAw==
X-Google-Smtp-Source: APXvYqwi3N77ux5v3XITqsvD7kw7Lzj/nkEw4EMddSAn2mY2cNYvaiD7bdCqGCK8e2C00e1OyUbxYA==
X-Received: by 2002:a1c:1fca:: with SMTP id f193mr5079801wmf.173.1572193423782;
        Sun, 27 Oct 2019 09:23:43 -0700 (PDT)
Received: from localhost.localdomain (p200300F133D01300428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:33d0:1300:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id 1sm8243299wrr.16.2019.10.27.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 09:23:43 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 3/5] clk: meson: meson8b: use of_clk_hw_register to register the clocks
Date:   Sun, 27 Oct 2019 17:23:26 +0100
Message-Id: <20191027162328.1177402-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
References: <20191027162328.1177402-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch from clk_hw_register to of_clk_hw_register so we can use
clk_parent_data.fw_name. This will be used to get the "xtal", "ddr_pll"
and possibly others from the .dtb.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 70ac6755607e..306b809deb49 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -3696,7 +3696,7 @@ static void __init meson8b_clkc_init_common(struct device_node *np,
 		if (!clk_hw_onecell_data->hws[i])
 			continue;
 
-		ret = clk_hw_register(NULL, clk_hw_onecell_data->hws[i]);
+		ret = of_clk_hw_register(np, clk_hw_onecell_data->hws[i]);
 		if (ret)
 			return;
 	}
-- 
2.23.0

