Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B7AC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003D220835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOEutLtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733033AbfDQRaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:30:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38788 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:30:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so33036470wro.5;
        Wed, 17 Apr 2019 10:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3SeWZ+i9DDtd32178f+nlVkYvxTLPywpBDUwe/6YRU=;
        b=cOEutLtmeZHAGoQzr0+KhdhbKVNsvCEIQusQMndgyRrRTqFjTLFLtLEGjiPMtpXrUv
         vhzFTFhA8vMqPZudbVDRZb+WfF6JK6XJ5Zw2WApvv/4R1N8dhmm/pPoHZaGSsKIPZunP
         RJN3xQ97dLpVeVdoqoQ0T0LdiSr8z8V8phGPiZSbLGLDt3cFWNAmg8b1J8SbcaStIim0
         /XfwY3/qQNU9hwMpx5IlUCz3AyiY5nBv0BCeMfiVXUJP0MdLNTYn7yr3LCUFsSfWKaXn
         WBXXoel+4Zjhg7L8BwEszdWIS0chk+P65/JuMGNowG+L0GW5Sqs9/WrCfjmb5Dez592p
         +LjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A3SeWZ+i9DDtd32178f+nlVkYvxTLPywpBDUwe/6YRU=;
        b=TMF6jAKQGh92X2SK2ER/wiV7ZjVP1KWuJ6hLCK84uZKsP3ZynnOXVd6KDJAV1rTVhD
         6g67gglJyTJ061wnNoMjj2TAnrcTlQhaX2jvX3KpF98fvmFJcSTBGPAWl/A703MkCrpk
         FWgmHhrV2ypcGAvYKwyR3y0tDmwk3N1NTksz4QxNbrGNIWKOrmkpdp1ghaqQ8pkknL9A
         hzSfz5AMeXbceo3P0kfvmZpWQ3HBRVScTE893S4Amcc81sW4APl5XKI757aI71Apq/Dv
         u5Gq2p6U7227wYPWLAQVJXZsuuim1/PqWC+1ctBvIUOJN5o+lFemp4PlAcB4iQMdLiTm
         eFoA==
X-Gm-Message-State: APjAAAUCn86ho7iMbvzSpa+5XBmpQXuexLo7qY6PkdsyWWVgvqCfeSWs
        4BT7QLT0SG+/KC7VDpOCjKSlRaS/XkM=
X-Google-Smtp-Source: APXvYqxcSiBFnXShwX61MMqIMALDFwX3abDFBveMBm3tRQjxMAktQ1jnpKFT7hAjCEwtWhxuPg/CBA==
X-Received: by 2002:a5d:570f:: with SMTP id a15mr2575789wrv.64.1555522217623;
        Wed, 17 Apr 2019 10:30:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::df7e:4a05])
        by smtp.gmail.com with ESMTPSA id c6sm2669306wmb.21.2019.04.17.10.30.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 10:30:15 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 0/8] Allwinner H6 Mali GPU support
Date:   Wed, 17 Apr 2019 19:30:23 +0200
Message-Id: <20190417173031.9920-1-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Allwinner H6 has a Mali-T720 MP2. The drivers are
out-of-tree so this series only introduce the dt-bindings.

The first patch is from Neil Amstrong and has been already
merged in linux-amlogic. It is required for this series.

The second patch is from Icenowy Zheng where I changed the
order has required by Rob Herring.
See: https://patchwork.kernel.org/patch/10699829/

Thanks,
Clement

Changes in v3 (Thanks to Maxime Ripard):
 - Reauthor Icenowy for her path

Changes in v2 (Thanks to Maxime Ripard):
 - Drop GPU OPP Table
 - Add clocks and clock-names in required

Clément Péron (6):
  dt-bindings: gpu: mali-midgard: Add h6 mali gpu compatible
  arm64: dts: allwinner: Add ARM Mali GPU node for H6
  arm64: dts: allwinner: Add mali GPU supply for Pine H64
  arm64: dts: allwinner: Add mali GPU supply for Beelink GS1
  arm64: dts: allwinner: Add mali GPU supply for OrangePi Boards
  arm64: dts: allwinner: Add mali GPU supply for OrangePi 3

Icenowy Zheng (1):
  dt-bindings: gpu: mali-midgard: Add bus clock bindings

Neil Armstrong (1):
  dt-bindings: gpu: mali-midgard: Add resets property

 .../bindings/gpu/arm,mali-midgard.txt         | 27 +++++++++++++++++++
 .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi-3.dts    |  5 ++++
 .../dts/allwinner/sun50i-h6-orangepi.dtsi     |  5 ++++
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts |  5 ++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 14 ++++++++++
 6 files changed, 61 insertions(+)

-- 
2.17.1

