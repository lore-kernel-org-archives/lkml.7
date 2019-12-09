Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9268C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABFE620866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575902617;
	bh=qOcz9nsuR9MkgwDqtN0nvDMzLDe1riIkSq5oRSkC7e4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fBbZa/mRFpx9MoJzxJElbwV8qEdOp59sECcyhh7uEw5cH2r7hf5AGoV+oDKZUQeXw
	 unxiSUg7yF6VpSgy02fIvw8uKFW5RoJDY0RuahJ/5Z8aX1RR0HKitMYY3bNs0+GdBl
	 Qa0xe1P4K5qRz3xka9nCEUHbPxLQ5m3+g6VTNOPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfLIOng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:43:36 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56198 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbfLIOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:43:36 -0500
Received: by mail-wm1-f67.google.com with SMTP id q9so15773257wmj.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 06:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5GMrlDTJZgtlmwpkaFtSDadNDfv99seyl6nQwayimsA=;
        b=pdlBTrpRLbnz32b/1c1oiv1TQ4ys41nnGHQc3qPNlMP35assplQ0ZD6VMQ2KmGWmbJ
         unF4CtInhA3xLB/28qiCVfhZZnTJBN/p9bFeIpBDSKMuof1IRjmvZhhNJs5NPDhv/87I
         9y2eyJzpAwYuxdUO94AUxQnQIhQMbcFoz/8VwIq4UJvjTqvMoKwB/+Cl1rWE/U80WNGb
         cgG7x1qjVb7gOYYQETFVlQlHYkuZdOqYOlCKoNRTUwPUEkREJpGSnZm5/mv/+tbA+IMx
         PU3mb3an9rfUq5ax4WRoqKKNMUOF7ILy5PgBXaHle+1TnBNuBCsLTzEg07HX1EZ29UUL
         z4cg==
X-Gm-Message-State: APjAAAWjxEWHFvW6ZyYA71OSu87sfYKz+QIxEQXmEsDFY7wDanOH9mVT
        sMjUCFPwyjwNYPOAmYLLRfM=
X-Google-Smtp-Source: APXvYqzn0eMk4JDUlv6X+P0C1L5Eb29E1giMVkZCuArPNDbgN+9AVUrkvAFe+KXAfBGHr05FLEINhw==
X-Received: by 2002:a1c:5448:: with SMTP id p8mr25624781wmi.70.1575902614236;
        Mon, 09 Dec 2019 06:43:34 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id t78sm13737425wmt.24.2019.12.09.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 06:43:33 -0800 (PST)
Date:   Mon, 9 Dec 2019 15:43:32 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
Message-ID: <20191209144332.GA24368@dhcp22.suse.cz>
References: <20191205223721.40034-1-shakeelb@google.com>
 <20191206081710.GK28317@dhcp22.suse.cz>
 <CALvZod4VgNJOXy+bMLvzDhpYUu8tBe-63aDA842LH4-O5f5zKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4VgNJOXy+bMLvzDhpYUu8tBe-63aDA842LH4-O5f5zKw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 06-12-19 08:51:21, Shakeel Butt wrote:
> On Fri, Dec 6, 2019 at 12:17 AM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Thu 05-12-19 14:37:21, Shakeel Butt wrote:
> > > The cred_jar kmem_cache is already memcg accounted in the current
> > > kernel but cred->security is not. Account cred->security to kmemcg.
> > >
> > > Recently we saw high root slab usage on our production and on further
> > > inspection, we found a buggy application leaking processes. Though that
> > > buggy application was contained within its memcg but we observe much
> > > more system memory overhead, couple of GiBs, during that period. This
> > > overhead can adversely impact the isolation on the system. One of source
> > > of high overhead, we found was cred->secuity objects.
> >
> > I am not familiar with this area much. What is the timelife of these
> > objects? Do they go away with a task allocating them?
> >
> 
> Lifetime is at least the life of the process allocating them.

Thanks for the clarification! It is better to be explicit about this in
the changelog I believe because it would make a review much easier.
Accounting for objects which are not bound to a user process context is
more complex and requires much more considerations.

> > > Signed-off-by: Shakeel Butt <shakeelb@google.com>

With that clarification
Acked-by: Michal Hocko <mhocko@suse.com>

> > >
> > > ---
> > >  kernel/cred.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/kernel/cred.c b/kernel/cred.c
> > > index c0a4c12d38b2..9ed51b70ed80 100644
> > > --- a/kernel/cred.c
> > > +++ b/kernel/cred.c
> > > @@ -223,7 +223,7 @@ struct cred *cred_alloc_blank(void)
> > >       new->magic = CRED_MAGIC;
> > >  #endif
> > >
> > > -     if (security_cred_alloc_blank(new, GFP_KERNEL) < 0)
> > > +     if (security_cred_alloc_blank(new, GFP_KERNEL_ACCOUNT) < 0)
> > >               goto error;
> > >
> > >       return new;
> > > @@ -282,7 +282,7 @@ struct cred *prepare_creds(void)
> > >       new->security = NULL;
> > >  #endif
> > >
> > > -     if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> > > +     if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
> > >               goto error;
> > >       validate_creds(new);
> > >       return new;
> > > @@ -715,7 +715,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
> > >  #ifdef CONFIG_SECURITY
> > >       new->security = NULL;
> > >  #endif
> > > -     if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> > > +     if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
> > >               goto error;
> > >
> > >       put_cred(old);
> > > --
> > > 2.24.0.393.g34dc348eaf-goog
> > >
> >
> > --
> > Michal Hocko
> > SUSE Labs

-- 
Michal Hocko
SUSE Labs
