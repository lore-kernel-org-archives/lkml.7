Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B80C5B578
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D15712187F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 02:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="pnCXRsvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfGDCXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 22:23:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45733 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbfGDCXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 22:23:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id u10so3098133lfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 19:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+J4G3+w2a6rqwsRd6naD6kRP3PZ6p5YJ6mI8owInsUY=;
        b=pnCXRsvCD/RtzrcOSH9XKM3pNpuZOmeLWIatc8U7JlkVMu98m1tFHyX9W8gckaXPfe
         b17ruB40N/kd408MIOehV98cOnIGdS2i5T85oAKHFtbQungZe4RQZXnoR3DvdoUOY49T
         A8Qralpdl860WzVeFgeSpieoUbth90cEXEwDDfG2ufwTCrsWhxFOKEEtU/VdnRP/Ma1P
         crPt3nVPNZZP45KVGlF3FSxFbEvNPhhYU+4eKXQyZkt8EnoLeDvdkLNiM9WDsGZxLtVf
         vkQFJrmKD9kDeXJtME/5Hl5v6hn8fG8k5HTT33wk8Phx9tWBoUoQbHDcM06FR4ZmfGpB
         MiQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+J4G3+w2a6rqwsRd6naD6kRP3PZ6p5YJ6mI8owInsUY=;
        b=ewxbT6LiPVJCR1wuxFYNFA1tpvtlPbCzd2EQx3wfhwB8sGJIlA3snUHGGVaqqYHg1M
         6CewarYtlsAMKD7wZhr+DvsTu16TcHu5VKXbiDrDLuuGkHKWf3Rj/mYL7ZNA1ctHjl9a
         BgVqvFba0A0cbz2zdiHy8+De9prIZnB1gZILPBoog7HXks3ocayKgU06yKmAxLWVmJKf
         yY7jK9tIKOuwrraZg9v6UQFfFCyeOmtOBX6CDN4BVqRYiu17PP4Ge2TqP5HxNQFVnNsi
         yDYFHdzxKmUvooJtsFwzU8prLnJChJs5iUoFUgdv3f9rm8JtzQu3C5nEQmhpIi6UJhRC
         /G4w==
X-Gm-Message-State: APjAAAUDf/iV9uW3lnQoLAUfDOY1io70T44EUJ/RQ/fgqJNqblhU/f47
        uvI3W8OyXOemJD46wPslwfxYfA==
X-Google-Smtp-Source: APXvYqwF1IDr3Zsnm8ndisg8PoI+GaRFZUtCxu7aZqBri2om9izSF5ZXvmOqrvAsLWKwdQBn04FOlA==
X-Received: by 2002:ac2:4351:: with SMTP id o17mr297792lfl.100.1562206988730;
        Wed, 03 Jul 2019 19:23:08 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o11sm635357lfl.15.2019.07.03.19.23.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jul 2019 19:23:07 -0700 (PDT)
Date:   Wed, 3 Jul 2019 19:20:43 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] soc: rockchip: work around clang warning
Message-ID: <20190704022043.gwcwasi6jni2qctm@localhost>
References: <20190703153112.2767411-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703153112.2767411-1-arnd@arndb.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2019 at 05:30:59PM +0200, Arnd Bergmann wrote:
> clang emits a warning about a negative shift count for an
> unused part of a conditional constant expression:
> 
> drivers/soc/rockchip/pm_domains.c:795:21: error: shift count is negative [-Werror,-Wshift-count-negative]
>         [RK3328_PD_VIO]         = DOMAIN_RK3328(-1, 8, 8, false),
>                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/rockchip/pm_domains.c:129:2: note: expanded from macro 'DOMAIN_RK3328'
>         DOMAIN_M(pwr, pwr, req, (req) + 10, req, wakeup)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/soc/rockchip/pm_domains.c:105:33: note: expanded from macro 'DOMAIN_M'
>         .status_mask = (status >= 0) ? BIT(status) : 0, \
>                                        ^~~~~~~~~~~
> include/linux/bits.h:6:24: note: expanded from macro 'BIT'
> 
> This is a bug in clang that will be fixed in the future, but in order
> to build cleanly with clang-8, it would be helpful to shut up this
> warning. This file is the only instance reported by kernelci at the
> moment.
> 
> The best solution I could come up with is to move the BIT() usage
> out of the macro into the instantiation, so we can avoid using
> BIT(-1).
> 
> Link: https://bugs.llvm.org/show_bug.cgi?id=38789
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, queued under arm/drivers now.


-Olof
