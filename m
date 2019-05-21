Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97031C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECE621743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="j+UCJZlm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbfEUPBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:01:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38306 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728784AbfEUPBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:01:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id d18so19025618wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF2CDs8GJndud+tJOwAui4kXWvWdLcOJYF5JUOigmaI=;
        b=j+UCJZlmQX3NC+lUmPI+K/5t1BBpvYyat/5tw8TlJITObCeJXzQv5JA3sYpUsJjKi5
         w7QG2E6DoLMRMlQR9I1PQ+FTWxIK4jC9vRYueXaSWq2I+tzmzCGUWS+KHHWDCa3QJuEr
         OGurZvGKMb4DkUlJExtPXFAlxEgUCSFf37sanZKDY6pp47RMTBQTa6i1EAFzad8uboxa
         NqVMRVjvthtOrN0UM2vSPys/bdXWr3CBldD6JiBNPPcMxZJg75gRQ23oyuNUXCBjoT3g
         yJu7UO3DoOrpup1u8QmDD/elHa4U80tLW3pb4wT+Y4TwQk2MFMrUUKBOt82qR840O2dK
         ipyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BF2CDs8GJndud+tJOwAui4kXWvWdLcOJYF5JUOigmaI=;
        b=jkiAYI/KBV2I0+Fo5jC6CNTgW/nC580QuS+qJSUWEAbe9RY63pptxkrBzX5VOHPeXR
         nShcOLWTTw1cwfcU6BFmvXDaRJqlBsh8ZIrdDwxJxScbKA6wNzoslXe33YCGAhTezbKs
         AodhxRhCuaWuAJTzC9nbxvQZXsXPVsW6NhbdIlOXRDPxn+JDM9j7fVo/V+WVU10ii/tg
         A/XJT3nxCNtHgYS25CB8pKPNkaOp/PglkqMoPuguKx66CIevZ2njf9oAHAgoIyx8rqa5
         Apj05n3+1ZTbLp7irwns7/CJW4bNLG8cYSJtxHpZRnAHYC7cgq7xLZuJj5AkfdEW5zwf
         bJkg==
X-Gm-Message-State: APjAAAV0AVUIUdW6DmTDujGR5gyslncgE4tp5jbGuKTwCptETBzP8kBR
        PSflwIIeXxMr+JGUi/IsV/yY7Q==
X-Google-Smtp-Source: APXvYqzc/ULB/4zVvRVJIncLQNslSLkrcgQiE0igOHAgUp0J6NZfXBnW15l5WJWrBOBUyVM9G9e7Sg==
X-Received: by 2002:adf:cc8e:: with SMTP id p14mr35315046wrj.82.1558450893970;
        Tue, 21 May 2019 08:01:33 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id b194sm3407505wmb.23.2019.05.21.08.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 21 May 2019 08:01:32 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: add support for Amlogic G12A
Date:   Tue, 21 May 2019 17:01:27 +0200
Message-Id: <20190521150130.31684-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12B SoC is very similar with the G12A SoC, sharing
most of the features and architecture.
G12B clock tree is very close, the main differences are :
- SYS_PLL is used for the second cluster (otherwise used fir the first on G12a)
- SYS_PLL1 is used for the first cluster (instead of SYS_PLL on G12a)
- A duplicate CPU tree is added for the second cluster
- G12A has additional clocks like for CSI an other components, not handled yet

Dependencies :
- Patch 1, 3 : None
- Patch 2 : Depends on Guillaume's Temperature sensor Clock patches at [1]

This patchset is a spinoff of the v2 Odroid-N2 megapatchset at [2]

Changes since original pathset :
- Added missing sys1_pll div16, cpub div16 and cpub atb/axi/ahb/trace clocks
- Rewrote "This patch .." in commit messages

[1] https://lkml.kernel.org/r/20190412100221.26740-1-glaroque@baylibre.com
[2] https://lkml.kernel.org/r/20190423091503.10847-1-narmstrong@baylibre.com

Neil Armstrong (3):
  dt-bindings: clk: meson: add g12b periph clock controller bindings
  clk: meson: g12a: Add support for G12B CPUB clocks
  clk: meson: g12a: mark fclk_div3 as critical

 .../bindings/clock/amlogic,gxbb-clkc.txt      |   1 +
 drivers/clk/meson/g12a.c                      | 659 ++++++++++++++++++
 drivers/clk/meson/g12a.h                      |  33 +-
 3 files changed, 692 insertions(+), 1 deletion(-)

-- 
2.21.0

