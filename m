Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A93DC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8242070E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 05:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UaDMeZnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgAHFX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:23:56 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34428 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgAHFX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 00:23:56 -0500
Received: by mail-pf1-f195.google.com with SMTP id i6so1028780pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 21:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1KUxpvNC0nSY4c57vW0grBhdHj/br9DS0Gj7LsMqAg=;
        b=UaDMeZnQsg7RWbE0j39tduViiq5tWgb5xwFNLW6CAsuaqrJDAaez2MGnV4PY7kH539
         aj30Ild0XBzKI5+QFVnZnuU/x9R/7QklbyAMShyxgCH4sxK7XMPCA8P3gzkn56vBNgnS
         fkoYP8jneVMWqlDMbIWdMfifnxnN8gAT8lJCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s1KUxpvNC0nSY4c57vW0grBhdHj/br9DS0Gj7LsMqAg=;
        b=aUaVdynh5owD+QPkF0/S9QJplfPR0LQok7bnne9ikINjx4qWs4Lpg85gvbH06+umYb
         6J8fU5MYWp7t+9psevvpbFqdD0Fr7c21AKpUD9g9XUUfyzhMkSY+4VKjaMnEz2EdIzB3
         /P9hSaIucZLRmnGlbVaPtYqsPN4QrQHOwfnB95ccHUpdTeESsKvUwThKlhcxhD6mtxVn
         uZHVZIFcMo18dXo+hfFsFtxTKrKxUDak/LKgTcURfwgj6ohyR4hJl1pL7qCzjL++LpJA
         Sn30r0Q7adAvgArxKRf2/MvZ/DtDpWnhYTr+eZrejgRiEZeOc/SQNNHRaqj11JhtMy01
         qnYg==
X-Gm-Message-State: APjAAAXA3oDz5Nr7LoikvULLKHjOimUsTGWY1aNbv4zU8ocJjPDOfPTv
        XCEAPUXi1RGX0Pyo/WPcjQ/6Kw==
X-Google-Smtp-Source: APXvYqxmaLR0+XdqtcLLRTMFj3xPry0wUm49NXvxttElsA1fauDaDpoKgiJkJbYJCbg0zpgZCOqf+g==
X-Received: by 2002:a62:446:: with SMTP id 67mr3056799pfe.109.1578461035208;
        Tue, 07 Jan 2020 21:23:55 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id n24sm387505pff.12.2020.01.07.21.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 21:23:54 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v2 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
Date:   Wed,  8 Jan 2020 13:23:30 +0800
Message-Id: <20200108052337.65916-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Sorry for the long delay since https://patchwork.kernel.org/patch/11132381/,
finally got around to give this a real try.

The main purpose of this series is to upstream the dts change and the binding
document, but I wanted to see how far I could probe the GPU, to check that the
binding is indeed correct. The rest of the patches are RFC/work-in-progress, but
I think some of them could already be picked up.

So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
backports to get the latest panfrost driver (I should probably try on
linux-next at some point but this was the path of least resistance).

I tested it as a module as it's more challenging (originally probing would
work built-in, on boot, but not as a module, as I didn't have the power
domain changes, and all power domains are on by default during boot).

Probing logs looks like this, currently:
[  221.867726] panfrost 13040000.gpu: clock rate = 511999970
[  221.867929] panfrost 13040000.gpu: Linked as a consumer to regulator.14
[  221.868600] panfrost 13040000.gpu: Linked as a consumer to regulator.31
[  221.870586] panfrost 13040000.gpu: Linked as a consumer to genpd:0:13040000.gpu
[  221.871492] panfrost 13040000.gpu: Linked as a consumer to genpd:1:13040000.gpu
[  221.871866] panfrost 13040000.gpu: Linked as a consumer to genpd:2:13040000.gpu
[  221.872427] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor 0x3 status 0x0
[  221.872439] panfrost 13040000.gpu: features: 00000000,13de77ff, issues: 00000000,00000400
[  221.872445] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
[  221.872449] panfrost 13040000.gpu: shader_present=0x7 l2_present=0x1
[  221.873526] panfrost 13040000.gpu: error powering up gpu stack
[  221.878088] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu on minor 2
[  221.940817] panfrost 13040000.gpu: error powering up gpu stack
[  222.018233] panfrost 13040000.gpu: error powering up gpu stack
(repeated)

So the GPU is probed, but there's an issue when powering up the STACK, not
quite sure why, I'll try to have a deeper look, at some point.

Thanks!

Nicolas

v2:
 - Use sram instead of mali_sram as SRAM supply name.
 - Rename mali@ to gpu@.
 - Add dt-bindings changes
 - Stacking patches after the device tree change that allow basic
   probing (still incomplete and broken).

Nicolas Boichat (7):
  dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
  arm64: dts: mt8183: Add node for the Mali GPU
  drm/panfrost: Improve error reporting in panfrost_gpu_power_on
  drm/panfrost: Add support for a second regulator for the GPU
  drm/panfrost: Add support for multiple power domain support
  RFC: drm/panfrost: Add bifrost compatible string
  RFC: drm/panfrost: devfreq: Add support for 2 regulators

 .../bindings/gpu/arm,mali-bifrost.yaml        |  20 ++++
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 104 +++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  18 +++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 108 ++++++++++++++++--
 drivers/gpu/drm/panfrost/panfrost_device.h    |   7 ++
 drivers/gpu/drm/panfrost/panfrost_drv.c       |   1 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c       |  15 ++-
 8 files changed, 267 insertions(+), 13 deletions(-)

-- 
2.24.1.735.g03f4e72817-goog

