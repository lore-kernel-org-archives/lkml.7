Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0232C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC1A208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 20:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZKzgwTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfE0UKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 16:10:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43827 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbfE0UKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 16:10:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id l17so9470663wrm.10;
        Mon, 27 May 2019 13:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDHZvbW5fijbJYqS49AHo5wrH49+8LRhFk5frtH+czs=;
        b=GZKzgwTsjl8oDnFeiCt7vuI5aKIZrQGAleaeM2RbFDLBcE9pCZz3wszFrErQsWBnev
         xSbVzEZkH2YIhlzU20dYu8H/77rmwr3ucbJ/J1cuUJlE5C0VAX9rBpt20D39GCFY75wf
         lYEKs/3NJdkjm+UP7hWIbHgH3wOipDJei5ZPnkCCbmVcVCYIekcFrMo+w26484791vB+
         7KFRFV3gUpScnOmLUqx2fD8JRCpt3zN9HWJLpQ9sauIyM17VnROccWPEBmyao3iCoWDd
         sGOip2GMuXO9TSwCmuU+AHhg4P4He2itS162rxpyd9g6ZhUghIQmqJcRDcocS3sgVhqY
         sA8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IDHZvbW5fijbJYqS49AHo5wrH49+8LRhFk5frtH+czs=;
        b=Qr+zelGo6kHXOBtV/ZkdrxqDUj2BJ6LXUdJPn8EkpX4pch+8CSt5u5Uvj+S60EC8Sk
         P7HqCnW0tMrFPleJP3cFlYWO29ZDS3OyblYnmYbgZ97pDztfXC0tRAvmHFk/9wA7uId5
         q9yZ14t67ImPo8zf4czL3ucKINu258Hdh6leOrxslOLwgxx8OfGlKdmhbR5HIvdVKrDE
         DBCn8sixPxL4xxoPUrjFU2Uje8039Z8OL1ebPQ6y0hJbwGdEK0c1EaFBX+WaQtTGEnBr
         1IKqwsb3Edc6ncwvFtm+4H0cyxK69rn33/+JJgu6Ynq3CwWd/4MMIQ4o19CwWsm8cNhn
         3gcA==
X-Gm-Message-State: APjAAAW1RbSf3PTntIlm8u/v+/bSTTkh/92FGAlDqjxzhdrgF1gEiQmh
        XjjeCmSczXuJQ5XzJXZeQcGwu9N3Ak3BEw==
X-Google-Smtp-Source: APXvYqyqpFAqUTi8dpMrKnZvZz7bKtAJFVOE03EyjPbv+ISOjv5Cl5nD4sOql4lDIlCwc/mR9Ktrjg==
X-Received: by 2002:adf:ff88:: with SMTP id j8mr1844331wrr.317.1558987812061;
        Mon, 27 May 2019 13:10:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id s127sm308523wmf.48.2019.05.27.13.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 May 2019 13:10:11 -0700 (PDT)
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
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 0/7] Allwinner H6 SPDIF support
Date:   Mon, 27 May 2019 22:06:20 +0200
Message-Id: <20190527200627.8635-1-peron.clem@gmail.com>
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

Changes since v3:
 - rename reg_fctl_ftx to val_fctl_ftx
 - rebase this series on sound-next
 - fix dt-bindings due to change in sound-next
 - change node name sound_spdif to sound-spdif

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

 .../sound/allwinner,sun4i-a10-spdif.yaml      |  1 +
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  4 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 38 ++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 sound/soc/sunxi/sun4i-spdif.c                 | 49 ++++++++++++++++---
 5 files changed, 87 insertions(+), 6 deletions(-)

-- 
2.20.1

