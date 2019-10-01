Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF200ECE589
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B393C20640
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="oWJ+OKnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387511AbfJALzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 07:55:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732680AbfJALzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 07:55:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so15165225wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2019 04:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nE4XL8qms/9Kpgy3n+0LiYMlRLilMKnu0uTWVFko214=;
        b=oWJ+OKnvV1nEG85+oJzgPToAX9vlxIWdG33ZmNo089bYl4219SMu9P+4ZiKS5alPnv
         5UHCIPKTg/6CjUPmjjl7COJyHASgZ7djN6vERzU3JRqTG5L8bPIElMntHt+sA8PpJI1V
         IvJlWa3b5iRZTemB7JePoQxA3AXeJx/CCyRXUiWTRLx2vb3eXCNIM5RKPGSL/X4pnFF2
         D4F2zIBTK+yyY8Eju1H5Iyw/NAbBZBOyZL4Gb/UDwyYhEwLtKHiaHV8ePa5S72ivUO5X
         opbH8Sxi5bqTWYhRKCyjxnb9bQPWuHeY8sZVnOQd3+cPmzSeWbxKdgHs8yRkyeD1CM2x
         DyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nE4XL8qms/9Kpgy3n+0LiYMlRLilMKnu0uTWVFko214=;
        b=pAyaKgdE+CnJ1514y8twR80WoROGyU98P+m9qG71/swF0VoK4CSVtcpOgONQEcZzv2
         yxiUbJ8jLdBqn/5OzdgeGsPV0BxlDs7/NKultBTphUu2N4bo2236kTfqhYVI3lspnemz
         YOYFnejZZN1SqIdttl7/tkQT5ZJKArjo/ttaWQy9KuOcssORq1huyjQFXuk+PBtPERDB
         W96WCy0U3vsZ574Nl5oYRR0h5FuT74wzrsG0NGwtubBhD25YQgdgmHHO2jH6x62TbsJu
         YT5ERssOU1OdjRaFxwjHe+cOsjaJjpKaQPO+/EdMtERkhRwZkN0eQ+jNemjzk8Fv2Jq8
         AUIw==
X-Gm-Message-State: APjAAAViGXV/zvnSs29/YiOULKRB+wn85EEcFaGrsjIKKQAVbCvLnW2O
        JI6Wjv34m3ZPd2mPgFTgpWx37w==
X-Google-Smtp-Source: APXvYqxw28X8pR77Rx9+mC0iRniK+Od8uatu5Uhz9j9oHbBWi+WdTmjujMGlSGZOE+lCuwODEk45pA==
X-Received: by 2002:adf:cf0c:: with SMTP id o12mr17227829wrj.30.1569930918809;
        Tue, 01 Oct 2019 04:55:18 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id p85sm4052171wme.23.2019.10.01.04.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 04:55:18 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] clk: meson: axg-audio: fix regmap last register
Date:   Tue,  1 Oct 2019 13:55:07 +0200
Message-Id: <20191001115511.17357-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191001115511.17357-1-jbrunet@baylibre.com>
References: <20191001115511.17357-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the addition of the g12a, the last register is
AUDIO_CLK_SPDIFOUT_B_CTRL.

Fixes: 075001385c66 ("clk: meson: axg-audio: add g12a support")
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/axg-audio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/axg-audio.c b/drivers/clk/meson/axg-audio.c
index 60ac71856e5e..4b34601342bb 100644
--- a/drivers/clk/meson/axg-audio.c
+++ b/drivers/clk/meson/axg-audio.c
@@ -997,7 +997,7 @@ static const struct regmap_config axg_audio_regmap_cfg = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
-	.max_register	= AUDIO_CLK_PDMIN_CTRL1,
+	.max_register	= AUDIO_CLK_SPDIFOUT_B_CTRL,
 };
 
 struct audioclk_data {
-- 
2.21.0

