Return-Path: <SRS0=t9Bv=TF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED080C004C9
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0762087F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 May 2019 17:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i48kTU5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfEERkD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 May 2019 13:40:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41163 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbfEERjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 May 2019 13:39:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so9156511lja.8;
        Sun, 05 May 2019 10:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3SE5g/jmgV5mNASQhzXKhHYJPe76OILIthVB+qsohQ=;
        b=i48kTU5OFPZStOA2TWKl13rQC4YdClnfX7TBrdw23LNxhtlh5lQ4RbXm9d4MiWQeXb
         /utUJpAGFUvzbNDne6BaaGxk49WL1TfDmKvruhQeoJ7EMLOK1kdH2MNTTJ7dBdT5Jec7
         UWe4jyCZLUkPYXochN2wFbsoVnUItB+0l/DrqMUg2xdjRT1rpko3lzGY5NeGVnXGNyU+
         yfXOa8uI2drOPSgaLNDh2T1W+jRWsVUFtbkxvfuIXpDs3GVOF7vJyTLlItrr0izM81V1
         xoXlpj25GwOXqSe9arRSGtzLQg3GkZyA2rFfZ+CO+B4zBbvFhm/iwf8Yh5GT7dWU2MMA
         YGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3SE5g/jmgV5mNASQhzXKhHYJPe76OILIthVB+qsohQ=;
        b=K+LTQxQWxNBBlGmCWf1ujHFokFUeTJkGCGyxOnz8SACrpNFqExir2cs9QvObNhY12d
         5iyx3xMuNDjSp3e4FkakXFifTYoDz8ntivxRSgCsTQEKKJ4UVtYuFJ0Oor0Ue9G5S6lX
         I/kUF70YfhFR0DtQfAn+u6YimryV36ST+bnxI8j6CSoF+Ol8a7yw0pCQPj+h6DQBGxQA
         P0VqNUuFtuZYuIe1ThvVPS3PQOzcqydoL0/iJUOo2v/cFQgTo1STtbsQrmRTeLw3gcAR
         q9DnR4T2nygtbYDFh9tJKMTzdW9hgWafvYAgLBG6Qw8t/tMkpC6mN0f8DSGFOvat3hYI
         OWHw==
X-Gm-Message-State: APjAAAWVvN3yfupEX2t1silvnN7nI7YoscpgNFuELTfpwIBauZPnI3S5
        sa+yT40l0DWcb1uOPa5XUCA=
X-Google-Smtp-Source: APXvYqwhSikFAq0dClUlxDG5krmxsB5eIzTUe9DMnqQJTN/73P5v5zF61OIjS8NyBZbhVlbGpRSHhw==
X-Received: by 2002:a2e:1508:: with SMTP id s8mr10931682ljd.87.1557077989134;
        Sun, 05 May 2019 10:39:49 -0700 (PDT)
Received: from localhost.localdomain (ppp94-29-35-107.pppoe.spdop.ru. [94.29.35.107])
        by smtp.gmail.com with ESMTPSA id z17sm1626938lja.26.2019.05.05.10.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 May 2019 10:39:48 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/3] drm/tegra: dc: Extend debug stats with total number of events
Date:   Sun,  5 May 2019 20:37:06 +0300
Message-Id: <20190505173707.29282-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190505173707.29282-1-digetx@gmail.com>
References: <20190505173707.29282-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I found useful to know the total number of underflow events while was
working on adding support for memory bandwidth management. Currently
the debug stats are getting reset after disabling CRTC, let's account
the overall number of events that doesn't get reset.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/dc.c | 10 ++++++++++
 drivers/gpu/drm/tegra/dc.h |  5 +++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index cf622a07e9b6..41cb67db6dbc 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1482,6 +1482,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -1945,6 +1950,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -1953,6 +1959,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -1960,6 +1967,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -1967,11 +1975,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): overflow\n", __func__);
 		*/
+		dc->stats.overflow_total++;
 		dc->stats.overflow++;
 	}
 
 	if (status & HEAD_UF_INT) {
 		dev_dbg_ratelimited(dc->dev, "%s(): head underflow\n", __func__);
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 1256dfb6b2f5..ab25157c948e 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -41,6 +41,11 @@ struct tegra_dc_stats {
 	unsigned long vblank;
 	unsigned long underflow;
 	unsigned long overflow;
+
+	unsigned long frames_total;
+	unsigned long vblank_total;
+	unsigned long underflow_total;
+	unsigned long overflow_total;
 };
 
 struct tegra_windowgroup_soc {
-- 
2.21.0

