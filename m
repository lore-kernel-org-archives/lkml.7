Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7D6C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B59214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Yp48pnG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfG2N02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:26:28 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40424 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfG2N00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:26:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id v19so53503491wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzloBHJZuIw/rxZFXtUAvelUg2L2IphfsMYx8JfRiGs=;
        b=Yp48pnG6fLGjrzkQjxWywxptMpGR+SIbHD7lBVj9BJ2cmB0oJBlDrhIZrN98xs7JBz
         btGMu+SdxAUm1kU5UZgWbkV644sufNPOEoU3qAxmfG+LMxlPpUnioTft700DqokcTQQJ
         8gyLo/wTnrtE759eVP94DNrsB8p8AawKdVU1K9mKBy6cg8ROQZMxCzIK2OY+6rnEMB2s
         QCzx/MdnRK3jz0aHLM8W0avWscPCKqUJ9fbhCzh0nHRQ2fdRLQML+wPJis2mmy4xeeXz
         +aJ9SYuGFxqP8/8P1BJl1VnKlUU0MW0G9s5sW+PUXfAm383AHTu5ki5bZrl8eZ7RJnUW
         P/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzloBHJZuIw/rxZFXtUAvelUg2L2IphfsMYx8JfRiGs=;
        b=HyDEhDXBS43ycMoWPtJ3nEpxwvr6tym5CIKc+FEI9ag4Damh8SmqgIG3avtRSYR2kt
         iqfSrINzVC2pfXsSyaghSD7C/T/3qsT4xsHNt2Wa+W9ACSlsy+Thz0Pf6uydfCAftkLV
         i3D7Ju59FjN44Gkvy/ibfXqlfccAd4g9uLSj2DwV0G3qgU+vl10iHg+rqIPqDJQTACWr
         31kVJ5lylaA+3kPVeX7g1CP/GuVmbnzpjnHWxyR0p4K7BC2Pz04Fz+xmUEmDf6O11+5b
         s6Vvg02arCTGpYgfjLAqDUb+FlY7I8guNIqwJaGkQP421WS7DXG2OTPctPQkt4PzVKzQ
         wcvw==
X-Gm-Message-State: APjAAAU0J+Dns4Xsb9tQ4towSMt7zPZ0ymXkBC4mQCBiftUNMFIwTsND
        L57RyQ867Ftfl6UTwQ42n24XGA==
X-Google-Smtp-Source: APXvYqw9hqNfOblzer1SvlkkNaWh5j4AAc7c7KP/ncRQHyDPEM/hoOoPcc0KoF6ALTdA6q6TbMTInw==
X-Received: by 2002:a1c:5f55:: with SMTP id t82mr98187475wmb.111.1564406784382;
        Mon, 29 Jul 2019 06:26:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id y2sm50270053wrl.4.2019.07.29.06.26.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 06:26:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] arm64: g12a: add support for DVFS
Date:   Mon, 29 Jul 2019 15:26:16 +0200
Message-Id: <20190729132622.7566-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G12A & G12B SoCs has kernel controllable CPU clocks and PWMs for
voltage regulators.

This patchsets moves the meson-g12a.dtsi to meson-g12-common.dtsi to simplify
handling the G12A & G12B differences in the meson-g12a.dtsi & meson-g12b.dtsi
files, like the OPPs and CPU nodes.

Then G12A & G12B OPP tables are added, followed by the CPU voltages regulators
in each boards DT.

It was voluntary chosen to enabled DVFS (CPU regulator and CPU clocks) only
in boards, to make sure only tested boards has DVFS enabled.

This patchset :
- moves the G12A DT to a common g12a-common dtsi
- adds the G12A and G12B OPPs
- enables DVFS on all supported boards

Dependencies:
- None

Changes since RFT/RFC v3 at [3]:
- Rebased on v5.3/fixes branch to take in order the last g12a.dtsi changes.
- added Martin's review tags

Changes since RFT/RFC v2 at [2]:
- Rebased on linux-amlogic v5.3/dt64

Changes since RFT/RFC v1 at [1]:
- Fixed G12B dtsi by adding back the sdio quirk
- Fixed G12A dtsi unwanted sdio quirk removal

[1] https://patchwork.kernel.org/cover/11006929/
[2] https://patchwork.kernel.org/cover/11017273/
[3] https://patchwork.kernel.org/cover/11025309/

Neil Armstrong (6):
  arm64: dts: move common G12A & G12B modes to meson-g12-common.dtsi
  arm64: dts: meson-g12-common: add pwm_a on GPIOE_2 pinmux
  arm64: dts: meson-g12a: add cpus OPP table
  arm64: dts: meson-g12a: enable DVFS on G12A boards
  arm64: dts: meson-g12b: add cpus OPP tables
  arm64: dts: meson-g12b-odroid-n2: enable DVFS

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 2417 ++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-sei510.dts    |   55 +
 .../boot/dts/amlogic/meson-g12a-u200.dts      |   54 +
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |   52 +
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 2418 +----------------
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |   96 +
 arch/arm64/boot/dts/amlogic/meson-g12b.dtsi   |  145 +-
 7 files changed, 2856 insertions(+), 2381 deletions(-)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi

-- 
2.22.0

