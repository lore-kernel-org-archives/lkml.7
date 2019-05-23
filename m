Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094D9C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1052175B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlctLp6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfEWG60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 02:58:26 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37605 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbfEWG60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 02:58:26 -0400
Received: by mail-ed1-f65.google.com with SMTP id w37so7679162edw.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MKO+DbOAmUO3UBihlXAri8/RQt56WDZm5zJVnszm8uU=;
        b=RlctLp6cuIItdscVbhYypMHPj+Ma4ehi4/3P5Fh1Y+zPTk1rgIfMjbBUvMFI2WIT1c
         OFAS3xr7hd0hi7kMK4HcQl18M2h8IDOSywX7q3QOLnTFrH4Ik2YLQKcwV1N6QbsCUMsz
         hcrHwTRaETP0KVZ9DUKJoK3WD3dKNtRTnw727dAp6EXfZ56HM4V+jGSfZ7lbqCX3m/o1
         WTAAOXPXHZwrVW5hiQS9WcO8JZuXQoNpigomXx0plq1pJ+EUD7S2OwtWTStKnBF/HuL3
         ZqHSI3TFNawJbIQ0SNaHAIxByF4RCrKqFnrvLzTA0uYMuPiuhRw8uKWB59H8OgF5+rYs
         Re8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKO+DbOAmUO3UBihlXAri8/RQt56WDZm5zJVnszm8uU=;
        b=O74tUSmwfQkF3avSdMPkBXTFWXcn+KpQgeDSn9BrpZVsEIJRgI6x6HHzgEU6jhs1AE
         OXIhC44iObB3VqbZITMdTov+p33EK4GW/tdRFKaTbfFHKrevyMtFjdaeuqijp5vTqqlq
         6xcwftZrOhoh8te8V3Hl1ER0Mu/BrsGAaVqfvAK0SBGot8eKgD7xWeWnfZpzCd5U89IH
         cLKuMPI34vH51ATbBfR1vwuCqjYl5YI8SFUfr7mw7MgUBqitb8ql/4psLUi3gUZ8KPOs
         +yFOemqteOpW2M9yaxPZdkl9R8hBZGH8w4zPB6xhliJaDTf7d2r8qEW6DP5J7O/Uiv68
         UreA==
X-Gm-Message-State: APjAAAXbHrW3ZYO/OauOKW99cALzFfgbe9lopyq6etrLYHK7Qx+E3uDj
        sGJZ3n8Vkx9NuDQ8HtXsKF00CxpCCMik0UGpkeGeAA==
X-Google-Smtp-Source: APXvYqw9XphmU/9Iv55oT16C4cbJJ42QuGbIrT7AOxWCaolB9QXeveJ3SnsetdAsmf8WaQliON6ZZTGdw+Tc5eexa4w=
X-Received: by 2002:a50:a3dc:: with SMTP id t28mr93416040edb.256.1558594703849;
 Wed, 22 May 2019 23:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190503033340.GA7980@archlinux-i9> <20190523015639.GB17819@archlinux-epyc>
 <20190523055258.GC22946@kroah.com>
In-Reply-To: <20190523055258.GC22946@kroah.com>
From:   Stephen Hines <srhines@google.com>
Date:   Wed, 22 May 2019 23:58:12 -0700
Message-ID: <CAAzmS69VFrTPzZ8DY_NPPTZYtBssocRnQOFAyo3VbSTO4CesbA@mail.gmail.com>
Subject: Re: -Wuninitialized warning in drivers/misc/sgi-xp/xpc_partition.c
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Cliff Whickman <cpw@sgi.com>,
        Robin Holt <robinmholt@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

Since this kind of self-initialization is considered undefined
behavior, the simplest fix here is to just initialize to NULL. It's a
reasonable interpretation of what is currently written, and will at
least make the existing code more deterministic.

Thanks,
Steve

On Wed, May 22, 2019 at 10:53 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 22, 2019 at 06:56:39PM -0700, Nathan Chancellor wrote:
> > On Thu, May 02, 2019 at 08:33:40PM -0700, Nathan Chancellor wrote:
> > > Hi all,
> > >
> > > When building with -Wuninitialized, Clang warns:
> > >
> > > drivers/misc/sgi-xp/xpc_partition.c:73:14: warning: variable 'buf' is uninitialized when used within its own initialization [-Wuninitialized]
> > >         void *buf = buf;
> > >               ~~~   ^~~
> > > 1 warning generated.
> > >
> > > I am not really sure how to properly initialize buf in this instance.
> > > I would assume it would involve xpc_kmalloc_cacheline_aligned like
> > > further down in the function but maybe not, this function isn't entirely
> > > clear. Could we get your input, this is one of the last warnings I see
> > > in a few allyesconfig builds.
> > >
> > > Thanks,
> > > Nathan
> >
> > Hi all,
> >
> > Friendly ping for comments/input. This is one of a few remaining
> > warnings I see, it'd be nice to get it fixed up so we can turn it on for
> > the whole kernel.
>
> Patches are gladly welcome :)
>
> thanks,
>
> greg k-h
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To post to this group, send email to clang-built-linux@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190523055258.GC22946%40kroah.com.
> For more options, visit https://groups.google.com/d/optout.
