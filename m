Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC815C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B414B217F9
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 19:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJFXJjCi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbfJNTf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 15:35:58 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45252 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbfJNTf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 15:35:58 -0400
Received: by mail-ot1-f66.google.com with SMTP id 41so14787452oti.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 12:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XrWcyp1buzweQbMvYgKZmE2h0wYSbiCvDrJ+ITMmwAc=;
        b=IJFXJjCibwKfNUOiQCp1JlGMkAtgvORwOi6fntAkmdXV7TAwwnpvaaFCjdTORnzFRQ
         mrmc27Pefqh5bqAq/aqfeXOcM5cy4gaIqkOeD/butl4CuorwZ6n6bQxP5QyGnMkbCw3m
         R9tGK7fIZyyCYHKBHUA3lqZVHt6kax2el+WpHGHLmkOnW/hNrlSY+6Y5q6G7eLq/7ogl
         B8xjA3BLnldSklthJd4STJn9cZYlDYwfNkx+NbRQsSOL7/0z3R0WP8e1nW7XOwQXzQ1B
         9u95uhgqJp3zCE9up+1EqEkfWNojZ+TclzSFpgIL5ENLTOwD4wxGNQMATLmDsuYVuNhb
         GiDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XrWcyp1buzweQbMvYgKZmE2h0wYSbiCvDrJ+ITMmwAc=;
        b=FDgdwkUh4cJq33wmd8sZDInDrBbfeKFrbXe+LYJcqaCtXUIqqk+sahdau7IMHzT1tO
         bpI7TQsVcUh+IoODzAJ8PAlEtMMD3mb1tvjvH+0o5EgniAudJeVaNpsiy8tjtIDgK5t2
         R9U5KrcAn+zTrvNWuctv8wASQv0mqQL1XzNsz451TRQj5JCBC8FjX2u+aznxwYF1kdaQ
         hnPe5iy6K3gbEByC9Bs3SEandZ2T0O9Rnk7CBiwzE18PqrIno2YV7gAX9KRfZoWZCbus
         tNgB86yUhbdMWgD29tJLVfw8Kt0lX05dYkJo4vyVY+VfWQDAPpp295ckUh3eRDK60aTn
         fc8w==
X-Gm-Message-State: APjAAAWwKx6Uh1xsYx6kYjQbULfZGUSjWqTYQ6zszYfKo0YkFxIK2bdW
        KUBMJSmB8iUgPxB62KLEJVUrco8Bcl+NwLWa71hr7A==
X-Google-Smtp-Source: APXvYqwzoS/csv409X8Yf9La00JPxKWIxu4wbj0FyCwv2f8S5eKwddkMYEcCIX/87xgRi3XqvhpLLQDlG3a6xO+8SK8=
X-Received: by 2002:a9d:75d0:: with SMTP id c16mr10442901otl.32.1571081757198;
 Mon, 14 Oct 2019 12:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191804.112933-1-hridya@google.com> <CAG48ez0dSd4q06YXOnkzmM8BkfQGTtYE6j60_YRdC5fmrTm8jw@mail.gmail.com>
 <CAG48ez2ez1bb=3o3h1KSahPU6QcdXhbh=Z2aX4Mte24H4901_g@mail.gmail.com> <CA+wgaPNPSOzEf-p8wsorqGe=eEbhFLkW6gYfYP1MaCqhQBvrnw@mail.gmail.com>
In-Reply-To: <CA+wgaPNPSOzEf-p8wsorqGe=eEbhFLkW6gYfYP1MaCqhQBvrnw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Oct 2019 21:35:30 +0200
Message-ID: <CAG48ez1w0MGaQdssdX7nZamPF_JmwR4g_Aj6cmHuojLfXAigfA@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent transactions to context manager from its
 own process.
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Todd Kjos <tkjos@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2019 at 7:38 PM Hridya Valsaraju <hridya@google.com> wrote:
> On Fri, Oct 11, 2019 at 3:11 PM Jann Horn <jannh@google.com> wrote:
> > On Fri, Oct 11, 2019 at 11:59 PM Jann Horn <jannh@google.com> wrote:
> > > (I think you could also let A receive a handle
> > > to itself and then transact with itself, but I haven't tested that.)
> >
> > Ignore this sentence, that's obviously wrong because same-binder_proc
> > nodes will always show up as a binder, not a handle.
>
> Thank you for the email and steps to reproduce the issue Jann. I need
> some time to take a look at the same and I will get back to you once I
> understand it and hopefully have a fix. We do want to disallow
> same-process transactions. Here is a little bit more of context for
> the patch: https://lkml.org/lkml/2018/3/28/173

That patch (commit 7aa135fcf26377f92dc0680a57566b4c7f3e281b) prevented
transactions within one *binder_proc*, which makes sense to me; that
still allows same-process transactions, so long as they are between
different binder_proc instances. What I don't understand is your
follow-up in commit 49ed96943a8e0c62cc5a9b0a6cfc88be87d1fcec, where
you try to block transactions within the same process (well, kind of,
the semantics of the term "process" are quite fuzzy here and don't map
onto binder well).
