Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3D7C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7783D218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 22:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="pJdb7y6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfCUWPy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 18:15:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42538 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfCUWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 18:15:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so414423qtc.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cGs3eGMqjdfLuMnMLSalwd1mGmwK5wmY9nBTmNMBKQ=;
        b=pJdb7y6fOLx68SFi2gYzBiD/IHNr5sikCW/q5xwMYLFKviDc/RtJs8JUc3DzC23lg7
         p+br859pbZhBwJXWF6wLqjX0LoHUAFFW8TN8iuki9wDPy6hRzHZyzplZdxKfh22G1OyI
         haP6lqqU/lQ0v+P6Lr8ZLcfstDMadrqJGfJ44VVJR2qqvtrvIwU7JKWbdFPeJ4mvwHa1
         2Zjr05VVb156vPgygHMpvdcKeCFErc/nQN2SfF2VEjNydZuE5HcAe+MHLyb0apZ7ou4L
         sbXRlkngm6pZsRQNBo6IUFSk+pmc+KaNudw4uhWUMU94ay6JjJH/34Hs+KxMCSvDY0u/
         /hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+cGs3eGMqjdfLuMnMLSalwd1mGmwK5wmY9nBTmNMBKQ=;
        b=pBUm8/Etrx6dl2QaV4UDhA/Ax0FY3X3GQmkFzric+Qt23ui5UviWnYufr7aZCk8irj
         Vk6b7NKGB+wqP2K1n/G/TIYl9Inee79Xri866azHv3mcYO8hnPX9jAmGq5R/LAjWjUMP
         EVcby0mWc2cz1UcNoL7R4F+IaVE671iqtqK/A4JZL414BtGiHtiIXEXiNd1koreCMQyt
         InbqJ/lPfyxS2SBYZVJ299wzvBPlumENxV2c62nqlOAjLZR/2SaDdZo3UDNeE+aAK0L0
         +a+q6d2FL/OmdOO4B17KYT2hTbPqUPnHx+c/kbbCKd11UTkZc8eM+vBE29jZidVEM3F9
         KB0Q==
X-Gm-Message-State: APjAAAV9V8wuWcITs5K3S21BM7r1TOrx3k0fGk7t5J/pHTNRIs0ZhXjf
        mNZdt4jz3Y0CNmzofJd9xLy44g==
X-Google-Smtp-Source: APXvYqyw2K/rLLfDlv5vRb1Ig+veHNyTpcpbRow1iYkgyuAC1/fyX65TQli2E9Sy1Ss98Vue9qzOwQ==
X-Received: by 2002:ac8:8d5:: with SMTP id y21mr5361254qth.67.1553206552678;
        Thu, 21 Mar 2019 15:15:52 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id w37sm3895968qtw.27.2019.03.21.15.15.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Mar 2019 15:15:51 -0700 (PDT)
From:   "Cormier, Jonathan" <jcormier@criticallink.com>
To:     Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Cc:     Bob Duke <bduke@criticallink.com>,
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
Date:   Thu, 21 Mar 2019 18:15:42 -0400
Message-Id: <20190321221549.13765-1-jcormier@criticallink.com>
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

