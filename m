Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A4C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98B0206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 13:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrQONUcr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbfH0NVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 09:21:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35170 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0NVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 09:21:53 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so3038555wmg.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 06:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=obFwSc/FpOjmW+9yje348zW4diAo1uZm4O9QishbHJ0=;
        b=FrQONUcrCqqNTPTWGdKHISKS49AX4QptOVuW4vk+7fXNrmS6KXD/28r2LI+2UJPWlD
         y7jAtr8czlO3WaBMmbdC9vi+059re5hiL0tejjNMCAwBnQS66DT7aGxM5S/Xhlgj2dO0
         TktGRVVs8gfGrw8uMxnehWjb/1AlXsYugDoCbCUu2OopOt7OWdtmT1OoaYj8bLuScFD5
         +XS5oJDx1RXdsmIHQrWPEIQtaW5JbB78HP84y+bDHnQ4NoCXua99lQZEE6BMSWEtGFDh
         dkvZlVe82mkG0XvKvOYjktMPsS/5iDc3/2+Iyeo90s9EG4WOcyPdNr/TyqIFCfy917zg
         /GNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=obFwSc/FpOjmW+9yje348zW4diAo1uZm4O9QishbHJ0=;
        b=D/TLkEpP08p2o9zYXcJL2oS2YDlkdoeC+jXac5obX8oXzYdZpKGcgw6c99pfqD89qX
         dU6xVEBPWyP5RrZOF7ysii3dVfvcbEF7Vh8BhyY5xdUtfKqftVTpZ/BWPg8Zqqxg5wr/
         2Ro4WtN87/7p13nPbFGYw0DXSSD5y6Ay4ElftS93w/5aSJlwXcBOeV485IIdgLXJOuMx
         ufPHruIyW896h9Lm4fnZJSvhpdP0QMhri+ESvKV++5MHs5tRVp1FfMzIZDVFTUZIv52K
         sQErSUk5maDd3eDf6qekxWWekzfbDWuXpoi6vEEZMT5hoR/xrTIl3Rk80F7lwsWOBu+s
         nK2A==
X-Gm-Message-State: APjAAAUIEMs2wIWwc+BRQqHDG0stloJj6GKZqnS2UYycUm3XRLb+28NZ
        PsCjJ4UliW6aY5tz09vzWw/wtRWGtrgz2Q==
X-Google-Smtp-Source: APXvYqwpldRGbB4hgkQQGFXcX0VfbXizWqE1iux/lLp2h8dyXQVFaQnsXr6Fs3zF0UEp3MxZs8mQqA==
X-Received: by 2002:a1c:c1cd:: with SMTP id r196mr29685413wmf.127.1566912111039;
        Tue, 27 Aug 2019 06:21:51 -0700 (PDT)
Received: from dell ([2.27.35.174])
        by smtp.gmail.com with ESMTPSA id k6sm3602638wrg.0.2019.08.27.06.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Aug 2019 06:21:50 -0700 (PDT)
Date:   Tue, 27 Aug 2019 14:21:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.3
Message-ID: <20190827132149.GF4804@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

Enjoy!

The following changes since commit 5f9e832c137075045d15cd6899ab0505cfb2ca4b:

  Linus 5.3-rc1 (2019-07-21 14:05:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.3

for you to fetch changes up to 4d82fa67dd6b0e2635ae9dad44fbf3d747eca9ed:

  mfd: rk808: Make PM function declaration static (2019-08-27 13:33:21 +0100)

----------------------------------------------------------------
 - Bug Fixes
   - Identify potentially unused functions when !PM; rk808

----------------------------------------------------------------
Arnd Bergmann (1):
      mfd: rk808: Mark pm functions __maybe_unused

Lee Jones (1):
      mfd: rk808: Make PM function declaration static

 drivers/mfd/rk808.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
