Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B584EC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8252621850
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRVai1T8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfEUQLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:11:12 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51888 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728662AbfEUQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:11:10 -0400
Received: by mail-wm1-f68.google.com with SMTP id c77so3584961wmd.1;
        Tue, 21 May 2019 09:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1KBi6qqP9EGBxX48fTi6KulOfsUgVuB2MNi/ParILE=;
        b=dRVai1T8gwETI5/fzjSqe8AAgm5d+9JKj0lCvTp44DKAxqPXkAJsbnpAfkaDBrRrh4
         jn7VRBDyVr1x2rk+QTLGqyAkgq5Fqp3egFWKGlh+H+TEDRbyGYTlPws4+ex4/X4Cwqfm
         WqNC2UHEkv/CuIg5MphCgSUSEuY6Yv9sZ9qqR8yaqh02ooNXjkJg2iontuV71habufQ4
         DFT/XugmCdba/HZ1Vdm2tFIPxi+Ooz1kc1MUa/TDWI7D7vKh36ygoFk2wR0IyWnE5UBq
         ZGFxScYi4/1zfKL0PIG3bCbz3lk7F4a9PDxPm6ysFc3XwNYOXrMdzNA/Vd6v3f1FbRBb
         s60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v1KBi6qqP9EGBxX48fTi6KulOfsUgVuB2MNi/ParILE=;
        b=rl5kVlPkzefIO+WUBW34P5y1uneMTGOBm2Dqp+/MWOl4s4nwZbdtA5nFE6ujHBWjTQ
         ziQE4GDvzwaQg4HEcZ4mWp8Gvg9N8Hh2alwlZSl84IVs0vwFv7B2FoG6gRRVZO2LsyTo
         vTymWXG6YhSCjCHZDmG9X5SWa637Cjr0vm6Dv3cq4gcACmZd2xrcdjOhYXG1QvA8neiL
         vd+dh1nlDVgYWbLyalRn98OhXf0mpSjQ5Dm5zcyaScIGCLuEe9stVBgf/u2YyP/wS4j4
         ibZjNmaBTcapkCWYh9M8vm7TfL2/64dbzpEh4LrNEs0wsJfmvibS4WwRR1vmILqJ409C
         oigQ==
X-Gm-Message-State: APjAAAW7Ffnbp+iljJZpgA+7EoG+ARgt8G+rMPo9nhD6hhdBPcvHuEqa
        0+vgqkiyxfrI9SZ8sui8zqk=
X-Google-Smtp-Source: APXvYqxzJh2R7WO4N4CR6Z7NWsbiVf7u/9TEGUdJ5mcXxXr27xkPEERbRL7FqUk2kZM5+H2JkAx1RQ==
X-Received: by 2002:a1c:b3c3:: with SMTP id c186mr3968354wmf.93.1558455068018;
        Tue, 21 May 2019 09:11:08 -0700 (PDT)
Received: from localhost.localdomain (18.189-60-37.rdns.acropolistelecom.net. [37.60.189.18])
        by smtp.gmail.com with ESMTPSA id n63sm3891094wmn.38.2019.05.21.09.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 May 2019 09:11:07 -0700 (PDT)
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
Subject: [PATCH v6 0/6] Allwinner H6 Mali GPU support
Date:   Tue, 21 May 2019 18:10:56 +0200
Message-Id: <20190521161102.29620-1-peron.clem@gmail.com>
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

One patch is from Icenowy Zheng where I changed the order as required
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

Change in v5:
 - Remove fix indent

Changes in v4:
 - Add bus_clock probe
 - Fix sanity check in io-pgtable
 - Add vramp-delay
 - Merge all boards into one patch
 - Remove upstreamed Neil A. patch

Change in v3 (Thanks to Maxime Ripard):
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

 .../bindings/gpu/arm,mali-midgard.txt         | 15 ++++++++++++-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  6 +++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  6 +++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  6 +++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  6 +++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.c    | 22 +++++++++++++++++++
 drivers/gpu/drm/panfrost/panfrost_device.h    |  1 +
 drivers/iommu/io-pgtable-arm.c                |  2 +-
 9 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.17.1

