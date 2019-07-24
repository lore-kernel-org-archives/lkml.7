Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AE9C76194
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC2F20651
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 02:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htgu23gv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfGXCYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 22:24:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40415 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfGXCYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 22:24:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so20369653pgj.7;
        Tue, 23 Jul 2019 19:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WMoTaUEzf2i0/9+THzPuZXCIUe+ekMzc88lMAn0PGM=;
        b=Htgu23gviBJDprRFajzRkyIgxs8zf4w1ZNqqoXGAaftgFuT1oDR17PvgSnH87ucKoO
         ZtQ2blOutSQbiWoH5NT7N6vyt5MIBdRQGQE2j3VTEUp2fofLXasXEBoXiYWVNZ8TqL1t
         52OAJj6DHABQZMDHlTEBkeEOuqZKI/lN2zdg+snMOFPKYnPcdM/CL7Kw0vfXSzor9fsI
         PDZ6MPqWdzagqKxEXec3Wp6AGA4cgH2XPnFAEHLCsC0E9ZTcRdQt9nR8kNkYAhfK1QHd
         q3SRpbYkxep6kggIlNOdTbPiXR2Gace1SIOOhcn7wWCrv7zSVHwu8flsN+cwPnh1+YMB
         zegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WMoTaUEzf2i0/9+THzPuZXCIUe+ekMzc88lMAn0PGM=;
        b=DAe3DATrUNgEochJZmugbo0yBWVH5jFM9FMC/mOZBEWBFa8ar5T9OKI7cboE14/Zka
         Zc+cVyuaKyDyGnGQkzvZBcIvaf/q4zJxoDApr98kz0bx5WoJXDoTo7dLLk71zQOpV1Nr
         BqVkSPHfwBiWz5/Wt4A/U/h4PHU4gohEM7gjOHEWn1MVHy67VV6kPzKWgVf53jRQb5Mt
         Mp7oKQM47XPofT55KP+qw5BVhWhJ1UL+yD8HAWj4z9boDzuqa68UANHrw/SRH4kOedW4
         wkBsI3bZBuSiFJkVRpTbatxllc967qW5HyCeJczxxryRB5x3Urz7he8CkA5oDE7upCl1
         IUuw==
X-Gm-Message-State: APjAAAWBN2Czs33jQiMpf0JAaASwU6lMiWHn0VPSIwAprBkSD3XJyzGj
        BOaiKsnn2lW5dIXnLXQXQA+T57nui/Y=
X-Google-Smtp-Source: APXvYqxUYEkM9XBDBboLoJOWeoCUeXs/SaDnGfKPq806XSURPgFa31xYTKVVDHaTF3ZqJBL9b6oguQ==
X-Received: by 2002:a65:6495:: with SMTP id e21mr80068044pgv.359.1563935051079;
        Tue, 23 Jul 2019 19:24:11 -0700 (PDT)
Received: from guoguo-omen-lan.lan ([107.151.139.128])
        by smtp.gmail.com with ESMTPSA id s185sm63468029pgs.67.2019.07.23.19.24.06
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 19:24:10 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list),
        linux-mips@vger.kernel.org (open list:MIPS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Weijie Gao <hackpascal@gmail.com>, NeilBrown <neil@brown.name>,
        Chuanhong Guo <gch981213@gmail.com>
Subject: [PATCH v2 0/6] MIPS: ralink: add CPU clock detection for MT7621
Date:   Wed, 24 Jul 2019 10:23:04 +0800
Message-Id: <20190724022310.28010-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset ports CPU clock detection for MT7621 from OpenWrt.

Last time I sent this, I forgot to add an binding include which
caused a compile error and the patch doesn't stay in linux-next.

This patchset resent the first two commits and also added binding
documentation for mt7621-pll and used it in mt7621-dts at
drivers/staging.

Changes since v1:
1. changed commit title prefix for dt include
2. split the patch adding clock node (details in that patch body)
3. drop useless syscon in dt documentation
4. drop cpuclock node for gbpc1

Chuanhong Guo (6):
  dt-bindings: clock: add dt binding header for mt7621-pll
  MIPS: ralink: drop ralink_clk_init for mt7621
  MIPS: ralink: add clock device providing cpu/bus clock for mt7621
  dt: bindings: add mt7621-pll dt binding documentation
  staging: mt7621-dts: fix register range of memc node in mt7621.dtsi
  staging: mt7621-dts: add dt nodes for mt7621-pll

 .../bindings/clock/mediatek,mt7621-pll.txt    | 18 ++++
 arch/mips/include/asm/mach-ralink/mt7621.h    | 20 ++++
 arch/mips/ralink/mt7621.c                     | 98 +++++++++++++------
 drivers/staging/mt7621-dts/gbpc1.dts          |  5 -
 drivers/staging/mt7621-dts/mt7621.dtsi        | 17 ++--
 include/dt-bindings/clock/mt7621-clk.h        | 14 +++
 6 files changed, 126 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7621-pll.txt
 create mode 100644 include/dt-bindings/clock/mt7621-clk.h

-- 
2.21.0

