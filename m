Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248FCC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E123D2063F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="Cu3L/Kj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfCUWOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:14:22 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41466 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727062AbfCUWOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:14:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id w30so419471qta.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cGs3eGMqjdfLuMnMLSalwd1mGmwK5wmY9nBTmNMBKQ=;
        b=Cu3L/Kj+kJ0Ar1WyEiKzCpuicDUpagkVXO1eUzocCFy1gb1PIgx/adBCoJEe2YxdHz
         2dW1P/y0BxJAIHuWSgWUb1NLIX7Wja6FnZHM9xroWYIYW2aKmAv6c6JCnEVoD4T+a5i9
         b+XSrFd90nygMRQHKy4X8dneLweyVGlekiOiIhn8jqFiYhWv0KJX070XE4Sk3o6sjfhX
         unI6QoQFbLMkNuJkEfDQ5FBINgEp1y7Lt2sGDTU0pCSHJsMSoMjLrIvy747gpArL0MmG
         /OlPj2b38j3ImJS4v/uR0vsZBvT831VNSD3xQkYtdvjIKIMH3G/7MZG04tHveOhNIzdK
         6Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cGs3eGMqjdfLuMnMLSalwd1mGmwK5wmY9nBTmNMBKQ=;
        b=IiiQ9DNPGFsveG8DgGMVgmYXIlDF5FUcuJEFeQ0MiMI1B2qUaHLHukONuPf3eyo4Ca
         QSqIWkJPQSL8EqZHmTN99nr2uSfHsNqvJfIeoeD/yw1/7h3rSfyfUp9/bH4d4Jq/lT8q
         Bg1m2zGWE0L9/4EMQQGoshsKbAV/rcLbJWivzYil5sqVTzeAF5/rnKPe2JRFdO4xZL4f
         bofVhstozdtqaQKLqcyo4sqgjXCcDuHpmVj1v1Og/v00Fsm3d+DKqSvH3Kbx3FkwinKV
         w1bKlnmud8ZniuEJTPJNm/XsUjtExBV2PUfugLYRN9ll3EoCtIdlxbtijYkUfDrby9lM
         gBrA==
X-Gm-Message-State: APjAAAWvf2tTSPHRQVmB5exQcjfoNcNQjslNzxal1bYEAn/ujgThOEha
        Xc+exYz1cj7jBs03gUsagIzrwg==
X-Google-Smtp-Source: APXvYqwnsszkRF1cw+4X13DUwSM/Ljv5sQRZu3oTK4cSDOIvbGOxEpaUK7MFo4jkBCUkn1b8ceaxEA==
X-Received: by 2002:a0c:9624:: with SMTP id 33mr5458927qvx.71.1553206460317;
        Thu, 21 Mar 2019 15:14:20 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id a67sm1700705qkb.53.2019.03.21.15.14.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:14:19 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     "Cormier, Jonathan" <jcormier@criticallink.com>,
        Bob Duke <bduke@criticallink.com>,
        Mike Williamson <michael.williamson@criticallink.com>,
        Greg Gluszek <greg.gluszek@criticallink.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jyri Sarha <jsarha@ti.com>,
        Misael Lopez Cruz <misael.lopez@ti.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] ASoC: tlv320aic26: Add device tree support and bug fixes
Date:   Thu, 21 Mar 2019 18:14:06 -0400
Message-Id: <20190321221413.13268-1-jcormier@criticallink.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches were created to get the tlv320aic26 working
on our AM335x SoM.

I'm resubmitting this patch series. Previous version here:
https://lore.kernel.org/patchwork/cover/601439/

This patch series relies on the following patch for proper operation.
commit 93d0ad8f374c ("ASoC: tlv320aic26: Convert to params_width()")

Changes since RFC:
- Removed the unnecessary "#if defined(CONFIG_OF)"
- Dropped the DSP_B patch
Changes since V1:
- Reordered Kconfig patch to first so each patch can be built
- Rebased changes to Linux 5.1-rc1

Cormier, Jonathan (7):
  ASoC: tlv320aic26: Allow tlv320aic26 to be selected in menuconfig
  dt-bindings: ASoC: tlv320aic26: Add device tree binding
  ASoC: tlv320aic26: Add device tree binding
  ASoC: tlv320aic26: Fix module autoload
  ASoC: tlv320aic26: Fix regmap by setting reg_defaults and reg_stride
  ASoC: tlv320aic26: hw_params was unintentionally clearing AIC26 master
    mode
  ASoC: tlv320aic26: Change Capture Mute to Capture Switch to match alsa
    documentation.

 .../devicetree/bindings/sound/tlv320aic26.txt | 65 +++++++++++++++++++
 sound/soc/codecs/Kconfig                      |  4 +-
 sound/soc/codecs/tlv320aic26.c                | 55 ++++++++++++++--
 3 files changed, 116 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/tlv320aic26.txt

-- 
2.21.0

