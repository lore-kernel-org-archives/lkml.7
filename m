Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70181C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DD5206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 18:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tKzCUvFd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbfG2SjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 14:39:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35424 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfG2SjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 14:39:09 -0400
Received: by mail-io1-f67.google.com with SMTP id m24so122332226ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 11:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FwMHPlbmAPxJQ/mJ/56Fjrh96L8HY/RcidjTcs4/fk=;
        b=tKzCUvFdpAjThXn2UowV+bawmycTgopdxquIlC+dqdFlomKh47e7PWPAWXwPDhlEV0
         WGaL2Lf3K2nX3uFrFKxHvVy8tSxAc9k2gVTAD9NVYrqF8DkZZW7UipkFX9bjCJCenxdt
         8Yu/uW7CHfDxENOSQSV6rziYo0QM8mfjwOKxWkAT1Jf4g729nbl1Eezj6UAWOTn672O/
         z1GpzyJZZlnM6k4dWYNVDKijnjLKx/kofl9zYXDCLISx67v1pkIzpZOukDv0BLs20LUp
         KWxNi9rJdkEwe55x4UrQMFO2ktWdudcrVcoyNBOJlB/pjpy3BEx0u41fUVp5lz6G+xXW
         k4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FwMHPlbmAPxJQ/mJ/56Fjrh96L8HY/RcidjTcs4/fk=;
        b=FmorVlYMtcJXJH6u8fhS70Usvn4ugLmoMH2bHRnRd5FPaWoltrkersIOJqCoqIvtsq
         8wOoM7zpZFyVYj/TC3YB2N58M5iFJ0qI2CCwVyVwdqWIVWgn9wSupc5R/J53InWSNddW
         aZ1P54iU7gELssH6/BknpjNk7NtnNn9iIMw+DFaPz8r4qbabk9jOmHBPrepdB6FMo5OH
         K5GVr16VrgY/4xS6vTykAnpP2de7VCCRtdsvqJTkX+VETMrZbWMxrwuSB/GI240REoHl
         7AC2q8XDRIEpkSRtwWH/xACPQmyiJ4MgiIvnCj44JIoLT4x1lE9BRpjUTQcvKXPglsdL
         0xQg==
X-Gm-Message-State: APjAAAUehAxklF4kO7exn3036JwvKK9oxO3htJIZ/OzghWKADeIruCOF
        x+5WjVpsa6rkL3Mlf2LUGk33Jkq8jWLRWjMaVmS4ZA==
X-Google-Smtp-Source: APXvYqwOyvbINe7VjyObX3vCNtadyRi+XDTMas83pG4+8ZVxw9xxSxj0gKL6sLA3lpVp0q7URJsTTC8vSVXcO2bi+AM=
X-Received: by 2002:a5d:9e48:: with SMTP id i8mr101423232ioi.51.1564425548036;
 Mon, 29 Jul 2019 11:39:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190726224810.79660-1-henryburns@google.com> <CA+VK+GM4AXrmZtv_narEU6pHO+NGrTc74iSSUNNbutZySfXjRw@mail.gmail.com>
In-Reply-To: <CA+VK+GM4AXrmZtv_narEU6pHO+NGrTc74iSSUNNbutZySfXjRw@mail.gmail.com>
From:   Henry Burns <henryburns@google.com>
Date:   Mon, 29 Jul 2019 11:38:32 -0700
Message-ID: <CAGQXPTgGJBiLVqAGWQZpSrTcWw4FnzDSkQWFOPhJ=TqtnQZPvw@mail.gmail.com>
Subject: Re: [PATCH] mm/z3fold.c: Fix z3fold_destroy_pool() ordering
To:     Jonathan Adams <jwadams@google.com>
Cc:     Vitaly Vul <vitaly.vul@sony.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        David Howells <dhowells@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constraint from the zpool use of z3fold_destroy_pool() is there
are no outstanding handles to memory (so no active allocations), but
it is possible for there to be outstanding work on either of the two
wqs in the pool.


If there is work queued on pool->compact_workqueue when it is called,
z3fold_destroy_pool() will do:

   z3fold_destroy_pool()
     destroy_workqueue(pool->release_wq)
     destroy_workqueue(pool->compact_wq)
       drain_workqueue(pool->compact_wq)
         do_compact_page(zhdr)
           kref_put(&zhdr->refcount)
             __release_z3fold_page(zhdr, ...)
               queue_work_on(pool->release_wq, &pool->work) *BOOM*

So compact_wq needs to be destroyed before release_wq.

Fixes: 5d03a6613957 ("mm/z3fold.c: use kref to prevent page free/compact race")

Signed-off-by: Henry Burns <henryburns@google.com>


> Reviewed-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Jonathan Adams <jwadams@google.com>
>
> > Cc: <stable@vger.kernel.org>
> > ---
> >  mm/z3fold.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/z3fold.c b/mm/z3fold.c
> > index 1a029a7432ee..43de92f52961 100644
> > --- a/mm/z3fold.c
> > +++ b/mm/z3fold.c
> > @@ -818,8 +818,15 @@ static void z3fold_destroy_pool(struct z3fold_pool *pool)
> >  {
> >         kmem_cache_destroy(pool->c_handle);
> >         z3fold_unregister_migration(pool);
> > -       destroy_workqueue(pool->release_wq);
> > +
> > +       /*
> > +        * We need to destroy pool->compact_wq before pool->release_wq,
> > +        * as any pending work on pool->compact_wq will call
> > +        * queue_work(pool->release_wq, &pool->work).
> > +        */
> > +
> >         destroy_workqueue(pool->compact_wq);
> > +       destroy_workqueue(pool->release_wq);
> >         kfree(pool);
> >  }
> >
> > --
> > 2.22.0.709.g102302147b-goog
> >
