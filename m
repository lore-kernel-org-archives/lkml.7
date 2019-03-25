Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262C6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D12C72075C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Rqt6f9n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYO7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 10:59:20 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:33593 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbfCYO7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 10:59:20 -0400
Received: by mail-wr1-f51.google.com with SMTP id q1so10563931wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 07:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlkR8cS9veKc4DBkyJ0Dz8LYpBdCv0R0a/FSIyLYoHU=;
        b=Rqt6f9n5FrrAQkazqeHSi0rCZC9HpVSK3p0kWpMHiiPDs9MGUp1lV1TE/fYwJ74nUb
         rNz49iJKFIq1KWuLZQvQLXkvrbe2LVoMAfPnRb5a/ANkiq8Vio9tHy/mlIJ/kQ5ktFxG
         Rh8bHkiwsW0rJotMVPqiPhwWPE4F4FVzh/AhvEsnEHUZbN0PGDGCpBsup279t3cOQS7Z
         SBdPC99eycltCJBI3VK+hp1h0g1dkFkt8c27Ml3LIdlHlhfL2JN6XsV3cApRc1ALsecp
         gIf7KDrM5a7b2T0/IlLBJT/drXvaVirghgrPJKwbcOsO+OHdVD7CdhOi1t9ax+/0qAKJ
         pvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vlkR8cS9veKc4DBkyJ0Dz8LYpBdCv0R0a/FSIyLYoHU=;
        b=WiRLCu/aQfkuYuf6XUD2PSy/xt/R2Mfm7GuEnnuotS9nHABWqVBxnbQc8ujfXlbCZJ
         Cf4iVBULUgtV8UQS/HIGp6IkAPWNrjLn5S9bmI+XibCG9MXjF4YJqWg6rjp1K0vtTjj3
         /8vQNsWgKgf1AOO08SZM0bvhJ5EQBC6iNgNiVwMguFin5sKm6NTrSJlqi74pdqOq4129
         18DGkmWcyl2+6rma2BV9pJb0bXfmiKjdCerjvF4ARiau2HEnR2Dvh0oP4zUsknszL8+6
         D/JSvL/Q4BKbT7rVMmszTX6wNMA61Qg/dDLjjvNDpawNbbtqQq/o5uC49gcFUvFabUHr
         QOeQ==
X-Gm-Message-State: APjAAAVqvGzi1TYpOu7YxaNgv4Nmbr9PVfK6H/BXRrrnzpib6COSmzeW
        KfBruP4c1qeQpPufpcic8Fq61g==
X-Google-Smtp-Source: APXvYqwh0JeEjGa/4T+EwMcccP1D8+Rt9OYAbnAc45hn7AqWmP4FOEEZLIqbT0r4h90cmmY40rKjEw==
X-Received: by 2002:adf:e443:: with SMTP id t3mr17025185wrm.257.1553525957734;
        Mon, 25 Mar 2019 07:59:17 -0700 (PDT)
Received: from localhost.localdomain (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id d11sm12836156wmb.19.2019.03.25.07.59.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 25 Mar 2019 07:59:17 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] arm64: dts: meson-g12a: Add support for Video Display
Date:   Mon, 25 Mar 2019 15:59:09 +0100
Message-Id: <20190325145914.32391-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds nodes for Video Display support.

Dependencies :
- patch 1: VPU, HDMI & Power Controller bindings still in reviewe at [1]
- patch 2: None
- patch 3, 4, 5: Patch 1

[1] https://lkml.kernel.org/r/20190313141030.5958-1-narmstrong@baylibre.com

Neil Armstrong (5):
  arm64: dts: meson-g12a: Add VPU and HDMI related nodes
  arm64: dts: meson-g12a: Add AO-CEC-A nodes
  arm64: dts: meson-g12a-x96-max: Add support for Video Display
  arm64: dts: meson-g12a-sei510: Add support for Video Display
  arm64: dts: meson-g12a-u200: Add support for Video Display

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  46 ++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  47 ++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   |  47 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 149 ++++++++++++++++++
 4 files changed, 289 insertions(+)

-- 
2.21.0

