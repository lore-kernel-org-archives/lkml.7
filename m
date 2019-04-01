Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158DBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7CBD20883
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="i4D/tL5q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfDASS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 14:18:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36167 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbfDASSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 14:18:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so478887wml.1;
        Mon, 01 Apr 2019 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPxzK2GdQ1iSLqc2nRqiVfQ9IIOMGO3nhp42wptShFQ=;
        b=i4D/tL5qroUQxRDoja6/T38ZQ1eDE7oy5qis+7kJKFxr4ZujVhvqPJp6g3UcwYbnTA
         +/h2aLwUZwZ43PbklZtHbprlxJ/0QXFWJbOvb0FuRwnFjqwUd8pMaGyfOVSRW/MF6pXY
         6/CqjElAgiSaLImCCbIUFuce3ZoD3hLN1wm3cpQalH12Qblt4EQQxm4+zszSXX9Efs2M
         ZIb1SIH6+zpNUn/c7MFzgxWk0BHsi14PKqcnr/FW8OYXDSdcBa+9yLwHt/lt6EEYmylr
         PNn5qz5tAOJ1YzUABqPuHsH/phEAX3Ah/h/0swLt1AfOdQXcqchitnGsWVo2AilDGGdK
         piDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wPxzK2GdQ1iSLqc2nRqiVfQ9IIOMGO3nhp42wptShFQ=;
        b=D6fyqI+7JpxphK3CJ3rZKrTyKZVm2oAEMCWWjv6+eSa+ONwxdHLRbugFlkVnb4riLt
         rWgnIBk1sFjIoSX5Dd0++58XmpcGtbWhBbAHMH6MpQqriFKGOW43MNdn9PW2d626YW/n
         O1301VmzUESqppZ6omLcuQpkDu0AM6S4sTYQzAm6Qm9uZiXpP5T9qpURkjTQEXYRlh4k
         OHler5cbBCo5q8DC2HK/vuMN3ZY3iVbdl5sUmpc8jImXcXj49rrTMRWMEFRa+joC7koQ
         h+b0Z8ov6Mwzln4vUVjBo9151FyUaKlRGlw8wwRe/Hmq4EIOAUEcxg9ogzNK/Zp9Qa2o
         WQaA==
X-Gm-Message-State: APjAAAWl3RTb38ueO82AqN4yBtfpFdGDoaI5x2UxaRvZwwZplovmvA9V
        7r3j6gTEpno6/Dxc8UvxHIazWY8e
X-Google-Smtp-Source: APXvYqzNpLiCRlP9dIEVJY3JYj1J3Z6w+JiM/GBgMYHtJwzZY9q++xRU2EdJh5eK6ExuZsg+TcvnFA==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr621786wmj.113.1554142703730;
        Mon, 01 Apr 2019 11:18:23 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD73A0800C9C8A7BE25478D36.dip0.t-ipconnect.de. [2003:dc:d73a:800:c9c8:a7be:2547:8d36])
        by smtp.googlemail.com with ESMTPSA id h10sm18131127wrs.27.2019.04.01.11.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2019 11:18:23 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, jbrunet@baylibre.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        u.kleine-koenig@pengutronix.de, bichao.zheng@amlogic.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] pwm: meson: two small bug-fixes
Date:   Mon,  1 Apr 2019 20:18:15 +0200
Message-Id: <20190401181817.11999-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series applies on top of my other fix "pwm: meson: fix scheduling
while atomic issue" from [0]

The first patch fixes an issue where the maximum possible pre-divider
(128) could not be used because there was an off-by-one error in the
code. I discovered this while testing with the longest supported period
(349514407ns) when running from XTAL. This is verified to work on my
Meson8b Odroid-C1 board using "pwm_b" on GPIOX_11.

The second patch was suggested by Uwe Kleine-König but was actually
implemented much earlier (back in mid 2018) by Bichao Zheng from
Amlogic. This patch fixes changing the duty cycle by relying on the
hardware to re-start the PWM output (instead of adding an artificial
"constant LOW" of about 20ms - as measured by Bichao Zheng when
stopping and re-starting the PWM output from within the driver). I
tested this fix on my Meson8b Odroid-C1 board which uses a PWM driven
CPU regulator (DVFS with all supported OPPs is still working fine for
me, although I couldn't observe any issues before this patch).

I also have some code-improvements queued which I'll send in the next
days, see [1]


[0] https://patchwork.kernel.org/cover/10880419/
[1] https://github.com/xdarklight/linux/commits/meson-pwm-for-5.2-v1


Bichao Zheng (1):
  pwm: meson: don't disable pwm when setting duty repeatedly

Martin Blumenstingl (1):
  pwm: meson: consider 128 a valid pre-divider

 drivers/pwm/pwm-meson.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

-- 
2.21.0

