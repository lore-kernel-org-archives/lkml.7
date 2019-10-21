Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9265CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDDD206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PW548Q7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfJULxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:53:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52951 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfJULxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:53:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id r19so13002325wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gt1pw+YVWT7/dtSjPazx4KZ8zuAkMJu/EEZtr/YppJ4=;
        b=PW548Q7S1ucxAGLAirhRIThSR6vhXeyQlJt/1GkEJqhFhb+x1wmN2Somtz0kPsilLJ
         GRv9wI2ob5s2YFWXIfeekILmnLr8SAfxd3Pi5nCIsCTg/Wy4nVxz/LuqqK9Qck4qtAhH
         RSJx2EACue5lXH68etee39b7Kn4drVB9WgVTbSruHJ2Re0WAPNMn1RegI5Lfe7w0B7gE
         NxtbhRn7DwmedhoyjkaLEQMQQXDozzE/wQuM3li9rABXirDW3ZbHZ5XAl3nAUPTEGrwq
         iGKKGuCgR9tdE22vTkzO7geM9U6DqcE0vTQ1xDFNIwbSorzZlU6BKh/ZXGCkuRFkjBj8
         fXEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gt1pw+YVWT7/dtSjPazx4KZ8zuAkMJu/EEZtr/YppJ4=;
        b=CCTvxiGBpqMipnUcGffmY8Rk7Dxfuq3Nfg2dbtG+gxiYYZbZE0chs5zvau1YBL/HKe
         2xBBovTYy/JYss9+kN4roFGuJA88+FrYP2Zxd54xn8e6OX2gTLgr5xNz4MMiNBuqjbuj
         bfmeQdafzvPNWoQLFxYBwFBx0qmaz/1r+ZXgJX+XgWNSytvm6364H3t+sKls24bQVZWs
         ZRfKu9yy7UGxuYOoX1H1nBAwvuaDkd7vHnhAo672wvh6EOEBm88yHw/UzwSekjSO2ffJ
         HkhOOUBK1xR4wYv/bD8H8vmDIYdE/h5xcJLjyTBY/R3qgOGZaYmyTjaJjqslNxdxSL1u
         Kb5Q==
X-Gm-Message-State: APjAAAVvjNp2sKwr7LBRan29kFGnxlVOy0t3V1KLilPCZ72ok5BjV/9s
        qAieA368gdn3zKOCQBo/4OjNpA==
X-Google-Smtp-Source: APXvYqw2RzfTvxPIekgfd9ydtKYE1bADmPmuJnFLPw0eQVY/hpfGQwr4dItAV4gPrFqutZU8JEE7Kw==
X-Received: by 2002:a1c:4e15:: with SMTP id g21mr17623911wmh.148.1571658821037;
        Mon, 21 Oct 2019 04:53:41 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id v10sm7531052wrm.26.2019.10.21.04.53.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:53:40 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:53:39 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Barry Song <baohua@kernel.org>, stephan@gerhold.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Drake <drake@endlessm.com>,
        James Cameron <quozl@laptop.org>
Subject: Re: [PATCH v2 0/9] Simplify MFD Core
Message-ID: <20191021115339.GF4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <CAK8P3a10w9Xg6U8EgUqPLbucP3A0wc9xO_WNG06LxHrsZkZc1g@mail.gmail.com>
 <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5e7695cc82b4370752f45082be007dbe410c74c.camel@v3.sk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Lubomir Rintel wrote:

> On Mon, 2019-10-21 at 13:29 +0200, Arnd Bergmann wrote:
> > On Mon, Oct 21, 2019 at 12:58 PM Lee Jones <lee.jones@linaro.org> wrote:
> > > MFD currently has one over-complicated user.  CS5535 uses a mixture of
> > > cell cloning, reference counting and subsystem-level call-backs to
> > > achieve its goal of requesting an IO memory region only once across 3
> > > consumers.  The same can be achieved by handling the region centrally
> > > during the parent device's .probe() sequence.  Releasing can be handed
> > > in a similar way during .remove().
> > > 
> > > While we're here, take the opportunity to provide some clean-ups and
> > > error checking to issues noticed along the way.
> > > 
> > > This also paves the way for clean cell disabling via Device Tree being
> > > discussed at [0]
> > > 
> > > [0] https://lkml.org/lkml/2019/10/18/612.
> > 
> > As the CS5535 is primarily used on the OLPC XO1, it would be
> > good to have someone test the series on such a machine.
> > 
> > I've added a few people to Cc that may be able to help test it, or
> > know someone who can.
> > 
> > For the actual patches, see
> > https://lore.kernel.org/lkml/20191021105822.20271-1-lee.jones@linaro.org/T/#t
> 
> Thanks for the pointer. I'd by happy to test this.
> 
> Which tree do the patches apply to?
> Or, better, is there a tree with the patches applied that I could use?

Ideal.  Thank you.

http://git.linaro.org/people/lee.jones/linux.git/log/?h=topic/mfd-remove-clone-cs5535-mfd

> > > Lee Jones (9):
> > >   mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and tidy error message
> > >   mfd: cs5535-mfd: Remove mfd_cell->id hack
> > >   mfd: cs5535-mfd: Request shared IO regions centrally
> > >   mfd: cs5535-mfd: Register clients using their own dedicated MFD cell
> > >     entries
> > >   mfd: mfd-core: Remove mfd_clone_cell()
> > >   x86: olpc: Remove invocation of MFD's .enable()/.disable() call-backs
> > >   mfd: mfd-core: Protect against NULL call-back function pointer
> > >   mfd: mfd-core: Remove usage counting for .{en,dis}able() call-backs
> > >   mfd: mfd-core: Move pdev->mfd_cell creation back into mfd_add_device()
> > > 
> > >  arch/x86/platform/olpc/olpc-xo1-pm.c |   6 --
> > >  drivers/mfd/cs5535-mfd.c             | 124 +++++++++++++--------------
> > >  drivers/mfd/mfd-core.c               | 113 ++++--------------------
> > >  include/linux/mfd/core.h             |  20 -----
> > >  4 files changed, 79 insertions(+), 184 deletions(-)
> > > 
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
