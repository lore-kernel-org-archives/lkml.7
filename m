Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C05C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9821921479
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="iUgrk3Qa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389783AbfETNs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 09:48:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39405 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfETNs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 09:48:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id w8so14711346wrl.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2019 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5sKOK1wXsgSaMO1AzQH4iq23iqC6NhMcHG8RaO68BM=;
        b=iUgrk3QarzpnVXXJjcHmm8EhxkcUwGaGt8kISnK9TukpoyYGA7+gj8AGKI592kpAbv
         LyPCIgD2H5dlq+FoG9Ce5ipLy474xpJi/4kfx9XLzXhcxPSpOSwlmY8w0W0nMXz5S6kT
         BZAFlZd95pWjB0kW0tYRuWvewdK3ifBRR9y4NLWTmm7oOCzriFSzDyfhV6y0lkYr2yU+
         sYCyzVQ0jjL2GtVBj+Mweou+I/bWcxrsuI35/UlbSO4eaKe8VqjrWrLMfFM4aHnORKDB
         B9Amk9hvhTvaITAt/iyJ50t7NrS1mkx+ajlxpCef2Fja9ukBQ6Yq/REKl5GGW25Rnxxr
         OoaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s5sKOK1wXsgSaMO1AzQH4iq23iqC6NhMcHG8RaO68BM=;
        b=e441D8SOQXkwEPiID5YHRRzfQVj5L2oC5QbJzdGMJGfS5s8IvatU86yGLFucLtvVR+
         zrT+WQjB5eS0iqeUxNNKAh9lyJasRRG6xN1DbI8mdSWruf61R42hvMngxyvNInpmhto5
         YjNs4VcgeiScb5XIpGCauO1wDuPMeU15U1cfJ/cJozvmlQFeMh3pfTwMNHVDoOxROh83
         xZ9HuRXH8hyDwfKtisLypSh2xXqbUjg2WJ3M1wNADlBjY5lbX7jqnuBJ0NN276ZbCwn2
         d1nBQMIamXpaYgFhbmofIGemiJCAOC65K35tDme7vVV5zAUvmxi3sMqfmeyyDaEKyoba
         xKbg==
X-Gm-Message-State: APjAAAXsznqANzGqEIMb32cv40Jh14IIhZAFS8ikR7xEVldiRLLH5ZCF
        NL9v3fjHyrcqGmmdXAn/13bX9g==
X-Google-Smtp-Source: APXvYqyUg6TkbDAAE6FFRfEtGNn0nmbTyFrH10vqBkNAGgn7Q6SzWFWsN+E2yrFIvFJj5Lg9hdGZTg==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr34485340wro.253.1558360104707;
        Mon, 20 May 2019 06:48:24 -0700 (PDT)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h12sm12091358wre.14.2019.05.20.06.48.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 20 May 2019 06:48:24 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: dts: meson: g12a: add drive strength and hwrng
Date:   Mon, 20 May 2019 15:48:14 +0200
Message-Id: <20190520134817.25435-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds :
- drive strength for the HDMI DDC and Ethernet pads
- HWRNG node

Dependencies: 
- None

Neil Armstrong (3):
  arm64: dts: meson: g12a: add drive-strength hdmi ddc pins
  arm64: dts: meson: g12a: add drive strength for eth pins
  arm64: dts: meson: g12a: Add hwrng node

 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

-- 
2.21.0

