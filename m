Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD7ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2D492089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 10:58:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hjbd4jzP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728378AbfJUK6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 06:58:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33898 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728334AbfJUK6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 06:58:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id t16so8283216wrr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 03:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OylZk9s0mis8tzuGBIwAaa88loW1Yq19LfmLj+u4mfs=;
        b=hjbd4jzPeI1PUWLlYV4B8LpdZp+xJ8qe9umoadGdA9E9h5uyWAn+m4H6FUYmLJdd4J
         0HxB57wjYo23ive7bR5mSTDVnyms+GgEFeZECTnwOrZlvN7jbloHloiEiUlKkISk4LIO
         osY7YZU9gXM6dy41N1p5yl3bu2LkA2fiuxLqwBQqjQD4IFUBxfKuXasoBn2UcVT37Z79
         8s9spHNbvhlSqirIuhbUceepbMrutWVFNZ4PGKN1ypMAPZ1sC2zc2EueBqoiG1YbJP2t
         UcbZenefQ1KTENMJJ52x5nF8UKFG8jUBzrieioNMqQE8qMh8wV6zhiXRAdpnG+PSa4ml
         fbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OylZk9s0mis8tzuGBIwAaa88loW1Yq19LfmLj+u4mfs=;
        b=VHe8f6/IZeHwcqOA+wdxiDAfbfwOxMNetZ4OoeHqYK7/MILfehHRM1MBlpiJejQOB1
         Uw75UgWCd1DKTO6bYrXo962Eb4C5fZcXKQGdu42+MSitBM5ZgunXUQyBdaXfDChPiWm2
         d4PjG16G2Ves0IkEowkpkogJngzKmLpnjf/RTp1F2/Dg6Sv0BLbnxnu1hXVT2NtHFgHB
         JBw2BeotJLtIzTNOx6L5Fwan3tyliBYzlVoAIDC6OvvWueE0HwIs44px/XcxR1Ut6A8G
         tVrwfmNjWpe6SZ/M6GDRJtsYMVEiR19QBzLDIIeK5JxcQOyCeD0XfDG/rsuEvWO3bwas
         b3fw==
X-Gm-Message-State: APjAAAUQt8Yxi98EqjDt+Rp+ovTtjuEp7LVK+CieUoMl1k1DvclsXfcK
        Z0Lay6cYnVnIDTyrwoEcbh2s8w==
X-Google-Smtp-Source: APXvYqxLywQVQYV53+QkKrhkhGktMMDXKUnoIKcMuinLHZJR/+FqsdQZzCdzCxFlcc4O5bj2Qqs5OQ==
X-Received: by 2002:adf:f004:: with SMTP id j4mr20804975wro.68.1571655512433;
        Mon, 21 Oct 2019 03:58:32 -0700 (PDT)
Received: from localhost.localdomain ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id q22sm12544289wmj.31.2019.10.21.03.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:58:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     daniel.thompson@linaro.org, arnd@arndb.de, broonie@kernel.org,
        linus.walleij@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH v2 7/9] mfd: mfd-core: Protect against NULL call-back function pointer
Date:   Mon, 21 Oct 2019 11:58:20 +0100
Message-Id: <20191021105822.20271-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191021105822.20271-1-lee.jones@linaro.org>
References: <20191021105822.20271-1-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a child device calls mfd_cell_{en,dis}able() without an appropriate
call-back being set, we are likely to encounter a panic.  Avoid this
by adding suitable checking.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 8126665bb2d8..90b43b44a15a 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -28,6 +28,11 @@ int mfd_cell_enable(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int err = 0;
 
+	if (!cell->enable) {
+		dev_dbg(&pdev->dev, "No .enable() call-back registered\n");
+		return 0;
+	}
+
 	/* only call enable hook if the cell wasn't previously enabled */
 	if (atomic_inc_return(cell->usage_count) == 1)
 		err = cell->enable(pdev);
@@ -45,6 +50,11 @@ int mfd_cell_disable(struct platform_device *pdev)
 	const struct mfd_cell *cell = mfd_get_cell(pdev);
 	int err = 0;
 
+	if (!cell->enable) {
+		dev_dbg(&pdev->dev, "No .disable() call-back registered\n");
+		return 0;
+	}
+
 	/* only disable if no other clients are using it */
 	if (atomic_dec_return(cell->usage_count) == 0)
 		err = cell->disable(pdev);
-- 
2.17.1

