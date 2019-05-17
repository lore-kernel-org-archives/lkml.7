Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA7AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA6E82168B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 17:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Byc6MLZx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfEQRYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 13:24:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:33379 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfEQRYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 13:24:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id w1so7035500ljw.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AmXm4mte+zKcRwUfgm7yrjVf+yzjXJtSQs1xu+wr18Y=;
        b=Byc6MLZxhstwWrZKbHUArEiROx0Xz+ebzcmQSrUYGLddb+Vr5Rhojy2hsG4A0Ina+E
         wKN1gSz5nXCgSzkqmbUf1oeEwa0MbmeolFixrDweKEJoJZl6i5ts8H8bdPThFwFvFFTH
         CmYJo43iBpvPxieQ0bPwp7ByjMMUo9d+3QuW6vC+Hl6O6204m1wVGGd51IgouKwAzgCJ
         WHtiEGVqm6Azjran2Y75+i8allxtUkDMj7QKlmhBeQcqNhVJeOwvFfn+EqGwM+WG0OYk
         myalanETQYxQTD/+MvIMp46wbz5N7RcuDGKHTW4vP0JD40SncyQ3Yfhan40e3I40U/l+
         Mfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AmXm4mte+zKcRwUfgm7yrjVf+yzjXJtSQs1xu+wr18Y=;
        b=PsKYyf5qLoMj7gLItLyz+T7D9gf7gvkJAlLEC5+KaFig0bXrc6UNOMOQmA1J6A+sWR
         jGeqvia/yIJ5TgRxTr4CmnLztHFnHgxuXYf9lIg+gepeYqr+6A1FJKopOccu6nUtCh1N
         FrrsUknRhr/nID9rrafqksXLilahJmB8Wtv/6Im0YrobN2Wrcf7ISbvIpLzi70WnPBQv
         U001z32+0ZTP6AA6f/4tWyW4NkayQCMstlBWvg0HCP8g6p94hu5aahwDSJjYanty1X2W
         Fhs3pEYvJ/gDx/PeBVVWNbAeBiMXrdxV1EJFJjnHIT+Ho4QIK+se6muuYuIoVKom3iUX
         zIYQ==
X-Gm-Message-State: APjAAAUFUSbj5s7cgGOhMtch8DLyi7sv3CyUIh7mtpnnYLQowGYuzsOd
        yTQLqd+XPAt4IV54wSiTSaT77/sGOwbnOdP3frZSfQ==
X-Google-Smtp-Source: APXvYqzwYIRqHsI7YC50VtLBNAvQFIT93L0uR2LTLAAVvk9GLhBX0BS6TNc+beAueO9JP4gznut0cRdd4JfYqE8uNX4=
X-Received: by 2002:a2e:2d02:: with SMTP id t2mr26134557ljt.148.1558113887278;
 Fri, 17 May 2019 10:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
 <0000000000001165cb058538aaee@google.com> <CACT4Y+bvMEQRcxqM4c9zc-eySQBnuGipwudCNvBv5f+Dgyr3ow@mail.gmail.com>
 <CAHRSSEyFoGXLnR4RCf-_eefMjf18pPKmJni7GWTROtPmYAnaOA@mail.gmail.com> <CACT4Y+aH8eApRv8u_DKh8Rr4Rr70GK4Lv1Wxac=18DxXu8GWjw@mail.gmail.com>
In-Reply-To: <CACT4Y+aH8eApRv8u_DKh8Rr4Rr70GK4Lv1Wxac=18DxXu8GWjw@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 17 May 2019 10:24:36 -0700
Message-ID: <CAHRSSEx5_Aoa27npJ2gr9xb7kGGBp3bJH9s=EiaYsixZrGh4rQ@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 8:33 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, May 17, 2019 at 5:26 PM Todd Kjos <tkjos@google.com> wrote:
> >
> > Yes (and syzbot seemed to confirm the fix). I didn't realize I needed
> > to manually close the issue. I guess you closed it yesterday.
>
> This is required to auto-close the bug when the commit is merged:
>
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
>
> Otherwise somebody needs to say:
>
> #syz fix: binder: fix BUG_ON found by selinux-testsuite

It looks like you closed it with your #sys comment ^^^

>
>
> > From: Dmitry Vyukov <dvyukov@google.com>
> > Date: Fri, May 17, 2019 at 3:08 AM
> > To: syzbot
> > Cc: Arve Hj=C3=B8nnev=C3=A5g, Christian Brauner, open list:ANDROID DRIV=
ERS, Greg
> > Kroah-Hartman, Joel Fernandes, LKML, Martijn Coenen, syzkaller-bugs,
> > Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>
> >
> > > On Fri, Mar 29, 2019 at 10:55 AM syzbot
> > > <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot has tested the proposed patch and the reproducer did not tri=
gger
> > > > crash:
> > > >
> > > > Reported-and-tested-by:
> > > > syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
> > > >
> > > > Tested on:
> > > >
> > > > commit:         8c2ffd91 Linux 5.1-rc2
> > > > git tree:
> > > > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.g=
it master
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8dcdce2=
5ea72bedf
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10fe=
d663200000
> > > >
> > > > Note: testing is done by a robot and is best-effort only.
> > >
> > >
> > > Todd,
> > >
> > > Should this patch fix the bug? Should we close the bug as fixed then?
> > > In my local testing I see this BUG still fires, but if we will leave
> > > old fixed bugs open, we will not get notifications about new crashes.
