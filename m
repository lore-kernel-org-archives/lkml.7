Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F878C28D1E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C4D2070B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 11:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwkWNm95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfFFLXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 07:23:09 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46879 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfFFLXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 07:23:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id n4so1973468wrw.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 04:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr9e4dK0lnGJ2yEy2umbpZ8NBL7aMcK376HEwfKTTSg=;
        b=EwkWNm95uFdLdM6RVx3Tj6uT8um7i0aQEk1uRiVUv6JiohjUK7uiq6SBosLxySlReZ
         w4+rqFTLDLLwOXiyiaTuRODHY2MCzFPoj4wGmCszy3QpM4x3VDY0toxgqWrOg5qgDiBy
         Wf0JxWZ0DuyF8axVyO7cJknAe+UoMA5tKaVllx1TOlExCep8ehzJtmLPY3MCL4OHXj0U
         ZpZITzyhYsNsYtt1HZVVGAarS8nclV9zhm43p1sT3GBHR4IL8n0Y9KsOy5SEOZDdIiPD
         uexzGvIpYaO2St7WwsvcujbC56A8JY9lH2lIb0tGY5YqwTBNRRKf9xdwlic898Xi7qqc
         fW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pr9e4dK0lnGJ2yEy2umbpZ8NBL7aMcK376HEwfKTTSg=;
        b=eONiJaAh2whPYXGatguzWcJ0T2voG6gdX+i9gverhVlD1/4a0CzLwaiuLfisA2E5lh
         LXXYU2zcc4m9BY4fSjRYJIT/YmL2/etvExig+RkBcq68i+ChQwrhut/Vi28uPAzjIQCW
         1mBhUmG3XAwAgizogZ8/ndpryXAchQ21OlzrE3kUfPPiHte7yFp8Wa83/J5MBT95D/+9
         dNWUzcTyZvdcDn4WVU8WfEMl940Qlp5Fx6BShFK0h0+G/aWkk37F+IUoMK+vmFLTh68l
         ketVBji36dj7PTovrwp1x4weiSsaVJcqNOZPdoGe85AhzUiZkp38jsGuQkKsetpv5LkI
         1l8g==
X-Gm-Message-State: APjAAAUblCTatiiwqEsdD+F9i++yL/CGlu2CE75ZjSFT22Eb440yANnf
        ll1eHsH8Pc4yus4o06xHhrAaLw==
X-Google-Smtp-Source: APXvYqwyiior9PPfwKkJcFzeIeybdOuBR2JLMi76La9WAds25CUUSZ1rFmNh/oK2g0Eo/Lfl17HItA==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr12198131wrv.126.1559820187229;
        Thu, 06 Jun 2019 04:23:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id f21sm1558333wmb.2.2019.06.06.04.23.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 04:23:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] soundwire: intel: set dai min and max channels correctly
Date:   Thu,  6 Jun 2019 12:23:04 +0100
Message-Id: <20190606112304.16560-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like there is a copy paste error.
This patch fixes it!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/soundwire/intel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 92be6ad84e8d..317873bc0555 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -721,8 +721,8 @@ static int intel_create_dai(struct sdw_cdns *cdns,
 				return -ENOMEM;
 			}
 
-			dais[i].playback.channels_min = 1;
-			dais[i].playback.channels_max = max_ch;
+			dais[i].capture.channels_min = 1;
+			dais[i].capture.channels_max = max_ch;
 			dais[i].capture.rates = SNDRV_PCM_RATE_48000;
 			dais[i].capture.formats = SNDRV_PCM_FMTBIT_S16_LE;
 		}
-- 
2.21.0

