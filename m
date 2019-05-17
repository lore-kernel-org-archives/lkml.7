Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F74AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A5B221726
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 15:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OaMaKXy5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfEQP0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 11:26:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35267 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbfEQP0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 11:26:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id h11so5309299ljb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zvJW3K/FS9j2vxT/67+kmUSDA+MGU3uHDKkLdS8tVa0=;
        b=OaMaKXy54R+NbVudd2Xg6OpB6auFmiMDHwz8V3o46MZbUkAufgvpUgBxdrDuCS+Lz2
         2/M/uqSr+sN0/6MXQqfKRbIC3N+xgAgzK1o3KihDM6wd8EUwfWk36YY1pERMHvgcIKPX
         M6JMBdpr5RnThlCXjj1rKxEfPfROfeNZ7DcNlzQ5alD5iIv0yJ0kcZ2jjM73h+xVtDIp
         h3eYta6zyDoaAtsMFPe4YQKrT/C8Y1WmPkk3GwBuXYVxHp8mcnRJ2YEu1jYW6sPb5dXz
         u/FG4qrmw3Ky+gfKI0ppAo2C7wYqcmojjYbgofHn+7f5ww5/YPWv1jLFqK0hrsoaFZRb
         jkdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zvJW3K/FS9j2vxT/67+kmUSDA+MGU3uHDKkLdS8tVa0=;
        b=YzMh0qfP4uxOT3yjM7jeTUs1DArbrbc+Z8QtxeZ8S/FIzt6IL7M/i6yoQIG96CkAkj
         Oz79kF4NeTrRSV29+E3PGuv/zcxx8n5b+iibEnt2NvIOE4oize4MNtEq0eOqIg86qWa+
         fxaZgHMbO889WPb73bo8MLD7ckYe19C7AQqLMuIw2HAHd5U9gyymvY9JKuJZ3Y59HTVw
         Px3dVK0pJzlwhkUnUN/Gb4S8CyDSNYpuy1CkeZZQlGdzFHOlb/o+030cTCPtqI5FGZv/
         TuaS9vyDQS7C51yeI71efP9ls6/7hwav5xXOEjpbSSuQxD8wZRu2SAaAIPgV4K9vs4Nh
         xg4g==
X-Gm-Message-State: APjAAAUQ62Ryjddz7k9IGZ+Caxw58K1pf7kxuhgdy92Bdd6iZEXqRaru
        Y0X6WSrLc1hoZ9dHONqkHBRJNBDwEilHNz7k88F8gw==
X-Google-Smtp-Source: APXvYqziH1YiKmkZ41CrbuyqVAx2OuWdaW+f59YxwY0995kt+Y9k5l7uq9QglgyQJp9P/BFOAZgpZ7DoIPSV4byKM9s=
X-Received: by 2002:a2e:9756:: with SMTP id f22mr7457174ljj.30.1558106777511;
 Fri, 17 May 2019 08:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAHRSSEy3od0-7HMCOjbHprc9ihu3VqkJi1-5OKew0oN-2BcPvA@mail.gmail.com>
 <0000000000001165cb058538aaee@google.com> <CACT4Y+bvMEQRcxqM4c9zc-eySQBnuGipwudCNvBv5f+Dgyr3ow@mail.gmail.com>
In-Reply-To: <CACT4Y+bvMEQRcxqM4c9zc-eySQBnuGipwudCNvBv5f+Dgyr3ow@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 17 May 2019 08:26:06 -0700
Message-ID: <CAHRSSEyFoGXLnR4RCf-_eefMjf18pPKmJni7GWTROtPmYAnaOA@mail.gmail.com>
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

Yes (and syzbot seemed to confirm the fix). I didn't realize I needed
to manually close the issue. I guess you closed it yesterday.

From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, May 17, 2019 at 3:08 AM
To: syzbot
Cc: Arve Hj=C3=B8nnev=C3=A5g, Christian Brauner, open list:ANDROID DRIVERS,=
 Greg
Kroah-Hartman, Joel Fernandes, LKML, Martijn Coenen, syzkaller-bugs,
Todd Kjos <tkjos@android.com>, Todd Kjos <tkjos@google.com>

> On Fri, Mar 29, 2019 at 10:55 AM syzbot
> <syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger
> > crash:
> >
> > Reported-and-tested-by:
> > syzbot+f9f3f388440283da2965@syzkaller.appspotmail.com
> >
> > Tested on:
> >
> > commit:         8c2ffd91 Linux 5.1-rc2
> > git tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git m=
aster
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D8dcdce25ea7=
2bedf
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D10fed663=
200000
> >
> > Note: testing is done by a robot and is best-effort only.
>
>
> Todd,
>
> Should this patch fix the bug? Should we close the bug as fixed then?
> In my local testing I see this BUG still fires, but if we will leave
> old fixed bugs open, we will not get notifications about new crashes.
