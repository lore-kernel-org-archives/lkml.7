Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6060DC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36983217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="W4uTbkPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfEUPT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:19:57 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37725 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727534AbfEUPT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:19:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id e15so19108552wrs.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IPAsBd9aqCnJMjXkUOTpKCD1VaCTy3cgfSntX0acqU=;
        b=W4uTbkPUsgy+wYyacFG5KBeV711U/EZ2erMd0a6GAG803PewiGEmhbAhhzHsjcy0m1
         CsbGHRURSiZa+kz0fSOiY3OTQhFg+Kbgde6fCvinBuXVbMBJaobR/5YCUJG4/NSKBO2l
         BnJ1HJYBnRhJFMCuAX8i8A7bePJ7di2YHuYLXsyZGxuycgM3y9wUzhcqFhThueQIrHs9
         ZCEfekei8R7wo99oD6OrhQQaO4cZi3shl8JY7w7M0fQGDNmi1w66jyTEZM05HyD8mi6K
         GTSMPUKplmxnnj0s+OvunZrl1qIkYeVTdBJNMdNfhb/jcFe6EejkTzIE/GLnMQNxLBsH
         DaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6IPAsBd9aqCnJMjXkUOTpKCD1VaCTy3cgfSntX0acqU=;
        b=pMAynj6kOedYRy71aKQ9rBhNdAIqtknSxvrSH3O8DRUUnkl1jzlXA9smQUg+Tv0R4P
         Zm6plyokZpytB7O0pZsThfUklHXmvSYY/08R5tYwXc0sbw6nZdwmHcTfQ5Ryh2Jj8Su0
         UyaQZ9uFnQHx/ejLKQWM36OV6hUyTc60fEl2+/Er3fJVZ7gFslNV6RBjx9IaSj3ArUd2
         rgxcNx4kZBKkCLJNJT9CQSnDXHDcgzc2ZI7MBZRcxJfdR5vOSjQ+5ylZuOx58TA/l8HP
         +5rZqnl9DAND/1BBmJo4MpHIqVp4pnFKR6bufg11v/jCQLYmOH2THzx58eRoIRi65+Cy
         COdg==
X-Gm-Message-State: APjAAAV0KwGtU8i8e/QPBVIil6iGhN1bpmfuEH4zc/jeEXsBkorVTF7w
        ZSdvnPnAR+noKSt9wLCEkFIgGg==
X-Google-Smtp-Source: APXvYqzv+0iUJ8V/1uMD79siZs9BDYvq/ZwRew6+bi21TmFVB8cSfm5Z0uUKS8YoH8d3R6LTjYy+eQ==
X-Received: by 2002:adf:c60e:: with SMTP id n14mr18774059wrg.255.1558451994318;
        Tue, 21 May 2019 08:19:54 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p17sm3945677wrq.95.2019.05.21.08.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:19:53 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] arm64: Add initial support for Odroid-N2
Date:   Tue, 21 May 2019 17:19:49 +0200
Message-Id: <20190521151952.2779-1-narmstrong@baylibre.com>
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

Dependencies :
- Patch 1, 2 : YAML rewrite of amlogic.txt bindings at [7]
- Patch 3 : None since clock + g12b bindings has been acked

Changes since v2 at [5]:
- sent the clk patches in standalone at [6]
- rewrote the bindings on top of the YAML rewrite at [7]
- Added MMC, SDCard and Network support to Odroid-N2

Changes since v1 at [3]:
- Renamed the g12b cpu clocks like g12a counterparts
- Rebased clock patches on top of Guillaume's Temperature sensor Clock patches at [4]
- Added AO-CEC-B support to N2 DTS

Changes since RFC at [1]:
- Added bindings review tags
- Moved the fclk_div3 CRITICAL flags to the gate
- Removed invalid CRITICAL flags on the cpu clocks

[1] https://lkml.kernel.org/r/20190327103308.25058-1-narmstrong@baylibre.com
[2] https://lkml.kernel.org/r/20190325145914.32391-1-narmstrong@baylibre.com
[3] https://lkml.kernel.org/r/20190404150518.30337-1-narmstrong@baylibre.com
[4] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com
[5] https://lkml.kernel.org/r/20190423091503.10847-1-narmstrong@baylibre.com
[6] https://lkml.kernel.org/r/20190521150130.31684-1-narmstrong@baylibre.com
[7] https://lkml.kernel.org/r/20190517152723.28518-2-robh@kernel.org

Neil Armstrong (3):
  dt-bindings: arm: amlogic: add G12B bindings
  dt-bindings: arm: amlogic: add Odroid-N2 binding
  arm64: dts: meson: Add minimal support for Odroid-N2

 .../devicetree/bindings/arm/amlogic.yaml      |   6 +
 arch/arm64/boot/dts/amlogic/Makefile          |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 286 ++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  82 +++++
 4 files changed, 375 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi

-- 
2.21.0

