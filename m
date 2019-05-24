Return-Path: <SRS0=Z4g5=TY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95EDC072B5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C249A21773
	for <linux-kernel@archiver.kernel.org>; Fri, 24 May 2019 18:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s2ZFjGlJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbfEXSRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 May 2019 14:17:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37821 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfEXSRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 May 2019 14:17:40 -0400
Received: by mail-lj1-f193.google.com with SMTP id h19so1079975ljj.4;
        Fri, 24 May 2019 11:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOTPz5lNju8Uwf51eJBHGL7FhyMKmYNlaIjFWCSiGME=;
        b=s2ZFjGlJcmB539B/LGdP4E0zY4XNlHT0ngjGl9uhJWqjDfzwF+gU+3VB7odWc+2nvM
         oxqBS5Ypscym2U7Es/IkT6Om0kGInRYq3nJIxx45XMClBzFwTRx9OESoAKn6SaFRmRci
         eTHX2pF2bzjVp8HVrFEIfclrHSsY7VT54qTez+aWoMgdnPr2yYUQY/da+bsuXh/CeB2r
         kmESwe03Al0CVQKfVGEaR137jaAELYf4VlJiQfYnwaCn/smQAVdrU/vNt7+XS/6s2xh2
         R136Jmbv5Z6Qc17wYcKRj4LzIrD77RCtWdKbPcTspu60gTDogFbVOb8hvYDzT5cKL9At
         BuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOTPz5lNju8Uwf51eJBHGL7FhyMKmYNlaIjFWCSiGME=;
        b=dwCPkCWZZbgsNO/jBijOfqXGOuR5KAUUqwjDUmXFClyffQymvzELjEd0+e6WmT/ABC
         N0OZYb6JzYbu8EO52tSIHQelViwaxZz2tAOIJvZIQ4bHU4rjpRhg/7A708rOMmi7e1tz
         6qWZ9ZDfxmjzcR4AhaNr2tmzkTB50Sr+VRmOBD6W8iumTUgrwlEuCEj1DaXrltJ1c+iP
         vH8kO9rM+abDReas8mdjUHeY6S9A06xtXaR/U6CslzlbuY6fBeF6doWCm+PX7tdoUJ3t
         4xokEDH8LNN2M3u4BpQMIMkPeZ5yIf4mpVTUc17On8LUG1Qn8/hGLEwXWPDYy4nY2QwT
         OZ1w==
X-Gm-Message-State: APjAAAXdc9cadvWPukIrWfxihr3StWGv3TN0K5OAi5ogbgfqj2UlQSRV
        OKE1yksvyq8yvqqGGec2kbzDD8nz
X-Google-Smtp-Source: APXvYqy6t/I6JgVTAG71Jqtfllh/WzeZ3qSfINCsL566Fz5VwbQfcnbzSJCKnRiWwKYjFlFFkY6rRQ==
X-Received: by 2002:a2e:2c17:: with SMTP id s23mr768905ljs.214.1558721858446;
        Fri, 24 May 2019 11:17:38 -0700 (PDT)
Received: from localhost.localdomain ([94.29.35.141])
        by smtp.gmail.com with ESMTPSA id h10sm810376ljm.9.2019.05.24.11.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 11:17:37 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/tegra: dc: Extend debug stats with total number of events
Date:   Fri, 24 May 2019 21:16:26 +0300
Message-Id: <20190524181627.16490-3-digetx@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190524181627.16490-1-digetx@gmail.com>
References: <20190524181627.16490-1-digetx@gmail.com>
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
index 3e13948dcdcd..e537c0d4bfdd 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1477,6 +1477,11 @@ static int tegra_dc_show_stats(struct seq_file *s, void *data)
 	seq_printf(s, "underflow: %lu\n", dc->stats.underflow);
 	seq_printf(s, "overflow: %lu\n", dc->stats.overflow);
 
+	seq_printf(s, "frames total: %lu\n", dc->stats.frames_total);
+	seq_printf(s, "vblank total: %lu\n", dc->stats.vblank_total);
+	seq_printf(s, "underflow total: %lu\n", dc->stats.underflow_total);
+	seq_printf(s, "overflow total: %lu\n", dc->stats.overflow_total);
+
 	return 0;
 }
 
@@ -1940,6 +1945,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): frame end\n", __func__);
 		*/
+		dc->stats.frames_total++;
 		dc->stats.frames++;
 	}
 
@@ -1948,6 +1954,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		dev_dbg(dc->dev, "%s(): vertical blank\n", __func__);
 		*/
 		drm_crtc_handle_vblank(&dc->base);
+		dc->stats.vblank_total++;
 		dc->stats.vblank++;
 	}
 
@@ -1955,6 +1962,7 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
 		/*
 		dev_dbg(dc->dev, "%s(): underflow\n", __func__);
 		*/
+		dc->stats.underflow_total++;
 		dc->stats.underflow++;
 	}
 
@@ -1962,11 +1970,13 @@ static irqreturn_t tegra_dc_irq(int irq, void *data)
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

