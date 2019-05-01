Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01466C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43E620656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 20:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI68YZzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfEAUlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 16:41:18 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35960 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEAUlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 16:41:18 -0400
Received: by mail-yw1-f66.google.com with SMTP id q185so12968ywe.3;
        Wed, 01 May 2019 13:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pMnJNBghgbvx76yH858QzVrsxw6HsYRaSJHXl4FlOF4=;
        b=AI68YZzLhQCxtwydtmox2s1kV3MxxSqKLPVFS6Og6Gd3M5gFoe2OKCwXhiEz1+15uv
         IiRRn97M0iThIQUH/BaPwDUkQcGbGb5S4Uf5Hn7qD43VNYF8XJyp69yAXPzaT9Q+mneS
         ei7OpQuFfULYkKf0p/+x45ptb97L0DDa35FckTqUub2nfxm7kqGHKnB+mWXBg3DIOpI8
         c9UJVKFAolmwD2cqm+KSE5QVowk3QwciDGDzpD78k9wkn1DDIjVkcMKI8yv5hDDIOaiR
         5XMKmTgXuRbNGyaDp2jIVkFIqtXeztgTYLwSYyKbh2iGEmSCHkfrkOV6yWNSP/rAaUOY
         v0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pMnJNBghgbvx76yH858QzVrsxw6HsYRaSJHXl4FlOF4=;
        b=jLqGZrC+objXWLzEKA0pvXtzzwU8vk7hOY6/d9ptuWfyFh0+wMC8BKB4Y/7mQWTlI4
         wqxWrTdZCmIq5/R5TOV72L9c5a3e8R3tEPGcQ8FMygtNJhVoBJnuwb8ygLyiyOpkASCj
         v1J7cKxZR1+cBln5FxSTjVavLClwF5og3qi+aR70RJ/RaX+9W7x/uMBx/q0tzXEs90fl
         8ZrUkJO/XgS/kLk42l8kSbl0yqUJuW/3ddkjPwCetqPO6Hm2frZ02xxqC+ahtWRDdA56
         TEMXQXUngY3zn4IOJ5yt5owpJpKPawZyIA4JnYQn5OZ6qat9JIasUssfAcQOBpctni6m
         KUtw==
X-Gm-Message-State: APjAAAXq13Q+Bxg3TruOnK51QwB4LabS491K4ZXWVoDWvIlTwKQZG6/5
        5ZpsgFpIEns3JDLa4hhuc/Q=
X-Google-Smtp-Source: APXvYqx09QzwfAaXmJ2ImCi7aKVVSbfHDhNFZfxx4iqqJ8p5W2BeNZeou6daKK6v4bUt1oEHtN/Wtg==
X-Received: by 2002:a81:9b4c:: with SMTP id s73mr57372980ywg.213.1556743277470;
        Wed, 01 May 2019 13:41:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net (adsl-173-228-226-134.prtc.net. [173.228.226.134])
        by smtp.gmail.com with ESMTPSA id e12sm2643769ywa.103.2019.05.01.13.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 May 2019 13:41:16 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B4674111F; Wed,  1 May 2019 16:41:15 -0400 (EDT)
Date:   Wed, 1 May 2019 16:41:15 -0400
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Subject: Re: perf tools build broken after v5.1-rc1
Message-ID: <20190501204115.GF21436@kernel.org>
References: <eeb83498-f37f-e234-4941-2731b81dc78c@synopsys.com>
 <20190422152027.GB11750@kernel.org>
 <C2D7FE5348E1B147BCA15975FBA2307501A250584C@us01wembx1.internal.synopsys.com>
 <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2JrAApXDws+t=q8AnKFkHJZSox7gsgwW-xEJTfs_mdzw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 30, 2019 at 06:12:35PM +0200, Arnd Bergmann escreveu:
> On Mon, Apr 29, 2019 at 7:17 PM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
> >
> > On 4/22/19 8:31 AM, Arnaldo Carvalho de Melo wrote:
> > >> A quick fix for ARC will be to create our own version but I presume all existing
> > >> arches using generic syscall abi are affected. Thoughts ? In lack of ideas I'll
> > >> send out a patch for ARC.
> > >>
> > >> P.S. Why do we need the unistd.h duplication in tools directory, given it could
> > >> have used the in-tree unistd headers directly ?
> > > I have to write down the explanation and have it in a file, but we can't
> > > use anything in the kernel from outside tools/ to avoid adding a burden
> > > to kernel developers that would then have to make sure that the changes
> > > that they make outside tools/ don't break things living there.
> >
> > That is a sound guiding principle in general but I don't agree here. unistd is
> > backbone of kernel user interface it has to work and can't possibly be broken even
> > when kernel devs add a new syscall is added or condition-alize existing one. So
> > adding a copy - and deferring the propagation of in-kernel unistd to usersapce
> > won't necessarily help with anything and it just adds the burden of keeping them
> > in sync. Granted we won't necessarily need all the bleeding edge (new syscall
> > updates) into that header, its still more work.
> 
> I think more importantly, it seems completely broken to sync a file from
> asm-generic but not the arch specific file that includes it.
> 
> The 1a787fc5ba18ac7 commit copied over the changes for arm64, but
> missed all the other architectures changed in c8ce48f06503 and the
> related commits.

Right, I have a patch copying the missing headers, and that fixed the
build with the glibc-based toolchain, but then broke the uCLibc one :-\

I'm travelling, so coulnd't get back to this, will try as possible.

- Arnaldo
