Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E13C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BDF205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ifE5fLK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732350AbfDDJhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:37:55 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:33916 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731781AbfDDJhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:37:54 -0400
Received: by mail-pl1-f173.google.com with SMTP id y6so902145plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=E9KiAh7iqeqfi5vdSR+7X//2Mmkd/Cv9Z4rVtgtGK4g=;
        b=ifE5fLK2awt3y5bwVCrSGM1XMlp8Bgs1lcasB1fMtXjklkD0wkWXEbIxARSAlhqwlB
         ViyVAWVY32GDF+ol+zfFRMAcTVwGVfQ945i0cvtMHcwHfgoy4YBYKilCVxezNSwyYMtn
         tgHw5vrYUq681TFBZEGnACO7cRkpj0iCk2iF8nR84YhS8bRWTok9BgEQ19ds8T9tYZYs
         fXGUJZfZ5OLlwBMKA8QMGPA/ZjenlsLUkIOtmkRWv2bnLqycgmWXtBEp52Qr1wuMlNw2
         9SUTalx1nS2WaEFVoijwyZo3ljIoSMyzm2jdAUqm7RHUkAzZI2jCTrRJpZNU5bl+KUDA
         tPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=E9KiAh7iqeqfi5vdSR+7X//2Mmkd/Cv9Z4rVtgtGK4g=;
        b=UuS1i6bh/P9dJ3LRm5USFK8ODVNc5uTUsg3IOdpY8COrMyCEIuPnqq9Ec7TW3PDugd
         XksD8OtWCqUgEgV2hB+DNCl2kcXZfifSOj/IGY8UCYL3W58bY4VTnk36wVgKhkLTCxMv
         jTSuAo5eYC3j9Za2UHFhlFGffQgYnSwnsjUMSBe3TtPrzZFMEXvnL3fHPlEOHCim7KDn
         73YEat8WYzTQzfqvJIXr19ghDb8cRe92jxjVEOFuKb+4Tgw78iFn0RHzLklzuh5tHQ5g
         pT7gcH/Wr1fcSr/YeQ8V086FsQLuTU3H3AFk4lJckPkv+yJU9p9f9lG8mKjvTc/xa7dF
         As8g==
X-Gm-Message-State: APjAAAU8ijmQb7+qMiMnsBh0jGRlZZzmGl+Pns+P88Q4qsh5PShv2UXV
        +cKP8yFKzTh3n7JaB5ipRklCBYAnfODH4Q==
X-Google-Smtp-Source: APXvYqyvTPrsCHVETZNIMjsU01fooOqs29wKtqAm2bOdsxp8nsW4G54ItBlkPVkiLecrJ7j54E7U0g==
X-Received: by 2002:a17:902:d68d:: with SMTP id v13mr5372787ply.55.1554370673325;
        Thu, 04 Apr 2019 02:37:53 -0700 (PDT)
Received: from dell ([147.50.13.10])
        by smtp.gmail.com with ESMTPSA id q80sm30985697pfa.66.2019.04.04.02.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 02:37:52 -0700 (PDT)
Date:   Thu, 4 Apr 2019 10:37:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.1
Message-ID: <20190404093747.GU6830@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Enjoy!

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-fixes-5.1

for you to fetch changes up to a05a2e7998ab1badcf80aed47b5313934fd131fa:

  mfd: sun6i-prcm: Allow to compile with COMPILE_TEST (2019-04-03 08:38:07 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Fix failed reads due to enabled IRQs when suspended; twl-core
   - Fix driver	registration when using	DT; sprd-sc27xx-spi
   - Fix `make allyesconfig` on	x86_64;	SUN6I_PRCM

----------------------------------------------------------------
Andreas Kemnade (1):
      mfd: twl-core: Disable IRQ while suspended

Baolin Wang (1):
      mfd: sc27xx: Use SoC compatible string for PMIC devices

Maxime Ripard (1):
      mfd: sun6i-prcm: Allow to compile with COMPILE_TEST

 drivers/mfd/Kconfig           |  2 +-
 drivers/mfd/sprd-sc27xx-spi.c | 42 +++++++++++++++++++++---------------------
 drivers/mfd/twl-core.c        | 23 +++++++++++++++++++++++
 3 files changed, 45 insertions(+), 22 deletions(-)
 
-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
