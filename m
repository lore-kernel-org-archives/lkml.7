Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D206C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D1926877
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 11:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggoMtVkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfEaL5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 07:57:15 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42947 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbfEaL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 07:57:14 -0400
Received: by mail-ot1-f66.google.com with SMTP id i2so7906620otr.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpFjn7QsmPn7gjQCM9ineIkv1noxcgSAUiCpDRJVGls=;
        b=ggoMtVkvlG2qeUN8pOMIN1TvDP/+0BIR4qcfVhviE9WDfOjfXeGyjpI+W8QnoUmxcJ
         x2nwoKGdoSv0EozQ2yVJeh0oozpuqn0bm3oClCut0g9YfWOoGy4k8OKi5Woc1Tr6wdsR
         saCjBiOMkI52qqNRHrMW6N4gvn65yFptrOZx31LXYdPgIvxnfwm0ddyiHDQYy5ngOdR8
         hB8y+5KTxRhiZEFuBdfQrU8TZ0MoRATlpTDWocL+1LY6KoAd6/KsWfNsYAWqXBWGn16I
         TGqOF89dydO5AY4Ooobb/y61+zEwGES1n/6oWV/AQYIDdJtcTSGt+nwd3u+HZRfK2riV
         etIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpFjn7QsmPn7gjQCM9ineIkv1noxcgSAUiCpDRJVGls=;
        b=SWriMihw4gWKZZTF3ugufXeHyGbAWeODVdORyJgzMw8rzntbcrEvfC7OhQe9kjDFjw
         wNPucfQSwnwbNv+dBJ6UJ5ULNfR4rLWdl/Yoweu/mJyzC1YsJjaVO12kKFYjCKe70iJO
         50YoTJaFx7Wa8N3T5ECIRtO+rMwNuddbVuQp/8kxJhAKGVQOR/Fm01Np3a0cXNaKDO/9
         XuXPAhT4/bgVxbqaqkL0/MaqIY4/KnUWgzBMq2AlLflhiyTej04eiV3nBMcN/NakgVZl
         YwoMYzroE0Je4KDg8F7VKT4ixyaNbrEtmR9Z5TLJYRAiuxEEsJ0ADyzmxKMSovdfuk2s
         6M1w==
X-Gm-Message-State: APjAAAW2xJBQ5wit0+4pOx6cZlsgb6/E+OzmHXhpnr6m9v0Mj3/8XHwn
        z/FMTuhBnPYHIWxU6NYJB3CD4v2XZJ3ZkY5uUvWTpQ==
X-Google-Smtp-Source: APXvYqzPMHqTSDmVvn+uwCrjm0kig8jLmBdto0sGBqXKrrdWB4kGfXZ/dGE1UTqnPsAhq0M8Y3sS7ZDD/TN+H4jp40s=
X-Received: by 2002:a9d:2f26:: with SMTP id h35mr1498224otb.183.1559303833714;
 Fri, 31 May 2019 04:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <20190530123452.GF22536@redhat.com>
In-Reply-To: <20190530123452.GF22536@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 31 May 2019 13:56:47 +0200
Message-ID: <CAG48ez0ivQ+gfwKMife-3ZwBuqAuc1BhDGW3dtYTHMq0sByuNw@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 2:35 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/29, Jann Horn wrote:
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -450,6 +450,15 @@ int commit_creds(struct cred *new)
> >               if (task->mm)
> >                       set_dumpable(task->mm, suid_dumpable);
> >               task->pdeath_signal = 0;
> > +             /*
> > +              * If a task drops privileges and becomes nondumpable,
> > +              * the dumpability change must become visible before
> > +              * the credential change; otherwise, a __ptrace_may_access()
> > +              * racing with this change may be able to attach to a task it
> > +              * shouldn't be able to attach to (as if the task had dropped
> > +              * privileges without becoming nondumpable).
> > +              * Pairs with a read barrier in __ptrace_may_access().
> > +              */
> >               smp_wmb();
>
> Hmm. Now that I tried to actually read this patch I do not understand this wmb().
>
> commit_creds() does rcu_assign_pointer(real_cred) which implies smp_store_release(),
> the dumpability change must be visible before ->real_cred is updated without any
> additional barriers?

Oh, yes, I think you're right.

So I guess I should make a v2 that still adds the smp_rmb() in
__ptrace_may_access(), but gets rid of the smp_wmb() in
commit_creds()? (With a comment above the rcu_assign_pointer() that
explains the ordering?)
