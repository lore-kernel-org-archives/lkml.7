Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45544C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC321871
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eXNI7uF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729844AbfJHXwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:52:15 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39609 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbfJHXwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:52:14 -0400
Received: by mail-pf1-f193.google.com with SMTP id v4so371113pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=93hNjDd5eCXL0gLM7IExhV/a9m9EoJoT7fu4u8l/oCM=;
        b=eXNI7uF0qS/fCt2cI6utGIXdycLWTx96ipuD1Awfs01s+oJasZqugJxfDr8XHm7lUZ
         8tjlu5fsX2JbhTMn9QkyqTBi6P7kyUsVaADWNvk/F75Y9kugrTQpZvB6/pg38RoNPDCR
         T6hxia1aurk05lY6rJaRTTdgwcuzUcea4EHyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=93hNjDd5eCXL0gLM7IExhV/a9m9EoJoT7fu4u8l/oCM=;
        b=GSaZpdsltg7Dc7YFRykUXJDyPJF19Q6eQiNrxL0767T4bEMxO1uvmMKEFrHEh8bwAf
         cfv23UK7ivcCGy0zZpdot2gk+7eVSIkgCu9nPGmBo7x4sXVmafcoqjGrhMrPLacRPp30
         epoEqLq3YUA3WHUk3mAQh2owSo9dOZLCr0OzRdXe5vbv8GVlrocivf0iGfZTl3J+5Sid
         yriyVQzS8JEbskCd5qoVTgXCzZIAYy04WUUwK2gzR20zb6aWTQtXRAFo0CaAXTH0gOYW
         gUbwe04fkmBhkEIHGTj8koEETpgqSpbJcjskGgTHMp9vGCeU7KbNwspfTly63DFQcu4Q
         /82Q==
X-Gm-Message-State: APjAAAUshk/juqjCdOnQ/xzWS2syR+Ub6v1bL8ZerlmZ6lgr0xcb37Ps
        h01BHh3ADogCOsbT5YYSnD5hdw==
X-Google-Smtp-Source: APXvYqyazmsIa9xT1DjyyRpW2ecIG7h2tPAxbPMK5zo+csVhL9H79eaaMl3eZK/YO3F1MgHPdxSGMg==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr617041pfd.49.1570578734052;
        Tue, 08 Oct 2019 16:52:14 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o11sm252083pgp.13.2019.10.08.16.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 16:52:13 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: jz4740: Remove unused match variable
Date:   Tue,  8 Oct 2019 16:52:12 -0700
Message-Id: <20191008235212.228856-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
In-Reply-To: <20191008105815.1011a0fc@canb.auug.org.au>
References: <20191008105815.1011a0fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 67ad656bdd70 ("ASoC: jz4740: Use
of_device_get_match_data()"), the match local variable is unused and the
compiler rightly warns.

sound/soc/jz4740/jz4740-i2s.c: In function 'jz4740_i2s_dev_probe':                                                                                                   
sound/soc/jz4740/jz4740-i2s.c:500:29: warning: unused variable 'match' [-Wunused-variable]                                                                           
  500 |  const struct of_device_id *match;                                                                                                                           

Drop it.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Paul Cercueil <paul@crapouillou.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <alsa-devel@alsa-project.org>
Fixes: 67ad656bdd70 ("ASoC: jz4740: Use of_device_get_match_data()")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

Can also be squashed. Sorry I missed this warning in the compile log.

 sound/soc/jz4740/jz4740-i2s.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index d2dab4d24b87..38d48d101783 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -497,7 +497,6 @@ static int jz4740_i2s_dev_probe(struct platform_device *pdev)
 	struct jz4740_i2s *i2s;
 	struct resource *mem;
 	int ret;
-	const struct of_device_id *match;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
 	if (!i2s)

base-commit: 442630f691a1537b7e0cc35e3d580222077549cb
-- 
Sent by a computer through tubes

