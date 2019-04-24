Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA34C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 071F721773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 08:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbfDXI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:57:48 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:52215 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfDXI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 04:57:47 -0400
Received: by mail-it1-f194.google.com with SMTP id s3so5001471itk.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 01:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ocZ2v0/qztPyVXIJjli4kzx9ai+9xYIL6N0jnSNL7jY=;
        b=n4dMBJVLNH32fvZsqq+lflV2ySH/BolAjvu56datgEOqOTwZRxTWkWbwk8n15JDMdv
         LQB9nLraK6+UnTMSfD2P12JOo5NJrvL/pTpMGILBuFUnV+Fv37awWoKjSavhaIApP6/F
         4AUtNd6X2rrLf+Rtxp1uAV9ehowGl+gNbz+3q1Lz1/S271sNz7nZgM7fGgx92oBSH4DC
         ic55UPzwC9mdc5aRyzWy/NVNMMs/R4mSRFRpkYx2L69k1iMzg8foku3crL1R5gq1ZTFC
         3sr03yd1MOV0+sh1WS/naBxJsClWElJFm7km2+8WR9MrUvS72yAz57xlll5fXHftHkDF
         C4+A==
X-Gm-Message-State: APjAAAUudbMoQ48hfnol/PF3mn2QOmWCDfO99gtlUmhqfc3ahOe8tGOZ
        PgJxQmO8gBSCHkyg1p6sDEbzRbDIZMSA5Os5utFrMiX+
X-Google-Smtp-Source: APXvYqzJmGmrxiqcftX3az/B4M0k6GaD5koTqbtYdS3tlZFRLoQT2vrEWJUlz9oHDZimkQkF6FQf/XYvJKG27KJIr/A=
X-Received: by 2002:a24:ac56:: with SMTP id m22mr6411196iti.25.1556096266835;
 Wed, 24 Apr 2019 01:57:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegt9DRmwKksR0QSA7NzQP_=a=yJybdL9mOP1cw5goGkdgw@mail.gmail.com>
 <20190424083800.GA11722@deco.navytux.spb.ru>
In-Reply-To: <20190424083800.GA11722@deco.navytux.spb.ru>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Wed, 24 Apr 2019 10:57:35 +0200
Message-ID: <CAOssrKeowGky6cccH0EKXiJkTwnPAU+as_vish=u4kvU=TQsvg@mail.gmail.com>
Subject: Re: FUSE workflow=? (Re: [RESEND1, PATCH 1/2] fuse: convert printk -> pr_*)
To:     Kirill Smelkov <kirr@nexedi.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Brian Foster <bfoster@redhat.com>,
        Maxim Patlasov <mpatlasov@parallels.com>,
        Anatol Pomozov <anatol.pomozov@gmail.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Andrew Gallagher <andrewjcg@fb.com>,
        "Anand V . Avati" <avati@redhat.com>,
        Alexey Kuznetsov <kuznet@virtuozzo.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Constantine Shulyupin <const@makelinux.com>,
        Chad Austin <chadaustin@fb.com>,
        Dan Schatzberg <dschatzberg@fb.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 10:38 AM Kirill Smelkov <kirr@nexedi.com> wrote:
>
> +torvalds
>
> On Tue, Apr 23, 2019 at 04:57:58PM +0200, Miklos Szeredi wrote:
> > On Wed, Mar 27, 2019 at 10:15 AM Kirill Smelkov <kirr@nexedi.com> wrote:
> > >
> > > Functions, like pr_err, are a more modern variant of printing compared to
> > > printk. They could be used to denoise sources by using needed level in
> > > the print function name, and by automatically inserting per-driver /
> > > function / ... print prefix as defined by pr_fmt macro. pr_* are also
> > > said to be used in Documentation/process/coding-style.rst and more
> > > recent code - for example overlayfs - uses them instead of printk.
> > >
> > > Convert CUSE and FUSE to use the new pr_* functions.
> > >
> > > CUSE output stays completely unchanged, while FUSE output is amended a
> > > bit for "trying to steal weird page" warning - the second line now comes
> > > also with "fuse:" prefix. I hope it is ok.
> >
> > Yep.  Applied, thanks.
>
> Miklos, thanks for feedback. Could you please clarify where the patch is
> applied? Here is what linux/MAINTAINERS says
>
>         FUSE: FILESYSTEM IN USERSPACE
>         M:      Miklos Szeredi <miklos@szeredi.hu>
>         L:      linux-fsdevel@vger.kernel.org
>         W:      http://fuse.sourceforge.net/
>         T:      git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
>         S:      Maintained
>         F:      fs/fuse/
>         F:      include/uapi/linux/fuse.h
>         F:      Documentation/filesystems/fuse.txt
>
> but git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git was
> not updated for ~ 2 months. I see other "Applied, thanks" replies from
> you on linux-fsdevel in recent days and it suggests that patches are
> indeed applied, but where they are integrated is the question.

My private patch queue.

> Linux-next also has no post-5.1 fuse patches at all, so I'm really
> puzzled about what is going on.
>
> Is there any reason not to keep for-next fuse branch publicly available?
> Or am I missing something?

I usually push to fuse.git#for-next within a day or two of adding it
to my queue.

> Could you please also have a look at other posted patches? I'm
> struggling for months sending them to you and not getting feedback. It
> is kind of frustrating to work in this mode.

I see.  I'll try to give more frequent feedback on patches.  The
reason for not replying is not that I intentionally ignore incoming
patches, but because I'm working on something else and context
switching between completely different projects is not easy for me.

Thanks,
Miklos
