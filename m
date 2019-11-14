Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8B9C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A49AB206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:28:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZHQKAym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfKNN2p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:28:45 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41855 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfKNN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:28:45 -0500
Received: by mail-qk1-f194.google.com with SMTP id m125so4923201qkd.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/mZVNsrrdQrSd4f+jtZYtmpcQwpVbpvj9DqjgXeIhMg=;
        b=PZHQKAymYb6gdMrbH5Bij9JxddaEK57E4lg4vvDn/Es+RqVi2EvkfAx9NZSyXhFQRA
         /AaFz4rDSIZHQ7gK0pM0SkxHaz9q4HOZnHB8uukiSZdbu3an6ETZAWoEtfaz+2NWLrgf
         EU2YjvYkzme3z8QHqc4YX0rojOZKsbQy8ERjQscytLPNP3/a/ka5LqKtaIOX7caXnwn9
         nuCcrB7KIZfnzARM9Mag7S9LFf6YRwe1bDzy2Rfrlbri8j+XrvQveG12ufnu/aYlWIeB
         fEW3UEXhQEo/A6aGld8/9NXfPVREVKenSqhhGsKDiuY9/2V+c7MHQU0fik1nNu7TsW0Z
         WpMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/mZVNsrrdQrSd4f+jtZYtmpcQwpVbpvj9DqjgXeIhMg=;
        b=abJjQFPMCbB14QBcrN4dmgfGc94ags+AXcXLkZi85XNEa0a4ig3JPj5XIoD4diVW4d
         3z/h2fPtDXCrqHhhe5dvOkBG6qI4R66JJv2Uco99Lzc8JeEgHwJdU3p39LeKMH43BbuJ
         RPWKBjZkq5PmeDhY3ONA1YRbYTlE3f0bSFSvmjbEzcmcuqh2OZhm3F+LURzU1+kcSk3/
         6FG4hUN4H7NucR0YnJ6jNv7YG4tJ7d9xx+Z4yLvT9RbLBKGvn45V8cq685BzBqo/vDup
         Q00bQkqjh4Kc+Mlptj5h/n+QO/hSMgUVQ5jFHI424hkKlhaQrGWISZZTSpH/D+tZIH6t
         pIpA==
X-Gm-Message-State: APjAAAUoMf+BBL/TVsTFVKuLL4PCi0/V2skhr4rEBbf/rXJKuW65420f
        WE++KbbmFEo9u88jcGnQVroElH1WyBltvZARwYOKkA==
X-Google-Smtp-Source: APXvYqylnPhIPw3TyRrtcNwmpfcdE/8C4v46TJJVFvtTQiRmW1fVFcw3EOQqirxSE+W70gfIm0O/Woq39S1wrBkB/8w=
X-Received: by 2002:a37:a94b:: with SMTP id s72mr7388312qke.256.1573738122547;
 Thu, 14 Nov 2019 05:28:42 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
 <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com>
 <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com> <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
In-Reply-To: <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 14 Nov 2019 14:28:30 +0100
Message-ID: <CACT4Y+YnaFf+PmhDT5JRpCZ9pqjca6VeyN4PMTPbCt7F9-eFZw@mail.gmail.com>
Subject: Re: linux-next boot error: general protection fault in __x64_sys_settimeofday
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 2:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 14, 2019 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Thu, Nov 14, 2019 at 1:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > >
> > > > On Thu, 14 Nov 2019, syzbot wrote:
> > > >
> > > > From the full console output:
>
> > >
> > > Urgently need +Jann's patch to better explain these things!
> >
> > +Arnd, this does not look right:
> >
> > commit adde74306a4b05c04dc51f31a08240faf6e97aa9
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Wed Aug 15 20:04:11 2018 +0200
> >
> >     y2038: time: avoid timespec usage in settimeofday()
> > ...
> >
> > -               if (!timeval_valid(&user_tv))
> > +               if (tv->tv_usec > USEC_PER_SEC)
> >                         return -EINVAL;
>
> Thanks for the report!
>
> I was checking the wrong variable, fixed now,
> should push it out to my y2038 branch in a bit.
>
>       Arnd


This part from the original reporter was lost along the way:

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com

https://github.com/google/syzkaller/blob/master/docs/syzbot.md#rebuilt-treesamended-patches
