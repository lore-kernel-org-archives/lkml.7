Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3BEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46BF320811
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 16:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="2C1BnO+e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfCNQhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 12:37:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50293 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727247AbfCNQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 12:37:35 -0400
Received: by mail-wm1-f68.google.com with SMTP id x7so3738659wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 09:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwBoD1sDij0jsG9awwD4X8EaqLlNFJrsNhL/sg7fZs4=;
        b=2C1BnO+e4y1GwCrS1NfwUUMq1/Fa5o3j6RsYEUcswvhmhrYWDk8A2bYUkhUpaBAoiW
         zAdsrQlZVeoaZE3V2Qd0J9iuOBNut/uIf7s5DaLkqL1aNdv+Jx+YrzA8ht00YaxpteHY
         0TU+FRBcDi9wSoeb6jlazARzfdfNWd+S3uufrj80hGTVCcpyZnAqCUGlOCuaye/qqicY
         UCJ7b0m2JQBFNyTYHww9e8peZWWzr/GfMc9yCCjVMbj49pFX+vFxLjbY1+N/JeHTKTus
         oAl1FA+vppJy8FJb0YKubDPmDM0Z7yqBLdJe2R1c85Yo80EtpAaoSrpznnvmv6tkoHfq
         O5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dwBoD1sDij0jsG9awwD4X8EaqLlNFJrsNhL/sg7fZs4=;
        b=S+kjRL8YPHAiMjmmBeI09cHZhFvwwEl4dlcfoI06HOb8+g1O+lMucgdQwYZULQdNWs
         74Mmjuc9LFU6UhVXhBGYfceVjIoacq1XHlWiGLjrVF24ZWRCio/Drt0qKR6gjs6wBQ/B
         HvheeRZt4j0oDfxbgq2W/+pwusWzbqixL+uXdDU6A7BMxQffCfpgo44o1EDHq/JGk22r
         gfrzC7yqkfPHXc6eI+akrDqk7HvM82sHyRhxrXTukNfQXP3L1PoL6VfTi96BhOH+jfaJ
         hT+A/vcgBozOifRgmJ05E3/5iqmPUSRV4mDiqqWUpebPXl841hPlihiyssARfPV38jlw
         oHWA==
X-Gm-Message-State: APjAAAXYyv2rf+8BA1Cd6Cm46+TggR35igS8YW2BKA95bq9VuezuqqL1
        gC0P8d+Dz29OrRYTYcsvq8LO3Q==
X-Google-Smtp-Source: APXvYqyHqgo2GfsBipQLYm3mmLaMOA3ytFrbvaK2Mufl3Ofrsvc6OJLYXa8DVtqK5L2BZUrdV7m+ZQ==
X-Received: by 2002:a1c:c90e:: with SMTP id f14mr3065130wmb.23.1552581453702;
        Thu, 14 Mar 2019 09:37:33 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id u17sm45003315wrg.71.2019.03.14.09.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 09:37:32 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH 0/2] pinctrl: meson: add g12a drive strength support
Date:   Thu, 14 Mar 2019 17:37:23 +0100
Message-Id: <20190314163725.7918-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this patchset is to add drive-strength support in meson pinconf
driver. This is a new feature that was added on the g12a. It is critical for us
to support this since many functions are failing with default pad drive-strength.

Now the slightly annoying part :(
The value achievable by the SoC are 0.5mA, 2.5mA, 3mA and 4mA and the DT property
'drive-strength' is expressed in mA.

1) Rounding down the value, we could be requesting a 0mA drive strength.
   That would look weird.
2) Rounding up, we can't distinguish between 2.5mA and 3mA

To solve this issue in this in this v1, we chose to document that, on Amlogic,
drive-strength is expressed in uA instead of mA.
It works well and there is no impact on the other platforms but I'm not sure this
is really OK with the DT rules ?

Linus, if this is not OK with you, here are 2 other options we are
considering. We would be very interested to get your opinion on the matter:

1) instead the generic 'drive-strength' property, we could add an amlogic
specific property, 'amlogic,drive-strength'. It would be expressed in uA
and parsed in amlogic specific code.
I think this option is kind of overkill. Expressing drive strength in uA is
not really amlogic specific so it does not make much sense, but it would
work ...

2) Add another generic property "drive-strength-uA". The change to do so
would be minimal and could be benefit to other platforms later on.

Cheers
Jerome

Guillaume La Roque (2):
  dt-bindings: pinctrl: meson: Add drive-strength property
  pinctrl: meson: add support of drive-strength

 .../bindings/pinctrl/meson,pinctrl.txt        |   3 +
 drivers/pinctrl/meson/pinctrl-meson-g12a.c    |  36 ++--
 drivers/pinctrl/meson/pinctrl-meson.c         | 166 +++++++++++++-----
 drivers/pinctrl/meson/pinctrl-meson.h         |  20 ++-
 4 files changed, 165 insertions(+), 60 deletions(-)

-- 
2.20.1

