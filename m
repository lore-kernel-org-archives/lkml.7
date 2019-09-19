Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1254EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D796421927
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 09:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Eek7UVSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388846AbfISJgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 05:36:36 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38315 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388661AbfISJgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 05:36:32 -0400
Received: by mail-wm1-f67.google.com with SMTP id 3so3132521wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 02:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iI+tkS4PiIp8BCmRgY+UMG+pL+AXGxEv73nrxIiQz5s=;
        b=Eek7UVSEU0ern91R93g8cvieSXZ4myQs3jTIKt8uNgy3UmF7EY3N6zv6hRWuUA3Aqh
         pcaLBQay01dui0oEJH2ylcIuEgiM+gdX0FbSy/6S0n3Bam7ZVmYIHEO82hdL6XAU3EWQ
         moqgrtOEjl41mEsoLXecZ5SSNTBW3e8zElGSSrUEZ4+NACiWB1+1O0jdSRlbSzsflLde
         SuDMzvOn1adnsaPbBO7sjVdchYm2qlmusAeVbEaDIG6oLbotWY8kECrmD5SqvaO+d0q2
         0ajv2GyUCwPVD/iD1LyB9H0isyNQOUiwMYeTX+Wqh/BM6qFTr4kpHdNHLr6wTbyl5RNI
         xDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iI+tkS4PiIp8BCmRgY+UMG+pL+AXGxEv73nrxIiQz5s=;
        b=i8uma+TE/E3rVTu01aVzKhNiZ5+fAPlcZuQJAKm/tdXxKpXxdzR+b8fX15cha1Q5Jq
         EkwAmrIeVzHWhKUZF18e32n/pguGcIProZBZ+hK/Y5uQD2kHJ3661t3PEUTl+gpCHi6A
         Tsf5K46B0gmzdzExQYqkGe21W4n1I0ZvpvxWM7sw19LoC/SUeRw/8jaycZPKaCfI9oTM
         vLWUJXMqQmuUk6o0jyq8UXGRhCPC78SH+ZJn71NH2CPx6gQmw28xM1BJVBgRZZ+jOMyd
         0pP4plAXapEnF3I1JODSlH30SJJba0ioBQTJpeZPTWF+ln0VQQ8F3CJplGR/ld1bSrq0
         AqOw==
X-Gm-Message-State: APjAAAUukyNX13cj/p9dZZJjFqkPUsQOsPVvIffCkarzM82zLAMPdVuz
        qkYKb5Be8rVlwdoBzu2YNoqixA==
X-Google-Smtp-Source: APXvYqznJatZccIrCzOBZuDhpnxTn29NEmTv3f2C4wKt2Z2k+sDqXbS3pe8+3Gdr0QAGBoRbyrmgrA==
X-Received: by 2002:a05:600c:2153:: with SMTP id v19mr2053035wml.146.1568885789291;
        Thu, 19 Sep 2019 02:36:29 -0700 (PDT)
Received: from bender.baylibre.local (wal59-h01-176-150-251-154.dsl.sta.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id q19sm16701186wra.89.2019.09.19.02.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 02:36:28 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     jbrunet@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] clk: meson: g12a: fixes for DVFS
Date:   Thu, 19 Sep 2019 11:36:24 +0200
Message-Id: <20190919093627.21245-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first serie of fixes for DVFS support on G12a:
- Patch 1 fixes a rebase issue where a CLK_SET_RATE_NO_REPARENT
  appeared on the wrong clock and a SET_RATE_PARENT went missing
- Patch 2 helps CCF use the right clock tree for the sub 1GHz clock range
- Patch 3 fixes an issue when we enter suspend with a non-SYS_PLL CPU clock,
  leading to a SYS_PLL never enabled again

Neil Armstrong (3):
  clk: meson: g12a: fix cpu clock rate setting
  clk: meson: g12a: set CLK_MUX_ROUND_CLOSEST on the cpu clock muxes
  clk: meson: clk-pll: always enable a critical PLL when setting the
    rate

 drivers/clk/meson/clk-pll.c |  2 +-
 drivers/clk/meson/g12a.c    | 13 +++++++++++--
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.22.0

