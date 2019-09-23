Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9169EC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6489720882
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BJ5LbRkd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437129AbfIWINy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:13:54 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37881 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406068AbfIWINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:13:54 -0400
Received: by mail-lf1-f65.google.com with SMTP id w67so9385067lff.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YP0Dty02K/PU7snWf9QCmnq9+d/+lpZCzmP6b7jH6B4=;
        b=BJ5LbRkdAmmWPoS4xoIHkGfseBJtqsTjDT8/SzOvXN4s2EcGhdbg44m+jOXBELIcM7
         4ANJ7E6jTSF9ZV6PoV9s6M/UvcK5qxO/EEGJRfM6MxvXh4CH8RQ83T9QQeE2spGj3wZG
         z1XbDZZvAk5dflfZlTdavY3SuAp8xmzsLydtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YP0Dty02K/PU7snWf9QCmnq9+d/+lpZCzmP6b7jH6B4=;
        b=i1TvRcX8rMM6UjAJtEWnZ6XvKh2fvnUIgm85IP+9yOLgjhM2SKU8yAxIwWFVw7n2Sz
         t0ivP95XA+BcO2e/StE+SLECicQvuS9tpak0LjZmhZGdkJdgraYcEQR+6W8rAlXVMr2f
         28+6WZs0RaTHDmbCNHNni5MjSpch4rhpaFUWRyiSkpT+he7ht/ErKx5nzPCa6XzEJo+2
         HEObBa5pjsKQzc8zjawQsgWVx4LNEuhi04lo7OBsnnCyL8fo34jHfnwVE0VfMy8hNDOX
         k0xPnu46846I1aJRjqPJRH72s/3xZlDvqPD0oAAXnHmp32DXSd+XXmAVQiFz6TH3+oe6
         elvQ==
X-Gm-Message-State: APjAAAX6O5Y6IT6O6t6nTOl6BVDyqxLCc20UXqGo9lny4iMt4TUuOzEV
        HkzKNsJRIz6KY9wuliD24hI3nw==
X-Google-Smtp-Source: APXvYqz1aK8MYGtYecVVxc/h+5tNAbQ8QHxsPIQq+G8SCQClVwWdZ7aqolsB4dTq+uFnHjerMW4hNQ==
X-Received: by 2002:a05:6512:4dd:: with SMTP id w29mr15905123lfq.2.1569226431814;
        Mon, 23 Sep 2019 01:13:51 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id c21sm2054946lff.61.2019.09.23.01.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 01:13:51 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/4] pwm: mxs: add support for setting polarity via DT
Date:   Mon, 23 Sep 2019 10:13:44 +0200
Message-Id: <20190923081348.6843-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for setting the polarity via DT to the
pwm-mxs driver.

The DT binding is updated, but I'm not touching the existing .dts or
.dtsi files - it seems that the same was done for bcm2835 in commits
46421d9d8e802e570dfa4d793a4938d2642ec7a7 and
8a88b2a2017d1e7e80db53080baff591fd454722, while
arch/arm/boot/dts/bcm283x.dtsi still has #pwm-cells = <2>.

Rasmus Villemoes (4):
  pwm: mxs: implement ->apply
  pwm: mxs: remove legacy methods
  pwm: mxs: add support for inverse polarity
  dt-bindings: pwm: mxs-pwm: Increase #pwm-cells

 .../devicetree/bindings/pwm/mxs-pwm.txt       |  4 +-
 drivers/pwm/pwm-mxs.c                         | 73 ++++++++-----------
 2 files changed, 34 insertions(+), 43 deletions(-)

-- 
2.20.1

