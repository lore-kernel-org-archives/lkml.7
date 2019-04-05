Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF19CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B071921871
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS90n7M0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfDELue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:50:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54781 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:50:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id c1so6325503wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 04:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4vA423L0B512xMUlryz6tq1OFnDQMAXtE1k4y9JTwU8=;
        b=lS90n7M0sIJmX7378Mlz1DffDMeuP7nsstODg05YV2EbsaPm4nNU3KJpDHXWzaIXPr
         u6BwJmnXogDkgdA07PegcKKmUp6YCdPT7tOss+AOzoyMDOarhk9PZJKu6ihaXhUBzBQL
         S38Q3k8Znd/pZnCXaQ9qMyHJq0ib0FlVsD9FuAMFnBkc+hosdjKDbHkOcM+qYDeoHG8o
         IYl1hiFdL3+wXX81p1/JZV6KyEboZotMJc1dofcK7JsxLjbxOtKW3GzADTc8J9/29HPI
         9jEhLqPwmX69OpH29al9vrbtf0WFaxJ/ZBQHNGUsOVaxAYg88ErvpX/I3pAbWu8VfMIe
         O7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4vA423L0B512xMUlryz6tq1OFnDQMAXtE1k4y9JTwU8=;
        b=eAnW+86FUO+e10ViKBalgw5TtLrCu6C8SkkrkxPq3xgSHaQW8SkoNTFP2b2XLENFm5
         MnRGp+ntoov0wo5m0iEeQ3Z2cAAJ47CmTgGDr9zSZA+0vWxW3MOvGKk+BXG4Rz/Vm4S8
         BsDeap56YTiqIg3cEKtWwQ/FO2M+BbUvr9TNC1iG5AttFub6h66asMOfjihLQv/qTKGX
         N/lJLll0evctIrUwtgMiqqi+izRy2fjN6ekFWXYb2ba3cYaUT6ydlc1+/h1XBCbF4Vw5
         4DLrf0qSJ/0HvufeQi+5lR/CkQ+kUtJwoKLKTH6i2L7cCktcoSl5iVND0ceQwlmg2wGN
         v+ww==
X-Gm-Message-State: APjAAAXXrJSFckbJFu1GKkZHdsdcvcF0q/IJsBiMLkJiWwvMCLIh5IxC
        yEhFjUMuTg+x76pKautrzk4=
X-Google-Smtp-Source: APXvYqx9Z2lotprdS0f7CAgDP62VLBrh+tflNBNFTwLPW4sxxK1RN4/7CCyU+7WRBw65MpzQfZVdgg==
X-Received: by 2002:a1c:4d02:: with SMTP id o2mr7556344wmh.134.1554465032373;
        Fri, 05 Apr 2019 04:50:32 -0700 (PDT)
Received: from localhost.localdomain ([178.138.34.252])
        by smtp.gmail.com with ESMTPSA id s203sm2881479wmf.14.2019.04.05.04.50.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 04:50:31 -0700 (PDT)
From:   Andra Danciu <andradanciu1997@gmail.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     daniel.baluta@nxp.com, Andra Danciu <andradanciu1997@gmail.com>
Subject: [PATCH 00/20] Switch to SPDX identifier
Date:   Fri,  5 Apr 2019 14:49:50 +0300
Message-Id: <20190405115010.28838-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set switches to SPDX identifier inside the fsl directory.

Andra Danciu (20):
  ASoC: imx-pcm: Switch to SPDX identifier
  ASoC: efika-audio-fabric.c: Switch to SPDX identifier
  ASoC: eukrea-tlv320: Switch to SPDX identifier
  ASoC: fsl-dma: Switch to SPDX identifier
  ASoC: imx-audmux: Switch to SPDX identifier
  ASoC: imx-es8328: Switch to SPDX identifier
  ASoC: imx-mc13783: Switch to SPDX identifier
  ASoC: imx-pcm-fiq: Switch to SPDX identifier
  ASoC: imx-spdif: Switch to SPDX identifier
  ASoC: imx-ssi: Switch to SPDX identifier
  ASoC: mpc5200_dma: Switch to SPDX identifier
  ASoC: mpc5200_psc_ac97: Switch to SPDX identifier
  ASoC: mpc5200_psc_i2s: Switch to SPDX identifier
  ASoC: mpc8610_hpcd: Switch to SPDX identifier
  ASoC: mx27vis-aic32x4: Switch to SPDX identifier
  ASoC: p1022_ds: Switch to SPDX identifier
  ASoC: p1022_rdk: Switch to SPDX identifier
  ASoC: pcm030-audio-fabric: Switch to SPDX identifier
  ASoC: phycore-ac97: Switch to SPDX identifier
  ASoC: wm1133-ev1: Switch to SPDX identifier

 sound/soc/fsl/efika-audio-fabric.c  | 17 ++++-------
 sound/soc/fsl/eukrea-tlv320.c       | 26 +++++++----------
 sound/soc/fsl/fsl_dma.c             | 26 +++++++----------
 sound/soc/fsl/fsl_dma.h             |  5 +---
 sound/soc/fsl/imx-audmux.c          | 26 ++++++-----------
 sound/soc/fsl/imx-es8328.c          | 15 +++-------
 sound/soc/fsl/imx-mc13783.c         | 22 ++++++--------
 sound/soc/fsl/imx-pcm-fiq.c         | 21 ++++++--------
 sound/soc/fsl/imx-pcm.h             |  6 +---
 sound/soc/fsl/imx-spdif.c           | 13 ++-------
 sound/soc/fsl/imx-ssi.c             | 57 ++++++++++++++++---------------------
 sound/soc/fsl/imx-ssi.h             |  6 +---
 sound/soc/fsl/mpc5200_dma.c         | 14 ++++-----
 sound/soc/fsl/mpc5200_psc_ac97.c    | 16 ++++-------
 sound/soc/fsl/mpc5200_psc_i2s.c     | 14 ++++-----
 sound/soc/fsl/mpc8610_hpcd.c        | 18 +++++-------
 sound/soc/fsl/mx27vis-aic32x4.c     | 29 +++++--------------
 sound/soc/fsl/p1022_ds.c            | 18 +++++-------
 sound/soc/fsl/p1022_rdk.c           | 32 +++++++++------------
 sound/soc/fsl/pcm030-audio-fabric.c | 18 +++++-------
 sound/soc/fsl/phycore-ac97.c        | 16 ++++-------
 sound/soc/fsl/wm1133-ev1.c          | 21 ++++++--------
 22 files changed, 161 insertions(+), 275 deletions(-)

-- 
2.11.0

