Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4560C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA2E2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 12:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OngWCzsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF0MOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 08:14:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55480 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbfF0MOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 08:14:02 -0400
Received: by mail-wm1-f67.google.com with SMTP id a15so5498956wmj.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6dZUNh41e54wloGbD976gFDh/dh9Od8QCAeDEWTqPi0=;
        b=OngWCzsC9ReioQ2dB+3Si543jtwEMKbYjq/B6YLYPcItr0MZED1V2Dnrf1ipky90Xm
         2iqnk1Q9oOnzku0hLU6IbIPk+Egc8yDD67sNL0VmwMMzUU6CWjk9wYoUOhtUyro6kaA2
         x/kegG5rlAwYjSM9O5eUH2HiLieh6BIsN7bTxHpA+O0W4ef+8mzhbLP8T45X3vwagZ3Y
         2zeBk3oPb43DvoPr30KaBrp0CTr4oLPqlx9RgjuNGnVfvlC2yVMbWuuALVF0uTIrL/Jy
         QcGya6qoe436hbQ2EZ06QZ3VYz3D6/Hnha2mc6zl9JCmqKAXP/jm6XI7aGTMuHjMXqrN
         FN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6dZUNh41e54wloGbD976gFDh/dh9Od8QCAeDEWTqPi0=;
        b=aXO4ArkNxbec2HJ7KEUf/PatbF/Zv7zGD5U2OoIqiP5YL0lCUpgum12WYWtyAx4rIR
         Byu46zSEzl9mhHwyPqDzTrw+mslIaSI7sXOxfFlspBD6AOPBoTZ3+PeTFvuo/O5Q08Lj
         U5ZHKc6zOHz7843fW4oDrwqaTqRxHjkLPgknCrmt2Tq07ckXzkCPjs6pZfkK3jdI1Ntu
         ZImGfryCYddpe4TAYqSq2HSDSs2hqkcoBlkFfSjlBMIEEFzAUN8i0Sbwl71yfk0+vPik
         KLcUEnPJ5hfsHq0uj/53Z8u1i/0XV7wbdQ2K18hYylYL2sienuLKUvERKEIc6oNt5rWM
         z6kw==
X-Gm-Message-State: APjAAAWb4UBaJW0FWfwT8Fg1fPGZTNKmf3vPFnK20qNFzGgbWUEdB+hq
        4EMWyIROGM419XlKPOvyApibLg==
X-Google-Smtp-Source: APXvYqza+Hvs5MtThW6KOFfdj04i4mvr0iJ5DAtXO9FQIkHVfLWq3VCCfUzX1vZSCuDoDWFEcBd7aA==
X-Received: by 2002:a1c:c109:: with SMTP id r9mr3255675wmf.143.1561637640165;
        Thu, 27 Jun 2019 05:14:00 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i11sm6160594wmi.33.2019.06.27.05.13.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 05:13:59 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH v2 1/2] ASoC: soc-core: defer card registration if codec component is missing
Date:   Thu, 27 Jun 2019 14:13:49 +0200
Message-Id: <20190627121350.21027-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190627121350.21027-1-jbrunet@baylibre.com>
References: <20190627121350.21027-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like cpus and platforms, defer sound card initialization if the codec
component is missing when initializing the dai_link

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/soc-core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 358f1fbf9a30..0ec1d7a59b24 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1064,12 +1064,20 @@ static int soc_init_dai_link(struct snd_soc_card *card,
 				link->name);
 			return -EINVAL;
 		}
+
 		/* Codec DAI name must be specified */
 		if (!codec->dai_name) {
 			dev_err(card->dev, "ASoC: codec_dai_name not set for %s\n",
 				link->name);
 			return -EINVAL;
 		}
+
+		/*
+		 * Defer card registration if codec component is not added to
+		 * component list.
+		 */
+		if (!soc_find_component(codec))
+			return -EPROBE_DEFER;
 	}
 
 	/*
-- 
2.21.0

