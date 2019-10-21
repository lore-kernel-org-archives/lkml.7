Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3322CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2122084B
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 14:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DL30plNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbfJUO3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 10:29:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbfJUO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 10:29:08 -0400
Received: by mail-wm1-f65.google.com with SMTP id f22so13038788wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 07:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++nYVU89w3D5DbGVf7UyY/WEEIeVtVLvhLaDHuQ9xMw=;
        b=DL30plNJoZ8YTRsPpIAOPgjMpjklyJGezkImhXfCfSZos1P4txGs18b3h6ApC7to+W
         BAgzrOE2Ip8/k1EqE1oKz1dp6dEMinAQypFmo6DKIj07DPfZMYwET/zJOQeItodlPbpC
         sRXI+omm3jVR8uL/9vC63hITA5j9cwZwfWtF81jSU1DPe4JRxa+LLquiHLNjDLotatOe
         PjnLksvMZrhcWnWtN3wnhfGRYMDiEZ1nJ7w3UA18WZhDym3PzKO4RmZIo36fy2R+YPxm
         QUjR7T6kE4vUueAXdB7E9pgpcQUf4UoqIHj78X0KZEj7M2WJFD7wyg6Ct+JDLM37Fmfn
         +n0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++nYVU89w3D5DbGVf7UyY/WEEIeVtVLvhLaDHuQ9xMw=;
        b=Od0euRCUU89642tDTRLLq/BGiBkiYmlCc6ynzlCEjijVujq921XzRUVTwerRl2CiyC
         iLT8y5AkvZo1Ck+allL9rid0yJbULYWWKbhstxgUA0oV9XhGYKfmPDVg/IIRDuLsh/GA
         dYq58Tu6xUfWCyectvigOkltIAUTH0EUb+Jp2VTeL+0+mrzEVLoC585Q9d9gAtsqo/dR
         73M2xSfmc7S8Sa3aCDPC1oOHBj6ArEEVQnaBcK9dfn6wbZtnoQ4D7MpKDiOq7UIJS9hS
         eJYSpgAvKhQP3QitcHjFK98OzK6285A2ivHtObX+vAkvQMgHwFGgf14zeUetnToNENq5
         R74A==
X-Gm-Message-State: APjAAAVpXosOQrOF1gUl/MDMJbKqIx9cGVacORuu/Jzk7pbXq4ZIFOa9
        A8pfiRZ+UWY5kSlYmj1qhyL1n7J5nlOFbQ==
X-Google-Smtp-Source: APXvYqxGkfu1beg6QQFKdXREUIGmgpSBRX5EoWUQK13HNfHKFmR5o2KsWBUYgn1oNa0KJmVl282MJg==
X-Received: by 2002:a1c:cc18:: with SMTP id h24mr20430362wmb.40.1571668145775;
        Mon, 21 Oct 2019 07:29:05 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id d11sm17304463wrf.80.2019.10.21.07.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 07:29:05 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/5] arm64: dts: meson: new fixes following YAML bindings schemas conversion
Date:   Mon, 21 Oct 2019 16:28:59 +0200
Message-Id: <20191021142904.12401-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the first set of DT fixes following the first YAML bindings conversion
at [1], [2], [3] and [4] and v5.4-rc1 bindings changes.

These are only cosmetic changes, and should not break drivers implementation
following the bindings.

[1] https://patchwork.kernel.org/patch/11202077/
[2] https://patchwork.kernel.org/patch/11202183/
[3] https://patchwork.kernel.org/patch/11202207/
[4] https://patchwork.kernel.org/patch/11202265/

Neil Armstrong (5):
  arm64: dts: meson-g12a: fix gpu irq order
  arm64: dts: meson-gxm: fix gpu irq order
  arm64: dts: meson-g12b-odroid-n2: add missing amlogic,s922x compatible
  arm64: dts: meson-gx: cec node should be disabled by default
  arm64: dts: meson-gx: fix i2c compatible

 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi    | 6 +++---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi            | 9 +++++----
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi           | 6 +++---
 4 files changed, 12 insertions(+), 11 deletions(-)

-- 
2.22.0

