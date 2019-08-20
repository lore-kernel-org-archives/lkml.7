Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FEF1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF99F22DA9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QX2ousUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730013AbfHTMee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:34:34 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44014 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730000AbfHTMed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:34:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id y8so12205666wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4Mb2956O3FRxXwLE7go2npN/BtpK8pSn0FcezT5G7k=;
        b=QX2ousUiVBfSy/6wp/ndiWEdieYpT86MhekZPf558vtyY6ounj3GNb8xDtX9fTyjQ+
         H/6hrMlgDpF8KLQyFos/ukJ65U/LNDR7fJnxuDhLDn1bGgRO8MXmO0eK33ILYpduu0zw
         PH7iRrywrKqO32ZGY/nGOPR5JhMKqUlQTJMaTqoY80etoh8RIpC9EP8D/A7O5miCYyfo
         7+e98l/N4Aza0s8osWdP+wb3iG/Bbfm/OJWyWCMWTn12NuvnNrrKnQaWhTmxYi8IAdak
         obVglZAWVmeNpHBrzeIHVtmM6+SoypHInqmkKexdMhfmznhWEdkeASFDSPBPeMvgtkhJ
         6CCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C4Mb2956O3FRxXwLE7go2npN/BtpK8pSn0FcezT5G7k=;
        b=K64sX+VVyNUn/YGmIY9t75YoX/axBMHGrUPA54bbB1cSk8B5R/Eoxh8b8P9NpGcdU6
         ucxnzda6j+DWzMt2u8lOYYJJlyiNgygybx+XpeGk4FI9vZ+aikmn9/u8gfatc0vYoYqu
         hGLc0hCY6R8STOiWAj9kvMrEh/oiOncS82wyofjeuzUgq/KxgMrzIIiUShr71xqbj5PM
         IL4jH06s2gv/DTEbhFUFBj9bdbA8mQXdDZ+3wnwW7gXG9i3lDZrKMYEGGfXny4d+YFfm
         ODBVWYTmc0yTm0vtSmpSGzUs37bIKveoPG5JiSehQwjwWYxDp+U1UXfyY+VZ4kCb8oPz
         Xm0w==
X-Gm-Message-State: APjAAAVhw7iLUQnIt+pfzz71Rd372X7z7dfTbix8i5qVNNSsF3itGP2D
        mZtyZjXZyyPDqAVG0rA0TZ6fWw==
X-Google-Smtp-Source: APXvYqyfMx9psJcHwdQJaV1Gfgogu/f2ULTJSwrbGBvr+1926NVQ0lmFBoo5xeAkyfipxmA98WqE2Q==
X-Received: by 2002:adf:a2cd:: with SMTP id t13mr31996957wra.251.1566304470874;
        Tue, 20 Aug 2019 05:34:30 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id 39sm59456442wrc.45.2019.08.20.05.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:34:30 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ASoC: meson: axg-tdm-formatter: free reset on device removal
Date:   Tue, 20 Aug 2019 14:34:13 +0200
Message-Id: <20190820123413.22249-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the devm variant to get the formatter reset so it is properly freed
on device removal

Fixes: 751bd5db5260 ("ASoC: meson: axg-tdm-formatter: add reset")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-formatter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-tdm-formatter.c b/sound/soc/meson/axg-tdm-formatter.c
index 21c735afab35..358c8c0d861c 100644
--- a/sound/soc/meson/axg-tdm-formatter.c
+++ b/sound/soc/meson/axg-tdm-formatter.c
@@ -325,7 +325,7 @@ int axg_tdm_formatter_probe(struct platform_device *pdev)
 	}
 
 	/* Formatter dedicated reset line */
-	formatter->reset = reset_control_get_optional_exclusive(dev, NULL);
+	formatter->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
 	if (IS_ERR(formatter->reset)) {
 		ret = PTR_ERR(formatter->reset);
 		if (ret != -EPROBE_DEFER)
-- 
2.21.0

