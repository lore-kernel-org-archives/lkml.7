Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB55C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A160218A4
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 16:59:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgIkVRRx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfGCQ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 12:59:24 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40114 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 12:59:24 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so2772116eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 09:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5mSNxLATS4nQEbUbxPfPu5wUspYlM1yDTW4a7jFDycc=;
        b=RgIkVRRxLkHDrsI7hyi3rW5WRur6hxyeB7sdRlFXqBDC1W6hb/pT/g3KNLOu3B0Vlk
         ncCgt9g9dOgLwOTXMGkvwO33HG/Dz6qPpJtgg1nvKTyUTU6k3adu+0i49DLmlNtwCnu6
         bJ4GJSSvQQ8vVqy3cAZ7v9VgJ2b8z0sk4PFpW1ni6Lu3th/u1W/Thh96+YqlRK4sDHxj
         d+SHNvKdKVulQgYJ1BeyV5zwqERiHwiEFmncBzJdRnLH9qouWqMSy3AojjZpsBUe/y3J
         5a7xEiZh5OwbsGkqhWeASYjVGqJQ6u2o95F8h2LPcaUjM+Gk32RZzWC0C/yhj4s+NTjc
         WWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5mSNxLATS4nQEbUbxPfPu5wUspYlM1yDTW4a7jFDycc=;
        b=EfJH3S7Omx+gpxUM4YWrmhj3evFKh0Ea8kc5+k9Jc7A/GDJSvaGby0QsIIGe4eOGXc
         icwVt1xydNCb9ute/QfgdiQg3OAZSNOJh6PTnduM8rpREJ4oQtYNtQdGssSDWuiE6102
         6jBpBS6psNHPoI0SoV0RnpZ/Jil/8/pxoKuI+fLTp5LdHAFC2DaoOCc6FUezIGCL/dHG
         zQqXJj2546cefozw/Xvd6LyxNJ/B3DXo08KcuPkYClswEeBIaEMtR/4J6iU1GRTjngME
         n1O+acMrfuecR4WtJxiNnlZQLDOuJD1W1iLsFEDpR7y5cY0C2W28+xXeW6OfwYx3jhQI
         +tKA==
X-Gm-Message-State: APjAAAWOLohTt0xePRkonXkeCvmVcL2h3h8vTGjJNbpTNVivb0j4VOwY
        Gc/jV6blaoT7VhxMsRhKDJE=
X-Google-Smtp-Source: APXvYqzMf3IP4/2/QjuYmIqZ0fDoNNwVbtRACRF7Njtd+DAyvpK0yleGpOhTCIXVWMOlDdR3j+oIxw==
X-Received: by 2002:a17:906:7681:: with SMTP id o1mr18871298ejm.207.1562173162397;
        Wed, 03 Jul 2019 09:59:22 -0700 (PDT)
Received: from archlinux-epyc ([2a01:4f9:2b:2b15::2])
        by smtp.gmail.com with ESMTPSA id t13sm855465edd.13.2019.07.03.09.59.21
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 09:59:21 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:59:19 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Heiko Stuebner <heiko@sntech.de>, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Huckleberry <nhuck@google.com>
Subject: Re: [PATCH] soc: rockchip: work around clang warning
Message-ID: <20190703165919.GC118075@archlinux-epyc>
References: <20190703153112.2767411-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703153112.2767411-1-arnd@arndb.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
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

Nick recently mentioned that Nathan was working on a fix on the clang
side. It might be worth holding off on this to see if it can make it
into LLVM 9, which will branch in about two weeks and be released at
the end of August (according to llvm.org).

I don't feel strongly about it though so if this is going in:

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
