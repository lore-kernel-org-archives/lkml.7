Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D644FC76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:00:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFAAB205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CUwZ43K9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731177AbfGOQAR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:00:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45890 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730942AbfGOQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:00:17 -0400
Received: by mail-pf1-f194.google.com with SMTP id r1so7603791pfq.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 09:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pf3WGwA9D7m+i0fi13et95NxKX1fwC73+4IJDRPguM=;
        b=CUwZ43K9ybSDvf08eErRqtarzGQdiyDymnpU0KIK2JQh0T9Sup32mLmqjhs/VSqLrM
         MYwEWnD1tZLcOi15wredI/8U9xLO31vPqZvI1nsgvE8QGayvfGS4zJ8DFpd8xTqTB2Uu
         X0XI38pv45yv7xUlijhdFuvP2joPIHdZCt3wPU6yGKh7zI1+RsRJeph15u1MMAsHXsmU
         N/CNSsdTxOBDr+vJzIQZq74ITN4H5tRoqeyXjfz14O98vHdJyS9nZdunI9ZY16WRAzUr
         aDjqrcEfrIeCTuDiF5a0mq44jqMLnJJxVYJo2ivJup10466XLsZAPQUB28/H/OHw+0N1
         yN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pf3WGwA9D7m+i0fi13et95NxKX1fwC73+4IJDRPguM=;
        b=Np3KDeJxFkdCVRjXFgQ2staR2bA07TGN5XzP4NoA7sCHMFVPC1lIcxTIFltkTzBX5h
         zlImEZLMrHWLOZ+dyAj3BorbsklSUOXQBh/8J4Egz3hS62V9px3f36f6yK3h0V39eJ/Q
         6CVXi4uX6VgxajuGUyakULCyhpzcuWBI+XCCRR6Jm590R0ZPXNdaITF2lULSXABzJm2x
         gom/ZxsCTLaTK2HrZXhL9iGL3MnvwY/VIjhoCIDwLJbOVQkx/dYd/bSzCQ5pKoT//Arw
         kyRMnae6DuHvmX4ZqP8b2AI/kxxhf5AydkgREcEYIh06hGfTcwZ0+nmcbN9u4bbfRWl6
         pVvQ==
X-Gm-Message-State: APjAAAV9a5jyOPtRMNS9Lw1yr/6igH/E0TBdQbegJkG5I7wusZXUCGt5
        oRC3lcpeYppDxAZ4NVPpTyB9BsstPUh9MZO0P4+pQw==
X-Google-Smtp-Source: APXvYqxUxnVJIFmSjF/fduDJIdHHtTu2E7rs0M1v5DQsmsjwZzuX9klo19X53kLCG4pNPCe3wIEdLnHCwqNb7FnoP6U=
X-Received: by 2002:a17:90a:a116:: with SMTP id s22mr29852919pjp.47.1563206415768;
 Mon, 15 Jul 2019 09:00:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561386715.git.andreyknvl@google.com> <41e0a911e4e4d533486a1468114e6878e21f9f84.1561386715.git.andreyknvl@google.com>
 <20190624175009.GM29120@arrakis.emea.arm.com>
In-Reply-To: <20190624175009.GM29120@arrakis.emea.arm.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Jul 2019 18:00:04 +0200
Message-ID: <CAAeHK+x2TL057Fr0K7FZBTYgeEPVU3cC6scEeiSYk-Jkb3xgfg@mail.gmail.com>
Subject: Re: [PATCH v18 07/15] fs/namespace: untag user pointers in copy_mount_options
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-rdma@vger.kernel.org, linux-media@vger.kernel.org,
        kvm@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
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
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2019 at 7:50 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jun 24, 2019 at 04:32:52PM +0200, Andrey Konovalov wrote:
> > This patch is a part of a series that extends kernel ABI to allow to pass
> > tagged user pointers (with the top byte set to something else other than
> > 0x00) as syscall arguments.
> >
> > In copy_mount_options a user address is being subtracted from TASK_SIZE.
> > If the address is lower than TASK_SIZE, the size is calculated to not
> > allow the exact_copy_from_user() call to cross TASK_SIZE boundary.
> > However if the address is tagged, then the size will be calculated
> > incorrectly.
> >
> > Untag the address before subtracting.
> >
> > Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
> > Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >  fs/namespace.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/namespace.c b/fs/namespace.c
> > index 7660c2749c96..ec78f7223917 100644
> > --- a/fs/namespace.c
> > +++ b/fs/namespace.c
> > @@ -2994,7 +2994,7 @@ void *copy_mount_options(const void __user * data)
> >        * the remainder of the page.
> >        */
> >       /* copy_from_user cannot cross TASK_SIZE ! */
> > -     size = TASK_SIZE - (unsigned long)data;
> > +     size = TASK_SIZE - (unsigned long)untagged_addr(data);
> >       if (size > PAGE_SIZE)
> >               size = PAGE_SIZE;
>
> I think this patch needs an ack from Al Viro (cc'ed).
>
> --
> Catalin

Hi Al,

Could you take a look and give your acked-by?

Thanks!
