Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280C1C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCC37222C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 05:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pgazz.com header.i=@pgazz.com header.b="T0Lhp//Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgACFpQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 00:45:16 -0500
Received: from box.opentheblackbox.net ([172.105.151.37]:46745 "EHLO
        box.opentheblackbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgACFpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 00:45:16 -0500
X-Greylist: delayed 512 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Jan 2020 00:45:16 EST
Received: from authenticated-user (box.opentheblackbox.net [172.105.151.37])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.opentheblackbox.net (Postfix) with ESMTPSA id 5B764428FA;
        Fri,  3 Jan 2020 00:36:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pgazz.com; s=mail;
        t=1578029804; bh=Ts8QAhkIUif8KCFZTtVhBKZBy2UKq0FvpO5yKxAIZGo=;
        h=Date:From:To:Cc:Subject:From;
        b=T0Lhp//Yo0y6Y+dQYPPsHCtTnayQyF25FXzgnyTsyWzEWGkkHN8cPhvCkGrSyfYBB
         1wZwY/t0GXsUbrYZnB47/wlwfJmwrPrAF9bW1gVTy7s0a5pVELAFcb9qW7yLNonMQJ
         /1AYSHkYavWWkvxdHTRfFnqOUDlimY3LNjJ7+eY+hakdSB8VurlGoQDh9FhuwrEouF
         OT1QAUtlLg7lLgbsQ4FLoy7kEE8B5JIE3celrH97h9LIznNGlshmLtyCCyW6f8G5Np
         QIc/V9HzIRvUgv17+cB4lNhiXfXK+jWPUdNrom6vdkCH1J5wSOjm5KgJ8gRFfE4BCG
         2jHW444eR2ONw==
Date:   Fri, 3 Jan 2020 00:36:42 -0500
From:   Paul Gazzillo <paul@pgazz.com>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Apparent Kconfig bug for Maxim 77650 driver
Message-ID: <20200103053642.yr7ynaqmi67z5hmk@dev.opentheblackbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems there is a Kconfig issue that causing a linking error for drivers/mfd/max77650.c.  It happens when CONFIG_MFD_MAX77650 is set (which controls drivers/mfd/max77650.c), but CONFIG_REGMAP_IRQ is not.  CONFIG_REMAP_IRQ controls drivers/base/regmap/regmap-irq.c, which has functions called by max77650.c.

In drivers/mfd/Kconfig, it looks like CONFIG_MFD_MAX77650 is meant to have "select CONFIG_REGMAP_IRQ" like several other configuration options from the same Kconfig file.

Steps to reproduce the bug for next-20191220 (also happens on other versions, e.g., v5.4.4):

  1. make allnoconfig  # using x86
  2. make menuconfig
    a. Enable device drivers->i2c support
    b. Enable device drivers->device tree and open firmware support
    c. Enable device drivers->multifunction devices->maxim MAX77650
  3. make  # should have a build error when linking vmlinux

This is the build error I get:

    ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
    max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_chip'
    ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_domain'
    make: *** [Makefile:1079: vmlinux] Error 1

Is this a real bug or am I doing something wrong?

Best,
Paul
