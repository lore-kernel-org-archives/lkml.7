Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885CC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 769DA2171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="F8FLvJUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDLMvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:51:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40212 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbfDLMvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:51:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so11793309wre.7
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 05:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfDuX/79NFdFqCR80hZUxxRjvBqa8fy8pulUwrDToic=;
        b=F8FLvJUSr4HXdDldkNIS1ZdSVgA0IiZmKEYxVPwP4xaeVkuBC6JVb7u1QdkvyWFCUu
         nfG/4MEGihyHDffwU2b3MbGulH/HkiGzietA+SvMQLeRFKS7suwT01qlTCLKMbqtFpH8
         ecYTd3Q6KWG1BBoJ7EftoK0vhGbSmpMCcVsPPIgQ9nGmDtjhle5KMSJ6xghsfDfgKlPz
         cHGxAKaxqvTg2+UKcASB/L3VNoFNBS+cxbNRgK82M9CKcbN0aP0lHAYC5PdmhrDnGTC2
         PcF6o0v9tTvdpYD2FJpH7J5Iycr7fg41ysxwZoDo8TwmW7+3EvWp7rReXHcK6J/HtW9O
         FUEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfDuX/79NFdFqCR80hZUxxRjvBqa8fy8pulUwrDToic=;
        b=YjqcWI3tykPty3sKzw9uUJlPFKEa/j9k4fMLvoXbTe+blMg6KUA5qNSypEGWzKaFVn
         ncrS0RfDHmGmxbPRTgH008PBGb4RaDjfkj50nRXpBbys6YydHhkY2ot+KXets5hPNAxv
         f9cKfNQ+6ITQiV4hlktX69Mjg+8v1NKEW0xkFFxL0jE6Cn6vYa2gg+pLRnbY2PW5UMyK
         AVOQ8wvgXG5c+upIXW/oaos6fiY7xzsbY14w5MlNCNW8YE69FMeNsfkIkopL+PIgQNBL
         jH2WNwVk4B0Sk+6QxdY7P/b/cAaR082TvxW8Io/mp17N52b390+SaP98hrQ0poBQ5C9Q
         s1SQ==
X-Gm-Message-State: APjAAAWZEEkKV52rnl7SBfjcJTTD8HJ9sUNOxv1o0DlqgsA5OQA+1k2m
        E26vWd6Qj9tFLJiiJPuuqcdo2g==
X-Google-Smtp-Source: APXvYqwK5ad6q492XTW2yCXmbXoJXz8OIOd8yZKEw9OmBjDyuhpBQokhVmG3Dzc1WqdKL5h96uGyUw==
X-Received: by 2002:a5d:670b:: with SMTP id o11mr23048981wru.125.1555073506833;
        Fri, 12 Apr 2019 05:51:46 -0700 (PDT)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id b3sm42049702wrx.57.2019.04.12.05.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 05:51:46 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patchwork-bot+notify@kernel.org
Subject: [PATCH 0/7] arm64: meson: g12a: add audio devices
Date:   Fri, 12 Apr 2019 14:51:29 +0200
Message-Id: <20190412125136.28232-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds most the audio devices of the g12a SoCs.

Kevin, couple of things worth noting:
 * This patch depends of the new audio clocks binding recently applied
   by Neil [0].
 * You may get a warning about an undocumented compatible string.
   The related binding documentation has been merged through ASoC [1].

[0]: https://lkml.kernel.org/r/20190329160649.31603-2-jbrunet@baylibre.com
[1]: https://lkml.kernel.org/r/20190404111733.28705-2-jbrunet@baylibre.com

Jerome Brunet (7):
  arm64: dts: meson: g12a: add audio clock controller
  arm64: dts: meson: g12a: add audio memory arbitrer
  arm64: dts: meson: g12a: add audio fifos
  arm64: dts: meson: g12a: add tdm devices
  arm64: dts: meson: g12a: add spdifouts
  arm64: dts: meson: g12a: add pdm
  arm64: dts: meson: g12a: add spdifin

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 304 ++++++++++++++++++++
 1 file changed, 304 insertions(+)

-- 
2.20.1

