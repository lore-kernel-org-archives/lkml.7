Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CB2C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20552206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nt47RbTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfKNNj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 08:39:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37687 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfKNNj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 08:39:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so4970007qkf.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 05:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwE1RWWFWw0V4uLoO65K5NOjyOKWscg7q/BhLYdVFnQ=;
        b=nt47RbTvSIQtdRZDO+UOKy7TQ2wLgILjj6kfuGdXDUOqUDky40JhJG83lsXaFtSD1J
         CZJ/HrsQ6ipy0hW4ogAMI9jqMBf/kptej1QkCo0AnR5qPg2Ty/+sc8FI7R6Elm4OVfqP
         /cvdMY/a1MW17rIHLJ1kiElD2FXczDO5NOm9s6SV+V/QDTjEG2/+CN0lyslrjGt3iYQC
         g2A8Cm7fHy1fs+dGn6JQ5LindEQqBCEenpHn4RYLDqp0gZnWXtnLDp8NhUc0wra+OgAR
         AcUJvUW1xwkJ1+wJZEQRv6ZhXtpitC6Ynr/9rT6PjibpfEmJK3okuwkKRnnEftTlYqwX
         s+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwE1RWWFWw0V4uLoO65K5NOjyOKWscg7q/BhLYdVFnQ=;
        b=tZmFsoWNpVuV7RVpzuG94ucYwaaKv1tjE74hSEJJ7LCIK8fLxL5BnX3ZtGj9pX/Af1
         T+V+0I3y2f1vfLpmhx0qYf6dzaW+q9KY1Gpt8icJ9G7T+9Y2j3c/C6LbWkknavOxRvKA
         IePvI6LUyHXkG1u5D4NEpqm143bmHLp9AmgfkZ347mgj9GkhBMICusCbe3X07SsMbq7u
         sLYfBVwHrR6LpIlgmZWg+hb9stpJIkZrtW6qEHgIFBBtAyll6p7gMWWNDL7JWdknJsNG
         20xUrbwl1HckLcZLXP4VZiEmfKSJcUsMpmSS/0kZB20PlJrWteIcEGcLJPSmKjIVzrj6
         VolQ==
X-Gm-Message-State: APjAAAVgrpoK98lrLoregoxHzbvILPh+BAhA7rnVyjnoN7P35ANYC1Jt
        Uy5N2zfsjkoaaqgamWE7/plsbQRHNRiKsupeZUCzmA==
X-Google-Smtp-Source: APXvYqzBp1Vo7D8E5HVr+0cDv919Lm7zBNPny8L/AHRm/VVGGmgU82I83QXQgyWUb4UjBtaYOuzapXaPUw6e05A/psw=
X-Received: by 2002:a05:620a:14b9:: with SMTP id x25mr7641000qkj.8.1573738765358;
 Thu, 14 Nov 2019 05:39:25 -0800 (PST)
MIME-Version: 1.0
References: <0000000000007ce85705974c50e5@google.com> <alpine.DEB.2.21.1911141210410.2507@nanos.tec.linutronix.de>
 <CACT4Y+aBLAWOQn4Mosd2Ymvmpbg9E2Lk7PhuziiL8fzM7LT-6g@mail.gmail.com>
 <CACT4Y+ap9wFaOq-3WhO3-QnW7dCFWArvozQHKxBcmzR3wppvFQ@mail.gmail.com>
 <CAK8P3a1ybsTEgBd_oOeReTppO=mDBu+6rGufA8Lf+UGK+SgA-A@mail.gmail.com>
 <CACT4Y+YnaFf+PmhDT5JRpCZ9pqjca6VeyN4PMTPbCt7F9-eFZw@mail.gmail.com> <CAK8P3a1viWDOHPxzvciDt8fPCm3XkbLJxAy1OjtJ_-vuP-86bw@mail.gmail.com>
In-Reply-To: <CAK8P3a1viWDOHPxzvciDt8fPCm3XkbLJxAy1OjtJ_-vuP-86bw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 14 Nov 2019 14:39:14 +0100
Message-ID: <CACT4Y+YsC7yX5d8Gw=C7pm_4xcZ1wjzb_=AoPOL1k5FEPERbzw@mail.gmail.com>
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

On Thu, Nov 14, 2019 at 2:38 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Nov 14, 2019 at 2:28 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > On Thu, Nov 14, 2019 at 2:22 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Nov 14, 2019 at 1:43 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > On Thu, Nov 14, 2019 at 1:42 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > > > On Thu, Nov 14, 2019 at 1:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > > > >
> > > > > > On Thu, 14 Nov 2019, syzbot wrote:
> > > > > >
> > > > > > From the full console output:
> > >
> > > > >
> > > > > Urgently need +Jann's patch to better explain these things!
> > > >
> > > > +Arnd, this does not look right:
> > > >
> > > > commit adde74306a4b05c04dc51f31a08240faf6e97aa9
> > > > Author: Arnd Bergmann <arnd@arndb.de>
> > > > Date:   Wed Aug 15 20:04:11 2018 +0200
> > > >
> > > >     y2038: time: avoid timespec usage in settimeofday()
> > > > ...
> > > >
> > > > -               if (!timeval_valid(&user_tv))
> > > > +               if (tv->tv_usec > USEC_PER_SEC)
> > > >                         return -EINVAL;
> > >
> > > Thanks for the report!
> > >
> > > I was checking the wrong variable, fixed now,
> > > should push it out to my y2038 branch in a bit.
> > >
> > >       Arnd
> >
> >
> > This part from the original reporter was lost along the way:
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+dccce9b26ba09ca49966@syzkaller.appspotmail.com
> >
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#rebuilt-treesamended-patches

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
this

> Is there a recommended way to give credit to sysbot if the bug only
> existed briefly in linux-next? Simply listing Reported-by would be wrong
> when I fold the fix into my patch, and it also doesn't seem right to
> leave it as a separate patch while I'm still rebasing the branch.
>
>       Arnd
