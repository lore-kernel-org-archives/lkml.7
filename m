Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F93FC00454
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309D206D3
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 18:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575915560;
	bh=djUQp1rD3P9simCFASBFGrEYHBJock4D0LmZwbJCh7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=m+hOf7cQ/UcM20VQuqibhiZ+nd/FkgEAu2XWsu3Bb3UOgvf84sE4wQHPjl2toV1Ub
	 OTiuzBgYv+GYxHUWbVquFRJr1RFAF4JvoWugXWhXp8+iM4Qzo48XPzMFHuHeCyk8+T
	 HnaebFTo/9ZY/mpmBk71V6PdFGhzH5HuI31hz5jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfLISTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 13:19:18 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35995 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfLISTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 13:19:18 -0500
Received: by mail-lf1-f67.google.com with SMTP id n12so11507065lfe.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZMqRZp9+bilXh0HGL9oR0MxLWgnBMeIphYWvOmpL9Q=;
        b=Yz+/sjhUXKZEs+qhSFKklhR8o2h6HC5lgJKoaBnwRJo1Isv/EBY7iJV3WCU91qirAQ
         rRDf37sKOK/pgKTHy0SWhM3EOI126l1pcn5N4S1fNR+CVqdFzl9hLpVim3R+/okkvArl
         qPaSO1elURSaIoUN1kgalqzaKSAFOCIOmIgKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZMqRZp9+bilXh0HGL9oR0MxLWgnBMeIphYWvOmpL9Q=;
        b=tG8qCtLMrErdago/0l8tDTJC+/KRx1CM/W12oC1ojzNtaqJEAzLjNigJB44HJI9IP6
         lVnh8/Kq58iWVOF+uA/jJNaKss8pv5FLh5QwFiob++ynceUdE56oh/8vaBszhpTcpPu+
         WE4/dlrhR/PPgc0BgCuPTKSziNqCRMoH/YtosWyS60w4eFeIEXmMvPsEcZNxrc6cvuFf
         yK05gG6cs9lEYzAVek0H2/ounez+2+IZ9mhIoGupNRIFN6qE3UOaf2zfRVmaxazCvcn9
         Q3A0dWT73iLimz5PNANxAeB0NOZ5fhoeeyQAJfy/skpTvu77VRQR9RKOCTkAxu/1aCWZ
         glug==
X-Gm-Message-State: APjAAAUYvCHPfLaeYIDeeB3tfSUmi2lZtiOwF1BC4ii9LdRKJ/EbTZmI
        e02uyToxvb0mn0kdzeMgt19JPRKINKc=
X-Google-Smtp-Source: APXvYqzlhv+/3unfuKSA3FwJsr9KdW4Ckh0FpsuivRTu/XyXZbm4AEnirPuN1hAd6s1f/MAsEzItTQ==
X-Received: by 2002:a19:2389:: with SMTP id j131mr14873980lfj.86.1575915554848;
        Mon, 09 Dec 2019 10:19:14 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c23sm316943ljj.78.2019.12.09.10.19.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 10:19:14 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id k8so16733192ljh.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 10:19:13 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr15150725ljj.148.1575915553079;
 Mon, 09 Dec 2019 10:19:13 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com>
 <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
 <CAHk-=wjeG0q1vgzu4iJhW5juPkTsjTYmiqiMUYAebWW+0bam6w@mail.gmail.com>
 <CAKfTPtDBtPuvK0NzYC0VZgEhh31drCDN=o+3Hd3fUwoffQg0fw@mail.gmail.com>
 <CAHk-=wicgTacrHUJmSBbW9MYAdMPdrXzULPNqQ3G7+HkLeNf1Q@mail.gmail.com> <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
In-Reply-To: <CABA31DqGSycoE2hxk92NZ8qb47DqTR0+UGMQN_or1zpoGCg9fw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Dec 2019 10:18:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
Message-ID: <CAHk-=wjnXUUbYikSFba5QqvJoFnO8c_ykXrw9Zz2Lt4SeyeZUQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     Akemi Yagi <toracat@elrepo.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        DJ Delorie <dj@redhat.com>, David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 9, 2019 at 9:57 AM Akemi Yagi <toracat@elrepo.org> wrote:
>
> In addition to the Fedora make-4.2.1-4.fc27 (1) mentioned by Linus,
> RHEL 8 make-4.2.1-9.el8 (2) is affected. The patch applied to Fedora
> make (3) has been confirmed to fix the issue in RHEL's make.
>
> Those are the only real-world examples I know of. I have no idea how
> widespread this thing is...

Looks like opensuse and ubuntu are also on 4.2.1 according to

   https://software.opensuse.org/package/make
   https://packages.ubuntu.com/cosmic/make

so apparently the bug is almost universal with the big three sharing
this buggy version.

               Linus
