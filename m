Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17AC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A1F42077B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="HFev9yVy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbfH2PXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:23:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42897 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfH2PXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:23:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id b16so3842454wrq.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 08:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dFPZ/6qLWwta/X/6TBZX224XPskUwC06RARQpEaapE=;
        b=HFev9yVyH4RcQrIUMgcPOCZRRrOPtTPk886G+NQd/p75QFtiPvnYzKXH9WBeDguB/k
         TImrqzMA+RWJAZIrYN7TfXgu/cRXgpKS4NPg3G/DatkmmE1BghBtfCS6qlPFBA4u3AOj
         UX0YqPUTyLiXLYbI1iVCzz5UfuxJWkrl5ggLJEeiJB4+LqZrRni2gHQxRgbhugQxU6Xr
         G6RGOfOFTBgkvw2dJQsGJRDprMx/tWVWR/KEuehgIEhg1l3VauJw/NtT9Yb5za7LjBlN
         1ALgAtX+uWojoxCzBVhxZIt0KliLtqsMambZAo3730iq+yX8ZEsLmi+N5ArlLL9i+RFR
         1YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7dFPZ/6qLWwta/X/6TBZX224XPskUwC06RARQpEaapE=;
        b=Ehf0NlQkmqLRL47/uiZB0bp7MWHQ5apyDV1kxCVSC+z8Zaocm9LvqT3vyf2DzA31bc
         uCwT4V7gbIfJOXSex59XhKb9O4Ldipnd05nFBf+sLDPZ/vvSXB0ue6coLWPazLCfWIc1
         W6M77R639T6VZHnkRd6cudMJyG5D0J2HrQh3zENM+p3e9Jm2Y0AEo9gljGZORk/UwhT5
         XQUUFYpa2avGWVUj0qqfGh/lTl/PvOgRMIkrN0Sh9Vv3fSodilfX2jwVlM/4ta1nqhzw
         UegahbsthXHqL1QCZMB9DSBV01wRaM+jK0yxxkba3/FxWp+IZ6F3ZBPy+y/HEs1uxC5s
         JLnQ==
X-Gm-Message-State: APjAAAUuUQxh1uZsajkkKOR3xvbhC8MYeBxIqty95K+aHOGInERfBkgS
        r3JQ8G7IYtjyF+dKbhqnATnGdg==
X-Google-Smtp-Source: APXvYqzll1J2sQmKjhlmvdflWUHVD07LklB6ktBI4HmwvZDmM228SATXANUgTUtpg6hjSwl8myph9g==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr6553995wrr.178.1567092225155;
        Thu, 29 Aug 2019 08:23:45 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d17sm4866871wre.27.2019.08.29.08.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 08:23:44 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 00/15] arm64: dts: meson: add keep-power-in-suspend property in boards SDIO nodes
Date:   Thu, 29 Aug 2019 17:23:27 +0200
Message-Id: <20190829152342.27794-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WiFi SDIO firmwares requires power to be kept while entering a system
wide suspend state to keep current connection state and eventually wake up
on packet reception/new AP connection, thus add the keep-power-in-suspend in
each boards enabling SDIO.

For the record, drivers requires it are :
- brcmfmac: drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c line 1125
- mwifiex: drivers/net/wireless/marvell/mwifiex/sdio.c line 426
- libertas: drivers/net/wireless/marvell/libertas/if_sdio.c line 1327
- wl1271: drivers/net/wireless/ti/wlcore/sdio.c line 411
and bcmdhd out-of-tree driver.

Neil Armstrong (15):
  arm64: dts: meson-g12a-sei510: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-g12a-x96-max: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-g12b-khadas-vim3: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gx-p23x-q20x: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-gxbb-nanopi-k2: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gxbb-nexbox-a95x: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gxbb-p20x: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-gxbb-vega-s95: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-gxbb-wetek: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-gxl-s805x-p241: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gxl-s905x-nexbox-a95x: add keep-power-in-suspend
    property in SDIO node
  arm64: dts: meson-gxl-s905x-p212: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gxm-khadas-vim2: add keep-power-in-suspend property
    in SDIO node
  arm64: dts: meson-gxm-rbox-pro: add keep-power-in-suspend property in
    SDIO node
  arm64: dts: meson-sm1-sei610: add keep-power-in-suspend property in
    SDIO node

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts           | 3 +++
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts          | 3 +++
 arch/arm64/boot/dts/amlogic/meson-g12b-khadas-vim3.dtsi     | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi         | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts        | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts      | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi            | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi        | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi           | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-p241.dts        | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi       | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts       | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts          | 3 +++
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts            | 3 +++
 15 files changed, 45 insertions(+)

-- 
2.22.0

