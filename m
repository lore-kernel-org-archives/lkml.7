Return-Path: <SRS0=wu79=TZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 029AFC07542
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387820862
	for <linux-kernel@archiver.kernel.org>; Sat, 25 May 2019 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV5jA5v5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEYQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 May 2019 12:23:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35038 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbfEYQXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 May 2019 12:23:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id m3so12812333wrv.2;
        Sat, 25 May 2019 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LlOtACKjbEr/GliRByNyiFfoBZkDJEiHct/H5BNOuY=;
        b=ZV5jA5v5EdN40oeJfD4arM0grlVd263pi7HCfu/Lc0qtmkGH6d5JkHX4RLYsVFdo7p
         RxxjsRkFcC3QtLx+gTS7jcGmaZb71ntgsbN8wtjFp5ovd1e8g1cmsNQ9K4Qd5sxVgFzi
         g1PtXq+RM5z3TsGHjJ7KOI/qavbiq7v7ao+zXTa8wXBnh2RhTZVGA9Pzoy02MxBUS9th
         XkP83HXw2qGBW46cSdiN9KuONPMA21B2CtuaYs2KgH0RDSfFhRAk6m4m++OrwiemvWoC
         1etX1l5ZhdKBlg91SWsWmqQNpLC5KWeZhjl8AEXmoeNEg5rPmVScInG4vBtHdTPpsklu
         Hnow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1LlOtACKjbEr/GliRByNyiFfoBZkDJEiHct/H5BNOuY=;
        b=RNB6dYNSxK61Hyf8aIVjtmTUbxcZX+FBk1B6ZUgLEcm5AqoL1KLZ0rRSOtoaG9cBZ9
         UTpu1/t5L2YxktGGaZHkfDlAPAQxe7W4RQpFFOkhGlzwlvnTHjsX3rjcrtRdIcjZzCXP
         Jmd9MTH/5oj9EIvJTp4FTDzGoBG6cOY8QTT0q/OJjjuYtiwW9k/61hv6BAFpmNmNoAHh
         4p0jb5UcDeh/9xkfeQbmoempM0Y9fLDx+J3eUmdDOnv4P+7OA99Wc9m5ont9QEMfuAto
         Ht7hSahPDDVp6xbbGttc1jUTsEXXEat8ZU91qYGIsUVTTgT6DG89GEDYANuPZe2iGWv5
         JhWQ==
X-Gm-Message-State: APjAAAVAGCzfNhiE7K4PqXkOgV3PEEOgBz7xeBnjZwBP66sIybtYQpvA
        FsqsFg/F+O9Q1Ff31W7eBws=
X-Google-Smtp-Source: APXvYqyTO2kOLZBGZBHawTkZ0RtUqR/jB9g+6yvYM7oTKfsB/3wBtPdMWgtfwwH/UI2W4r3SWneX/A==
X-Received: by 2002:adf:dcd1:: with SMTP id x17mr16454565wrm.98.1558801410917;
        Sat, 25 May 2019 09:23:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id k184sm13194409wmk.0.2019.05.25.09.23.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 25 May 2019 09:23:29 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/7] Allwinner H6 SPDIF support
Date:   Sat, 25 May 2019 18:23:16 +0200
Message-Id: <20190525162323.20216-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*H6 DMA support IS REQUIRED*

Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
is different from the previous H3 generation and not compatible.

Difference are an increase of fifo sizes, some memory mapping are different
and there is now the possibility to output the master clock on a pin.

Actually all these features are unused and only a bit for flushing the TX
fifo is required.

Also this series requires the DMA working on H6, a first version has been
submitted by Jernej Škrabec[1] but has not been accepted yet.

[1] https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=89011

Changes since v2:
 - Split quirks and H6 support patch
 - Add specific section for quirks comment

Changes since v1:
 - Remove H3 compatible
 - Add TX fifo bit flush quirks
 - Add H6 bindings in SPDIF driver

Clément Péron (7):
  dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
  ASoC: sun4i-spdif: Move quirks to the top
  ASoC: sun4i-spdif: Add TX fifo bit flush quirks
  ASoC: sun4i-spdif: Add support for H6 SoC
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
  arm64: defconfig: Enable Sun4i SPDIF module

 .../bindings/sound/sunxi,sun4i-spdif.txt      |  3 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
 5 files changed, 88 insertions(+), 7 deletions(-)

-- 
2.20.1

