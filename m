Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB3B6C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C48208CB
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 10:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="wqzma/Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfF1KDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 06:03:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51720 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbfF1KDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 06:03:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so8490106wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 03:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkIKqohD1pWyDDJZwRAR+FLcGS0BmuKJrepunlcK85k=;
        b=wqzma/SfPs0SNGTJrk5pSZ/CDzjE4TIsL1pUirIMru6Dd+k6VggDOtK8vTsC1hGLBl
         LkxecZDEuCSeCquLFAOPUsgoDKzm5faSmD1FnVCT7mAIophBAoibWoibsUUid8aXk7z1
         ReoaPn8iXq3u3x4tzSeci7yYCYibuOp7i9fH0JjNnW3tsNULnII/S3nTg5NJTPxm6n+L
         XQCn7bneeug8DsDsEwH6nFbR7aM+12R56vcL/hhU8Afv3LItBO/gwcnghPvcETXmMDOX
         reWrBAZ8fCMca+WmYEPAZ1tOiCj8kYRTNDsyKdttCYERhyT/eh212yuCPYf61oXc6OCd
         SFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tkIKqohD1pWyDDJZwRAR+FLcGS0BmuKJrepunlcK85k=;
        b=D+nyeGFjBJC8OHE+yue79hCEAAj97YG6Nc+CBaqS4+UqOL2ORYDdlAepvtUrl4EPOS
         fxGQp3uYm/WK+1zrzv13w2F5VIZjUqtE2d+w/Pzdrcz4hTmsPKRQ9TgY9aAezS37eAcr
         mNM77yqh/ffKKpKD6qTa2dc1nHs8PSV800ii5vuyjlfnXC9spH1KRbIXMvoxXytPkmCQ
         lcZp2HqyDA1p5859VnDSrlznFtMpDTopx7uWaOCh0P4FG5/hMAMjUgYi78pPW1lBvwcu
         YlsyunLzX5KJjinwE186ApFVY+F1BJsKtYilIwRqkSm8PCPa8QGQxjGuQ23ZGoAaAn4X
         OrbA==
X-Gm-Message-State: APjAAAU1WVcGY92CLB7A3fh/hKk2z7ivRZ564BH+u4WdQjKyzYheVACx
        TVwG3FL8ZTZjShFt0qLK4sNcEw==
X-Google-Smtp-Source: APXvYqwhcFL6tQPvDpqRgEZ6o9MP/TYJoYCPuvCjDURwYT5TSOIYtMdW/bnH9RbLDIM8UWBC5Gscrg==
X-Received: by 2002:a1c:a848:: with SMTP id r69mr6526253wme.12.1561716183015;
        Fri, 28 Jun 2019 03:03:03 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id l124sm1628874wmf.36.2019.06.28.03.03.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2019 03:03:02 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH RFT 0/4] backlight: gpio: simplify the driver
Date:   Fri, 28 Jun 2019 12:02:49 +0200
Message-Id: <20190628100253.8385-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

While working on my other series related to gpio-backlight[1] I noticed
that we could simplify the driver if we made the only user of platform
data use GPIO lookups and device properties. This series tries to do
that.

The first patch sets up all the required structures in the board file,
the second modifies the backlight driver, the third and fourth remove
the leftovers.

This series depends on the three first patches from [1].

I don't have access to this HW but hopefully this works. Only compile
tested.

[1] https://lkml.org/lkml/2019/6/25/900

Bartosz Golaszewski (4):
  sh: ecovec24: add additional properties to the backlight device
  backlight: gpio: simplify the platform data handling
  sh: ecovec24: don't set unused fields in platform data
  backlight: gpio: remove unused fields from platform data

 arch/sh/boards/mach-ecovec24/setup.c         | 33 ++++++++++----
 drivers/video/backlight/gpio_backlight.c     | 46 ++++++--------------
 include/linux/platform_data/gpio_backlight.h |  3 --
 3 files changed, 38 insertions(+), 44 deletions(-)

-- 
2.21.0

