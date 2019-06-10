Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F98C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785F920820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjIypT6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389792AbfFJMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 08:15:51 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54194 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388866AbfFJMPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 08:15:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id x15so8264694wmj.3;
        Mon, 10 Jun 2019 05:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=G/jDmCEBdW+KnNnzIkI5FBxnykVJAEM3IcCO6wGYvxQ=;
        b=VjIypT6jxNeDcP3wUSkxn+P8CxxAUuMUNzeZgTuyvcKeoibelkyyRwRwXo7aPfSjUQ
         Q3v7OyN788mNnJacP6rY+JqmUhSABKuQjwGSKgdSIgNdHLdpPQiG4rtmNU1t7N7IHcmK
         nKHcw+Tloj67CNuGvh8/mUeuS7GEic2+TdmmDjK8bjZkORCIZAYC6801bb8F1Mu/UT5F
         F6yBHxWkYxGdneJVZ1cb6xAm5yVDez2tj2BC1zOA4h+/f03ff6iaj0CskD8DSNOOZsL1
         I3zmkYmnRzyJg4TYipAau0Rqvbd2Mqn7JFZV+cg2TLmfJTOFkMY0MD4oDMOswXtX9aOg
         ZL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=G/jDmCEBdW+KnNnzIkI5FBxnykVJAEM3IcCO6wGYvxQ=;
        b=RZdlEbouOjBShWcbLGMIS7UrdSMVHlYqcwtOTgRGn2Cju9s/40u3Bi7t2Z/L9M8Tir
         1SLwc+UCOIVimZPNEdRGBrObGAJKFDHAMqdEAoqM5IBe3HGSHxltp9+WWKSkyK2+vlbb
         e2IkRYaJsRqokv3BgeOFSy8Bk0ItYDnsuB9EvkA5n/n6pCngpqnI15rPKVrFrysvvpW0
         9zouNwgPliafSNOcdnDGjWueG55IYtaJlZX1rXDS7q4Q52826XGM+zGTh81GvVFbWYYj
         Up9o76g4ZXGjfA1zdc+h44zsliTSc0SzGauEL6ECui6PHkH3Fu8ZD5kiDlLUzN319vcS
         V+3Q==
X-Gm-Message-State: APjAAAUpCGukWlJjRB0RY/s1BBXArdrTmBHWimLDhFZL9t8347yqoI9B
        0wR2QBZ/gQVW+EJ5erCj+so=
X-Google-Smtp-Source: APXvYqxAzpVPFjmvXHC7Dyyt0DOCvzn4V9dg6udoS70h922GjJQFGyHYQYvnE4PoiIh4fnOVv7NBJw==
X-Received: by 2002:a05:600c:228f:: with SMTP id 15mr14125457wmf.31.1560168949128;
        Mon, 10 Jun 2019 05:15:49 -0700 (PDT)
Received: from ryzen.lan (5-12-114-167.residential.rdsnet.ro. [5.12.114.167])
        by smtp.gmail.com with ESMTPSA id f21sm10385574wmb.2.2019.06.10.05.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Jun 2019 05:15:48 -0700 (PDT)
From:   Abel Vesa <abelvesa@gmail.com>
X-Google-Original-From: Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bai Ping <ping.bai@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Carlo Caione <ccaione@baylibre.com>
Subject: [RFC 0/2] Add workaround for core wake-up on IPI for i.MX8MQ
Date:   Mon, 10 Jun 2019 15:13:44 +0300
Message-Id: <20190610121346.15779-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another alternative for the RFC:
https://lkml.org/lkml/2019/3/27/545

This new workaround proposal is a little bit more hacky but more contained
since everything is done within the irq-imx-gpcv2 driver.

Basically, it 'hijacks' the registered gic_raise_softirq __smp_cross_call
handler and registers instead a wrapper which calls in the 'hijacked' 
handler, after that calling into EL3 which will take care of the actual
wake up. This time, instead of expanding the PSCI ABI, we use a new vendor SIP.

I also have the patches ready for TF-A but I'll hold on to them until I see if
this has a chance of getting in.

Abel Vesa (2):
  irqchip: irq-imx-gpcv2: Add workaround for i.MX8MQ ERR11171
  arm64: dts: imx8mq: Add idle states and gpcv2 wake_request broken
    property

 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 20 +++++++++++++++
 drivers/irqchip/irq-imx-gpcv2.c           | 42 +++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

-- 
2.7.4

