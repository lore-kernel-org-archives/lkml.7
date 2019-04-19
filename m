Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B57AC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F6A20869
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smOxsVOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbfDSTOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:14:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44149 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfDSTOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:14:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so7926607wrv.11;
        Fri, 19 Apr 2019 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd3S+Mf+Q5mKFNJ2557E4VnQHOtpZj9UubuBQAoizH4=;
        b=smOxsVOKcApmiBmDFPymal2Cd55aZuhF62HW93ui53fTMHnhBoin8f9Of3LuduZO1m
         jet3cu3eOnjOnOtGA5sI0acxdtYKVlIH9RGCwdHtJV+lngYR6ksuzoLFWCN4JlZgAkp1
         g4ixlwt0PZkOWFPsVnG3goHHFPts6USrSQqzQQWrHdCpXdjaF12qwXjz8nMo1RS8Gccb
         p22/6e8omzVfzVSA82jTO4G90qJujk7RiCwCgLrf+UJeIX39SJVY/2o/HJemfBez0Dy6
         sEwmkvBnTHTeEA88q0ccBfgStdFBxfjPJwGEcU4Gsu3ABbO8rzVCku0zh+07dr8Pe545
         PP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jd3S+Mf+Q5mKFNJ2557E4VnQHOtpZj9UubuBQAoizH4=;
        b=qGfCnX4Woyilp4Q2BfndhKA8Bw83dLlVh6OkBtS+F1N0WjGIiRqvKZK8MyJdxs4pgC
         xgw5TFLvikfh3teuhAcFdXSWas5L8nM/8uaybIlg0qpnJhU6JbOeHN/jUotX+DJl8Db7
         ggUUxnAKrii/gPBd2xmmZLyfWx7NTItKXffKoWVDc776fJHdwWWdB/ZPLyhchFMshz6c
         9mmh4oPKEoJUNONwz085hafO8iHo83a98SI5hV5rHzi0YBFvQ+eR7n1S2xzf0l1dSK99
         YUYchBO6rEeF4pQPtufvrtdV9NCT71UM1eMVlFXPJp+H6tUfVDPz/n5o725xeOF7szA3
         BWbQ==
X-Gm-Message-State: APjAAAWpwqN+1K1InPDi+p4lFAWxDYf2K8ltSBasC+sK+ltcdhCGqVRT
        5kpmMPdEtXHb5CyuUhLcKzw=
X-Google-Smtp-Source: APXvYqyRFIIPTwLPRvmF0h+3wr9mjSY9NQPZ6or7JB1dRBh12Su0EYTWsB7WQDgAPRAaIhul2dKIaQ==
X-Received: by 2002:a5d:4103:: with SMTP id l3mr3239183wrp.151.1555701257503;
        Fri, 19 Apr 2019 12:14:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id z18sm8131149wrr.90.2019.04.19.12.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 12:14:16 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 0/5] Allwinner H6 SPDIF support
Date:   Fri, 19 Apr 2019 21:17:25 +0200
Message-Id: <20190419191730.9437-1-peron.clem@gmail.com>
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
is different from the previous H3 generation and not compatible.

Difference are an increase of fifo sizes, some memory mapping are different
and there is now the possibility to output the master clock on a pin.

Also this series require the DMA working on H6, a first version has been
submitted by Jernej Škrabec but is not yet accepted (as this moment):
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=89011

This series has been tested on Beelink GS1 on top of sunxi/for-next with
Jernej DMA support patch.

Clément Péron (5):
  dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible
  ASoC: sun4i-spdif: Add support for H6 SoC
  arm64: dts: allwinner: Add SPDIF node for Allwinner H6
  arm64: dts: allwinner: h6: Enable SPDIF for Beelink GS1
  arm64: defconfig: Enable Sun4i SPDIF module

 .../bindings/sound/sunxi,sun4i-spdif.txt      |  3 +-
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 +++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 sound/soc/sunxi/sun4i-spdif.c                 | 42 ++++++++++++++++---
 5 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.17.1

