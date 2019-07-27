Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C23CC7618F
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE84E22BF5
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 00:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpSRNYnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfG0AED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 20:04:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42621 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfG0AED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 20:04:03 -0400
Received: by mail-qk1-f195.google.com with SMTP id 201so40324985qkm.9;
        Fri, 26 Jul 2019 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=mEmoQBaRl/1lmhoeCdF1FJ9rNewOoyZM5tGW1krtLhQ=;
        b=lpSRNYnLTr6knLzzD5T8+yNV4l2vBrfi7rdECTBpP0f8jHhB3ziOvo0o2wGL7jT2r4
         iTBNCN2F7ZXyBDV0+gQcbfuTi01U9Rdd/ZPjDSX6FRBcVut3gLXPjVJQGy/SnNJDHtwP
         T4mwcbP03RWplN7dWSqi07/1zcNw0G5XvRQvtosS8jn8UVvM4nsoiO8n2ijPOe+2PhAp
         aOnyIdd4a0oZbs9x/o6jnhcWFORM99lHu5ZrmsCGj9UVCFbfqgWJjtOrObh42vBLO/qP
         d1i2YjLKBVvjuEmpSvTRk5IhgIiB7tjMz3+bXqeNoHjnMbxrNK1DQEE4/k62IVyE6RpZ
         jhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=mEmoQBaRl/1lmhoeCdF1FJ9rNewOoyZM5tGW1krtLhQ=;
        b=C21ZZ/rFhmbMuaHtX2OgrKPLF8mZnoCeqS2CqMZKe74fGNHnXg6U2VGCvwCT81qL/o
         Fxgwku9jeIwTljQYtSJfhSnxj6bssoWLP72rVbwImydN6ay03/hPlCsCkY6menH1x4eg
         YNPA1TGdC/nTnHpK5Mjs1sWdnlUtXJHLVNkEcela6qj5xbtJyWWDtU0eZWjZoAdEGUnQ
         50twwcK0pfsl000u4EFC36Zzld+aBeIkKVVFpg2l8cVDYaQYxwlKBXzH7OxntWH7iZms
         s5G7DnfeVlGEd0/G01EY9p6kucFOI5WZm+d2C6MPUj235WOyFvhPUXlETQFgbDmRPSWJ
         LpIA==
X-Gm-Message-State: APjAAAXYkzQ0fQ1K6Zfg2oRCfxaq1RCPNkdW8DLLSIAZPZlXuFOLHPVw
        of6tr09qi6gp8BbB1FFv+FQhUfy3IbpJJlvpSw==
X-Google-Smtp-Source: APXvYqz45qkkRxLjIFzWjMdTB9431UDpqGzcxQe3BhFkJ0qBwtyWxN5dc7AzrErI8ijfXBbJ8J+BInZVsK8m7Orbtqw=
X-Received: by 2002:a37:6944:: with SMTP id e65mr59809231qkc.119.1564185841934;
 Fri, 26 Jul 2019 17:04:01 -0700 (PDT)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Fri, 26 Jul 2019 18:03:50 -0600
Message-ID: <CAL_JsqJLB4q6wqTOX0oXAGQF4wuZ0irNT8nmpFEmuUKjvv38BQ@mail.gmail.com>
Subject: [GIT PULL] Devicetree fixes for 5.3-rc, take 2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull some more DT fixes for 5.3. The nvmem changes would
typically go thru Greg's tree, but they were missed in the merge
window and I've been unable to get a response (partly because Srinivas
is out on vacation it appears).

Rob


The following changes since commit e2297f7c3ab3b68dda2ac732b1767212019d3bdf:

  dt-bindings: pinctrl: stm32: Fix missing 'clocks' property in
examples (2019-07-20 20:28:53 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.3-2

for you to fetch changes up to e1ff7390f58e609aa113a2452a953f669abce6cc:

  dt-bindings: Fix more $id value mismatches filenames (2019-07-26
17:41:41 -0600)

----------------------------------------------------------------
Devicetree fixes for 5.3-rc:

- Fix mismatches in $id values and actual filenames. Now checked by
  tools.

- Convert nvmem binding to DT schema

- Fix a typo in of_property_read_bool() kerneldoc

- Remove some redundant description in al-fic interrupt-controller

----------------------------------------------------------------
Maxime Ripard (2):
      dt-bindings: nvmem: Add YAML schemas for the generic NVMEM bindings
      dt-bindings: nvmem: SID: Fix the examples node names

Rob Herring (2):
      dt-bindings: clk: allwinner,sun4i-a10-ccu: Correct path in $id
      dt-bindings: Fix more $id value mismatches filenames

Talel Shenhar (1):
      dt-bindings: interrupt-controller: al-fic: remove redundant binding

Thierry Reding (1):
      of: Fix typo in kerneldoc

 Documentation/devicetree/bindings/arm/renesas.yaml |  2 +-
 .../bindings/arm/socionext/milbeaut.yaml           |  2 +-
 .../devicetree/bindings/arm/ti/ti,davinci.yaml     |  2 +-
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |  2 +-
 .../intel,ixp4xx-network-processing-engine.yaml    |  2 +-
 .../devicetree/bindings/iio/accel/adi,adxl345.yaml |  2 +-
 .../devicetree/bindings/iio/accel/adi,adxl372.yaml |  2 +-
 .../interrupt-controller/amazon,al-fic.txt         | 16 ++--
 .../intel,ixp4xx-interrupt.yaml                    |  2 +-
 ...er.yaml => intel,ixp4xx-ahb-queue-manager.yaml} |  2 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |  2 +-
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |  4 +-
 .../devicetree/bindings/nvmem/nvmem-consumer.yaml  | 45 +++++++++++
 Documentation/devicetree/bindings/nvmem/nvmem.txt  | 81 +------------------
 Documentation/devicetree/bindings/nvmem/nvmem.yaml | 93 ++++++++++++++++++++++
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |  2 +-
 .../bindings/timer/intel,ixp4xx-timer.yaml         |  2 +-
 include/linux/of.h                                 |  2 +-
 18 files changed, 161 insertions(+), 104 deletions(-)
 rename Documentation/devicetree/bindings/misc/{intel,ixp4xx-queue-manager.yaml
=> intel,ixp4xx-ahb-queue-manager.yaml} (95%)
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/nvmem.yaml
