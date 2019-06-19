Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEE1C31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1257E2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 17:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="Wd86yREJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730194AbfFSRfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 13:35:04 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46484 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfFSRfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 13:35:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id v24so4045421ljg.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=htP0r9H4Ug/hMWstSFNELmZ5mjTD+8H5I4sHYA1uA1o=;
        b=Wd86yREJsjvOnqdXLgJP1v+h2vrhJ2IEHn0raqMpzzpFi0uO59iXALOtxzAk/IQwmR
         Plu1ZW/HIz385hiVY+P4EFqoEdXf6Ek73vu+zYzBuIF2JcNb/03Qxq7LGLjPwS/HA6B6
         SBfNZha08W1x1Yl3dx65ddk8DyU5kyfqyDx575BK8uBjnhd6HkF8nbHntQqYRUEFGIPx
         zuusCCdrtWF9ZCW50WSd08ikGjrjIxiyU/L0qVnzrfV6fJYXUHvkpq4WBpdyVD7bMRd1
         XyQlq0hlq0Sp0uGDI+IAToaJKpAGraaH7sMFr0YM1WEaVgLsNTsXEqrxgK5vpbZvbzb1
         tgJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=htP0r9H4Ug/hMWstSFNELmZ5mjTD+8H5I4sHYA1uA1o=;
        b=hmNegtSZ8Hd5zSzsSNSfiVv3APVPl7gJMdJpDSF92MXU43Q/Lw1Ko4QSgM5kRY+Qh6
         qplD90TfGXDPP2FUStT6/DHJ4E50UcXREIODkJn685bzwdNlu3L/Bo/lpYwRe0D9R1BD
         ZY1NiBtuW8njBMCtRfxc/rELJH+mlbPrg4hjBGtON8lumdZCLkfQHCz6i4TAjWbVUR0K
         Up6DevWfqwUklBM7vWvrbHhNgyrasJZNbXEov8WslAxZXQ6bGEkp5a5EqssY3Fzr4fmX
         kwSOLwpklzSJESHk2VL2gr4O0ET0txNIgYhYLA/sdD9H6ic6Sljr14Np6rL0J9zUjJjN
         FtAA==
X-Gm-Message-State: APjAAAXLEhYhszws2jJpnIdTI1nLWKX15Y8TgKA/Btfxh0rM85fd2v+k
        Y1gmMoNoQpNGZoDkoaJXblsKQw==
X-Google-Smtp-Source: APXvYqx5vPzt9fwBNRIGVD3LR7cVv7o1RMylfxjY+n7FD0xWq4OCme9GFyKfPKlPT67lSrCDBhMvGQ==
X-Received: by 2002:a2e:29d:: with SMTP id y29mr57904265lje.134.1560965702770;
        Wed, 19 Jun 2019 10:35:02 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id v2sm2773214lfi.52.2019.06.19.10.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Jun 2019 10:35:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 10:33:54 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arm@kernel.org, linux@armlinux.org.uk, arnd@arndb.de,
        ard.biesheuvel@linaro.org, robin.murphy@arm.com, nico@fluxnic.net,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, tony@atomide.com,
        marc.w.gonzalez@free.fr, mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] ARM: use arch_extension directive instead of arch
 argument
Message-ID: <20190619173354.z5znqao6iveoffc7@localhost>
References: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0ca465daa7c7663c19b0bcb848c70e8da22baff.1558996564.git.stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:40:50AM +0200, Stefan Agner wrote:
> The LLVM Target parser currently does not allow to specify the security
> extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> to use Clang with LLVM's integrated assembler, this leads to build
> errors such as this:
>   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
> 
> Use ".arch_extension sec" to enable the security extension in a more
> portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
> multi-platform kernel is being built.
> 
> Note that this is technically not exactly the same as the old code
> checked for availabilty of the security extension by calling as-instr.
> However, there are already other sites which use ".arch_extension sec"
> unconditionally, hence de-facto we need an assembler capable of
> ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> arch extension "sec" is available since binutils 2.21 according to
> its documentation [1].
> 
> [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
> Changes since v1:
> - Explicitly specify assembler architecture as armv7-a to avoid
>   build issues when bulding v6/v7 multi arch kernel.
> 
> Changes since v2:
> - Add armv7-a also in mach-tango
> - Move .arch armv7-a outside of ifdef'ed area in sleep44xx.S
>   to make the kernel compile also without CONFIG_SMP/PM.
> 
> Changes since v3:
> - Rebase on top of v5.2-rc2

Thanks, applied to arm/soc.


-Olof
