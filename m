Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB76C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FEB421473
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 03:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QA3b1VEM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbfD2Dza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 23:55:30 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33984 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfD2Dz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 23:55:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id ck18so129048plb.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXk34VsYreRCPNz4i6pWPCyTwvp96N833kW5KsYPoLI=;
        b=QA3b1VEMbb59818pXyhhNImtFA59xQ9SCX5WROV+Ul/trmfLt4HCeV030EL6SVf+iL
         N4s8vtOptfY7n0NAMyGYKVz7OOd8lsdVcIlBDOPBEJ/X1a81gLUMzCzapAfpsJkywWNo
         7uLoYVxud71OMLp9bl+NqVQ57Yadzqm9zi1pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bXk34VsYreRCPNz4i6pWPCyTwvp96N833kW5KsYPoLI=;
        b=leq6eU2Y6O8zyL7s5ixyWegnsuXPxIBOLmOpOuK2o50WzzswFClNLGUmzqDXE8wwea
         ks451iud1Dw++xGerDARCJ06A1vnYJiOZ+dZ6K/ys8AfxzAjSpb5fy9LJNR6lz6UFep3
         EqXeI38UiOJeFWkt1WiDMADpdfL00r9j+asU1FbvBh+J47+xpP4+b3oq+8Nrw6vU8vqJ
         SFVxjr0C+mkf7d6X4mb9XFdCbEZqGLCErcdSbeUHuFptNFWGxtuaL3aGTNIp8zrCoHqv
         5q9mm8YmDqGU0p7ntQfExhChUaF8dYlNg0HAfsBGV7jXcp2UK/yDyLPst2YTLf946DFd
         7m8g==
X-Gm-Message-State: APjAAAVAhccD5Td03zpPx3ZRx3bGI+jSPbqBXy9N+YGFwrFCnfwTXgiA
        EDc46PU+faiB4/HdWrHJlDgsjpI/09g=
X-Google-Smtp-Source: APXvYqzjt4UrpemC6KYvWhVVLUW4VYRT494asAiDQflS3Vl76Sn5i0szake9Oj3w9XgJcvbp9UevSA==
X-Received: by 2002:a17:902:6f17:: with SMTP id w23mr39043760plk.29.1556510127299;
        Sun, 28 Apr 2019 20:55:27 -0700 (PDT)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id x128sm55433585pfx.103.2019.04.28.20.55.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Apr 2019 20:55:26 -0700 (PDT)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     linux-mediatek@lists.infradead.org
Cc:     Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Chuanjia Liu <Chuanjia.Liu@mediatek.com>, evgreen@chromium.org,
        swboyd@chromium.org
Subject: [PATCH 0/2] pinctrl: mediatek: Fix 2 issues related to resume from wake sources.
Date:   Mon, 29 Apr 2019 11:55:13 +0800
Message-Id: <20190429035515.73611-1-drinkcat@chromium.org>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes 2 issues when resuming from a wake source, especially if these
wake sources are level-sensitive.

Tested on mt8183 with the series in https://patchwork.kernel.org/cover/10921121/,
but this should affect all mediatek platforms.

Nicolas Boichat (2):
  pinctrl: mediatek: Ignore interrupts that are wake only during resume
  pinctrl: mediatek: Update cur_mask in mask/mask ops

 drivers/pinctrl/mediatek/mtk-eint.c | 34 ++++++++++++++++-------------
 1 file changed, 19 insertions(+), 15 deletions(-)

-- 
2.21.0.593.g511ec345e18-goog

