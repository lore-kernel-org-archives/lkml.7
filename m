Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571C0C4360F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A2BB2171F
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 16:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tt9+WuWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfCXQnj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 12:43:39 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33921 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 12:43:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id p10so7470180wrq.1;
        Sun, 24 Mar 2019 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2r38gJpfFe4P7HtoACDMN8D+Ed6JJt9Nux7ChLwiuk=;
        b=tt9+WuWlBUcM3VoHmNt/kZywyCPpRq7NpHMDQI2bYrXvGbUwk4Jdg/p4HU6mWcnQb8
         BIl099tfJO592uJMq/LbjsAy7m//DnLgHRFRWsQWMLuX8v56fXaXzVnRZqulYl7H00MX
         nzBRRwwYXNhUSvhVBOempMLaSSThHwum8FhF35XUWAQ6gjocFAA00Olto/DLWxP0ZPJI
         /2S/quGgmUSe9m7wC0dFCMEzfii9u+kebjs+FBwqfhdCC7raXKAiIkhrn5TfcZxs2mWT
         Tqk3AZoZ6FFd4Wrc/BtuP8K+gSPNkhIIJYZW7s7YS+eI21NBHnWJAER9JqSV6LXB6lEX
         hmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w2r38gJpfFe4P7HtoACDMN8D+Ed6JJt9Nux7ChLwiuk=;
        b=BEscDDQJHnHt/TUvnQHtkV1vYTPMKLIlZ1dDg8FGgEEgCwc6LbzUe8OzP0uv6KwFtS
         wOepwR6Yb8jZdYBj5fNP5rWuzXlXScs0Ag1Ixh2fZKaGGrLCWVTjo9g+PHvJHv7ogu+H
         Z4wJrY1yooBaJKMQyGM6+0TV1g7GjD/pnna3RqrYd4QpteOClIrxkhRVoDOmSEzRJWPK
         hBP1xP+Gm9K5iyTvTcPO2htHDCHlLA1yjFhGVUTcXnnyJLjG+QcLl2Q7+VZt2ffSpyTa
         1v+tIrCI9qZnOY7I02JqaG6kmPXyEN8SQge57zEcUKR62x6SBQjPQ32w8qjVy+AviS6D
         Wu6Q==
X-Gm-Message-State: APjAAAXj/K4VtSmDEK1XLQc5OLuoc0aWHCPbUxozQ0t3djGKy6ukDooS
        5e5R1ZDz1xPyvnI76Gw8K6kg7uHr
X-Google-Smtp-Source: APXvYqxi7MrEGPvI0xo3HHvxXE+5nclfglXNSMkgiW0axjGrWnZa8Vm3ska1+I89HKUOFX6JXH12bA==
X-Received: by 2002:adf:fbd2:: with SMTP id d18mr12858946wrs.55.1553445817321;
        Sun, 24 Mar 2019 09:43:37 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7399900428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d739:9900:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v16sm19042461wru.76.2019.03.24.09.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 09:43:36 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/1] clk: meson: fix PLL rate rounding
Date:   Sun, 24 Mar 2019 17:43:26 +0100
Message-Id: <20190324164327.22590-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

can you please look at this small fix? I discovered that my Odroid-C1
wasn't booting anymore. My other Meson8m2 board was using fine.

While investigating this I found that it hangs while setting the
sys_pll_dco rate. This is important because unlike Odroid-C1 my
Meson8m2 board has a fixed regulator (and thus always runs at a
fixed CPU speed).
It always hanged while trying to set a CPU frequency of 312MHz. This
can be achieved with:
  24MHz (xtal) * 52 (m) / 1 (n) / 4 (sys_pll)
However, my added debug logging showed that it was trying to set an
M value of 51, resulting in an output frequency of 306MHz. My debug
logs showed that meson_clk_get_pll_settings() considers 1248MHz
(which is the rate requested for sys_pll_dco for a CPU frequency of
 312MHz) "worse" than 1224MHz.

I'm not sure exactly why the bug caused the board to hang, but my
patch fixes it.

Please apply this to v5.1-rc as I believe the Odroid-C1 on kernelci
also suffers from this issue.


Martin Blumenstingl (1):
  clk: meson: pll: fix rounding and setting a rate that matches
    precisely

 drivers/clk/meson/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0

