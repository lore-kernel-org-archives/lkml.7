Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40649C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE02173B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 14:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727352AbfGQOoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 10:44:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59429 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQOoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 10:44:13 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hnlAB-0003E4-Mw
        for linux-kernel@vger.kernel.org; Wed, 17 Jul 2019 14:44:11 +0000
Received: by mail-io1-f71.google.com with SMTP id v3so27365551ios.4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2019 07:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2386PExRpbgkN+Uat/urOUj93u5UGvh9BJdUwckpNOU=;
        b=cQOWXXZetmbQhMYdG6cOLCpmXKAFfTHWO5TRBGRgpBkTeOYKQ1y5iECvXkLpxrw90S
         HfmWfgqPQ/rksoLFVZi7OwnW0FhiYyWGxjXOq6ogUQHQgIm3tQPgpBNU0fM7EVhS/LSK
         JpV6xwPkxZ/nhkYO6EJZkD2YlJgSkrrPHCGLMF/l++lk9xEK14Y4ztkGDp+Wsg8KJLTy
         /K7V4LdeHB3j0OYzoGbzGIc9+opglz20cbF5mzVFMDNGu5iJ2SYUE7RYRceGXrk8NAXu
         FtMw9gIzpv8v9Cq+ZqGhZ+x3Ppzy3G+zVf7cP0zZF9HfTQSaJDv2HZoaxBGk6SYRE9Vz
         uhkw==
X-Gm-Message-State: APjAAAVx6UpI+MEGWjQldJUcILYujWWoRQviu5FDrDOQBbCDHWgRwtCi
        EoWb9xFfEMc4BDHVyT9NYcfVhvOGyomkkF03uRamOxjT8CtkuMLwvhOvcrAc4OMfMmJy2pLIChN
        yczBsPxWECN09kFt2wBqavYJpEBDca2HT+shOMGxdyg==
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr6672199iom.36.1563374650645;
        Wed, 17 Jul 2019 07:44:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqfT69e5rzzR/7TL/+M0DTpyD7jvbubvnAeiiJgh1lxop81SNNuRZlYSPK0abCBA7IaEXmNQ==
X-Received: by 2002:a5e:8a46:: with SMTP id o6mr6672164iom.36.1563374650305;
        Wed, 17 Jul 2019 07:44:10 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:31dd:dc66:96d:f1eb])
        by smtp.gmail.com with ESMTPSA id l11sm18574102ioj.32.2019.07.17.07.44.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 07:44:08 -0700 (PDT)
Date:   Wed, 17 Jul 2019 09:44:07 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, kbuild-all@01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [kbuild:kbuild 5/19] drivers/atm/eni.o: warning: objtool:
 eni_init_one()+0xe42: indirect call found in RETPOLINE build
Message-ID: <20190717144407.GU5418@ubuntu-xps13>
References: <201907160706.9xUSQ36X%lkp@intel.com>
 <CAK7LNATqxQnen2Tzcici8GnJuc-qNeCYcCYisKM2OkNow1FDnQ@mail.gmail.com>
 <20190716124249.GP5418@ubuntu-xps13>
 <20190716162014.iu47g6o7ralxhcf5@treble>
 <CAK7LNASDRFuwC4jxvjgs0bUU8EJ93k1_eQTynK2wRfJCRfmFjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNASDRFuwC4jxvjgs0bUU8EJ93k1_eQTynK2wRfJCRfmFjw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2019 at 11:52:07AM +0900, Masahiro Yamada wrote:
> On Wed, Jul 17, 2019 at 1:20 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >
> > On Tue, Jul 16, 2019 at 07:42:49AM -0500, Seth Forshee wrote:
> > > On Tue, Jul 16, 2019 at 03:57:24PM +0900, Masahiro Yamada wrote:
> > > > (+ Josh Poimboeuf)
> > > >
> > > > On Tue, Jul 16, 2019 at 8:44 AM kbuild test robot <lkp@intel.com> wrote:
> > > > >
> > > > > tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
> > > > > head:   0ff0c3753e06c0420c80dac1b0187a442b372acb
> > > > > commit: 2eaf4e87ba258cc3f27e486cdf32d5ba76303c6f [5/19] kbuild: add -fcf-protection=none to retpoline flags
> > > > > config: x86_64-randconfig-s2-07160214 (attached as .config)
> > > > > compiler: gcc-4.9 (Debian 4.9.4-2) 4.9.4
> > > > > reproduce:
> > > > >         git checkout 2eaf4e87ba258cc3f27e486cdf32d5ba76303c6f
> > > > >         # save the attached .config to linux build tree
> > > > >         make ARCH=x86_64
> > > >
> > > > 0-day bot reports objtool warnings with the following applied:
> > > > https://patchwork.kernel.org/patch/11037379/
> > > >
> > > > I have no idea about objtool.
> > > >
> > > > Is it better to drop this patch for now?
> > >
> > > I'm surprised that the change would have any impact on a build with
> > > gcc-4.9, since -fcf-protection seems to have been introduced in gcc-8. I
> > > guess there's no full build log that would let us see the actual flags
> > > passed to the compiler.
> > >
> > > I'll try to reproduce this result. If you think the patch should be
> > > dropped in the meantime, that's fine.
> >
> > The problem with this patch is that it's breaking the following check in
> > arch/x86/Makefile.  GCC 4.9 doesn't support retpolines, so it's supposed
> > to fail with the below error.
> >
> > ifdef CONFIG_RETPOLINE
> > ifeq ($(RETPOLINE_CFLAGS),)
> >         @echo "You are building kernel with non-retpoline compiler." >&2
> >         @echo "Please update your compiler." >&2
> >         @false
> > endif
> > endif
> >
> > Maybe the flags should be placed in another variable other than
> > RETPOLINE_CFLAGS.
> 
> 
> 
> Josh,
> Thanks. You are right.
> 
> 
> Seth,
> I think you can add the flag to KBUILD_CFLAGS.
> 
> If you want to make sure this does not affect non-retpoline
> build, you can surround the code with ifdef.
> 
> ifdef CONFIG_RETPOLINE
> KBUILD_CFLAGS  += $(call cc-option,-fcf-protection=none)
> endif

Thanks, I'll send an updated patch shortly.

Seth
