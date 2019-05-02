Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC4CC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC96E20645
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 12:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zsm0Hc1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfEBMKz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 08:10:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51874 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfEBMKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 08:10:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id t76so2479708wmt.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VXnkCeQD9CSagUVthpKhe513V9cyFde6oB8Eo2RI2s=;
        b=Zsm0Hc1NNbj1/+fIZ/BsybgMhuG/oOzaKqUFCEk8LgEfDc9hJT7dxy7GpIFI4JNnhr
         PGXOVN0dZ2kiiDCJr85WYiICSRRDNKkpe9/jAqTZ0mlOf4j9RPB5r8PVl56U8lkocgJt
         KVdNAV3h/Q4NNidtPUvEOB5GFV63HNMfuVMbxEYXAw8YMLy6Bo9teYIc13Np49yXKlwq
         LQCqrOMBFHnxdcMlWFEn+Qdo9/UEjBCRLz1uBbVaYkoOK6RT4sZIoQrWpp47OZmXVBAM
         gMtQ6gLO+p739fPYzxm6NGDSulCjzNZ3MzKZcsUl38RoxfjTeBjxesm9h78AeVzhytaX
         ID/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+VXnkCeQD9CSagUVthpKhe513V9cyFde6oB8Eo2RI2s=;
        b=nD0YhhFSxpHVWBRggZe0ipeBEw+PZIMQGeUKI12HMc+3wHnGyxJDMRHyKAX0nbMTmr
         2F6oiz6/W/qEdi3ETtmcKFolpMRaYS8MtHfhORul3qil351dkk0UYK0zbyyB1dX/V1Co
         0VFF9Pvj6BvYoGXabKsYAr9aJESm17AI+XvzVFEE5j6L7AbH72vnk6b2IE50Ovq7lytj
         3KHO46xOpMT6yCn5J0U0brPYKZs6Ckg37jDdD5dSidptfjvH4UXP/D26h8aDhNFVyvO1
         AThXNmFXUCcM+jP2oAwKH/OjSgLk+sE/MCa/z5ld4DLFLZa+R5lY15YFSs3Rb3071lZM
         YClw==
X-Gm-Message-State: APjAAAVC83uGTNyfSya1VrsbMajEOY9K3AriaR1q99YxKKW6gm414Itu
        OyeEbnsryT+2h/0AdpN1BE9WPg==
X-Google-Smtp-Source: APXvYqzRKOlOevXDDSWksfUTYabZbVoMJ/6J96gC1hBjVY9RvSugrai1mEmZuwx2m1GH4e4XuKgfFw==
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr2265512wmh.32.1556799052888;
        Thu, 02 May 2019 05:10:52 -0700 (PDT)
Received: from localhost.localdomain (aputeaux-684-1-8-187.w90-86.abo.wanadoo.fr. [90.86.125.187])
        by smtp.gmail.com with ESMTPSA id u9sm3648348wmd.14.2019.05.02.05.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 May 2019 05:10:51 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, matthias.bgg@gmail.com, perex@perex.cz,
        tiwai@suse.com, kaichieh.chuang@mediatek.com,
        shunli.wang@mediatek.com
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 0/5] ASoC: mediatek: Add basic PCM driver for MT8516
Date:   Thu,  2 May 2019 14:10:36 +0200
Message-Id: <20190502121041.8045-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add a basic PCM driver for MediaTek MT8516 with only
support for ADDA Playback & Recording for now.

Fabien Parent (5):
  ASoC: mediatek: make agent_disable, msb & hd fields optional
  dt-bindings: sound: Add MT8516 AFE PCM bindings
  ASoC: mediatek: Add MT8516 PCM driver
  ASoC: mediatek: mt8516: Add ADDA DAI driver
  ASoC: mediatek: mt8516: register ADDA DAI

 .../bindings/sound/mt8516-afe-pcm.txt         |  28 +
 sound/soc/mediatek/Kconfig                    |  10 +
 sound/soc/mediatek/Makefile                   |   1 +
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |  23 +-
 sound/soc/mediatek/mt8516/Makefile            |   7 +
 sound/soc/mediatek/mt8516/mt8516-afe-common.h |  18 +
 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c    | 794 ++++++++++++++++++
 sound/soc/mediatek/mt8516/mt8516-afe-regs.h   | 218 +++++
 sound/soc/mediatek/mt8516/mt8516-dai-adda.c   | 316 +++++++
 9 files changed, 1406 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8516-afe-pcm.txt
 create mode 100644 sound/soc/mediatek/mt8516/Makefile
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-afe-regs.h
 create mode 100644 sound/soc/mediatek/mt8516/mt8516-dai-adda.c

-- 
2.20.1

