Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C06C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CCD72084E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 15:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="sVjb13m/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbfFTPAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 11:00:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39255 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbfFTPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 11:00:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so3509400wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 08:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTgzDGLM/ROVQf5F0ngjAOq0Ibk1O1YBIUhnq8jWYwo=;
        b=sVjb13m/4Abjxcelx9dk0B2n0Gz48wNUKtEvFQSB6xjURfrJ8rVJunYzemrjIso0+O
         w1nuS/IZOyrwLZjCU/rKMeGAmxQNp35eHQcKJ4WmO8fHr0xXb4hkFZxWbWAa0yyS02Sj
         LubycPz4gZcpi6SRA+gvfvmvLemvvjHI/OQK9g8H5FLFwO6XfIDRKtml019xxHEv1iDK
         4YDCXsWc+bscbSaOySuV/XfMZobok6vF5h9JuKY43v9AC+RymMy+mStnpkUqOMalExwk
         Hcuz1qHDK8vh8koQP3omgI0YxWklCijA3BABZFVBnjpZjLUVwxnN1nHEzuzL42GfNpuQ
         +PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BTgzDGLM/ROVQf5F0ngjAOq0Ibk1O1YBIUhnq8jWYwo=;
        b=lfeUQllmlbtY7FqxbvRmlUq1uLZGBIsUkVkGqJMRuNkooycgqYHkdRwb6kvzvEWgaB
         K1NrbZpsg7VFslwVBADXaTnvJgj8x6002sIeYVOBFevPx56GVHOuzZAI1MnSEIBbyP2D
         wuj5BIQBhnTJJnL5+ehMrO2Mi/YZmapnLsE3sLRjxo6So53oamTdc5ZQwh8tMj9iJIDg
         FrbDEibn8l4o9cDcSfkG52QCVSul3yj+/RpbG96N7wMSjyNLn3PlSKyHxWh1l4VLY9fu
         I/VEkNUZo5KaNJ8RKCQZ8nzQJ+UqizIqzf3ilF9480Pr26JK51838FHNjJHJ2nA5KyS1
         3uUw==
X-Gm-Message-State: APjAAAWfMokeCn9DSRvn4mL+Zc7BLCZCHACawZdsrWYymzN9sqo6F6ch
        quatFMJO6MFIl9Ici+s3/4ve2g==
X-Google-Smtp-Source: APXvYqzMhLhcvV17323ZfwIYU4iAPa4KaU3gRalLKZq0KpBFZBYD+bml5U5CtROED7DHXD+AIE9uOg==
X-Received: by 2002:a1c:a952:: with SMTP id s79mr85112wme.28.1561042824707;
        Thu, 20 Jun 2019 08:00:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o126sm6802520wmo.1.2019.06.20.08.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Jun 2019 08:00:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com, khilman@baylibre.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, martin.blumenstingl@googlemail.com,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [RFC/RFT 04/14] clk: meson: eeclk: add setup callback
Date:   Thu, 20 Jun 2019 17:00:03 +0200
Message-Id: <20190620150013.13462-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620150013.13462-1-narmstrong@baylibre.com>
References: <20190620150013.13462-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a setup() callback in the eeclk structure, to call an optional
call() function at end of eeclk probe to setup clocks.

It's used for the G12A clock controller to setup the CPU clock notifiers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/clk/meson/meson-eeclk.c | 6 ++++++
 drivers/clk/meson/meson-eeclk.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/meson/meson-eeclk.c b/drivers/clk/meson/meson-eeclk.c
index 6ba2094be257..81fd2abcd173 100644
--- a/drivers/clk/meson/meson-eeclk.c
+++ b/drivers/clk/meson/meson-eeclk.c
@@ -61,6 +61,12 @@ int meson_eeclkc_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (data->setup) {
+		ret = data->setup(pdev);
+		if (ret)
+			return ret;
+	}
+
 	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
 					   data->hw_onecell_data);
 }
diff --git a/drivers/clk/meson/meson-eeclk.h b/drivers/clk/meson/meson-eeclk.h
index 9ab5d6fa7ccb..c22b57781e3e 100644
--- a/drivers/clk/meson/meson-eeclk.h
+++ b/drivers/clk/meson/meson-eeclk.h
@@ -20,6 +20,7 @@ struct meson_eeclkc_data {
 	const struct reg_sequence	*init_regs;
 	unsigned int			init_count;
 	struct clk_hw_onecell_data	*hw_onecell_data;
+	int				(*setup)(struct platform_device *pdev); 
 };
 
 int meson_eeclkc_probe(struct platform_device *pdev);
-- 
2.21.0

