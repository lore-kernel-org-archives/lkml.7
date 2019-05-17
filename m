Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D286EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 933FD21726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 18:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShU59QoS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfEQSrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 14:47:08 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39512 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfEQSrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 14:47:08 -0400
Received: by mail-wr1-f68.google.com with SMTP id w8so8166667wrl.6;
        Fri, 17 May 2019 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDNkiLJjFXCawT5EirH0tC0q56cBKU4m+h7W3OArVyU=;
        b=ShU59QoSeaAR7MM+7sLznlllmGxphdG2LuoN/mvYJ3l7U35bfVO6bm+wBNKyK4OK6G
         93tikl9UxFB8ch6DwSy+eEwqbtuSTlHHqZCd8ZGqc5GTQAS/tc5WYIm01LGqQvgVv1U9
         Lil/TzFLIcxEtTDgAseMVGvAvVP7oFojlYTEr4hxASIS4sgS9UXbPfpL8hPC/kmUEYHF
         V4B9dQ60bm2eHS4EzoS24pHXg9ruZd5qWimFlVpKtk7B8MK6Nu/buXaGX3VhCT2HTllm
         ELDB1+fDfOkSX2Du3QxSDgcADYM00WisukoewX9/rIxEnyKMLbSi2oO43DoEWTeyu/Su
         vQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vDNkiLJjFXCawT5EirH0tC0q56cBKU4m+h7W3OArVyU=;
        b=hxVr2wUlmaqwiR3qrYV4Yp/g170XCdlzZiWlaPGGn25z8fCXasm+XX6SA0wh1pY7wL
         IkNdzBaWrMyb4OBMszW/B+ICz/djfYvxE3dyVfWt1yD8cYGkFKZaRnP/xZr8i6aEF6/t
         0qie3gWML8WBKAtywHwl+6/O1PxgCpBzDrk6pSIFSfNyDk6k/OY+6G64qnPDfleE8MrU
         zscRBl1YxixvHVyCrAjJEvJmPnxRgPp8W6hc0WnFKTkDrATiiewfXDXB1BbEW4K3Yx9C
         TPMX5dEHWYaqY3dCB0gjxjECZw7HCucM3jKRWzZ8B/sKS0goxZdm4133CArdlOFlHv6b
         eLEA==
X-Gm-Message-State: APjAAAW7/JoB9uYpC6Su2cYOyQXk3QUuGeqM3BjIT/Cn0gSdaJ06MKgV
        PvU/naQje3Fc87VtyOWH/rM=
X-Google-Smtp-Source: APXvYqwLBIK/ntjqXde729LnM1cq3YTMK/Br76X9joaZ7paAbpaKGQLbTHmzFx5IuUlAJiCxrcBC4A==
X-Received: by 2002:adf:f208:: with SMTP id p8mr16535297wro.160.1558118826182;
        Fri, 17 May 2019 11:47:06 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id v20sm5801112wmj.10.2019.05.17.11.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 11:47:05 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Steven Price <steven.price@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v5 0/6] Allwinner H6 Mali GPU support
Date:   Fri, 17 May 2019 20:46:53 +0200
Message-Id: <20190517184659.18828-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Allwinner H6 has a Mali-T720 MP2 which should be supported by
the new panfrost driver. This series fix two issues and introduce the
dt-bindings but a simple benchmark show that it's still NOT WORKING.

I'm pushing it in case someone want to continue the work.

This has been tested with Mesa3D 19.1.0-RC2 and a GPU bitness patch[1].

One patch is from Icenowy Zheng where I changed the order has required
by Rob Herring[2].

Thanks,
Clement

[1] https://gitlab.freedesktop.org/kszaq/mesa/tree/panfrost_64_32
[2] https://patchwork.kernel.org/patch/10699829/

[  345.204813] panfrost 1800000.gpu: mmu irq status=1
[  345.209617] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002400400
[  345.209617] Reason: TODO
[  345.209617] raw fault status: 0x800002C1
[  345.209617] decoded fault status: SLAVE FAULT
[  345.209617] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  345.209617] access type 0x2: READ
[  345.209617] source id 0x8000
[  345.729957] panfrost 1800000.gpu: gpu sched timeout, js=0,
status=0x8, head=0x2400400, tail=0x2400400, sched_job=000000009e204de9
[  346.055876] panfrost 1800000.gpu: mmu irq status=1
[  346.060680] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002C00A00
[  346.060680] Reason: TODO
[  346.060680] raw fault status: 0x810002C1
[  346.060680] decoded fault status: SLAVE FAULT
[  346.060680] exception type 0xC1: TRANSLATION_FAULT_LEVEL1
[  346.060680] access type 0x2: READ
[  346.060680] source id 0x8100
[  346.561955] panfrost 1800000.gpu: gpu sched timeout, js=1,
status=0x8, head=0x2c00a00, tail=0x2c00a00, sched_job=00000000b55a9a85
[  346.573913] panfrost 1800000.gpu: mmu irq status=1
[  346.578707] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA
0x0000000002C00B80

Changes in v4:
 - Add bus_clock probe
 - Fix sanity check in io-pgtable
 - Add vramp-delay
 - Merge all boards into one patch
 - Remove upstreamed Neil A. patch

Changes in v3 (Thanks to Maxime Ripard):
 - Reauthor Icenowy for her path

Changes in v2 (Thanks to Maxime Ripard):
 - Drop GPU OPP Table
 - Add clocks and clock-names in required

Clément Péron (5):
  drm: panfrost: add optional bus_clock
  iommu: io-pgtable: fix sanity check for non 48-bit mali iommu
  dt-bindings: gpu: mali-midgard: Add H6 mali gpu compatible
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for H6 boards

Icenowy Zheng (1):
  dt-bindings: gpu: add bus clock for Mali Midgard GPUs

 .../bindings/gpu/arm,mali-midgard.txt         | 15 ++++++++++-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  6 +++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  6 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 +++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 25 ++++++++++++++++++-
 drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
 drivers/iommu/io-pgtable-arm.c                |  2 +-
 9 files changed, 78 insertions(+), 3 deletions(-)

-- 
2.17.1

