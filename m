Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7324DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4283020578
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 07:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yrmaLwf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408767AbfJXH4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 03:56:44 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53944 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733188AbfJXH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 03:56:43 -0400
Received: by mail-wm1-f68.google.com with SMTP id n7so799986wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 00:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=oU6wj2FUWdqzPOi39bBnAtmdgqZD7+qIfluWVGBoF2I=;
        b=yrmaLwf+gejOUkvGCLtJSy2R2bbsgjUCtMcTEEgROhyKOlp3N+wJT0xh6KXKxMXHxJ
         Kv+Q+FwvvKSIknihufoXJa5KY2oKlssIJruynw+cFfeyixWZjOtZ6/ZP+Qv9BMO4qwXl
         PLY4ggatP0tp0BzwoiklAHki+IiKx5p1Cbl8IHLtJSDdTe5OoBSx3p8GsJ/GSZBjMSwf
         iP6IVEMQYfFbwvBlaWWBnL2VfrNt0hkzEmwOsRZ0iE4Nqxm3jF/M0F5adlaL4YwVvGJe
         zWXxkisOLWgSAnCJjjFx3vM/448aJCnQy1CUouPYTx6ZMgoZWEhn6IO5kdJT6LUaF5no
         P1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=oU6wj2FUWdqzPOi39bBnAtmdgqZD7+qIfluWVGBoF2I=;
        b=CnK81aQdfq7Ylp64z6/vTmaV7+uxyvoO1mwBz94veB95Ta5BSlDw+gfgnWe1U8vknb
         gbubvG0j6DwEtOkKJBZfbE4ZP09yFUDhlS8BHtvV5lp/+u3mMWaYiTd+q7HhdRJ72VNX
         7WRXHVySG6+4FHV+UTV1jY+9xqggjltkFOFqnuE5aCz2LJxOlYsBTSamz+MAiPhifSxR
         10grShwh2eRUjUvXobuLMWJLeR4bgm2CUgvWuz+4wYZ5S7mqY+g+COM2U5usWHON2zVG
         yWMC/A/J8Ojg6PFO9Qg22aJtni8MYH5G0Er/g+eD6amBvrKYL9CG2JHgV4W0PriqLOTW
         Rjeg==
X-Gm-Message-State: APjAAAXsGoz33MvMGvhGCc98fnSWXeS7sjKC4pFxKRU+c1mpX0Hr6zEq
        iVwdLhoHCGFT/EC5yENLKxfiVtLxeA8=
X-Google-Smtp-Source: APXvYqzfvQ9q1FWBFb+f9zYFLxlRWeLKJpdgYrwLe7ptAGgnlRnVRokRmmneKTjrV540l0QK96C4sg==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr3840227wmk.25.1571903799863;
        Thu, 24 Oct 2019 00:56:39 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id o189sm521768wmo.23.2019.10.24.00.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 00:56:39 -0700 (PDT)
Date:   Thu, 24 Oct 2019 08:56:37 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD fixes for v5.4
Message-ID: <20191024075637.GH15843@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-fixes-5.4

for you to fetch changes up to 603d9299da32955d49995738541f750f2ae74839:

  mfd: mt6397: Fix probe after changing mt6397-core (2019-10-24 08:49:25 +0100)

----------------------------------------------------------------
- Bug Fixes
  - Fix broken support for BananaPi-r2

----------------------------------------------------------------
Frank Wunderlich (1):
      mfd: mt6397: Fix probe after changing mt6397-core

 drivers/mfd/mt6397-core.c | 64 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 24 deletions(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
