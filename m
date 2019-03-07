Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA0BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895CE2081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 14:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vZ1Jf+42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfCGOBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:01:54 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38669 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfCGOBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 09:01:53 -0500
Received: by mail-wr1-f66.google.com with SMTP id g12so17552853wrm.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 06:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OY+0phA8UpFX5vYMRqFcrzCII/hw5auEsrx9gW+lk8=;
        b=vZ1Jf+42eBeGkGkdC2HCb9PkWCpqRAS7vN/jPqRhlOy3lrbB5ISvd95kyrOW+0DIxG
         V7BVx8U13CgTAovZncs2SwK3m+82XrtW8V5R2PswqpKQa5d7sXXlOkutUCEJS5sLxBD5
         kqEvCHIhr62QJpAm9gk+06lWZIo/etb9pHv4W+ZpaNshKaMTGKPPTUJr2rGmx/YmgMa4
         ih+H7kPU0ynj9asKTDGoqj+AmlwtExoxdUHWYa3BA0fz2PNUHXYeo6bVebVnbinJ2OON
         n7NvNxeFZAkmJWlvk/4a306Ep86StormdpsNDpb4r5eF2UBMJ/lZxnicPP2/+fSZTbCd
         Yh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/OY+0phA8UpFX5vYMRqFcrzCII/hw5auEsrx9gW+lk8=;
        b=OOJ4Bqf7AuRRNtSOj5PsQL6VDuQG9yHziUTTHjPT8eR0JvMc5j4AfPpQyeCKs1Gi74
         hBaUh2X3zR+hy/oq4fQIe0sw1NHueylcOPvZlpCZ2kF6bcFET4aLBNwRGCKh3jYBIS50
         p2VeDCETMK8pHlg82291FEI4jH1z8cs4+Fj1PZoJXYbEjQBNOoctu4iL0s4C9DVoDHjX
         d2bXFsBQW2tvj6mWbwxPwHOhnynpQGXej/V71MHOHOp2JPgWzWA0oInpKPmpW+oRkgW1
         oBC2C+weqCHQmWx2UykTrmvF2OWZNgFwCWM+h+Y7AP4euL+tze14HN2XEkM3LkW4Z79f
         UXzQ==
X-Gm-Message-State: APjAAAUeem2W6NwQSbzurdfpcaIUId27GatclKwXBz30ambuJDmcl3Co
        kfvrx/9Sos7wZh1JOlfjGUft2Q==
X-Google-Smtp-Source: APXvYqzziAutuhS7emt8QtI+La2FPbkArnKXU5544NmybfrdOSJxOwGq1zxHUQJdpywmuuqvIHsq5A==
X-Received: by 2002:adf:e3d1:: with SMTP id k17mr6926799wrm.143.1551967311465;
        Thu, 07 Mar 2019 06:01:51 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h137sm9892098wmg.41.2019.03.07.06.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 06:01:50 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: meson: Add SoC ID detection for G12A
Date:   Thu,  7 Mar 2019 15:01:44 +0100
Message-Id: <20190307140147.22047-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset :
- Fixes the package id detection for S905 variants and AXG packages
- Adds new SoC IDs and Packages IDs for G12A/G12B, and S805X/Y
- Adds Add AO Secure node for G12A dtsi

Changes since v1:
- Added G12B S922X package ID
- Added G12A S905D2 package ID
- Fixed patch 2 commit message

Neil Armstrong (3):
  soc: amlogic: gx-socinfo: Add mask for each SoC packages
  soc: amlogic: gx-socinfo: Add new SoC IDs and Packages IDs
  arm64: dts: meson-g12a: Add AO Secure node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi |  6 ++++
 drivers/soc/amlogic/meson-gx-socinfo.c      | 39 +++++++++++++--------
 2 files changed, 30 insertions(+), 15 deletions(-)

-- 
2.20.1

