Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32F0C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5B520645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 16:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiYmuPB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfF1Qz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 12:55:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33051 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF1Qz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:55:57 -0400
Received: by mail-lj1-f193.google.com with SMTP id h10so6686370ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 09:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E1s9SHdejCcLhI9v5CB85EdGtkVPS8wN9741lqH2J5U=;
        b=WiYmuPB4PHzJzEMi+NJ0Wmoh8XdcD/3l5z9Les3Q2QX9RSp7PR2A80PLUcprJVIf1D
         NNhv+ISL/4Sv4sJBG9lx9fIyzNABC//kk3odCEG59D/9NWoXeQcTi/Mwl3rRi1X3H+0s
         yiN2GuHOaVs1ftEWtBeFJlSCdEt+2fQSWO3I4h7kVF1qUt/WX7yyOPBvE6KQFATwRz50
         79ng+DKldaBoKKxTEeai9arj/hGvu+ucq/d35SL8Rdd9MIBfSD7icWi2RCQpeyk/zpT5
         1lDS6uVcsPkkR7uqUwPLkBTWuIm48tX5cjFBRjfyzKePgIK3nR55pnk2Ru+q2Qcp3PpZ
         m61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E1s9SHdejCcLhI9v5CB85EdGtkVPS8wN9741lqH2J5U=;
        b=KPlkk0bPHgBiYFXLkJgVVv5CrJ+F15QfOtStMU7ZgdHQdQuQeV+GdpFGNVYkVqtKfB
         G3eZd26LfkvJYC5fKLwPNOR2LKF+F/3SudJKxuYY2d8B6q94s4dAomN9lUiY7nsXQuas
         hn1WpnxF16Jp2SqK4YUQX+il4to+grmlf+Ks7qaYDVMBeBB7ceIgQd0/xGSJG8ii+ozz
         04DDT/stqm80TRO6+eQyPvwQwpVizbcsQLG3Yi4d5WazNM+675kT42EbKGkQIW6wUyla
         +dXB/LyrZQTPAgRwpTrr+DPGA+HtwLmifRH3fRcIFj2Su3bNdvOOLOld+ygIOjZ9tWR8
         IiHQ==
X-Gm-Message-State: APjAAAXfxW4jW3FNwfjhpVLqRPVVth0RZIyELfArIqkp9PM+TA2TG2Lf
        SNTodbiFXweVSjPDuBNxhRS+bUEjgETj0B3879z1YA==
X-Google-Smtp-Source: APXvYqz2M85/GYPs1z6CkDilf7Lb1A6Oty+PzwB3F4eQBe9UBJa9DbMbwOrjU7l4kfroJCG64CsVRE+AX1kR3xl5Ltk=
X-Received: by 2002:a2e:970d:: with SMTP id r13mr6755114lji.126.1561740954178;
 Fri, 28 Jun 2019 09:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b6b25b058b96d5c3@google.com> <20190618121756.GL28859@kadam>
 <CAHRSSExL1fUNpV4jBON5qh47M8A+na0twVNEqpvkBoYVnbJSHA@mail.gmail.com>
In-Reply-To: <CAHRSSExL1fUNpV4jBON5qh47M8A+na0twVNEqpvkBoYVnbJSHA@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 28 Jun 2019 09:55:42 -0700
Message-ID: <CAHRSSEzAv_jVBsP9U6Nb3uDnXEwH1Q6ef0fTrxLNTjAV0HeHng@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (4)
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     syzbot <syzbot+3ae18325f96190606754@syzkaller.appspotmail.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:37 AM Todd Kjos <tkjos@google.com> wrote:
>
> On Tue, Jun 18, 2019 at 5:18 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > It's weird that that binder_alloc_copy_from_buffer() is a void function.
> > It would be easier to do the error handling at that point, instead of in
> > the callers.  It feels like we keep hitting similar bugs to this.

I took your advice. Fix posted: https://lkml.org/lkml/2019/6/28/857

-Todd

>
> The idea is that if it is an error that the user can cause, it is
> checked by the caller of binder_alloc_copy_from_buffer(). Most uses
> are kernel cases where the expected alignments should be fine and it's
> a BUG if they are not.
>
> Admittedly, a few cases (like this one) have slipped through since
> they cannot happen in Android (syzkaller has been very useful to find
> our bad assumptions).
>
> -Todd
>
> >
> > regards,
> > dan carpenter
> >
