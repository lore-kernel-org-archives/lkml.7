Return-Path: <SRS0=fBTF=VC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2CCC0650E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94598218A0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jul 2019 00:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="1qFgGu8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbfGEAXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 20:23:16 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41665 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfGEAXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 20:23:16 -0400
Received: by mail-lj1-f194.google.com with SMTP id 205so7526464ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 17:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=VPPNIsnCiYOFrVJf9Rqzbk9YAn/UwDR10urmS5284ZY=;
        b=1qFgGu8AKCcvVfLCHgMxX/ZFFDd8+NUM/DwcbP/GylIhipUGuKT5FYzOIZkpQoI9vb
         BspnDK3L6vNZpKBwYYPyc54XypHIfeBB+Otecd30Q7X5295sJnP06z+VV39EZI+MjvTI
         mCpx2V1HM1gEbmvVkNSF/QKWaivdjFmklyBJa/jOgp2IJDKfCWFt4p9pA074SFKcXvWH
         2bebRQQcvGtQQeSy8sJeHH9UJLaXEyBFiTydiMcVpUqwqSUaQJdVVn2ZM1yaFBfPgc1q
         KRZt/HiXF+rygfbMj3EBjyUmlfzCnOljHvLGpy/ZfWSQoUeOcHtiDmWPrs6xENcSelvb
         LhJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=VPPNIsnCiYOFrVJf9Rqzbk9YAn/UwDR10urmS5284ZY=;
        b=nKU4euoGQ8WYEbkBkbEqhbcka10CICNbkpHoPxuSeiP5Md/ekW/pRj5qfA/qi/JsBF
         XVzN70Nh18BNxU0lbJb2e90Z+sm3sCJjr4jcCTcfHfaAFAHeB/475s3Ka88gjI1SlsyU
         UtQ4DbDoJsGxhXnDzIsSoboglxuyBuDDjEmQptebIBEZxyowCh/J7gAystPeaDCLb30I
         BooW5jaPqJhm2cYLYvZJ/zgrgzYs2bfWNQEeo9vAECvMfFAeNsnDE19YmpS4CPSUPDsa
         2ORQokJc3PNoNC+TSxlO/vASaMFX7zbRNTHeY8r/az2zpkpP6Stwa3o5EJbkuWOnMl9d
         GiyA==
X-Gm-Message-State: APjAAAUodW1ful6EGneeIoXD3yPDWkQNJ0SQJeRkG8bMVh5uc55vCl9F
        Gu7FJ2d02ozWGhSs+hYayuCgOLmpOnW8Xg==
X-Google-Smtp-Source: APXvYqwySAztCQHYsMcjSnOPelLhcDoEog685HpVsGNkPE8gp1W66xxF9wsHGUfUfQSvlY9ftkHolQ==
X-Received: by 2002:a2e:9a10:: with SMTP id o16mr415852lji.95.1562286194001;
        Thu, 04 Jul 2019 17:23:14 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id 133sm1228902lfi.90.2019.07.04.17.23.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jul 2019 17:23:12 -0700 (PDT)
Date:   Thu, 4 Jul 2019 17:22:23 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     olof@lixom.net, arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        greg@linuxfoundation.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190705002223.wmc5ge5jszy4z6vc@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg,

The following changes since commit 6fbc7275c7a9ba97877050335f290341a1fd8dbf:

  Linux 5.2-rc7 (2019-06-30 11:25:36 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to 2659dc8d225c956b91d8a8e4ef05d91b2e985c02:

  Merge tag 'davinci-fixes-for-v5.2-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci into arm/fixes (2019-07-02 15:13:20 -0700)

----------------------------------------------------------------
ARM: SoC fixes

Likely our final small batch of fixes for 5.2:

 - Some fixes for USB on davinci, regressions were due to the recent
   conversion of the OCHI driver to use GPIO regulators

 - A fixup of kconfig dependencies for a TI irq controller

 - A switch of armada-38x to avoid dropped characters on uart, caused by
   switch of base inherited platform description earlier this year

----------------------------------------------------------------
Arnd Bergmann (1):
      soc: ti: fix irq-ti-sci link error

Bartosz Golaszewski (3):
      ARM: davinci: da830-evm: add missing regulator constraints for OHCI
      ARM: davinci: omapl138-hawk: add missing regulator constraints for OHCI
      ARM: davinci: da830-evm: fix GPIO lookup for OHCI

Joshua Scott (1):
      ARM: dts: armada-xp-98dx3236: Switch to armada-38x-uart serial node

Olof Johansson (2):
      Merge tag 'mvebu-fixes-5.2-2' of git://git.infradead.org/linux-mvebu into arm/fixes
      Merge tag 'davinci-fixes-for-v5.2-part2' of git://git.kernel.org/.../nsekhar/linux-davinci into arm/fixes

 arch/arm/boot/dts/armada-xp-98dx3236.dtsi   | 8 ++++++++
 arch/arm/mach-davinci/board-da830-evm.c     | 5 ++++-
 arch/arm/mach-davinci/board-omapl138-hawk.c | 3 +++
 drivers/soc/Makefile                        | 2 +-
 drivers/soc/ti/Kconfig                      | 4 ++--
 5 files changed, 18 insertions(+), 4 deletions(-)
