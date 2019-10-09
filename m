Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F5AC47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB5F82133F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 08:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="EXTxIiip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730289AbfJII1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 04:27:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730030AbfJII1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 04:27:20 -0400
Received: by mail-wm1-f66.google.com with SMTP id m18so1472356wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 01:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ETtimywo0QHOEXACD3eWpss97piVMA8Q9apqqhkw9s=;
        b=EXTxIiipvuSRt3WpixN9cmSOd/S6uza/iZhQU2JhNUziPV1RMySYp2fvsj53vsagey
         zR5fa6oQJP1MdHdhhpIYr7fFNG7AhLum4c8Ium/fG1aZPc3Oq54lnZYraX3DloaWyK/a
         +qbVxpyw30HziDNPNyJBd8LlBqJN+tGxqQ2QN9orrpm36i+jQrOs/MIZQMAuxA/dMgTA
         7G58AUOSO1CkiagedmeVWfVNr3fRYqxybl6tCJIzt9uDVStjjd/s5xbFs2ZI1adR1YJX
         37hkNEz7DoTTo07GyJr1LNXzFw74IcIDpUrsm6UxzQPd+tIeTXz/arf3ZcHvhvEIVo54
         0W3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ETtimywo0QHOEXACD3eWpss97piVMA8Q9apqqhkw9s=;
        b=p6xKsMuNmhcXZGzVUM2OfRNUXWBf+u5H7jTW/ASL7aoodhQIPhInzsampc+69xWPJW
         uWcuB4adt+I7+j4kx56nf15q7EpqNjZSdkRZ3TJmRQdvsVDwYYWY2dvUh6yuGn8uAmIq
         s+KJ94JUSThjcid//7PwnmMlqZgBX0Vs0owheHTrMnl6i7Obk5dYoOH/gK4C2EI0ZKRK
         62S6e5KwBAaVGvTq9OFzPnfFwFNCUTsfsoJJIibPkpuxCoQu0Y1/DjUWAXraDLtbUOSA
         HIWWxYhChaDI+96OBKQuT0jBAxg1Puj6tsim5qv9fpPGtQRYXR3EORdj0CRURhfLzsfd
         8Ihg==
X-Gm-Message-State: APjAAAW6DuVnVaUqRctybhSiKlGX3DrLfjuoSP9WXqf9xaHOFTCgKhrH
        EQs+5+9SdoACoESzhxRM8R4o9A==
X-Google-Smtp-Source: APXvYqzemyQZ1o5FQC5LcUGT4JwMcSgBGuRC2yCv1uuPFs1osQ0i4ZTxxRPbv1kvQQSlyCH9Rt4zuA==
X-Received: by 2002:a05:600c:22d7:: with SMTP id 23mr1583514wmg.31.1570609637059;
        Wed, 09 Oct 2019 01:27:17 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id r18sm2545364wme.48.2019.10.09.01.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 01:27:16 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: sm1: add audio support
Date:   Wed,  9 Oct 2019 10:27:06 +0200
Message-Id: <20191009082708.6337-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audio support on the sm1 SoC family and the
sei610 platform

Kevin, The patchset depends on:
 - The ARB binding merged by Philipp [0]
 - The audio clock controller bindings I just applied. A tag is
   available for you here [1]

This clk-meson branch [2] has the necessary clock driver changes, if
you want to test this.

[0]: https://lkml.kernel.org/r/20190905135040.6635-1-jbrunet@baylibre.com
[1]: git://github.com/BayLibre/clk-meson.git clk-meson-dt-v5.5-1
[2]: git://github.com/BayLibre/clk-meson.git v5.5/drivers

Jerome Brunet (2):
  arm64: dts: meson: sm1: add audio devices
  arm64: dts: meson: sei610: enable audio

 .../boot/dts/amlogic/meson-sm1-sei610.dts     | 205 +++++++++++
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi    | 327 ++++++++++++++++++
 2 files changed, 532 insertions(+)

-- 
2.21.0

