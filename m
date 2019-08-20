Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAE5C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C0322CE3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 12:16:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="OGWTiqhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbfHTMP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 08:15:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46877 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbfHTMP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 08:15:58 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so12140723wru.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2019 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hh2kf0s/i1cC//+TV+jY6cSBLC41FA/AKhHkBEYopZg=;
        b=OGWTiqhOkJoervwr8V3fEVbnEyMHxGs/1W6172hYGxd0VIkUGlvHUayJsibEsc8uUb
         qaxVQWgd9XIveUyS1N4JHSk7gGqfexD0evTGcbrwt2kwHdKSTJxtwMCoNtzDSgbH9K4Z
         kMTBnJfSLZ5XyFPQMvMsrecVrfdcaqjdQSxNxq32B0Foe1dD/7hiSIvzsICogq8XezrP
         A/hlRJDjt1RgGIvNwhxjrpzziA9q+tz+2QFhjHUXbFmViDzbjpYVPxE4DyffQDL1TrjP
         vK3MdLqJi+XYnLle/xqEQNhCcIu5xhAL1tKoQ2mHzXWmSZuztgA5/GDVCDX5Awx32or8
         6I1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hh2kf0s/i1cC//+TV+jY6cSBLC41FA/AKhHkBEYopZg=;
        b=uT+GV3zi4eyGzKg3BiASnjDTCA0WQFpkqA40wI5qa9anH9rcI0mSZy7cVrTmAlcuiE
         NsUG1kCjGEqarcOsEJ2J7c1InsTyw11ibsHC0QO/wqkb1kVzxOAozUGzUpqiInIUIGSc
         IWKXumb/8pfEmhnqqVpcSSpQ1HvXRogvdldvcdh/oO24OObPRCJSI39xzwJu3je7U0Z0
         1wpiHXs2Y+22mL/uRA+VOKVhjmbg4+37hC2vX6cXY+vPO+WisjEe95wV6SvQ6A5lrDR2
         +502FAAWmEznZD146qtLVUe/IxDNl3ex/rwd4Vc4xf49/evPFDAzzIQbJbCkZNaxCBpt
         dYQg==
X-Gm-Message-State: APjAAAVFPKBALHQ5OBYVHxKr+XUyK/snr+Dq0DhY+DguArQWj58Q5m+b
        8SVt2NRCjchkkakLntoK4/JVPToJyRw=
X-Google-Smtp-Source: APXvYqz4WW0/7VvjoMxKB9GaX/uDPbDLn33wVUDE24ydFXJT4DLtH+dQEcBjmsyWv2/9zGf8efKpuA==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr33465269wro.133.1566303356447;
        Tue, 20 Aug 2019 05:15:56 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id h23sm15300765wml.43.2019.08.20.05.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 05:15:55 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: g12a: add tdm resets
Date:   Tue, 20 Aug 2019 14:15:49 +0200
Message-Id: <20190820121551.18398-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds the dedicated reset of the tdm formatters which
have been added on the g12a SoC family. Using these help with the channel
mapping when the formatter uses more than 1 i2s lane.

Kevin, please note that to build, this patchset depends on the new reset
bindings of the audio clock controller. I've prepared a tag for you [0]

[0]: git://github.com/BayLibre/clk-meson.git - clk-meson-dt-v5.4-2

Jerome Brunet (2):
  arm64: dts: meson: g12a: audio clock controller provides resets
  arm64: dts: meson: g12a: add reset to tdm formatters

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.21.0

