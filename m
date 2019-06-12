Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D66FC31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1508221773
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GDzbgDhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438066AbfFLLgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:36:49 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33513 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409079AbfFLLgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:36:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so9539519pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 04:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MhkB743oojqt0jCijE6DsOt5IqaBpxqgWof9mFxCLr0=;
        b=GDzbgDhOafy14R/X43UkUN/+wf8bZdqGlFyPynLyOoG20vlQgN7zE9jZaanLyn3zx5
         qQhhso2gb34OxP/u3xHSg6zS8JjJRY1rM9k4rX+82IiHVqiDxz7X2a893Yf4graw7TMN
         nSUF/2Gtu0ZiA9FjJgluVZwCMm/sY7nIvA/8cwZyNRO0pWttZ9rn4SJm4NDG5Og1LJ7q
         69ebVQ9hxBQQPUib1nigJuccodsU3NmYrSrnehuErfe4YWQQvRoySvoE3IbFgIm+u5mm
         oszynkP2bKoPt4/Zv/VgvQYlSIXKjNdvA3RFAgK5OHTEZyvWErx96s2gVUjdKfd7KRLc
         uonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MhkB743oojqt0jCijE6DsOt5IqaBpxqgWof9mFxCLr0=;
        b=hfez54Nukf7EN8hHhIk3mmD64jdNcRNczNoDAIvGhN/2725SB+xgpXYneKZnMyHNhY
         ZKJFMT1NCaYNMeoszPsUJ/sjOIyBoH2RDUia485uQEJbAMzskh9q1qxloKRvKTzLEVQz
         nZqjEhWePi7Qu5kq+GRQY+DbTSv36VMcXs6xzFlzhva42HMSq5aa8Wh3SNjDvmLjgDf9
         7k2CGyyjiewFFUixFsu6aGAFZlvV5hZ6Xxj1slu0TdyAkA/cawe1AyAF5jxP6VVpMokt
         5xPngnZEnG8b8De1Omv/iwehbP/QucgNFG6zIsKWrIGv6QQWLhxA1mfeY6HI8FDhs5AY
         0dUw==
X-Gm-Message-State: APjAAAV0UbBe++jD90J6p6O/RSTyeGAPo1kMdN+vgXp/aphWPu+oFENW
        0R0QelQJ/zkHoL7c6sbm198XttdVn1TK461WvtU3bw==
X-Google-Smtp-Source: APXvYqzGzjPmF8qGtciCMiJ8cvvmFlnWp+2d9nBudQ86r37IgxuDA/rPCLSSJ3M+cA0egqf1SPnYkN9tXts/BubXkpo=
X-Received: by 2002:aa7:97bb:: with SMTP id d27mr18575219pfq.93.1560339407628;
 Wed, 12 Jun 2019 04:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559580831.git.andreyknvl@google.com> <51f44a12c4e81c9edea8dcd268f820f5d1fad87c.1559580831.git.andreyknvl@google.com>
 <201906072101.58C919E@keescook> <CAAeHK+y8CH4P3vheUDCEnPAuO-2L6mc-sz6wMA_hT=wC1Cy3KQ@mail.gmail.com>
In-Reply-To: <CAAeHK+y8CH4P3vheUDCEnPAuO-2L6mc-sz6wMA_hT=wC1Cy3KQ@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 12 Jun 2019 13:36:36 +0200
Message-ID: <CAAeHK+xCmc-x=Mvs8RC+xJOCw6AnEUgUzXXjjS3NJXeLwJkyqg@mail.gmail.com>
Subject: Re: [PATCH v16 08/16] fs, arm64: untag user pointers in copy_mount_options
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Khalid Aziz <khalid.aziz@oracle.com>, enh <enh@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christoph Hellwig <hch@infradead.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 4:38 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Sat, Jun 8, 2019 at 6:02 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Mon, Jun 03, 2019 at 06:55:10PM +0200, Andrey Konovalov wrote:
> > > This patch is a part of a series that extends arm64 kernel ABI to allow to
> > > pass tagged user pointers (with the top byte set to something else other
> > > than 0x00) as syscall arguments.
> > >
> > > In copy_mount_options a user address is being subtracted from TASK_SIZE.
> > > If the address is lower than TASK_SIZE, the size is calculated to not
> > > allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
> > > However if the address is tagged, then the size will be calculated
> > > incorrectly.
> > >
> > > Untag the address before subtracting.
> > >
> > > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> >
> > One thing I just noticed in the commit titles... "arm64" is in the
> > prefix, but these are arch-indep areas. Should the ", arm64" be left
> > out?
> >
> > I would expect, instead:
> >
> >         fs/namespace: untag user pointers in copy_mount_options
>
> Hm, I've added the arm64 tag in all of the patches because they are
> related to changes in arm64 kernel ABI. I can remove it from all the
> patches that only touch common code if you think that it makes sense.

I'll keep the arm64 tags in commit titles for v17. Please reply
explicitly if you think I should remove them. Thanks! :)

>
> Thanks!
>
> >
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> >
> > -Kees
> >
> > > ---
> > >  fs/namespace.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/namespace.c b/fs/namespace.c
> > > index b26778bdc236..2e85712a19ed 100644
> > > --- a/fs/namespace.c
> > > +++ b/fs/namespace.c
> > > @@ -2993,7 +2993,7 @@ void *copy_mount_options(const void __user * data)
> > >        * the remainder of the page.
> > >        */
> > >       /* copy_from_user cannot cross TASK_SIZE ! */
> > > -     size = TASK_SIZE - (unsigned long)data;
> > > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> > >       if (size > PAGE_SIZE)
> > >               size = PAGE_SIZE;
> > >
> > > --
> > > 2.22.0.rc1.311.g5d7573a151-goog
> > >
> >
> > --
> > Kees Cook
