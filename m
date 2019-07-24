Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36316C7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0960C2190F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 16:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jITz/uDE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfGXQYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 12:24:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33718 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728748AbfGXQYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 12:24:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id n9so47740355wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2019 09:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rscQz3KUGOpkCDKHMcXdQe7Cl/GoBVV86V2E9kxxK1s=;
        b=jITz/uDE43k3A8NB1nlk3u+xzG/Y0MTElmt4Smge4Q7/p2i4AQP+Ot+lzFSbs47nGs
         nn730d5rJ1NTniNhwvL69qjT1i8otT5IErkH1IiOMTNxW24JI06varqHToVixQg9jubW
         apzUCJPFyUzn7NKyoVzr34ZHbOSBLFFqurZhsZcz1QT5CYE5yCVjRWij5XwCt1SsMLH6
         gO3Jx9ohRvjRTh/gNM246+tC38Ty8u7M+KUP7nIZiB3NUacjKhIFZsBmuWhWZ1skiHep
         HHskYmreyeF6CvNKUjIf88ehFvrMJu1k0LGqCrX+Itgq1xAhb/3oczCVjg1ktXi2w5x3
         +efA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rscQz3KUGOpkCDKHMcXdQe7Cl/GoBVV86V2E9kxxK1s=;
        b=V/tC6XZE6m8IxJ3BjBAQPrO23GlHHCH4H5UFHYQbS5wGgiJqeqzvnXraXU8sxrIcMC
         q1AOejsmG5oOrOHJWeEVvWqCTwGLH6vcnpNuAEjLFkJTsZ+WP0j/xdKddLZR9j9om71t
         VTP2ANGADzTp9rJZ8g1SYPnI1BiiibpuJjmgk5nmcp6r8Z396PnURCyYyDXWnG/I04zq
         +R/+RybA1UQEoiDPaoBLBb5jnct4O7MNINMBO+I1X21DQ+lwi4usIaJBKT5ZYSBELfKv
         sTFphGe4VsohF9qkOlVX+spsKKs5dMVshSzH1maQIX+WeDwMxOwcTyevfyGnfxK4po1X
         kH9A==
X-Gm-Message-State: APjAAAXN4itw8FCvXw/hFQMUOOzKBU9ee01vvhaZwFCXGsMwwslbsJ8E
        9xMSmq1b9KEz8lmhKb+TYVGMZXr14lQ=
X-Google-Smtp-Source: APXvYqwzABCOBCOzXWxksAWXozHEuvx2wpN+ZOBXgno4LlJoOSdi7K6PGndRhEJOhxZWMIuNGujEzw==
X-Received: by 2002:adf:8bc2:: with SMTP id w2mr5964754wra.7.1563985449460;
        Wed, 24 Jul 2019 09:24:09 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id f70sm55688960wme.22.2019.07.24.09.24.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 09:24:08 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH 0/6] ASoC: improve codec to codec link support
Date:   Wed, 24 Jul 2019 18:23:59 +0200
Message-Id: <20190724162405.6574-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As explained in this previous series [0], on Amlogic, we are using codec to
codec links to deal with the glue which is between the i2s backends and the
synopsys hdmi controller.

This worked well until I tried to .get_eld() support in the dw-hdmi-i2s
driver.  Doing so adds channel mapping controls to the codec. This shown
several problem

1) .pcm_new() is not called on codec to codec links.
   struct snd_soc_pcm_runtime do not even have a valid .pcm
2) struct snd_pcm_substream and struct snd_pcm_runtime are ephemeral
   This is a problem if a control needs to access them

The goal of this patchset is to resolve the above issues and improve the
codec to codec link support enough to correctly handle the hdmi-codec

The support of these codec to codec links could probably be improved in the
future to behave like any other link and use soc_pcm_open(),
soc_pcm_hw_params(), etc...

The challenge lies in the dapm mutex. The soc_pcm call dapm function locking
this mutex but the dapm mutex is already held in snd_soc_dai_link_event()

[0]: https://lkml.kernel.org/r/20190515131858.32130-1-jbrunet@baylibre.com

Jerome Brunet (6):
  ASoC: codec2codec: run callbacks in order
  ASoC: codec2codec: name link using stream direction
  ASoC: codec2codec: deal with params when necessary
  ASoC: create pcm for codec2codec links as well
  ASoC: codec2codec: remove ephemeral variables
  ASoC: codec2codec: fill some of the runtime stream parameters

 sound/soc/soc-core.c |  42 +++-------
 sound/soc/soc-dapm.c | 186 +++++++++++++++++++++++++++----------------
 sound/soc/soc-pcm.c  |  35 +++++++-
 3 files changed, 162 insertions(+), 101 deletions(-)

-- 
2.21.0

