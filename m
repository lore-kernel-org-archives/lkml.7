Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14557C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7EF20657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="O6FAMfy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfEPPNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 11:13:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfEPPNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 11:13:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3so4043538wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 08:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izMGsuKh4OaKNtMmoPYzsuIZrqZf/ZhwaQ2KkK7m38Q=;
        b=O6FAMfy1E00D7rfyyVnNT++z7+nbL/ykgXcd19bJdjprVpRdB+G16c25hH3CCNc6W+
         2f/MiIs1l2FbyNBVpXESCwpqR7qXnF6Kym2i22WwkpehytRXPXfHRU9iREWYujFsUk5R
         NMgcqnF0fMSrxSQWVrZc+u3ysgPSoEQD1VwH8EmPByCrBRrT7tydB1KD6BtZR2OMmp+q
         e6NG1Bm3RXcnqejR21Uexr4xM8Kipef10MfzC2z1cS5HwnfN+wRMEzRFNv6VxsCYFQPi
         rFknz5FMBYzuuegBU3qlaGwwmro6WEVkPjtQRe/DntnM8H4pdBoLobalW+Y0CBRAhLIp
         ck9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=izMGsuKh4OaKNtMmoPYzsuIZrqZf/ZhwaQ2KkK7m38Q=;
        b=XNwCjesr5jYf/XBxPNsz/WogPW//a2yQALPKtLT5wYEQJZ1sIMN93g8gxRDsRDOkkU
         6QVQ1gohPe8HRrQzeWk9v/PCazokcD8UULRccIK3Di6VHZLmkNM7bkho+evqGJcquPtg
         nh+hVqQbz5+Cw6gGekcbNj/ZpQCcfvm6lfqImv4SNL0pxI6uui4WnchLoVo1yQQ7bbmR
         UeEWeHumCwaHjH6nMbno3U+PnE0pKU+a9IDB8q2vl6peLNAkgeMoYhoQSY/NpsxlLMOG
         emf/HRL4FaZQUbYhlTgmvA0AsEdL8NfHbm2af3PhM0loIwEOkdD7abYyIuQFbfaZLaYy
         Tj9g==
X-Gm-Message-State: APjAAAVL37BNhSZ0UQMJGT4xuzj/xnGuFs8O+NmTVyneikVK0yrGfoFA
        S+yisjvRKz2rJpBl5LYGzVeWog==
X-Google-Smtp-Source: APXvYqwDQ8utDUGlwEyZtxj0oqgawoWJGWIrLrB1I0n5YfrN5JX8T21Fx+9+r0xjGOfXvlvWk6uSow==
X-Received: by 2002:a1c:7a0d:: with SMTP id v13mr15628758wmc.44.1558019625939;
        Thu, 16 May 2019 08:13:45 -0700 (PDT)
Received: from boomer.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id 17sm6968126wrk.91.2019.05.16.08.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 08:13:45 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pinctrl: meson: pinconf output support
Date:   Thu, 16 May 2019 17:13:37 +0200
Message-Id: <20190516151339.25846-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds output support in the amlogic pinctrl driver.

Linus, this patchset is based on the drive strength series from Guillaume
which you just applied [0]

[0]: https://lkml.kernel.org/r/CACRpkdZ+p-J5Em3rzZcUwpA-a+CVOY91CgLqoRm_QVZP6E4Osw@mail.gmail.com

Jerome Brunet (2):
  dt-bindings: pinctrl: meson: add output support in pinconf
  pinctrl: meson: add output support in pinconf

 .../bindings/pinctrl/meson,pinctrl.txt        |  12 +-
 drivers/pinctrl/meson/pinctrl-meson.c         | 182 ++++++++++++------
 2 files changed, 136 insertions(+), 58 deletions(-)

-- 
2.20.1

