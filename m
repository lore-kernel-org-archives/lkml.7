Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB68BC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9926E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 14:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VESsgNY2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbfFGOrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 10:47:43 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:36285 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729374AbfFGOrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 10:47:41 -0400
Received: by mail-wr1-f49.google.com with SMTP id n4so2469088wrs.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nsYofuMppnRqgCVGCzspZVxlbsz2i2O0oowpiPhknA=;
        b=VESsgNY2BTLGAyx5Z9sLoiBllQ5A227565yEWm/niFWezYzsGjx0pAUVikjIctPDs3
         SRqUAkaM3McZicYSYQ+Klm+EO7Pn0AphEHFsx0AkBp95bMUYQCtsja8Jv5kHoQQ5hxPa
         g7y6XJBZ5Gd7wE9W3Y0n5W2TaE5j4zctKr+VGEkx2GwaXY6DjldCWUL5O3jXIJZSLE3t
         OFhWuKfRIoB4m83VpaVfk3U05gzQ/rRVZgk/GujbQSEuClfiXNZlWgiLL759C3goWVIN
         oydwAq8oaWTQlPmb/jx8X0RVZn+FWbILTVw5zg+iZssRSVLPauFbyXGtxBELAhy2kEgI
         IUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9nsYofuMppnRqgCVGCzspZVxlbsz2i2O0oowpiPhknA=;
        b=fCTbgLHvHNpNxc0Dv9cTkB4VXBC1dkjwFWXyuhwLn4xMXi2oPhBopxzmJhqJbjzJtG
         r8SpYfEv2bvr0vieI4uWVpsA7AE+3/EfXZRj3cLwXqSCR5bCsWVvUotI0aQ5dv1Ptfhs
         E2HiY+6jgCzTb1o9PCLVbkarG+dp2EJMkkn5ZCj/JwEDCPZJN28OTBBj50rgjEXgLNfM
         DRsCCHXDvE7KSvD4ndzaGDjP8N4H1Sn+OVgDZk57u46aVkT1TS3tuYIW8Rqg7S+TXgzq
         VRxwZbE1KXLKuevzLrI03i/zjubYRifk6+ZwhnLYGS0rohQJFTedLCYyLJRT6Slhctvc
         CdSg==
X-Gm-Message-State: APjAAAVxa30U6WwemeoKuRoU78qeXtsp9u022o73dFrpPdQo2mrimC3n
        5KIKlhgRV+GbQGSXaU/ACBEIdg==
X-Google-Smtp-Source: APXvYqwTyBPojSgywsCHuUgsnr7aG7OXbTgjaTxNtEuvLKYqrVAsh21/mqKVoLEOHuxUCGZQwtNW/Q==
X-Received: by 2002:a05:6000:1c6:: with SMTP id t6mr3086900wrx.236.1559918859367;
        Fri, 07 Jun 2019 07:47:39 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q20sm5184516wra.36.2019.06.07.07.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 07 Jun 2019 07:47:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 0/3] arm64: dts: meson-g12a: mmc updates
Date:   Fri,  7 Jun 2019 16:47:32 +0200
Message-Id: <20190607144735.3829-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- adds the SDIO controller node using the dram-access-quirk
- adds SDCard, eMMC & SDIO support to X96
- Add SDIO support to SEI510

Changes since v1:
- removed already applied SDIO patch
- added missing clock input from pwm
- added reviewed-by tags

Guillaume La Roque (1):
  arm64: dts: meson-g12a-x96-max: add support for sdcard and emmc

Neil Armstrong (2):
  arm64: dts: meson-g12a-x96-max: Enable Wifi SDIO Module
  arm64: dts: meson-g12a-sei510: Enable Wifi SDIO module

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 50 +++++++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 90 +++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.21.0

