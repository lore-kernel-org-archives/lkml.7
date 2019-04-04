Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA69C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B15C20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 15:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="XhRewR9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfDDPFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 11:05:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37946 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbfDDPFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 11:05:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id w15so3815300wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 08:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB5foxrt3C76LRQYopjHfbUjFV2YxQTZVMUiKN7tn0w=;
        b=XhRewR9qqAwgKIzPdfgAVxtR5fotF0TD4rTzKQTXn3fFXzVpAgxvNeGNjX8UPsIrLb
         ReHwSJr4wfgPz+Yxh0vU85ecIz1kuIzrkoIhhX0KK1ytV40mYmb5/ck2h/C2h4B4duLK
         IYV6Y/nzQ6CwgV7Anckm6ivDyNx2EFxcxHOeUUeIPaRwahpIcpwCQuIeEkbg63HUXwW0
         wGL3JFM3C8+fO9kEmdUc0dhcJTmPNq/5S5mcgjwv6K8o5jnM9T9N4pGbeHTuV8BD3iiN
         Hokgi6UeTWM4YcWNgEZq7UYN8DA+a2+Wtm4zbVLEeVf3Qhtlg9yKYnW3KJagBVcSGagu
         5I4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TB5foxrt3C76LRQYopjHfbUjFV2YxQTZVMUiKN7tn0w=;
        b=nh29XA0ZLYaqafvQigbsRM9Zi80YrfzQH//dnFyI7nQJfIADuOmywOAD1IpWmUyusr
         4X0fykjnn2bfWNfgdVdOu6YTcvCyLPxHpm0IUuYqn5Mbr737FtbGSDjwzR6xIsKNra/6
         hy8xktVc+pCLP4O7lEshfLgJ5mzKqCYbkXPfRkzTnSQ6FrxqpRgTDYaXUY+uTUrmt7V4
         EVqdFcjvNam12zKVEbOBkPyixWwFiAR2I/vX3f3/jSMCNdWixMCmcJPn9g7cBYL8khIW
         owTBD01pPjoaZgRrE4Ltf8/KcKCaQyMWb8eS9LiLKOTqFvSBL1hNXk4Sr+bGg/DokoAK
         8C8A==
X-Gm-Message-State: APjAAAWJtmNqU+G2KsCGRsoR5gxvxyJAVgZxSZlxznrUkQrSbRfPUkwu
        JWeTTJekD5q9fxxIaKm6idHKnw==
X-Google-Smtp-Source: APXvYqxkongdDzndt0TvxTAkETNNujNLzgX7fj0iGbsuBm344J2kHUEY6yAiy345e3eBqGGKUkFHfA==
X-Received: by 2002:a7b:c76c:: with SMTP id x12mr4486473wmk.97.1554390328711;
        Thu, 04 Apr 2019 08:05:28 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id z23sm9880981wma.0.2019.04.04.08.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 08:05:26 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, jbrunet@baylibre.com
Cc:     baylibre-upstreaming@groups.io,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: Add initial support for Odroid-N2
Date:   Thu,  4 Apr 2019 17:05:12 +0200
Message-Id: <20190404150518.30337-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds basic support for :
- Amlogic G12B, which is very similar to G12A
- The HardKernel Odroid-N2 based on the S922X SoC

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture, but with these differences :
- The first CPU cluster only has 2xCortex-A53 instead of 4
- G12B has a second cluster of 4xCortex-A73
- Both cluster can achieve 2GHz instead of 1,8GHz for G12A
- CPU Clock architecture is difference, thus needing a different
  compatible to handle this slight difference
- Supports a MIPI CSI input
- Embeds a Mali-G52 instead of a Mali-G31, but integration is the same

Actual support is done in the same way as for the GXM support, including
the G12A dtsi and redefining the CPU clusters.
Unlike GXM, the first cluster is different, thus needing to remove
the last 2 cpu nodes of the first cluster.

G12B clock driver is very close, the main differences are :
- the clock tree is duplicated for the both clusters, and the
  SYS_PLL are swapped between the clusters
- G12A has additional clocks like for CSI an other components

Dependencies :
- Patch 1, 3, 4, 5 : None
- Patch 2 : Depends on the v5.2 meson-clk PULL request
- Patch 6 depends on the G12A Display DT patchset at [2]

Changes since RFC at [1]:
- Added bindings review tags
- Moved the fclk_div3 CRITICAL flags to the gate
- Removed invalid CRITICAL flags on the cpu clocks

[1] https://lkml.kernel.org/r/20190327103308.25058-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190325145914.32391-1-narmstrong@baylibre.com

Neil Armstrong (6):
  dt-bindings: clk: meson: add g12b periph clock controller bindings
  clk: meson: g12a: Add support for G12B CPUB clocks
  clk: meson: g12a: mark fclk_div3 as critical
  dt-bindings: arm: amlogic: add G12B bindings
  dt-bindings: arm: amlogic: add Odroid-N2 binding
  arm64: dts: meson: Add minimal support for Odroid-N2

 .../devicetree/bindings/arm/amlogic.txt       |   6 +
 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 178 +++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 ++++
 drivers/clk/meson/g12a.c                      | 451 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  20 +-
 7 files changed, 738 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

-- 
2.21.0

