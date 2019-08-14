Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D54C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59312083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 14:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="VAPOmbqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfHNO30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 10:29:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45417 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbfHNO3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 10:29:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id q12so21021747wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 07:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IzMeyCw4b+7DKgb/SLhUrPAysAZa9vx3wztCpi4ATU=;
        b=VAPOmbqxGPwOnu/ahhV4JorGqlJkzO90cqNgECVmwc2YqbZP4mROMy3dXJ/1sfFI2J
         jpBnqHM3N6+eifsigJK3AM8SWvVHh4wWhSehha9PO4sAK1anbFSn/RGHNHxq7dvKwqTy
         3waODWYiIhnsP9Qs3ebrS22URajl2LL9ObAK0jz+9ntmB3EaVgVpsMlH3xLqe6dYn/ac
         C5xCtCa6nzJbuFhbESygbFQb8Q8Twmz0CT0wMj7r4ZhgGWS35T2jXiBnmdRZqpIFo5PD
         eXitIImiYDiCADlNI6CfhY4pRc5db7iQCHmxtlXUjG2D1ZCcjZt6OBQlqsBYf9Gd5FU6
         F7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2IzMeyCw4b+7DKgb/SLhUrPAysAZa9vx3wztCpi4ATU=;
        b=ctGbzmdoNCIgyAy+gwTpQmD21QxbQKsUbZgcaoDqEIztpJV9i72ZezPCaDePT0AZ9j
         QX1TJFv8DZ3MQzxEIjVz3aCkFXunQnH63FqzE5WT7+8w46ApEzGrYvryUhvFpvbBa5hk
         tjwPsIr9cnH5kdErYJt3haRUYTweYtVVNm9/wQafrpHS94mCs6j66n+CnAC51f+vO+uS
         9A6xjX9LrH+y8AX02bXdkyJPROix+n0BRHkaeA003EQrzNsba4nSchXoM6ZVO3uhLwmN
         DCdcZmiL5yZniQZBEIv7lGGhgKB4D0O8YhY0pH8ZprRCfJFxZkOr17KRO2ReZsTBWe3j
         soiw==
X-Gm-Message-State: APjAAAX0YRT7IzGTB8YBxY6w92slMlI9AaKT3Mh8SWGOdZwOzWXli8/l
        Eg8U0B5831r+V+Yk3bB2kpzvfQ==
X-Google-Smtp-Source: APXvYqytAei+jJQfHJhChYLVNukfzd1vwskFZJVslXGn3U/8AlBoTjX7g3J6RtLDiVTl/Q6LfDLoGw==
X-Received: by 2002:adf:fa42:: with SMTP id y2mr53881666wrr.170.1565792962947;
        Wed, 14 Aug 2019 07:29:22 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o7sm4202908wmc.36.2019.08.14.07.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2019 07:29:22 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 00/14] arm64: dts: meson: fixes following YAML bindings schemas conversion
Date:   Wed, 14 Aug 2019 16:29:04 +0200
Message-Id: <20190814142918.11636-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of DT fixes following the first YAML bindings conversion
at [1], [2] and [3].

After this set of fixes, the remaining errors are :
meson-axg-s400.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12a-sei510.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12b-odroid-n2.dt.yaml: usb-hub: gpios:0:0: 20 is not valid under any of the given schemas
meson-g12b-odroid-n2.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'
meson-g12a-x96-max.dt.yaml: sound: 'clocks' is a dependency of 'assigned-clocks'

These are only cosmetic changes, and should not break drivers implementation
following the bindings.

Neil Armstrong (14):
  arm64: dts: meson: fix ethernet mac reg format
  arm64: dts: meson-gx: drop the vpu dmc memory cell
  arm64: dts: meson-gx: fix reset controller compatible
  arm64: dts: meson-gx: fix spifc compatible
  arm64: dts: meson-gx: fix watchdog compatible
  arm64: dts: meson-gx: fix mhu compatible
  arm64: dts: meson-gx: fix periphs bus node name
  arm64: dts: meson-gxl: fix internal phy compatible
  arm64: dts: meson-axg: fix MHU compatible
  arm64: dts: meson-g12a: fix reset controller compatible
  arm64: dts: meson-g12a-x96-max: fix compatible
  arm64: dts: meson-gxbb-nanopi-k2: add missing model
  arm64: dts: meson-gxbb-p201: fix snps,reset-delays-us format
  arm64: dts: meson: fix boards regulators states format

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |  6 +++---
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   |  7 +++----
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi     | 19 +++++++++----------
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts |  1 +
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  4 ++--
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  |  4 ++--
 .../boot/dts/amlogic/meson-gxbb-p201.dts      |  2 +-
 .../boot/dts/amlogic/meson-gxbb-p20x.dtsi     |  4 ++--
 .../meson-gxl-s905x-hwacom-amazetv.dts        |  4 ++--
 .../amlogic/meson-gxl-s905x-nexbox-a95x.dts   |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi    |  5 +----
 13 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.22.0

