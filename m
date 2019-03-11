Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2263C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6A4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 09:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="1+gXhw+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfCKJ4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 05:56:19 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43866 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfCKJ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 05:56:19 -0400
Received: by mail-wr1-f44.google.com with SMTP id d17so4295672wre.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5odumMPqXsJ46+A7zdstiqux6E3Cw2T3fnx8yG9MXA=;
        b=1+gXhw+29l+0dSa+z3z7JYPFdgfOrGVsZDRLbi0tKX/1OSMbfD1UQ1mKD/pXxyNP/p
         Z87hgrqil/yfsLhYMw89JIFvZ2tBV2OpI18EzDNpINXwpCTgtwkGxcDIOqNRlrMF/HYv
         1yhmhTz715ShEmbAeAyQ986PjRvq+agKlPwqPMTOBcYMUSv3llQn1qRx3xfEJahogozP
         bQmB58oPOen4lET+Ac5x4yrZ7BvfuIwAX5QLBJBsMfNhi1YiqTbqW7W7BUuZuHwn1Zne
         qAXj6ITTZ8F9697EmyTBCwt3puxmEVn/ek7yXlIeV28mRM++2e97eJstRDbOJv0p8zQ6
         2AjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E5odumMPqXsJ46+A7zdstiqux6E3Cw2T3fnx8yG9MXA=;
        b=dT1ag3fxB1ruVuNeEnaFyqzSC4jZQQpjONCDzhocXAHekmX6j67Gcl2xblDe+bl4q2
         x3aKj1hgvGEV+j8Xv5WB5T+cUQS1kj0Jw0+157p0JwFuKJBE9EfabzFOS+SHqpq/HfcT
         vnQ1GPpQEXB1FlCjLwUEwnondkNsLsvD9B6jdj0bpunlPIKiZYJx/PEm2LjzG/Jy9UN5
         Hapjo6WAfbPbNtpy1m8twufzA8JYJq/RGiyZlfqRUVtS1qT1UJo/JPOWxK2CvNvEQae/
         pkdS+87wIa2tjR3xKvJRWxii7dRfLH4Ms3K/u3yYOSm8iSV7dC9BGRPLKhOaievoZ4y/
         mErg==
X-Gm-Message-State: APjAAAUyu9u0IOla+v+hTH9J7hIc8H+/GmBIrD+Qgp1R7MGoXG45WC23
        osI1+HCUMucAsunYcA5DaIuv9w==
X-Google-Smtp-Source: APXvYqxL0XcwZmofwI221hhIdt6O80Bqt79gm2QFbzYhqwx1hpUIU84Q8dJKd6XSOixysjSZV1KKCw==
X-Received: by 2002:adf:f690:: with SMTP id v16mr19993596wrp.139.1552298177009;
        Mon, 11 Mar 2019 02:56:17 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id e12sm4764737wrs.91.2019.03.11.02.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Mar 2019 02:56:16 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] arm64: dts: g12a: Add boards peripherals
Date:   Mon, 11 Mar 2019 10:56:02 +0100
Message-Id: <20190311095613.11371-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Following [1], add regulators, bluetooth, UART and ADC keys on :
- meson-g12a-x96-max
- meson-g12a-u200
- meson-g12a-sei510

[1] https://patchwork.kernel.org/cover/10843095/

Guillaume La Roque (1):
  arm64: dts: meson-g12a-x96-max: add regulators

Jerome Brunet (2):
  arm64: dts: meson-g12a-u200: add regulators
  arm64: dts: meson-g12a-sei510: add regulators

Neil Armstrong (8):
  arm64: dts: meson-g12a-u200: add uart_AO pinctrl
  arm64: dts: meson-g12a-sei510: add uart_AO pinctrl
  arm64: dts: meson-g12a-x96-max: add uart_AO pinctrl
  arm64: dts: meson-g12a-x96-max: Enable BT Module
  arm64: dts: meson-g12a-sei510: Add ADC Key and BT support
  arm64: dts: meson-g12a-sei510: Enable USB
  arm64: dts: meson-g12a-u200: Enable USB
  arm64: dts: meson-g12a-x96-max: Enable USB

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 97 +++++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 97 +++++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 88 +++++++++++++++++
 3 files changed, 282 insertions(+)

-- 
2.20.1

