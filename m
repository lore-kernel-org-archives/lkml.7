Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FD7C48BD3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6751216E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 02:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="gO9JdY7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfF0Cuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 22:50:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42711 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0Cuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 22:50:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id t28so658987lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 19:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=BTKCxnhTazrPesoHKDV4p8sRapqVbrsGw9bOncK6AZU=;
        b=gO9JdY7D9q0BkzIBQI9C0ktBuctOyqDjPah6J+45Rj43WFfPDhuCyeicU4enOUY7dm
         VuIyQqJxWnIaqzMkznyd2uO7XSahMortHR8YUaG7dOv+zCmmJ1Y5eauotob7cR/Fhb5L
         jFqiM8NrmAZAiUMZPgccGP9QABRsB2l3TGnhyfYqVFeObOsabYQoXlipLoE+C17oT6JQ
         4zvPZFUI4RneAwmz1DI/eqPpfh20xre5+hOY/hCX4s1JxzqgMEXwfBIZ6HSG2js3uXB6
         dLDFyLYu+Q5PLs40TzONI8rcJRjDLyJ5Iz7buRXtJbYjJcEzM+R2CEUAvHQKrpwPA0hj
         auyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=BTKCxnhTazrPesoHKDV4p8sRapqVbrsGw9bOncK6AZU=;
        b=E74gYjT8xKyjPWdNT3wSCYZpTwRt5raX/ReokjCYNK/Us6JdnjPl9XfQp/VkrQQjdq
         wKscgh4Fxt4E3tR6ijGLZr/FTbpDsgERklIE8QeDWHuR/UUAj12dOK8kSJVM4yBcuZET
         biGHN14M4mMO9METT56pA/eKRp38piU2qyHpmZJUjxy8Z0YymZZ6hJ6ZiuWMeY9loiq2
         mRR+TZiGlqH9XrwJ7TxwmHsxgDm4KWglpgn/XVNWT/vF+pHVMUdgBGdIKuXHkpvi/UIo
         M0dEucyWJQtxAGLbIb8gJ0HGVtQRixnDcY5wLs4h4NFTv0ZGK5dXsBg2aEm73/st30CC
         SlTA==
X-Gm-Message-State: APjAAAVW3y9NB7ZVJ9b1uUTgmYblw+elaMKtAffaCJe96ObmgsCZwvwY
        hOug9BrlT1tUHWLOzsqNFlp5Zg==
X-Google-Smtp-Source: APXvYqwhLURgl+MsgWvofjbyRiAKbfjz5hDylTAkGa/+UG0J4j7UGT0bxctq8zcKUe2fAy2VfDC4bg==
X-Received: by 2002:a2e:9198:: with SMTP id f24mr914481ljg.221.1561603838424;
        Wed, 26 Jun 2019 19:50:38 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id g68sm111896ljg.47.2019.06.26.19.50.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Jun 2019 19:50:37 -0700 (PDT)
Date:   Wed, 26 Jun 2019 19:45:08 -0700
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org, gregkh@linuxfoundation.org
Cc:     olof@lixom.net, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20190627024508.x5opgsq4tjk32m6j@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Greg,

The following changes since commit cd3967bee004bcbd142403698d658166fa618c9e:

  soc: ixp4xx: npe: Fix an IS_ERR() vs NULL check in probe (2019-06-18 06:47:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/armsoc-fixes

for you to fetch changes up to e73f65930f8880fafaccf2cc1e5c44272e9523ec:

  Merge tag 'imx-fixes-5.2-3' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into arm/fixes (2019-06-25 04:20:08 -0700)

----------------------------------------------------------------
ARM: SoC fixes

A smaller batch of fixes, nothing that stands out as risky or scary.

Mostly DTS tweaks for a few issues:
 - GPU fixlets for Meson
 - CPU idle fix for LS1028A
 - PWM interrupt fixes for i.MX6UL

Also, enable a driver (FSL_EDMA) on arm64 defconfig, and a warning and
two MAINTAINER tweaks.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: omap2: remove incorrect __init annotation

Florian Fainelli (2):
      MAINTAINERS: BCM2835: Add internal Broadcom mailing list
      MAINTAINERS: BCM53573: Add internal Broadcom mailing list

Li Yang (1):
      arm64: defconfig: Enable FSL_EDMA driver

Linus Walleij (2):
      ARM: dts: Blank D-Link DIR-685 console
      ARM: dts: gemini Fix up DNS-313 compatible string

Martin Blumenstingl (3):
      ARM: dts: meson8: fix GPU interrupts and drop an undocumented property
      ARM: dts: meson8b: drop undocumented property from the Mali GPU node
      ARM: dts: meson8b: fix the operating voltage of the Mali GPU

Olof Johansson (5):
      Merge tag 'imx-fixes-5.2-2' of git://git.kernel.org/.../shawnguo/linux into arm/fixes
      Merge tag 'gemini-dts-v5.2' of git://git.kernel.org/.../linusw/linux-nomadik into arm/fixes
      Merge tag 'arm-soc/for-5.3/maintainers' of https://github.com/Broadcom/stblinux into arm/fixes
      Merge tag 'amlogic-fixes' of https://git.kernel.org/.../khilman/linux-amlogic into arm/fixes
      Merge tag 'imx-fixes-5.2-3' of git://git.kernel.org/.../shawnguo/linux into arm/fixes

Ran Wang (1):
      arm64: dts: ls1028a: Fix CPU idle fail.

Sébastien Szymanski (1):
      ARM: dts: imx6ul: fix PWM[1-4] interrupts

 MAINTAINERS                                    |  2 ++
 arch/arm/boot/dts/gemini-dlink-dir-685.dts     |  2 +-
 arch/arm/boot/dts/gemini-dlink-dns-313.dts     |  2 +-
 arch/arm/boot/dts/imx6ul.dtsi                  |  8 ++++----
 arch/arm/boot/dts/meson8.dtsi                  |  5 ++---
 arch/arm/boot/dts/meson8b.dtsi                 | 11 +++++------
 arch/arm/mach-omap2/prm3xxx.c                  |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 18 +++++++++---------
 arch/arm64/configs/defconfig                   |  1 +
 9 files changed, 26 insertions(+), 25 deletions(-)
