Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2ABBC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B9620693
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="B80Z/X2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfCRKFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:03 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35357 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbfCRKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id 81so4784519wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 03:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27Y5ngsXY+lsihk1ETnQLar+63BvZaw0mFMpXeArpvY=;
        b=B80Z/X2/OhJGEyQiwM93Sixm3fzLtf9aVez/If5suy/AeZlmgRz3knTeVHKZ0hmifn
         uFIeq3SpRdzAWnksCGLKxgQVVYuYxePJAqPow2lTnK7VBSYGYMq68Vp/xMqQZEyIC0BD
         EmGRlG+rZ+oZ2vmJ8YLCY8pMec0ZlEvpAHllrC9X5a1c2u4h3UOv8JjtSVauyqCPoQqc
         ekMBE58sXe6rHBiPLckORiVPiyjYJXq6/PXkd71O6HVynJW1qW8/D7L7IE5P2wHwaBOj
         eeDANqFtwTNwpr1a0h5X9/lfC0ZV4PaKlkpSS49dfTX6eM1rWg/b4zGmjwZuPoP3n8Q3
         64sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=27Y5ngsXY+lsihk1ETnQLar+63BvZaw0mFMpXeArpvY=;
        b=soi/0T9XntTRn7V8/6SbuSAoq3prVFC2weho4eUBnSyq6DpffpXeoz/pMH4WArf0wh
         NcU6m3+R3TUk2nFSH/2i/zQiH9lgNNMrw/tDgqKntb9XMu5AaJRCzKMAKFOn0aixwmDm
         DwzGPTfiM2lKEEwuII+bEPlgMSJ986ZU3CF5v+ATVK6m7wsXxaW4fA74P7NHVCBne43U
         i6wHecPEc06mtOxy2f8vZ0IJSWr1ShIdbH5/C5XCzpxQe6IdDr3Mnq5zMQuFkSNQLJJm
         JasI1QEm/s9//y7xO2gpE7VlKnxYRlm4VVOILzAEfdKlOEXXhByHLBrDvsSN2OcLClbJ
         JD/Q==
X-Gm-Message-State: APjAAAU5ghL2bIjS4+fln6W2vvuTKHiwmnU4RhgXts/LXkUNVATONAZI
        5ZKH4xo2XxZe/FDSNmZT9AYerg==
X-Google-Smtp-Source: APXvYqzlHNXFXd50DVNlShkPbZ6b+x68br8sgfnANKXJQv42B03K77AU3wruNW/4oPs1893XjXbaBA==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr11173953wmn.143.1552903500107;
        Mon, 18 Mar 2019 03:05:00 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id i11sm5216800wrp.40.2019.03.18.03.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Mar 2019 03:04:59 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 00/11] arm64: dts: g12a: Add boards peripherals
Date:   Mon, 18 Mar 2019 11:04:47 +0100
Message-Id: <20190318100458.5619-1-narmstrong@baylibre.com>
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

Changes since v1:
- Collected martin's reviewed-bys
- Added missing regulators in commit logs
- fixed x96 dc_in regulator
- fixed includes overall
- removed dwc2 enable floowing disabled remove in [1]

[1] https://lkml.kernel.org/r/20190318095851.4062-1-narmstrong@baylibre.com

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

 .../boot/dts/amlogic/meson-g12a-sei510.dts    | 94 +++++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-u200.dts      | 93 ++++++++++++++++++
 .../boot/dts/amlogic/meson-g12a-x96-max.dts   | 86 +++++++++++++++++
 3 files changed, 273 insertions(+)

-- 
2.20.1

