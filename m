Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DEEC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073B420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 19:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gy6E/NSd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfFMTnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 15:43:32 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43857 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbfFMTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 15:43:32 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so8553323plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/JBzTlaIRys/4FXlOVowrLaN7Y7ioCSg9apqikje/Y=;
        b=gy6E/NSdOlgf6LDqxXvrrdZaWN9fZiGtU2p+2qfuTU2RRFBgGSCkswaDXP5lnek7Gt
         gIVtAu43gayoXBKbFHeReMDQsGHMe0OrC+LStPfMP/aB3BLgPDlqHg6jhTl5BH7TWDvR
         ALcClNEmwV9FnItsyQwG8b7Eyniz5DLVJMvZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i/JBzTlaIRys/4FXlOVowrLaN7Y7ioCSg9apqikje/Y=;
        b=MDDmNNJqNSgxtS7bQhcZZ33oSO+FfxpF1ZAxWaaCCDVzFJYAWu4Y7ArjUEAQoUj5p9
         J35VkVTvsLxjJ3qY5aO0/FT/b8DbflilVSJVFQ3FE58q+8Ofo02q1aBM78NdGRG+kzDm
         jLoqkqSd8G9itUKcvHz9lVyKsg/FrqiqIsVsPo6Bes1NlR6OH922Vu9pQPTyWSXTZGQu
         yrsrEMhEVnGmxthlZKmDib51qYodjtVoa+rstlZz+QgQe6PZQZyJNHoH9vXA1BVhnSCf
         rAZ2GzIDyQb7iO1Gk704iV/WM1TsVl3NvI9CJgV5IXHvjyfe+sznMBrPmxilwN6wQ1E4
         nsbQ==
X-Gm-Message-State: APjAAAVc8/HwnWnwBhuhkz1Uqdj7Uhc+LT2D/6lbKL+I53aoc4acNolr
        2jNV8u3TF4jEWLbafwOnkKafGQ==
X-Google-Smtp-Source: APXvYqy985in01FdAKRYCWFmFh62RofTuNsQ+FVfIK1rCnkbbPytQd81yY4V9MCH3ohqvL1VEyDFfA==
X-Received: by 2002:a17:902:21:: with SMTP id 30mr88301989pla.302.1560455011492;
        Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f2sm498807pgs.83.2019.06.13.12.43.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:31 -0700 (PDT)
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
Subject: [PATCH 0/4] backlight: Expose brightness curve type through sysfs
Date:   Thu, 13 Jun 2019 12:43:22 -0700
Message-Id: <20190613194326.180889-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
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

 .../ABI/testing/sysfs-class-backlight         | 32 +++++++++++++++++++
 MAINTAINERS                                   |  2 ++
 drivers/video/backlight/backlight.c           | 22 +++++++++++++
 drivers/video/backlight/pwm_bl.c              | 30 ++++++++++++++++-
 include/linux/backlight.h                     | 10 ++++++
 5 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-backlight

-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

