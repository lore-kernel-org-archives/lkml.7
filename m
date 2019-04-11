Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A5C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0CDE2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 21:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1NAIcJC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfDKVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 17:45:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41081 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfDKVpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 17:45:01 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so9222320wrq.8;
        Thu, 11 Apr 2019 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO7ZbqbFmzmu8SfEGP5EwS/rwu0a7irUt+Wa/9Y62UI=;
        b=F1NAIcJCmU945gvVuV2XYZwIZirO4AF7Jgxq7cBQbtkOrYuhaqreVH24/zm/HBHRek
         57yfy8pYCPgHJLgHr9nw1hzslMt3p35lhY5SExFRsRpxIQrGpWJyOOmbMlmVX9GPoZ0Q
         7uZRK10yMy1W0zg7/vZIaK1hCglMNdjDPjnkrt+mWOvR1CciVlvALOP7yFuIsNc2WAAq
         O8/djJGvY3rVOseSydK5NJk8gd/z9UMpfNenS1oONFPCpNHNCZ+EhdR9LuL5JlxzI3qO
         3aW3nVpv18nGgXGkHriqltzAsmCUNkBe4ElpvmIyaI6quH8pVQPo4mujVlnVZrifg+aF
         Y34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rO7ZbqbFmzmu8SfEGP5EwS/rwu0a7irUt+Wa/9Y62UI=;
        b=CYZxiBMgsTtVzL0zrrmXol7+1zx4cO9bbHq9j+OUtBs0HmjiscFYqfbpM1e3PAw8/v
         HOJtUEKL5r6K8uUpkEDrw2pG12MqStbLU5P44dn4xTbXg7kraOQE5/FBjNgmQANRlv9f
         xqj6PVbav4fodM9ru3vZQ+BiYfTddJeyADHrO/Ouxgg7FYRsjI4YFTp3lGe6LVI8ctfd
         FDYoYTAvCiO7cTDMlmmVANnTzfgXFpqEbcHRbBCTwgp5r8VwDjJnzBWDF0Tqt5a2BdRS
         NHaOsTff1ZOnQc/x1I2CpsA8gk4XmIzde1nU2AbLXPqBxVl9oxx+spmgiWMyWZnteB+U
         fdCA==
X-Gm-Message-State: APjAAAXiZjJYStpvuaoxWP/l7zs4aSsZJjKcauJxQObuzlAr0+H72Cpn
        lXG0ebiHRKcVhZKlkcwpqSA=
X-Google-Smtp-Source: APXvYqz+15NPZc508myg/FKG0Ngq/U0t6isgWhDhIGjK+rPD4Lar+9PDHXvbPC+Y0hAuhJXlpA6oQA==
X-Received: by 2002:a5d:42c5:: with SMTP id t5mr3498180wrr.275.1555019098769;
        Thu, 11 Apr 2019 14:44:58 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id a22sm5952961wmj.44.2019.04.11.14.44.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 14:44:57 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 0/4] Allwinner H6 SPDIF support
Date:   Thu, 11 Apr 2019 23:44:18 +0200
Message-Id: <20190411214422.2267-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

*H6 DMA support IS REQUIRED*

Allwinner H6 SoC has a SPDIF controller called One Wire Audio (OWA) which
is different from the previous H3 generation but still compatible.

Difference are an increase of fifo sizes and there is now the possibility
to output the master clock on a pin.

Also this series require the DMA working on H6, a first version has been
submitted by Jernej Škrabec but is not yet accepted (as this moment):
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=89011

This patch has been tested on Beelink GS1 on top of sunxi/for-next with
the series above applied.

Clément Péron (4):
  dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
  arm64: defconfig: Enable Sun4i SPDIF module

 .../bindings/sound/sunxi,sun4i-spdif.txt      |  3 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 39 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 4 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.17.1

