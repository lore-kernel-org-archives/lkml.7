Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 266D5C31E49
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397A2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ok5DOoG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbfFMP0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:26:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39574 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfFMLmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 07:42:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id z23so9764401wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tw+9nr0k/SQ4+6C+T7NQWdtgxVemIU5O6qgx24DY8vo=;
        b=Ok5DOoG/v42T5p/NULeH/QnUtOj3y3bgwt/tHoF5P/QfLizFjo2FteTJhShh/SJZlr
         Nmlqr3KRJRhMsWo6pVvAXVbul1OayENODZ5gcGgO5C7JDGHK9U+PzWdA/jg93WjfgrBX
         3aPLgeJJNFVLG2B/rgjiiSmhS+VPDiaQJtZu9Yj5qNZsnJJwZOWKrk3hKiDrwVwOJa46
         DJ8yGbCY355E06ytD2Ad5rB+zWuOJWxU5VFLulOd9U0WSoao+makMDcH1cw103nSXVwm
         WvwvNjZS5YfcP6dgfELXmWKxdmNFba7TWuBCTXVwsvhillQ7D9Jrl3egEbQtgmyPgiVH
         5Z9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tw+9nr0k/SQ4+6C+T7NQWdtgxVemIU5O6qgx24DY8vo=;
        b=QvON5aJee1EBQbql1umAudiqtmPRf2E+xTrWL2WA7+Q/5NbneBPLm9TOu2rPvG272O
         SQR0wXN+VKTQiD9URbB4fWE5fPEvkf9K9P2CrkSWPjLcMBghTtnUZ1oZ50CskFq4YvaM
         m1wTi/o05xqPtrP3wvA7w68czUe7lAgtRJh40uaE81kwZyiZg2qy6DO5t/ljB/RCLm/R
         1Yzswq0KeWqfGgKzTSXtvLs3A/0IWqmaCqbsIgilRoYc6L5+pjh2+tNHXy7a0JwN/EtB
         sMOFuNXGn6qE1lMx9xk3O9OLPfvLOUvZsz2ugZme8GB75WclwX0rGc7o+RHSXG5EI/2y
         d9aA==
X-Gm-Message-State: APjAAAVfs2+NbCXS3ulTxgZwas3idI37OKnaQBLzMckEEm3gykw1hZ5T
        ZERPI33zg3Z3PXyVbEUsC7e+BcE4uQE=
X-Google-Smtp-Source: APXvYqzEpIcfbKY9VmOQOlh4gHR44pyPiRNjVhiHDFIUMTdcrq2NBX4iOv+SXfr3SjTejuF07/m1hA==
X-Received: by 2002:a1c:9cd1:: with SMTP id f200mr3280189wme.157.1560426163056;
        Thu, 13 Jun 2019 04:42:43 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id b5sm2598490wru.69.2019.06.13.04.42.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 04:42:42 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 4/4] ASoC: meson: axg-tdm: consistently use SND_SOC_DAIFMT defines
Date:   Thu, 13 Jun 2019 13:42:33 +0200
Message-Id: <20190613114233.21130-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613114233.21130-1-jbrunet@baylibre.com>
References: <20190613114233.21130-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There a mix of SND_SOC_DAIFMT_ and SND_SOC_DAI_FORMAT_ in
axg-tdm-interface.c. Even, if this is currently the same thing, lets use
the same group consistently.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 sound/soc/meson/axg-tdm-interface.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/meson/axg-tdm-interface.c b/sound/soc/meson/axg-tdm-interface.c
index 585ce030b79b..d51f3344be7c 100644
--- a/sound/soc/meson/axg-tdm-interface.c
+++ b/sound/soc/meson/axg-tdm-interface.c
@@ -306,8 +306,8 @@ static int axg_tdm_iface_hw_params(struct snd_pcm_substream *substream,
 		}
 		break;
 
-	case SND_SOC_DAI_FORMAT_DSP_A:
-	case SND_SOC_DAI_FORMAT_DSP_B:
+	case SND_SOC_DAIFMT_DSP_A:
+	case SND_SOC_DAIFMT_DSP_B:
 		break;
 
 	default:
-- 
2.20.1

