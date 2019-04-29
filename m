Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02D9C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F2F20693
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIO9fcp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfD2D0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:26:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33746 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfD2D0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:26:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id y3so3552099plp.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 20:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfaUjavgU7FLcbQRnhsJ2vG6fwuvzcfeYnH0eMo2lew=;
        b=ZIO9fcp3UVgcrIpro2HhbPWDhopkv0jrc/1NOivlvUpXqUNgaAWC3mq2KSfBJcfro6
         FnUyZrktLKoHzUugRUgUO1fD0EBf6bACTP64AxQFAlOpDPq31IP1E0S/bAmcVJXu/mAx
         CW/Fu5r6XzT83MF0MjYDhG2nocDhko8GyAYAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfaUjavgU7FLcbQRnhsJ2vG6fwuvzcfeYnH0eMo2lew=;
        b=SJI6ttCVILli31i3ZPn64/nmo42h+FpdeSPoPGQUy++FVtqhaOP+/a4D7hSc+MV6yU
         VVCbsMokOrH6399p3fJHdTnDqte8N9TSNS425ecY9CCDVUlFHff+hiYhF3GqmevuKGCd
         Ill1gJy/A2hET5GNg+AYJTdl6ff4pdSqAKDxat07lfcuBaVSLlY+HlDiHMoAw8yTsC16
         1CylMnpLlFs9c/jlj2BiMxAkUpu6sHzpOOmLyuaE6O+bIJOOFesaEcsHi4bn2T4OuRHl
         /u/ODAkJPDy7UKlXZPmafUxJbPlhnbHzZyX1Jzlcz9nIYEti1PUP/M3uLZu4kzCVGOkS
         86VQ==
X-Gm-Message-State: APjAAAUb5DDpg6WIaiYpVUlizBvoipj1ZuiK0c28B26rlUYTuMRHTame
        F1a6i5uB7O9EtjB9UxZauhXtDg==
X-Google-Smtp-Source: APXvYqx3ji95ro+Qgz/gh/2nu0EmODc2XcZ6cLoCoVh777KZZC76LVFq9Evhuk0WPUubiVGpIc4D9g==
X-Received: by 2002:a17:902:b089:: with SMTP id p9mr59602794plr.185.1556508366781;
        Sun, 28 Apr 2019 20:26:06 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id a10sm41364938pfc.21.2019.04.28.20.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 20:26:05 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH 0/2] pinctrl: mediatek: mt8183: Add support for wake sources
Date:   Mon, 29 Apr 2019 11:25:49 +0800
Message-Id: <20190429032551.65975-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for wake sources in pinctrl-mtk-common-v2, and
pinctrl-mt8183. Without this patch, all interrupts that are left
enabled on suspend act as wake sources (and wake sources without
interrupt enabled do not).

Nicolas Boichat (2):
  pinctrl: mediatek: Add mtk_eint_pm_ops to common-v2
  pinctrl: mediatek: mt8183: Add mtk_eint_pm_ops

 drivers/pinctrl/mediatek/pinctrl-mt8183.c     |  1 +
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  | 19 +++++++++++++++++++
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.h  |  1 +
 3 files changed, 21 insertions(+)

-- 
2.21.0.593.g511ec345e18-goog

