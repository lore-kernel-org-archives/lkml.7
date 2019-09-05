Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540E9C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BC3218AF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ssbfMIbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbfIENAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:00:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52430 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbfIENAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:00:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id t17so2695029wmi.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 06:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5v0Dy23bszDikjahnfR50/JyqF0JMw3pYibReU0maQ=;
        b=ssbfMIbUr7q1MBCXJtcNYU5Zqq2x2YbEn6f2TIT7lyHcFFxlKU+8ADEwzx8bzJEb7D
         PmwjjhQRmOC6USAlOkBj0jll64frnU14pbOsMRquXNYt7uTQjSZs3g7cejUtFI1CUXS+
         7LkylxpucT/6N12qSu1uwK9QvFgG+Hi1mwRzaQlPQf764Q8fvn6ymvrIuhOMEiUrQiPR
         lt1pOl/xLCiVPZApcw0iFrEE+EDMWHfe/YDUTBtIeFtYhl7aK7vOmaylNiZURMOa1kHh
         uZITr3iTK532vd+ITf2HJwsULPvriuet+8+c3DhjhfFa8Wi0zH3RKtsJXrxIBCDmHSfq
         Pbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d5v0Dy23bszDikjahnfR50/JyqF0JMw3pYibReU0maQ=;
        b=b0Bi84WMQ1BvuLluvijs9YFN3N+2BGPH6kLkJO1KjguJgkVQ45XhBGuYkvNXJOcGt4
         Uree/Mrigbm7T8/E+jd57w5kn7eaYfmz5SRQQzg4zRmvAJxZ7scedsYnkRTqUx3PxDS5
         c5NFcaarGKiMzpGL26pYa7Miwty0u1oQ3Z8oG1yUppLkbV7AUSTLXrEfavT1gMOXSq0O
         Z68DjyAnNK++ekF50VLExPUruYUnCo5QSTvCHEaxgaT845DCQ2PR/2C1gwpwj2pxDbr7
         rIxTyH0QhfUnLpVkZjC1xiAOM/VAIBVsgIFKfFgMvsUzcWuvNIDaeGy4RpM43uJ/rpbl
         UlKw==
X-Gm-Message-State: APjAAAXvzjS9zk3hWFzpe6wdoqdN2tsMoh7pL5w3VVF6iil/+NOfz/Q6
        KK3dN5+BfIn/tceE3fBR4+AijQ==
X-Google-Smtp-Source: APXvYqyJ5a4GKbnNy6ifNCJ/h3sAEQrmaDMw8nRKCghJv8Y44i3udTkVE2loifhIC9yyK/Y6ScVf5A==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr2872266wmc.152.1567688403371;
        Thu, 05 Sep 2019 06:00:03 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z189sm3727903wmc.25.2019.09.05.06.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 06:00:02 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: meson: audio updates
Date:   Thu,  5 Sep 2019 14:59:51 +0200
Message-Id: <20190905125956.4384-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patchset features a few updates to prepare the addition of the audio
on sm1. It fixes the register range of audio fifo which was incorrect.

It also create another layer of dtsi, common to g12a and g12b but not sm1.
The audio related device are moved to this file.

This was done because the audio bus, which was at 0xff642000 on g12, has
moved 0xff660000 on sm1. Overwriting the reg property was option but it
would have left confusing node names on the sm1.

Jerome Brunet (5):
  arm64: dts: meson: axg: fix audio fifo reg size
  arm64: dts: meson: g12: fix audio fifo reg size
  arm64: dts: meson: g12: add a g12 layer
  arm64: dts: meson: g12: factor the power domain.
  arm64: dts: meson: g12: move audio bus out of g12-common

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  12 +-
 .../boot/dts/amlogic/meson-g12-common.dtsi    | 320 ----------------
 arch/arm64/boot/dts/amlogic/meson-g12.dtsi    | 344 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  15 +-
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  14 +-
 5 files changed, 352 insertions(+), 353 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12.dtsi

-- 
2.21.0

