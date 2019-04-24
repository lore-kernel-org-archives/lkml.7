Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ACAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE9392175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 19:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGLX0b8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388393AbfDXTeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 15:34:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46640 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfDXTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 15:34:20 -0400
Received: by mail-wr1-f67.google.com with SMTP id t17so26703327wrw.13;
        Wed, 24 Apr 2019 12:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1cF8fAhckqCQeBof+LDZOSyFffHGWYmYM1KYpMOwxdg=;
        b=sGLX0b8OEmpqoxNbr/K+6RQtsVoDuvnmCtdlBIqGdVMZ2f1SloPZprDem5tNH2djpL
         meXqaCWNPwUnh4krk0PSh1ocVdeNLX9Umdz1LrMRVSisDFKSLz0i6WkIo4Cdy++YIndQ
         QdajAmu61r3dTb4YC1jWgqUfNLttXAWMv7+VP3d1rLDz4jJ2TV8UXpUih2jui1XFKezc
         5PhSyvOKmA1fFSyt+B5tggjAmX0B6gh35e5RkukmUAQcPQcXfi8MSRvppQxKgE5c9XGy
         C+9m7moe2ygd/8buyFKgfo22Kr2pvKnFayOfOW2LqNBpbrx7yMwR+toYUIK6vJ58CIm+
         oODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1cF8fAhckqCQeBof+LDZOSyFffHGWYmYM1KYpMOwxdg=;
        b=S/Z7FsyjkKllBat93wI3GQyvoipBLKfj3HJ/dwQV2bqJ7OVIPls/z76XhRZ+IEHg1X
         fZJwyAx5kx6jaW8Oahk8yZB2olX/Q4MVItzcLKAuB44W1gDJ08cRtZAYAXQkQJ7EGEmZ
         Zpm5mu33+gypajr35opPJK90G3986k2yqyev/B/YeJHe/YLIGgiFI2OjAW/EEyslNUGd
         z3+cpk9E9krK/ZeROU6DXwmTvBIcKK8A8gu+XwoHwYBxMC2dgcs7msSw1AcTGup7G3NB
         ldR1zt8jHjuC9TXQa4K/k2R3q16igkGmqjOw32ijcIRfIE/Gcyv6SfZqtBTRVkBR/0nD
         QB6Q==
X-Gm-Message-State: APjAAAU7+HfrLC9W7bheZr/mUpaZjECPs54Cb1m8M6yYQ4slnSnGNPkq
        ieyEVygOVqTh5wM2p0UqmxA=
X-Google-Smtp-Source: APXvYqw8g1obnBiKQlgqkBfL0g94zAfBKlFMw0mO2YaMAwox22etxdYSNT/GyaaTbsiQyGm/Ryxt5A==
X-Received: by 2002:a5d:62cf:: with SMTP id o15mr1310611wrv.45.1556134458597;
        Wed, 24 Apr 2019 12:34:18 -0700 (PDT)
Received: from myhost.home (bkw231.neoplus.adsl.tpnet.pl. [83.28.190.231])
        by smtp.gmail.com with ESMTPSA id c2sm18088776wrr.13.2019.04.24.12.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 12:34:17 -0700 (PDT)
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        dmurphy@ti.com, jacek.anaszewski@gmail.com
Subject: [GIT PULL] LED update for 5.1-rc7
Date:   Wed, 24 Apr 2019 21:34:13 +0200
Message-Id: <20190424193413.8135-1-jacek.anaszewski@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull LED update for 5.1-rc7.

There is a single change to MAINTAINERS.

We announce a new LED reviewer - Dan Murphy.

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/j.anaszewski/linux-leds.git tags/leds-for-5.1-rc7

for you to fetch changes up to 52fb56f7b5a9cc23a07b2c237bad91180263a492:

  MAINTAINERS: LEDs: Add designated reviewer for LED subsystem (2019-04-24 21:07:18 +0200)

Thanks,
Jacek Anaszewski

----------------------------------------------------------------
LED update for 5.1-rc7.
----------------------------------------------------------------
Dan Murphy (1):
      MAINTAINERS: LEDs: Add designated reviewer for LED subsystem

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)
