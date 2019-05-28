Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A653C04E84
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C6520883
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 08:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="fXMVIE25"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfE1IIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 04:08:06 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53011 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfE1IIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 04:08:05 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so1748523wmm.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2019 01:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieWxa3W4BA8q2H3D0T8EoXTx0zcolQkck6xLMl469g8=;
        b=fXMVIE25gFBZkltfmyi30Hdm7oNXRGCg36Ue8AqJIKTu7Br2JjltL2l6mx1/y9zSXq
         1DejqGZzDgEzZyrh+mASa0IfJnMPwCxnXK2yhf+1DD/jfIl0ZaZPNeobIIjpHbFtBjM9
         WAXIZQsvFdNREA+ApsFE5hFbklJhY0xqsYn8k9wwPCOo5divimvO5v5w8OPFAE+xqb+6
         mwcLS4ym6FxvQRYnVWJHcNrE2CbFvL4drdq/mdoRamgIX6KNQpc0lm22lWBlQ9i8C3vg
         CcdPHA187hf3LD7qFqVVPbDHqo0L/BOjomOsOzcMaL84toLnN+ckxsZ0JYhUyqhVJtBV
         1F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ieWxa3W4BA8q2H3D0T8EoXTx0zcolQkck6xLMl469g8=;
        b=J/ytJgpf/qYbgGAmlonk3p/EOowFncPoUamOheLY6dgcr7PIiAT4Q6hMKgmLg34Fbq
         0XcqMfJzvqp01CodzyYftebOQibqgMnSF5ItSs9D48r2hDSoCLwzP8wg9KPNyXNh8Mwh
         6jUEFisZ7DVjz9DAjlEMxGesVpPpuu6TK5OW/oUg3LxJVBeZxoQdb4JeGwA25cKaNwQ7
         AcdVq3HxXgIj53rvRARpRKKZXylZMmObt+CgnAMXYBv3t9scebGB/bsgw+vzVrcIFyfz
         C1hS5lAE8cl0F10U75clD/UmRSvo8TnJqXpW5qeRugCXgxrxMtTa60OVEqSQD4i5uL4v
         DL/A==
X-Gm-Message-State: APjAAAUmX+U6zLG4te8wz5DKaXdgkCbaclusCoHTlJUVGoMbGclQP7xn
        qg96OhCyawvbaij/CJdM52BNDw==
X-Google-Smtp-Source: APXvYqyfEAM5t74+Aid/26YokQ5XGUc9ooC3hQavU+b4VuiimllFa2MwkUoKeGaKLZR6X11GoMK3tg==
X-Received: by 2002:a1c:f413:: with SMTP id z19mr2191165wma.145.1559030883029;
        Tue, 28 May 2019 01:08:03 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id z74sm2456121wmc.2.2019.05.28.01.08.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 May 2019 01:08:02 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] clk: meson: add support for Amlogic G12B
Date:   Tue, 28 May 2019 10:07:55 +0200
Message-Id: <20190528080758.17079-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture.
G12B clock tree is very close, the main differences are :
- SYS_PLL is used for the second cluster (otherwise used fir the first on G12a)
- SYS_PLL1 is used for the first cluster (instead of SYS_PLL on G12a)
- A duplicate CPU tree is added for the second cluster
- G12B has additional clocks like for CSI an other components, not handled yet

Dependencies :
- Patch 1, 3 : None
- Patch 2 : Depends on Guillaume's Temperature sensor Clock patches at [1]

This patchset is a spinoff of the v2 Odroid-N2 megapatchset at [2]

Changes since v1 at [3]:
- Added the cpub_clk div2..8 and replaces the ahb/atb/axi/trace divs by muxes
- Added the CLK_GATE_SET_TO_DISABLE flag to ahb/atb/axi/trace gates
- Fixed all the G12A typos
- Added martin's reviewed by on patch 1

Changes since original patchset :
- Added missing sys1_pll div16, cpub div16 and cpub atb/axi/ahb/trace clocks
- Rewrote "This patch .." in commit messages

[1] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com
[2] https://lkml.kernel.org/r/20190423091503.10847-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190521150130.31684-1-narmstrong@baylibre.com

Neil Armstrong (3):
  dt-bindings: clk: meson: add g12b periph clock controller bindings
  clk: meson: g12a: Add support for G12B CPUB clocks
  clk: meson: g12a: mark fclk_div3 as critical

 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 drivers/clk/meson/g12a.c                      | 772 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  40 +-
 3 files changed, 812 insertions(+), 1 deletion(-)

-- 
2.21.0

