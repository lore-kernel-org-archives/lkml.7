Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15856C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23BE20880
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dOZVFsNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfDGTJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:09:59 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43529 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfDGTJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:09:59 -0400
Received: by mail-lf1-f66.google.com with SMTP id g7so7803146lfh.10;
        Sun, 07 Apr 2019 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=85TO9jPm+zhkWkApsGkRREUepYUPz1yNK3zyp+jiZCw=;
        b=dOZVFsNhNY5KEszIpu99U62A6GhoSsoCqGty0jSUc7/hxx+KPFeeYNLhAn5BAaYpK6
         4sb5/zUvlTPfdMFgSVT+QQ4SKRBYqptm6pmpLwAn7vzb7+pBqF9JA/ilMXL7KTY8uMfJ
         LY+9DldlSJ3dz72S/zy2aIL2hsAJ9w+gXb/dX9D5i5z0z6GSW799Rf0O5866qGVdIslX
         6MvXjChKMmCW+8Txg/MzSUdUnXDdrsFchKSVDJUVvOhcjyrg+H7C5BfNR/AvfXsa3Ir0
         d1vWP1gleO4K8ln0NO+CS0XZ2M0hoeF9hr2GroGDrP5422Yt4GcmwMZ64C2fFmNJbeYm
         AZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=85TO9jPm+zhkWkApsGkRREUepYUPz1yNK3zyp+jiZCw=;
        b=AltL0V1GtyDbFbpPBh5owwWNDfHuV6iZVt9A1CMDHHejoLa4AIxTd0Cyx0u8nlH6H8
         jjavU2WaCZYMyj5/bjxczgUn70tnIm2Tnxtjadg8c7l8QcH3oo2HwTNL0Ga5BYCeFQk5
         aFOOQBo7bQY0HShCz9uSoi8LGbGlSVOzifVZiMlRBW1FGK62m+HdD4qQTTJrrI/GFL9s
         yhFkXKAPh1GqTyB+FMMYx5qeMq4pdjP4ArzNMdS0sXyDcdW50PmPPawy8Rn0F2Hu9/Lf
         p5/ACTG0pHx0Q5nwTRN49eWc4vrxWxpajZ36ugMCh0lUjf7NVg5oURIfhJ4chPc4veTR
         f2Qw==
X-Gm-Message-State: APjAAAUlFwtDy2pEvfCfU84zmdeNLm41BShlphPuWcRyyBva15GV7g64
        cG89b0LzfWb8cJd6be9O3Wg=
X-Google-Smtp-Source: APXvYqy0cDhGth96jl4i+DhH0aYTEog/xD9MxPIxO9E8Dj0zWwo6+OawWT+e1NXAKk69bFtZCElSLA==
X-Received: by 2002:a19:2042:: with SMTP id g63mr651094lfg.56.1554664196864;
        Sun, 07 Apr 2019 12:09:56 -0700 (PDT)
Received: from myhost.home (bkw193.neoplus.adsl.tpnet.pl. [83.28.190.193])
        by smtp.gmail.com with ESMTPSA id q23sm5972356ljj.44.2019.04.07.12.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Apr 2019 12:09:56 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     lee.jones@linaro.org, tony@atomide.com
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        jacek.anaszewski@gmail.com
Subject: [GIT PULL v2] LM3532 backlight support improvements and relocation
Date:   Sun,  7 Apr 2019 21:09:51 +0200
Message-Id: <20190407190951.27288-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v1:

- synchronized DT label properties in DT bindings with what has been agreed
  for the patch "ARM: dts: omap4-droid4: Update backlight dt properties"

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/lm3532-driver-improvements

for you to fetch changes up to bc1b8492c764fea940fc66206047e37a7f8d77e1:

  leds: lm3532: Introduce the lm3532 LED driver (2019-04-07 20:45:49 +0200)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LM3532 backlight driver improvements and relocation
----------------------------------------------------------------
Dan Murphy (4):
      dt: lm3532: Add lm3532 dt doc and update ti_lmu doc
      ARM: dts: omap4-droid4: Update backlight dt properties
      mfd: ti-lmu: Remove LM3532 backlight driver references
      leds: lm3532: Introduce the lm3532 LED driver

 .../devicetree/bindings/leds/leds-lm3532.txt       | 101 +++
 Documentation/devicetree/bindings/mfd/ti-lmu.txt   |  20 -
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  27 +-
 drivers/leds/Kconfig                               |  10 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-lm3532.c                         | 683 +++++++++++++++++++++
 drivers/mfd/ti-lmu.c                               |  11 -
 include/linux/mfd/ti-lmu-register.h                |  44 --
 include/linux/mfd/ti-lmu.h                         |   1 -
 9 files changed, 813 insertions(+), 85 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3532.txt
 create mode 100644 drivers/leds/leds-lm3532.c
