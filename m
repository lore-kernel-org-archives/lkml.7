Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE9EC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF2AE2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j3ZjM6ED"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfEQPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:33:45 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40822 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfEQPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:33:45 -0400
Received: by mail-io1-f68.google.com with SMTP id s20so5811885ioj.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GoGLeBQVAsYPYmaa8owBbA17fSxllGxNfZRsvsyP5GA=;
        b=j3ZjM6EDepNj7gaQ6h4Jc48vu7SKp/YzHnh5TSiOz/PRaAaqMHgYMFBnmVLyxYdgEI
         EZIm0sRxvvLLTdG3nXCjf6pcaXNRY8jguJrgGfFWE6IWp4UzBWXCrJdMg/nzVMAUyVai
         cLtTR0Y+Woe+PQAh05Xux2EE5jB/GQw49HoVmthVhOpKfIoPkr1rHJm3bQ8amLoQnOyV
         IwOYzDJxuO8YKExzbhetrm2kYqraUd2NNa9oYLEBqOssVdGFN2iA8NwLr1G8Jd+2h51C
         A+5gMHL7Z6CKMAXsWchHvo/j2ltJ+E0DnWKTeh/9MdbLNqbOZfDuaC7YaKx5D2+4U19z
         4FIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GoGLeBQVAsYPYmaa8owBbA17fSxllGxNfZRsvsyP5GA=;
        b=t435mTRVlQj8ZC8aaSubWh8gLEmwa+QwoLS1SyvGhpspXtZ1wmd+oXWrmNALzrE2AS
         JQDTDTLwY5mRagkUpOVAIIPTZDbTlP4Lk64KkTb1DBj7Aw7VrI0VBkuTOO66fn6mRVXK
         PwXMOCHNKV37mSSFbaReusrF2leR6X5+9F80iR7OdNfvG3P9wFJD8/UFa4Y9Xejql6EH
         0yfGDt63+4p5bu1Tjy05fuL8qSeWw0udHKeF+/oCZsgRRMZt7S7DD8oPuVwsq9yLT1hb
         GtKrdLK3v5JoiUeZcJPeBxMwVPRVfBLLbQvlJfwDTfBywDvMk9mFR4oyKgWeTAadk5vQ
         GW4Q==
X-Gm-Message-State: APjAAAVKKOelRV4EQkGXhOkJr/zYlB/ivT4DPEPA55R98rp+9qgsYF/W
        bpVuRJr0cD/tyI4D8KV9/EXKFHL1JjJobD+HMKlLYQ==
X-Google-Smtp-Source: APXvYqwhVUxb9Ppd9SQcF28GTRh3a9btGC2LzO1osXyanXipbzAKyZjnLjxnOQlqzErLhh5oOMCg7n6jmWzuVCmXyvo=
X-Received: by 2002:a5d:9dc2:: with SMTP id 2mr5594339ioo.3.1558107224311;
 Fri, 17 May 2019 08:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
 <0000000000001165cb058538aaee@google.com> <CACT4Y+bvMEQRcxqM4c9zc-eySQBnuGipwudCNvBv5f+Dgyr3ow@mail.gmail.com>
 <CAHRSSEyFoGXLnR4RCf-_eefMjf18pPKmJni7GWTROtPmYAnaOA@mail.gmail.com>
In-Reply-To: <CAHRSSEyFoGXLnR4RCf-_eefMjf18pPKmJni7GWTROtPmYAnaOA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 May 2019 17:33:32 +0200
Message-ID: <CACT4Y+aH8eApRv8u_DKh8Rr4Rr70GK4Lv1Wxac=18DxXu8GWjw@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (3)
To:     Todd Kjos <tkjos@google.com>
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

On Fri, May 17, 2019 at 5:26 PM Todd Kjos <tkjos@google.com> wrote:
>
> Yes (and syzbot seemed to confirm the fix). I didn't realize I needed
> to manually close the issue. I guess you closed it yesterday.

This is required to auto-close the bug when the commit is merged:

> IMPORTANT: if you fix the bug, please add the following tag to the commit=
:
> Reported-by: syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com

Otherwise somebody needs to say:

#syz fix: binder: fix BUG_ON found by selinux-testsuite


> From: Dmitry Vyukov <dvyukov@google.com>
> Date: Fri, May 17, 2019 at 3:08 AM
> To: syzbot
> Cc: Arve Hj=C3=B8nnev=C3=A5g, Christian Brauner, open list:ANDROID DRIVER=
S, Greg
> Kroah-Hartman, Joel Fernandes, LKML, Martijn Coenen, syzkaller-bugs,
> Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>
>
> > On Fri, Mar 29, 2019 at 10:55 AM syzbot
> > <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch and the reproducer did not trigg=
er
> > > crash:
> > >
> > > Reported-and-tested-by:
> > > syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
> > >
> > > Tested on:
> > >
> > > commit:         8c2ffd91 Linux 5.1-rc2
> > > git tree:
> > > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git=
 master
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8dcdce25e=
a72bedf
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10fed6=
63200000
> > >
> > > Note: testing is done by a robot and is best-effort only.
> >
> >
> > Todd,
> >
> > Should this patch fix the bug? Should we close the bug as fixed then?
> > In my local testing I see this BUG still fires, but if we will leave
> > old fixed bugs open, we will not get notifications about new crashes.
