Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0CCC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E1320663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 20:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OerfV0sn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbfFXUbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 16:31:21 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44831 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfFXUbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 16:31:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id t7so7525750plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 13:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8eKR4sWGzU8LALqN+Rywpmmy+C9BMm/CB6qnIMC0UI=;
        b=OerfV0snZfWTKFe6g+LZSlNlk+hlaRZTYdkXi6xFzubIfsuYRqrR478es590r/uipG
         Za9cOfVOlS/Tx8biMdxBPavuRBtuFpD5DqsfSl4Frr5uGAgXHd9EfJPHv7PHPKGz5ykf
         Ha81o5GREDJwrbSfWGjsmCtO9Dqm7iWDvuM8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8eKR4sWGzU8LALqN+Rywpmmy+C9BMm/CB6qnIMC0UI=;
        b=uoAKWJcb8WpiY5Ure2YYXNAN7tes3Ez8IWkl1vK5kW//dHKujg6FsZHPGCM0lH4e59
         /y3Rpnt/C6bZKbJ+Zxuvig/lOXZ7PBIKHTZqd/jpcP4gg/ztVooIHf+e0nqdP6SNwqYm
         vwdKYrnKoxkdUk855dF2OkFvt3WNwOWXnbzl7nBc81wld06QwSYMUMnFeE9SqtSwJMLE
         QNlfP/0ogMIv0jZL1B6jRC3SrtN1F3I9JI+S6Px8Cs+LxuYMoZCf3v4SBssdT2O22jrm
         Ns+IsanpNSDG7d2hGq3aR5Gd9KJLDWX9y0tygZdPA5cSkwBuZzVZ6T3x2tmwNFlMn99U
         cUUQ==
X-Gm-Message-State: APjAAAWsWhXqftlg7mzRQ7T5sawE/+OOi5p8ta4X29s9yO46gJx/zOuF
        5Pcqn2J/T8emsWMsIIHDqBcIBA==
X-Google-Smtp-Source: APXvYqzBKihWAttr4Rykcb5BT7S4M6tWgTs4LN43nmmOkYIKYPwMKpzMISvKirmoiIp5hny8kMFQzQ==
X-Received: by 2002:a17:902:d916:: with SMTP id c22mr20031582plz.195.1561408280395;
        Mon, 24 Jun 2019 13:31:20 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id u128sm15650127pfu.26.2019.06.24.13.31.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:19 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 0/4] backlight: Expose brightness curve type through sysfs
Date:   Mon, 24 Jun 2019 13:31:09 -0700
Message-Id: <20190624203114.93277-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Backlight brightness curves can have different shapes. The two main
types are linear and non-linear curves. The human eye doesn't
perceive linearly increasing/decreasing brightness as linear (see
also 88ba95bedb79 "backlight: pwm_bl: Compute brightness of LED
linearly to human eye"), hence many backlights use non-linear (often
logarithmic) brightness curves. The type of curve is currently opaque
to userspace, so userspace often relies on more or less reliable
heuristics (like the number of brightness levels) to decide whether
to treat a backlight device as linear or non-linear.

Export the type of the brightness curve via a new sysfs attribute.

Matthias Kaehlcke (4):
  MAINTAINERS: Add entry for stable backlight sysfs ABI documentation
  backlight: Expose brightness curve type through sysfs
  backlight: pwm_bl: Set scale type for CIE 1931 curves
  backlight: pwm_bl: Set scale type for brightness curves specified in
    the DT

 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++
 MAINTAINERS                                   |  2 ++
 drivers/video/backlight/backlight.c           | 21 +++++++++++
 drivers/video/backlight/pwm_bl.c              | 35 ++++++++++++++++++-
 include/linux/backlight.h                     | 10 ++++++
 5 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
2.22.0.410.gd8fdbe21b5-goog

