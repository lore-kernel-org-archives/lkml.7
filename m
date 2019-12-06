Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8274FC43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5060220707
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DFttMATf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFKC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:02:27 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42441 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfLFKC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:02:26 -0500
Received: by mail-ed1-f67.google.com with SMTP id e10so5285355edv.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 02:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAvJfWkyWR+AqwH45vb7OdQ/ejgJ1D722M1KzKBLqNU=;
        b=DFttMATfsmSCeQvvYWYUxpzer6Vkitii5nW2aHuvNNv3pS/l2CnW//0LmGe2d/a5JX
         K3ntKEfzHD8h3ey0yht5svU93Lnu0VvACpK49dJ5c5Tk91ozdJi0CVXT/3lYKtdxU20M
         NrrkunhxObUHN1OpeafvG3rSGaZRZFNT844O4mljiWQWH2gDrojjy2ueiElHYV4y4Bsj
         JsAwhPN0uOtK04Re9e/Einc4uIZ3VeU1ctXKl/9b+DxFtL85yfTRQ9z/YkYagIxv8Y9C
         wvsFIWhwMA1zTeV0aK7dkEVmfH245dWAiPvqNFDvdWjhKLNNp7fV/bZa6UiajtYYJLnS
         b0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EAvJfWkyWR+AqwH45vb7OdQ/ejgJ1D722M1KzKBLqNU=;
        b=IEmvk3ybEkTVpIhNz0wD4DtHhZXV6tQa9p+i4bqPrDyvcqUmejr2JFAhAeSF1x6Bde
         DlP37+dFZros9HQexs7gFct2k5J/Gan9GpdgkxYf2jeBwDAW53Dsfl9XZtvUtf4aERGh
         v29VKfjprTO+kX1CMy9NZhWdKv5lygAMWsAnae42qSrQHH5z93NfHzD95pgPRB4w8qys
         dObj3b0ihETzv+0ztyQ0yNAhrAbxXA9X2COt8wEZzDHoH8ZrByEI4JDOTPOAJaBJYiOM
         6v2GDx6rP3FbUjXR4JDiP6BVdixaIgQJfe6XMOvguAW5NXZtKwGqd15cR3hJvNg9ygYn
         LdgA==
X-Gm-Message-State: APjAAAV6atpvj8QKOKPK5FMUTNLV5b3xIVfzHHmkXYeFnBgBafTiygwv
        ugQAjBSyM/tHw3b/2MIAg6ksPHWYpVg=
X-Google-Smtp-Source: APXvYqy5SQAlBOFPQ3Lsgyk1faem3zPDe6yWaPFjquElixuLqt7HnpG11CnVZHLnBLUCdj5tUMuRNw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr14587402wrm.210.1575626544415;
        Fri, 06 Dec 2019 02:02:24 -0800 (PST)
Received: from starbuck.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id d14sm16372314wru.9.2019.12.06.02.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 02:02:23 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] arm64: dts: meson: add libretech-pc support
Date:   Fri,  6 Dec 2019 11:02:14 +0100
Message-Id: <20191206100218.480348-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds support the new libretech PC platform, aka tartiflette.
There is two variants of this platform, one with the S905D and another
with the S912.

Jerome Brunet (4):
  arm64: dts: meson: gxl: add i2c C pins
  arm64: defconfig: enable FUSB302 as module
  dt-bindings: arm: amlogic: add libretech-pc bindings
  arm64: dts: meson: add libretech-pc boards support

 .../devicetree/bindings/arm/amlogic.yaml      |   2 +
 arch/arm64/boot/dts/amlogic/Makefile          |   2 +
 .../dts/amlogic/meson-gx-libretech-pc.dtsi    | 362 ++++++++++++++++++
 .../amlogic/meson-gxl-s905d-libretech-pc.dts  |  16 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |   9 +
 .../amlogic/meson-gxm-s912-libretech-pc.dts   |  63 +++
 arch/arm64/configs/defconfig                  |   2 +
 7 files changed, 456 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-libretech-pc.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxm-s912-libretech-pc.dts

-- 
2.23.0

