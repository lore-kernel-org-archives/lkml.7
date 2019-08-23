Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA31C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40222173E
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 15:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PG4XOJ29"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405948AbfHWPol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 11:44:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46604 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405927AbfHWPoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 11:44:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id z1so9032917wru.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 08:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94WrC/BBgFJ3B1KulaFSwiNtZR1yN0jFyWLE8Zon3I0=;
        b=PG4XOJ29ZJXkv/aI115bn6+yjvx6Pazp64dPnO+Zc60xH8oYL9GNUGM2NUSEslY8KR
         4zNar2bwmtBWE4T7J3eukHuW7BvmFFpjsFocpkP9oPdgFr+W0bnVIgNN6fQR7ZiNSmK7
         5x8qOo+Buv6mV+ibVqQ+y9Z0TVh0iV90pKp5eJZrBbHs5ugAkYi8QTYAGX0OtMV0ugjw
         cvCLTVzbsy724GH6e6BzoPyM5zU1CkDKhxqGVfZ+Lzk05XiY1bqJK25kvUoFtSuxspDl
         Hu6QfAgJB/FlSyoOYtSqaEGhMY6vHF//rr5FP0yCR6bbByNXcyjIMbg/tiEkcdz3sdgh
         FPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=94WrC/BBgFJ3B1KulaFSwiNtZR1yN0jFyWLE8Zon3I0=;
        b=Ry3fxHos1QGw2iQ8adGIMRRgNuZvB/X6JrjumJlboejWoU6QteAfHpqX8Xgv0+ciaY
         g2Eu48y66vlyLwMvT2nPPNMww5Aq/aCyVLBzzemRebdomFFMAoAubXVo4UQ4W5PlVYOE
         Fk+s2jaL3pAS7voMwrccxAz49Pes1+dbbO43ZfyVSvjoSGR+EhA07vrz4crOp/ETEtlg
         lUcGeNDLkr+hNRZ29rbORF2e5F66QPRZ/RT2xe6uX+aXbb5+1rhh1OXSQq02G1BimMey
         xHdXZH3g7BQJIVDS347/gyB9YPRXS7DmYUQva7h8XtA29EONjPO7YZ+UfbbKHg/T2QYP
         LURQ==
X-Gm-Message-State: APjAAAURxo56Ik75IIFZ0SOwYQjeNQs4BXYE1PQNW8hCgPOLpV1XRX+n
        tnEaczVi11tS7p0DQgIv/BNhmw==
X-Google-Smtp-Source: APXvYqwezDRfZb6B8c8Y1CQApWZ9F//On7ooLCRo4hwkX0NwPYIUHhbrpO8M8TY2AesSZdBr3W4hLQ==
X-Received: by 2002:adf:dbcd:: with SMTP id e13mr5804786wrj.314.1566575075858;
        Fri, 23 Aug 2019 08:44:35 -0700 (PDT)
Received: from starbuck.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v7sm3567342wrn.41.2019.08.23.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 08:44:35 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] ASoC: meson: axg-tdm-formatter: add g12a reset
Date:   Fri, 23 Aug 2019 17:44:30 +0200
Message-Id: <20190823154432.16268-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset add the possibility to provide a reset to the tdm formatter.
Such reset is available on the g12a SoC family and helps solve a random
channel output shift when using more than one output lane.

Changes since v1 [0]:
- Rebased on kevin's tree

[0]: https://lkml.kernel.org/r/20190820121551.18398-1-jbrunet@baylibre.com

Jerome Brunet (2):
  arm64: dts: meson: g12a: audio clock controller provides resets
  arm64: dts: meson: g12a: add reset to tdm formatters

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.21.0

