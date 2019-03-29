Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157D0C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79CC2070B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="o4g5APBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729718AbfC2QHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:07:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54293 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbfC2QHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:07:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id c1so1907624wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCTUbKrBIzwZK7i4F3iyqIemr9Qt0Oo1bG7f71jNIlc=;
        b=o4g5APBzpMItecjvqZQk6zPyuisef3kZhlLRxTYpaQpxs82NebKm2AiD0va9/2QBhQ
         OYDwU42Grn4P0D7PgD8zGH8n9mhT21pmUSNkc2YkF8Hwx7Es8zpbIDEqRcGiiUrVsL76
         HbSvMh8b95fz6DMieoSKZGtsU5df23zs91atAErhuTAC8Z85eH0xzOaH8blA834UMfhv
         erSQSoZX0p0LVM2759Shgnu+EWY0/nU5rZ6tstQx4/6BYMipMVvmovcS7wjJ37LgMSI6
         NcjdFSemgOzzcSPpIIHyputZ+1rH1AtFzLRu1o/8GuhirQgG8/TbEfjwB41PpZFDpBHD
         yTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XCTUbKrBIzwZK7i4F3iyqIemr9Qt0Oo1bG7f71jNIlc=;
        b=PMPfI0VbuOz5BXkmnmlzVsZDY1LiTRbZvrdmyM5qZa3AerEs6ssmdpEzxKvny+RLgy
         B+8Pfc+QdAJL61ZvZnhbNnchQOGs2jDCyenlQR45yjEZB5R/dr2ekpBgnjjJRQadyXoA
         41tGURr9msbRQm8cen+aTHaknmkTeDE35SMaJu1IVTAX8aGt+xsiMlQ/krbz/1O8eqWL
         2rhZMRGyiERuZnzuW3khH6yhYumaqnbD0+vB3ia1BxzNiIgrWiA8xRor3G6KHxadrCAi
         j+0fWvimgvL7Aam/Y9qzEhsYb3HhAR0Rj0hXg93wFry1b+nuo16cN/BN//EiBV5o6zIa
         1XyA==
X-Gm-Message-State: APjAAAVhdu5kG5vK8+gilmvQ9/N8ATg5cCf+ua159PgFkDqPn9Qokv9f
        /M01Q9lAsfU3E+gxyJSM8EK2XQ==
X-Google-Smtp-Source: APXvYqxmjLzqna2DG01+kc4RUY3h0WrjjA95K3GJ2AWxZq+lIcLJnr71FcSK/XGCVdkMvy16B+PJ4g==
X-Received: by 2002:a1c:804c:: with SMTP id b73mr3989566wmd.116.1553875619010;
        Fri, 29 Mar 2019 09:06:59 -0700 (PDT)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id c10sm3329527wrt.65.2019.03.29.09.06.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 09:06:58 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/4] clk: meson: g12a audio clock controller support
Date:   Fri, 29 Mar 2019 17:06:45 +0100
Message-Id: <20190329160649.31603-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset updates the axg audio controller to support the audio
controller of the g12a SoC family.

Jerome Brunet (3):
  dt-bindings: clk: axg-audio: add g12a support
  clk: meson: axg_audio: replace prefix axg by aud
  clk: meson: axg-audio: don't register inputs in the onecell data

Maxime Jourdan (1):
  clk: meson: axg-audio: add g12a support

 .../bindings/clock/amlogic,axg-audio-clkc.txt |    3 +-
 drivers/clk/meson/axg-audio.c                 | 1219 ++++++++++-------
 drivers/clk/meson/axg-audio.h                 |   36 +-
 include/dt-bindings/clock/axg-audio-clkc.h    |   10 +
 4 files changed, 736 insertions(+), 532 deletions(-)

-- 
2.20.1

