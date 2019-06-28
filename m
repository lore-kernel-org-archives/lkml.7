Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5190BC4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1A2064A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pqUrZZrH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfF1IRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:17:14 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39329 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbfF1IRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:17:14 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so5283183wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iX4GoXUMjYo0yWAqnak7nWNu9SahWjJ+qIlyX2DjnA=;
        b=pqUrZZrHnpMwYQiyu/1jCW1Vn1dbIBUApoVZMhyhBwvnhvhfumKMpGn/HD06hkyLKV
         mAr70tgH1UWNF40M5i4Iu7TZyBCOF9E4DVrgXNhfgFoe68UERxt7W4BtnpD/aXQbHgrr
         KSKRFDsze0oQlGIrrEesEJEXxvjGoX7ByoMNidbjknRj4Bylt+bqRjjgIIVO6eX4pKnN
         1AmfDbD/NeC/4Z9WHyrLlNhDEE1EW62NsHUnaW1L+cOpLHwoL1tVmmD214BJEgmzEGJp
         UBCPbzQkK8BSlSG9gz7fGNCBlajjvLjh/2C21gkCh6AjXCuIST7i+hrq6mn684QyGZ60
         KhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0iX4GoXUMjYo0yWAqnak7nWNu9SahWjJ+qIlyX2DjnA=;
        b=Xa2pOpmCol6x5WBX52jwFPKnn8v9+vtaIMr3/r4PoniY1SZsCeksb9YiD+9Y5F3lBt
         ixvkuSCF93H8PZtaZRRpfk106Lb2RGqryx7DVx+tOKYpsv2XIwTtUec2Ua4MicMaRE2/
         4ozCQBprbKdI9aSGly/gm2eRahl3Xr3yqVOUJF4M5yU+R38sjatUYnOtU2BDk51+7iLd
         vzwPwnN1222n6p8bN0PEdVfZrrKNxU0jpQgMTbE9DtcxX36SBw3ricxUKTDJe2Ffdas6
         ++L7nnLTD0948R7PSP0CVjff7vWQVOCIDRJWexBPcFxJST+7U/pTmLvDmXEvPhe0McsB
         X8kQ==
X-Gm-Message-State: APjAAAVUzmwV4i9NnriNxUaURKoLFEuv3NJwpAGH29PAQKy5XhbP453W
        ypLIHDFcCF5fK/dnS1YSkdOA0w==
X-Google-Smtp-Source: APXvYqw+rkcyh3PTU9URJjuIKiu4kZ97NgtKOX3PAukWMiU12hf7kxkJIrnT5wyWxV6LyDzzRWcw8A==
X-Received: by 2002:a05:6000:124a:: with SMTP id j10mr6749454wrx.191.1561709832291;
        Fri, 28 Jun 2019 01:17:12 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r5sm2819216wrg.10.2019.06.28.01.17.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 01:17:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: meson: axg-card: remove useless check on codec
Date:   Fri, 28 Jun 2019 10:17:08 +0200
Message-Id: <20190628081708.22039-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While checking cpus before dereferencing the pointer is required, it is
not necessary for codecs. 'codec' can't possibly be NULL in the loop

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-card.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 70bb0cbad233..14a8321744da 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -118,8 +118,7 @@ static void axg_card_clean_references(struct axg_card *priv)
 			if (link->cpus)
 				of_node_put(link->cpus->of_node);
 			for_each_link_codecs(link, j, codec)
-				if (codec)
-					of_node_put(codec->of_node);
+				of_node_put(codec->of_node);
 		}
 	}
 
-- 
2.21.0

