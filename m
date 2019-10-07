Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1183C4360C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ABF72087E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 01:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ePZ816xN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJGBWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 21:22:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46628 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbfJGBWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 21:22:48 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so7542341pfg.13
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 18:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCpzl+gjS1v/BSSwthsIOdrAj0WDgOHfZaPSpjZwrE8=;
        b=ePZ816xNk7+dQ69KuXtpaAdNDZ/w3rfOt2arPilX41K653IW6LXa8uAjK4U0plr7gA
         KhJKStGDPrNgAzgIou5cpKOfkW8cq38wkbi+7/ecCH/mjesC5l8R3G4WSZnSN8ZrQiHD
         Mpa4hLeyordCDN9i7mqSlX6pydZUDqzBzUxBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCpzl+gjS1v/BSSwthsIOdrAj0WDgOHfZaPSpjZwrE8=;
        b=Yeb02ZtzzdOXB4cJXH45rkqIPIBokocXKav/yXPQV4juh9cSbYXpaeGxycZMfRfmSH
         EjyF1xrO3kCAvyAUFK1Ov4xfS4oBeWGjcTGyS7/nnXXrbNujTNSKrOmqr8fS3xEXyAjq
         LnC/p51h9s/nkHZiPmr6rTaZvtGkQBOIdKRkh18VKKuUYEe1OqtkU2QxjODsVjKvayxG
         pO33GLXQ0vEp2g/X9xor1AjDjTd5RnM9WtJWL/JGhQd2VbziYzJzpKoEUV0Kz0xmP8me
         8woPlsLlIjSBp+7iSrMLwLr/ynUHPPM3v+aMXz/78KhygnD7/C0cwQHlur2WMWrAScTa
         MI2Q==
X-Gm-Message-State: APjAAAXJEgfTB2BdMffou4eRurHvcKUr0VGQ3u7KrsTkPY2JyiwEvSzg
        ZWBnhTdAD3o2xsVQ8O0v4cOzcg6dG0I=
X-Google-Smtp-Source: APXvYqw5Ot1CuQzVenRF9hy63thVwqNgbzgyVgPV9oeogrT3F07BuEkQ7nnwiLOtczyfaBLPIcn+7Q==
X-Received: by 2002:a62:7912:: with SMTP id u18mr29525727pfc.242.1570411367590;
        Sun, 06 Oct 2019 18:22:47 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g4sm12963978pfo.33.2019.10.06.18.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2019 18:22:46 -0700 (PDT)
Date:   Sun, 6 Oct 2019 18:22:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MAP_FIXED_NOREPLACE appears to break older i386 binaries
Message-ID: <201910061817.9ECFDFE182@keescook>
References: <20191005233227.GB25745@shell.armlinux.org.uk>
 <CAHk-=wiy9MWteoaoV15FJ7QJeRhBtCVgo6ECiLb4khuc5PxHUg@mail.gmail.com>
 <20191006130924.GC25745@shell.armlinux.org.uk>
 <CAHk-=wh6jhO1X3VZuZ28aA4m0k6wGhkHRRrJSQpQ69N901D7Mw@mail.gmail.com>
 <CAHk-=wg14VfTec2AiW0iSVUzj2x2_PYffH9O5sDV5ZRagjQwRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg14VfTec2AiW0iSVUzj2x2_PYffH9O5sDV5ZRagjQwRg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 06, 2019 at 02:14:59PM -0700, Linus Torvalds wrote:
> On Sun, Oct 6, 2019 at 11:07 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Yes, we should get this fixed. But I continue to ask you to point to
> > the actual binaries for testing..
> 
> Just to bring the resolution back publicly to lkml after rmk sent me
> test binaries in private email, the end result is commit b212921b13bd
> ("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings").

Unsurprisingly, I'm not a fan of reverting that patch, but obviously we
must since it breaks old userspace. :) I'm travelling tomorrow, so if
Michal doesn't fix it before I'm back, I'll take a stab at it. I'd like
to retain the general best-effort-defense of "don't let mappings collide"
but I think it'll require us retaining more details about what the ELF
told us to collide with. (i.e. the LOADs can collide, but not into
stack, brk, etc.)

And better yet, we need self-tests here. execve has SO many corner
cases... I'd like to figure out some way to capture all these.

-- 
Kees Cook
