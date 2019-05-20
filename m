Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D698AC04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACB4F213F2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DabpozCT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbfETNOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:14:11 -0400
Received: from mail-wm1-f46.google.com ([209.85.128.46]:36711 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732294AbfETNOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:14:10 -0400
Received: by mail-wm1-f46.google.com with SMTP id j187so13010660wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vM5pv+BQoP8scy/zAPoM9eQQv0k4Qnfy+iC/Zx6yuYA=;
        b=DabpozCTljhiuQK9QrebXpccXYRwzclUP4vK0OAUbMnMu8Qi58I1NDibj54SEIzo9R
         SfnCaxEkMc1Uhdq6rWh/mtI+LMm7hE2XA2b/qc24IaNYdJxgiJ4inIINn/lNJFeQmbhT
         U6u861AXckob5AeViOuw7bdQpgi1gr/i0VUVEY9rWOr7l3JvW1TcI73XuF41euXOMweY
         oJiPBWWWrGDfUv2u/7sjvLfeb5dZv/gsC8joINdnsphCFGB1U95/yJ07bFAnyAhcsju+
         ydyhcwyD3O69Rhjdo4/s82FLSxIAeAmGk8mi3zLZfDKdtei4lYhuWo/B9QH1jRCblrzy
         R/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vM5pv+BQoP8scy/zAPoM9eQQv0k4Qnfy+iC/Zx6yuYA=;
        b=gbcac0t+1gZfldBI0j7Yi7EukkoqHmURHcJG+9A7HQjKJvgcxuPo+ziuu1e1LgUzQ7
         fOHeQUnk8nUPgjJCFEHgs56HP/CZePBQwsb6fcrnVNyhuY/gjPPz7yqxZB2lJ49wSWWf
         190hNjJw0h/uIRB49zeIOHbMdiiSASikspMrb+EBYFY0/X5CXwd8BY8FbrLA6qhNh05W
         PWJqES6Lns7bEKWJrjdFaoBFhDYu8+/ketczPdn0e9Gp8h/A1Z6+cVA78vMvavW9NYJL
         562Q9vdMzOIFZecLfDh5QfRo3h8IqiQ17IR8HjsBszqbRBNOkuA0YYwiP9jZegcbpyWf
         N8JA==
X-Gm-Message-State: APjAAAWU5rwVpfaUG8N1n2/MSkhdAOQeYJGeDXmbflw5N7Ubf44VeYSd
        W0Plv9zdD9xN81YRKPPLpX3iU/cmnqA=
X-Google-Smtp-Source: APXvYqw41vjWwxdNzZM0t2ysXvFl+JiMozP82cEPi/tn/xJK/zONQePg6F113T5Q7tayNsVVWoxfzw==
X-Received: by 2002:a1c:7d8e:: with SMTP id y136mr17488503wmc.129.1558358048365;
        Mon, 20 May 2019 06:14:08 -0700 (PDT)
Received: from boomer.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id z8sm18054284wrh.48.2019.05.20.06.14.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 May 2019 06:14:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: meson: g12a: add ethernet support
Date:   Mon, 20 May 2019 15:13:56 +0200
Message-Id: <20190520131401.11804-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add network support to the g12a SoC family

This is series is based on 5.2-rc1 and the patches I already sent last
week. If this is not convient for you, please let me know, I'll rebase.

Also, you will need to get the clk tag "clk-meson-5.3-1-fixes" (to get
the update MPLL50M id) from clk-meson [0].

Changes since v1: [1]
 * rebased on v5.2-rc1
 * s/eth_rmii_pins/eth_pins
 * fix MPLL50M typo

[0]: git://github.com/BayLibre/clk-meson.git
[1]: https://lkml.kernel.org/r/20190510164940.13496-1-jbrunet@baylibre.com

Jerome Brunet (5):
  arm64: dts: meson: g12a: add ethernet mac controller
  arm64: dts: meson: g12a: add ethernet pinctrl definitions
  arm64: dts: meson: g12a: add mdio multiplexer
  arm64: dts: meson: u200: add internal network
  arm64: dts: meson: sei510: add network support

 .../boot/dts/amlogic/meson-g12a-sei510.dts    |  7 ++
 .../boot/dts/amlogic/meson-g12a-u200.dts      |  7 ++
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi   | 90 +++++++++++++++++++
 3 files changed, 104 insertions(+)

-- 
2.20.1

