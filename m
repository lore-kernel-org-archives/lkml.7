Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9F8C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3E020848
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="BC8Bsfal"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfEPVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 17:51:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34787 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfEPVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 17:51:12 -0400
Received: by mail-lf1-f66.google.com with SMTP id v18so3821732lfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TxsNy0d6Z0NEmyHjwLQqkeMvbekfex2o7Dex22q3rXc=;
        b=BC8BsfalvsLkHyig9Dht9Oshl6827AqjIKgf14GTPWRJ+gFcmG0B/lcDupYHDLnDm9
         FIagejSZDef52VTnIlw6cx4lLi/pclQyxNCrhSV/SIInc45kD+waIWwN4VKhb+0VKjqT
         gr4O8X0pSyS5BWiaMKDgyBq4tGfaaqo3w/Lh9Ta7rV2BMLkVbMLRMHq/PgY2Cv7DxI3T
         6Faq6HlJ+UJb9POBD8nbbsN8UwRY7EXqcYFpUAkSvddVoq6R1zkjgCEhzQ2qwPLkv1ol
         fSB/gfX/Lgyac3ZXjDSyVvQlIKI2ut/dENTvP7T/lrOwzuUlOI0uah1UVe8Hy7Mv7dma
         LOOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TxsNy0d6Z0NEmyHjwLQqkeMvbekfex2o7Dex22q3rXc=;
        b=rRnW7HvsTAViEbGsRtv3FEkagBhi+l+FGfcuE/9Ja95N1uuS9CxU5uOGb63aX541+8
         x0iX6ugQofUDfkPJwsZo1KO5EAxNrFA1T9aFCitxEBOCL9v7PG0EXm0CEqo17wr57k1A
         p65L2xlreMaNrN3ttKq0JM1YeuYPm/S8OLlNyQXOzcXcXygx0fibrTM/lR7DaTOvrJx2
         fWJkdB5sKlTCLJAf9QyqIZWP/JiPd7brah/fnI0A2hOEc2SzWgs/FBEibmHdeJ31Zb88
         L3mH2UDfq0WwshLXjFRafwYIYoTaDatf7pKmx90tZQq7Y+H00RMItpQKMeV/6Dol4tkK
         5hoA==
X-Gm-Message-State: APjAAAVLXMSOk1ue5gy3gbEE1HTHqWt9/EpaBlCFBQhRPnybGdYHiozI
        xq/A7vVeCtIbWgtDNZXGNd9OQw==
X-Google-Smtp-Source: APXvYqyUx/72N94IFhpw2E4+oVtCGmXZIOvsrpFHsbjII9Tz+5BOtbhb8EcJkKImevrUyRIje+YKdQ==
X-Received: by 2002:a19:5045:: with SMTP id z5mr26662060lfj.108.1558043470797;
        Thu, 16 May 2019 14:51:10 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id o124sm1174315lfe.92.2019.05.16.14.51.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 14:51:09 -0700 (PDT)
Date:   Thu, 16 May 2019 14:48:19 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Stefan Agner <stefan@agner.ch>, arnd@arndb.de, arm@kernel.org,
        linux@armlinux.org.uk, ard.biesheuvel@linaro.org,
        robin.murphy@arm.com, nicolas.pitre@linaro.org,
        f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kgene@kernel.org,
        krzk@kernel.org, robh@kernel.org, ssantosh@kernel.org,
        jason@lakedaemon.net, andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, marc.w.gonzalez@free.fr,
        mans@mansr.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] ARM: use arch_extension directive instead of arch
 argument
Message-ID: <20190516214819.dopw4eiumt6is46e@localhost>
References: <f48c245e7e2b432f6771a5f97ff9f4b5bedc5089.1554968922.git.stefan@agner.ch>
 <2f3d0fa7ba599f46960ad3e7419477fd@agner.ch>
 <20190424141217.GC8007@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424141217.GC8007@atomide.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 07:12:17AM -0700, Tony Lindgren wrote:
> * Stefan Agner <stefan@agner.ch> [190423 20:20]:
> > On 11.04.2019 09:54, Stefan Agner wrote:
> > > The LLVM Target parser currently does not allow to specify the security
> > > extension as part of -march (see also LLVM Bug 40186 [0]). When trying
> > > to use Clang with LLVM's integrated assembler, this leads to build
> > > errors such as this:
> > >   clang-8: error: the clang compiler does not support '-Wa,-march=armv7-a+sec'
> > > 
> > > Use ".arch_extension sec" to enable the security extension in a more
> > > portable fasion. Also make sure to use ".arch armv7-a" in case a v6/v7
> > > multi-platform kernel is being built.
> > > 
> > > Note that this is technically not exactly the same as the old code
> > > checked for availabilty of the security extension by calling as-instr.
> > > However, there are already other sites which use ".arch_extension sec"
> > > unconditionally, hence de-facto we need an assembler capable of
> > > ".arch_extension sec" already today (arch/arm/mm/proc-v7.S). The
> > > arch extension "sec" is available since binutils 2.21 according to
> > > its documentation [1].
> > > 
> > > [0] https://bugs.llvm.org/show_bug.cgi?id=40186
> > > [1] https://sourceware.org/binutils/docs-2.21/as/ARM-Options.html
> > > 
> > > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > > Acked-by: Mans Rullgard <mans@mansr.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > > Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > Arnd, Tony,
> > 
> > Patch 3 and 4 got merged by Gregory. I think the other two patches are
> > ready to be merged too. I think they should go in together to avoid
> > merge conflicts. Tony, if you agree, can you Ack patch 2 so they can get
> > merged through arm-soc?
> 
> Sure I just acked it for you.

Hi,

These came in right around when I did the last patches for this merge
window. I'll apply them once -rc1 is out for next release.


-Olof
