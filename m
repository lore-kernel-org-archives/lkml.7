Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEEDC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C07A21655
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="L+w7i+/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfJGJcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 05:32:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40902 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfJGJcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 05:32:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id d17so8748417lfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjJb4Lw1u4Pakm4DYiGRG6UBYCd5/SKc3snKb7a41eY=;
        b=L+w7i+/XSvQwHJCGQG27QQxfMFppLPlg08famGOQUJibMHc12TXh9PR5l+7yance/0
         em4sgYjEaGwuw0fqCfGB+DLaXvS+cjs1JDbAsnbhgrEO3PyC3dFCvbuR1KUgvWgLsDM1
         /aecwOZUsR4lB30qJ+AUgV+WmYvWzqfJSXVq2D5V7BHushGRfodmeoIJFjU8cn6NOdYe
         7idKl1uC7u98t8KKQWO5/i5qWpUS9AuyvyKYf3ZAv/I/7IojgZj6lfC93W9oegZ6eyY8
         0VXWLUww674RNY4tyOZlKE6OCKLZLXN768i4vuhZhtlGJYp+RD0rQXO2/cZJhMzOpVtI
         9ggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjJb4Lw1u4Pakm4DYiGRG6UBYCd5/SKc3snKb7a41eY=;
        b=ZDbY1wSnf+ygF+bVQbfaNl3a+bPpresZRviWVXgjDNTWFVUUXBJL0++FZtd/iCGO61
         HU2+z1ZZxvUfUXCql2uRZwuid2Y35n5toS9+OA5N09/mh4KD88IiYGgEeu+U4MbAM70l
         /56xoqvwiGHVkD3PkqNJuyFOInyh0fWHktuUCgSuvExGUNq8NkYTzRV7O0woBGEmf8hF
         qTOzSzJggVOgegtAkFVqvxe1NzEOUGG52/Plh3oEduTefqFOVjo1JrvkDI/rI5KybwOB
         f4zfB/PsoKQwJIS9XosfO+/4bYq0fYtnvHWyohziCSr/76jkafEBNixh5vafoZmUROsZ
         B4zA==
X-Gm-Message-State: APjAAAVC/CKdYvxgj7/GUmp2sH/i9D6sxiXFuYLvA/mzv+r+Rzczt64H
        GNIdJz9RBL0AMIar8/Xe7NbXPYhSHoQALQXmQBE9Wg==
X-Google-Smtp-Source: APXvYqwXSdg79nM61/yrNU4LIMp21a2m4WX62zPPo3IuTua6nuJzwDg70f31wxHvltrmiSsd8wCBM7RhFA4de6TXKEc=
X-Received: by 2002:a19:7605:: with SMTP id c5mr16903890lff.114.1570440717212;
 Mon, 07 Oct 2019 02:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191006172016.873463083@linuxfoundation.org> <20191006172018.480360174@linuxfoundation.org>
 <20191006173202.GA832@sol.localdomain> <20191006182433.GA217738@kroah.com> <CAKUbbxKbR6R_VM233pkw7_rxv_DMJoBPC_U5ZgVkR6GpXVAScw@mail.gmail.com>
In-Reply-To: <CAKUbbxKbR6R_VM233pkw7_rxv_DMJoBPC_U5ZgVkR6GpXVAScw@mail.gmail.com>
From:   Martijn Coenen <maco@android.com>
Date:   Mon, 7 Oct 2019 11:31:46 +0200
Message-ID: <CAB0TPYGjhzqAK5pAP3rjgqq9=9LA4z2Xpv+QG8sDrEkd+HWDyA@mail.gmail.com>
Subject: Re: [PATCH 4.9 30/47] ANDROID: binder: remove waitqueue when thread exits.
To:     Mattias Nissler <mnissler@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Todd Kjos <tkjos@google.com>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org,
        syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 8:28 AM Mattias Nissler <mnissler@chromium.org> wrote:
> Jann's PoC calls the BINDER_THREAD_EXIT ioctl to free the
> binder_thread which will then cause the UAF, and this is cut off by
> the patch. IIUC, you are worried about a similar AUF on the proc->wait
> access. I am not 100% sure, but I think the binder_proc lifetime
> matches the corresponding struct file instance, so it shouldn't be
> possible to get the binder_proc deallocated while still being able to
> access it via filp->private_data.

Yes, I think this is correct; either the binder fd is closed first, in
which case eventpoll_release() removes the waitqueue from the list
before it is freed (before binder's release() is called); instead if
the epoll fd is closed first, it will likewise remove the waitqueue
itself, before binder_proc can be freed.. I don't know the __fput()
code that well, but at first glance it seems these two can't overlap.

The whole problem with BINDER_THREAD_EXIT was that the returned
waitqueue wasn't tied to the lifetime of the underlying file.

Apologies for not spotting this needed a backport BTW - I refactored
the wait code heavily somewhere between 4.9 and 4.14, and somehow
didn't realize the same problem existed in the old code.

Thanks,
Martijn

>
> > >
> > >         wait_for_proc_work = thread->transaction_stack == NULL &&
> > >                 list_empty(&thread->todo) && thread->return_error == BR_OK;
> > >
> > >         binder_unlock(__func__);
> > >
> > >         if (wait_for_proc_work) {
> > >                 if (binder_has_proc_work(proc, thread))
> > >                         return POLLIN;
> > >                 poll_wait(filp, &proc->wait, wait);
> > >                 if (binder_has_proc_work(proc, thread))
> > >                         return POLLIN;
> > >         } else {
> > >                 if (binder_has_thread_work(thread))
> > >                         return POLLIN;
> > >                 poll_wait(filp, &thread->wait, wait);
> > >                 if (binder_has_thread_work(thread))
> > >                         return POLLIN;
> > >         }
> > >         return 0;
> >
> > I _think_ the backport is correct, and I know someone has verified that
> > the 4.4.y backport works properly and I don't see much difference here
> > from that version.
> >
> > But I will defer to Todd and Martijn here, as they know this code _WAY_
> > better than I do.  The codebase has changed a lot from 4.9.y to 4.14.y
> > so it makes it hard to do equal comparisons simply.
> >
> > Todd and Martijn, thoughts?
> >
> > thanks,
> >
> > greg k-h
