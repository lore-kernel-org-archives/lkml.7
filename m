Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310E0C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0432420679
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mPvW2e6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfFRHSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:18:08 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39334 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:18:08 -0400
Received: by mail-pf1-f195.google.com with SMTP id j2so7113803pfe.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Lj4Or491uCz2tJJXb3WzbO2VXWNk3Hk7nTOtYQN43sI=;
        b=mPvW2e6mcV/CIqhidFpo+Yurn5TdvkXOW1QdaK3u5WTFGziti+wTCsJW/eOOr02fqG
         J9JT0PVET8S1CLVBiYeXo2sKcEPICn18rwWbomdjPf2FiLN4VjQzlUsjJufdGHsHnIl/
         yucipCljbwALWRVvWM6KF4m8FqUC2+lBTG3jYhsyOODebLlB5k6xtqgnNbW6rZWsrHBN
         +ls1KOFsQeRhllGKvOrw9dfca9T45nBQEH7T4VCNFlpTSgvYvAJ3jh+83VBphd3ftRIL
         nZl+2bwQZIS7GAI/obVHxanKvqbfkrHlqkWTaG4cJGi3M4vUQGG4EWgtvcuI2qzN5EqR
         RdqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lj4Or491uCz2tJJXb3WzbO2VXWNk3Hk7nTOtYQN43sI=;
        b=DpyHwcZH0bWZF3nBvvE+hO1GSF2P1/MvdEL9lcnGcF/BUjRfex6qUktO+xElUO5pPZ
         aXQjqECiUmjuOuu6qrZpoMx3Olnw6bLaDr5/rlsS5VdfPVr01MujgKNACNfoWZrfP7zc
         idqyClXibkRrkKMS333BniWd4IoE1o1S+2pED0zx/gZrYaCPzGKA+U7R6t4m92yDv2/a
         J75i5YA3odTVAsY6o5kWjzYXIgrPnOCoS534YM2VB4MLW5d8rmDOJpkXgjb5ixF7lOt4
         Ss/dq+p7WgWClJIoofsvQYeUGoemRMv2FXEYxchDNBSh5GG6g8fqGIMHY0myblb9HAaF
         O1Ng==
X-Gm-Message-State: APjAAAWgDUDQgd/AW9TNCr4N0Ts5iDMbS1eohERU7jc5Ao7Y0kBmMixr
        DW2OPNWbiPRqQqPT/gj670mOzQ==
X-Google-Smtp-Source: APXvYqzVQmDQx7MS4P1iKQ8RlVJhSS2xJyaB9wF2eydxpDgmsaFQMWNabJZt0GUQO5Ds3AbcW/Ei9Q==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr3088727pjp.76.1560835753055;
        Mon, 17 Jun 2019 22:29:13 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id b6sm13477601pgd.5.2019.06.17.22.29.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jun 2019 22:29:12 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Patrick Lai <plai@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: qcom: common: Mark links as nonatomic
Date:   Mon, 17 Jun 2019 22:29:09 -0700
Message-Id: <20190618052909.32586-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interface used to communicate with the DSP can sleep, so mark the
links as nonatomic. This prevents various sleep while atomic errors when
bringing up the audio interface.

Suggested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 sound/soc/qcom/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index 97488b5cc515..2c7348ddbbb3 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -116,6 +116,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			goto err;
 		}
 
+		link->nonatomic = 1;
 		link->dpcm_playback = 1;
 		link->dpcm_capture = 1;
 		link->stream_name = link->name;
-- 
2.18.0

