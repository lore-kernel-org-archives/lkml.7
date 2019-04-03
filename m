Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B8D8C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290D82084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 06:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JCwVzhUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbfDCG4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:56:02 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46598 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfDCG4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 02:56:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id h21so13776284ljk.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 23:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6nBKwdpUeXgOaBDWhRUmhQnAUSDUDTdXm2H5dVc2Qw=;
        b=JCwVzhUnie7ynLFL0eGk6kAglbhANXSQCHCfNLYKEPVVnPZMfO0v7im0un6+dLtpmT
         OuXUbLgOLF3KHR3GGJhDb1ZbDlEhn8OeLQtByd0pmmCNRwTC3RCRnPcoj6u4SJtu0u3L
         mrvOzy8GlYpqMJD5XiKzAwYpvSu7KIhghj+rmTZUWic1i4TB8TFrpGX3WavPNJLZ6Lb8
         gJFvQpzOJ8ufLt1BR938R+v9OaDDFhQTKSMc/Jmd/JyM/mhUMigFj88z+OfEvUz+5P9C
         358PomxACBRAJDd/Ijt0FZp4Dy1QHSfprZZhs4uHOmRFuyEUi6+CaJdVSRS3cWhtsW27
         5ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I6nBKwdpUeXgOaBDWhRUmhQnAUSDUDTdXm2H5dVc2Qw=;
        b=oV7zIsg9RD51oFCvwTNiKs7sDVp9sItorg78uaYh3v102lMkaefjbyQ6PY1jD7ba9B
         usp1tHBWvnfH1fK9laLw3yFrjLVxqRgX4KZSTrNGe8D6ZhAxHXLfewV2GQvs87J/Rf52
         nXM8NYWB3Gt8D9eFijudsm/DzruOAoNGOzmWfKksVO+iIL4QzfiL1lE8JqcOWzqXWq3K
         4KEkMGw8MBEaZny3pGC/y/6Tpp+yYGg/5TM78lB5MK+WQ4wIaUCuo2d1yzRugZiglNlr
         IbxXmJMnYqSQFby53u1eImScK8Wsv49ChjckY29mFgAKY91oFRBkv9aGkKCZOJhKr1Y3
         KzqA==
X-Gm-Message-State: APjAAAXav0w+y7lvcec0ALWSbOrNaUYP/86G4kM3nknUt9Vhhdm9/AmB
        J1zT63QAigquevOTSYL3Y7qYbw==
X-Google-Smtp-Source: APXvYqxlpaxZyjKugyhYttDEeO/n1d4OeGlVbovQ9CgbDa4n9N7BKuuKJB1yx+LiEuCOju6MhS0QMA==
X-Received: by 2002:a2e:84ce:: with SMTP id q14mr7838919ljh.80.1554274560128;
        Tue, 02 Apr 2019 23:56:00 -0700 (PDT)
Received: from localhost (c-573670d5.07-21-73746f28.bbcust.telenor.se. [213.112.54.87])
        by smtp.gmail.com with ESMTPSA id v21sm2788168lfg.26.2019.04.02.23.55.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Apr 2019 23:55:59 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] ASoC: Mediatek: MT8183: DA7219: fix build error
Date:   Wed,  3 Apr 2019 08:55:47 +0200
Message-Id: <20190403065547.19382-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building CONFIG_SND_SOC_MT8183_DA7219_MAX98357A=m the following
errro pops up:

../sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c: In function ‘mt8183_da7219_max98357_dev_probe’:
../sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c:413:13: error: ‘struct snd_soc_dai_link’ has no member named ‘platform’; did you mean ‘platforms’?
   dai_link->platform = NULL;
             ^~~~~~~~
             platforms

Rework to use 'dai_link->platforms' instead of 'dai_link->platform'.

Fixes: ebbddc75bbe8 ("ASoC: Mediatek: MT8183: Add machine driver with DA7219")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
index 93536659a859..1e7e8aed8707 100644
--- a/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
@@ -410,7 +410,7 @@ static int mt8183_da7219_max98357_dev_probe(struct platform_device *pdev)
 		 * the "platform" will not null when probe is trying
 		 * again. It's not expected normally.
 		 */
-		dai_link->platform = NULL;
+		dai_link->platforms = NULL;
 
 		if (dai_link->platform_name)
 			continue;
-- 
2.20.1

