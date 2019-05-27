Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27BFBC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2CF420859
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 13:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="U8OljUhL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfE0NjE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 09:39:04 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:35913 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfE0NjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 09:39:02 -0400
Received: by mail-wr1-f46.google.com with SMTP id s17so17006110wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2019 06:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We4uplovOQZf8H9MqR+ir4BPzEX0UmRJmd0i71JwLdk=;
        b=U8OljUhLuC8mevKL+HHyzkXr5aEOCsHb4+QRyCvHdDMnvf1UwZit3DX+Xwuv+1BN87
         kLTzOba7MlPs9PZFq06yRi5dOGdLV15s+sboSrda5hLrqpDblXzGVCIPZR48Eff3Vo9y
         kDzCANilF9GqGyg9sv7VU0bwow7KK/cZAlq26bUy41FBkl2mSyutqYvruxw8wli9iG4J
         q+MxOTaVfYL0o20Ibk7sbFIXtagq0yPL8x2zdXaaNfe1zLYiznb7Vl0jM1D2PtIQtewk
         dOy0Xkx2nguj3Mxt+SVq/vwqKGYLg0gkDO/6YU/qtRdz1dLarFBvDl/wIlBuKEDsao1z
         y4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=We4uplovOQZf8H9MqR+ir4BPzEX0UmRJmd0i71JwLdk=;
        b=UAF2USBos79Hscl9DsXDSUA2IpPHTqSt+dP67j7CJehkboppg4qiAFHwyDYShvtk4Q
         uNtCGpMrJryzAzy66Rl7+aV+1C4lseJvaO04AMVJc5aAifD6SZuQL9VARb1T790t8yIQ
         dYAP9t8qeP6in87LTr/UPVL6zvNeFH4LUKksgibZd86NebJTyQnX/wso+CM1xudkS+AC
         n4aSM+xF4+Hknmc9b1268UGVySeEaOFKXCOCrhFaz0J4LXuzzfuc9NXJFjmBrUJXC4iS
         sVb6NhUjV/9PmUpbDlWBFgnxtB92bQWwChZ7qzoY4+wO3/XIXTUYrNIUPf1HO3GllN8R
         f+QA==
X-Gm-Message-State: APjAAAVh2vHBfs7qTT2cAVbIc7Zk3FJNwvUtQEre/KoG07ny6lMU0dcu
        TX2a2UYI3v0UFo0l5Q8EvmCAgA==
X-Google-Smtp-Source: APXvYqy5ZEX6ePMPpeCwIYNkq3QaAODyB0QRmvozaWBghiJhVpy5B6aiXIWnkmWqKGFCvZCb+FvsIg==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr60204098wrj.121.1558964340408;
        Mon, 27 May 2019 06:39:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id a124sm7838335wmh.3.2019.05.27.06.38.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 May 2019 06:38:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 00/10] ARM: meson: update with SPDX Licence identifier
Date:   Mon, 27 May 2019 15:38:47 +0200
Message-Id: <20190527133857.30108-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the SPDX Licence identifier for the Amlogic DT and mach-meson
files.

Changes since v1:
- Use MIT instead of X11 in DT, and precise it in commit logs

Neil Armstrong (10):
  ARM: dts: meson: update with SPDX Licence identifier
  ARM: dts: meson6-atv1200: update with SPDX Licence identifier
  ARM: dts: meson6: update with SPDX Licence identifier
  ARM: dts: meson8-minix-neo-x8: update with SPDX Licence identifier
  ARM: dts: meson8: update with SPDX Licence identifier
  ARM: dts: meson8b-mxq: update with SPDX Licence identifier
  ARM: dts: meson8b-odroidc1: update with SPDX Licence identifier
  ARM: dts: meson8b: update with SPDX Licence identifier
  ARM: debug: meson.S: update with SPDX Licence identifier
  ARM: mach-meson: update with SPDX Licence identifier

 arch/arm/boot/dts/meson.dtsi              | 44 +----------------------
 arch/arm/boot/dts/meson6-atv1200.dts      | 44 +----------------------
 arch/arm/boot/dts/meson6.dtsi             | 44 +----------------------
 arch/arm/boot/dts/meson8-minix-neo-x8.dts | 39 +-------------------
 arch/arm/boot/dts/meson8.dtsi             | 42 +---------------------
 arch/arm/boot/dts/meson8b-mxq.dts         | 42 +---------------------
 arch/arm/boot/dts/meson8b-odroidc1.dts    | 42 +---------------------
 arch/arm/boot/dts/meson8b.dtsi            | 42 +---------------------
 arch/arm/include/debug/meson.S            |  5 +--
 arch/arm/mach-meson/meson.c               | 12 +------
 10 files changed, 10 insertions(+), 346 deletions(-)

-- 
2.21.0

