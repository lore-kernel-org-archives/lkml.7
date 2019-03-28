Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B62C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B5412075C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 01:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Un5VE50G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbfC1BAN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 21:00:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40740 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbfC1BAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 21:00:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id t8so11472883otp.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 18:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZ8GO8aoB4z8b/syN7KNKrJi26ULf6l5YY/SscEWg9A=;
        b=Un5VE50G5EIFKZB4NatrzEVNo5ffg5PZhdjpX1+jM0VJSYafrN8ph02IaJZsTQpQAW
         HHc93Yy6jLGRgOUbU3oJ36xZczdc9jlwki+8ku0cq1CIHcQwU3s1wNlN1uIBHmk4Scip
         FeUQ4W0pu7Y0hc9LZM4jVMDTkyM0ojVIfG/fOCyl5N9GJPmV+OM3W4rlqd/Gv/dpeb0g
         D3aMMPhve2om9/s+65dwgKgJSv5lFIsug/4J0DLwGyuxGrXlHeaJTbh4rvta2yVKO27M
         IeUQyg1hKWLpSjqGeVaTYwKa8bP08TEeEE83x5jLGrGuxdWczPzTnsdBHgViqiWQRlDQ
         YlPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZ8GO8aoB4z8b/syN7KNKrJi26ULf6l5YY/SscEWg9A=;
        b=CepqFObH4DuIAxMvqFumWzp2TQhb3Dvcvyqt8CZzplD61Lhf2v5MS1vtPz12OxAzDw
         fFEFZ5gHI9hA6paxifOcSBDpRWevlSs7vPKlVHVrH8QKYGUQf2NXIFGP7ruB7WtQs2Yj
         4gnJhooYtvkQXuR4zroM6Tnyha+jS9eLLdmfxwvqGTl2VhpLbSc7jMQ/JW5cycJ714Uu
         5ahrrEuw2PtkBGqSSdwvLdCkKl5elEFRLDVhBA2hHCmBhDCYN11RMGmpJFqmqAR7Yrjd
         ceJ7dWSGZE7vc93c1PIbQhKGju5Jtv9wXfOCyjZOA0pK9P7HGA9SolnDXaV5jnxyMgo/
         COqA==
X-Gm-Message-State: APjAAAUIT2GxVNHdabbiisd1lhjmPIxwVN+GujyAzt8T1eb2z03wYAN1
        edBMmHMfpWnJFVtrFJVnYARFIjxySKfj6UvEzr7VIw==
X-Google-Smtp-Source: APXvYqwPWLd/A16AE0gUm5z5aVQkkyA4Kqfzj+l9H2a8gDKP/CZyO77wk4tA6+pJ3HwUcHYQCvkZer4atMcy2Ocqopk=
X-Received: by 2002:a9d:309:: with SMTP id 9mr27707445otv.230.1553734811474;
 Wed, 27 Mar 2019 18:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190327145331.215360-1-joel@joelfernandes.org> <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
In-Reply-To: <CAGXu5j+nhsL_s36R0k5APUfP6cNiH-BGEJu6mV6UcsP0i3gtyA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 28 Mar 2019 01:59:45 +0100
Message-ID: <CAG48ez1vZ5cngEKVtWTL9rz_K8K25b1sMKYrNs+jn4Va3KYucw@mail.gmail.com>
Subject: Re: [PATCH] Convert struct pid count to refcount_t
To:     Kees Cook <keescook@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 1:06 AM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Mar 27, 2019 at 7:53 AM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > struct pid's count is an atomic_t field used as a refcount. Use
> > refcount_t for it which is basically atomic_t but does additional
> > checking to prevent use-after-free bugs. No change in behavior if
> > CONFIG_REFCOUNT_FULL=n.
> >
> > Cc: keescook@chromium.org
> > Cc: kernel-team@android.com
> > Cc: kernel-hardening@lists.openwall.com
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > [...]
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 20881598bdfa..2095c7da644d 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -37,7 +37,7 @@
> >  #include <linux/init_task.h>
> >  #include <linux/syscalls.h>
> >  #include <linux/proc_ns.h>
> > -#include <linux/proc_fs.h>
> > +#include <linux/refcount.h>
> >  #include <linux/sched/task.h>
> >  #include <linux/idr.h>
> >
> > @@ -106,8 +106,8 @@ void put_pid(struct pid *pid)
> >                 return;
> >
> >         ns = pid->numbers[pid->level].ns;
> > -       if ((atomic_read(&pid->count) == 1) ||
> > -            atomic_dec_and_test(&pid->count)) {
> > +       if ((refcount_read(&pid->count) == 1) ||
> > +            refcount_dec_and_test(&pid->count)) {
>
> Why is this (and the original code) safe in the face of a race against
> get_pid()? i.e. shouldn't this only use refcount_dec_and_test()? I
> don't see this code pattern anywhere else in the kernel.

Semantically, it doesn't make a difference whether you do this or
leave out the "refcount_read(&pid->count) == 1". If you read a 1 from
refcount_read(), then you have the only reference to "struct pid", and
therefore you want to free it. If you don't get a 1, you have to
atomically drop a reference, which, if someone else is concurrently
also dropping a reference, may leave you with the last reference (in
the case where refcount_dec_and_test() returns true), in which case
you still have to take care of freeing it.

My guess is that the goal of this is to make the "drop last reference"
case a little bit faster by avoiding the cacheline dirtying and the
atomic op, at the expense of an extra memory op and branch every time
we drop a non-final reference. But that's a pretty low-level
optimization, and forking by itself isn't exactly fast... I think the
clean thing to do would be to either move this detail into the
refcount implementation (if it turns out to actually be valuable in at
least a microbenchmark), or just get rid of it. Given the overhead of
fork()/clone(), I would be surprised if you could actually measure
this effect here.

Eric, can you remember the rationale for doing it that way in commit
92476d7fc0326a409ab1d3864a04093a6be9aca7? Am I guessing correctly?
