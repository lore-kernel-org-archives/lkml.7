Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88A2C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1AB206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KgyP6r57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbfLFQve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:51:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46633 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 11:51:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id g18so6291950otj.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 08:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xPuh9B5tA1ITgn+9ZrG/kJs2qr+bpLjJsSaWY7fdAo=;
        b=KgyP6r57AvYOFBqX+wQZ6q7l2at+HNopoVl4a4I4wceDk1CqdvTEjniPJHL/D+LRby
         TwiCltORjjt6/tDuvnNKvKkx+NaueuodMUgcbBA7s8tpIfGgGr4OgY107jPEsXJ9kYhF
         ZLsv6ctPPfIl9iY19SevdGnb//zH1gtP2sOwCItQyqL9UR/+hpV3WPYLaSwQMREJFOWg
         tUtiR42c3pRQB+DvHelzHS4hBp5ZoTxzGLQfcbgkvGHHkzBiPJtWIiqH+2ftmJOdLsJW
         k1Zt1kw3mDPj10YIrBiGleGLuy2/8tYuc17pZ7utS8C0vTCd2OM9KcWpNp/HqMPrkr9q
         ubxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xPuh9B5tA1ITgn+9ZrG/kJs2qr+bpLjJsSaWY7fdAo=;
        b=XBbItbChxZ+RrWkrl+G2hlJ2EH0IE8QK6L8Y2By678QtOsNZSvlyax7yTxPKVnQwJe
         yD238PC9Op8GZzMTEtO2+WsM/noy+ID6VT04usWHxlgWAVRd0+q4sCxWAGUPFVjZyLuz
         B50JlZa6SHBOP7T3UXjbVftBGmRmcl9pSbYJJcZIZVE2l2l/c3OD2IelitBRFilwl3bT
         Eio0E3+dxHy5hYS+v0L79uanDf4B4zvBtTUJQlKp+jgylPVjPCk5GAYuvZf+6Jbe5h1l
         Frc34EpWvbuF9fTsI/aqM/R8slaBx5lr5pB2vm/Z+8d+g53ZTyBsfcHuG2WOkDwSB/kC
         Enzw==
X-Gm-Message-State: APjAAAX8p+PQeflDAnfePKjOJcr7AZkDWTFysePGxkXBXb2JBUtbJvtq
        ZCSVrRdGGzbZR0U/+f6VZJTU+OlYexx8CLojt12pVA==
X-Google-Smtp-Source: APXvYqztPkRaphkD5UkuAdMxJrYSRE/BXcsGJ7WHcsOktDTvyh1JZbKCM05MoiGZlgZOlziI1oAePJAlvopeZYikfRw=
X-Received: by 2002:a05:6830:10d5:: with SMTP id z21mr12103032oto.30.1575651092606;
 Fri, 06 Dec 2019 08:51:32 -0800 (PST)
MIME-Version: 1.0
References: <20191205223721.40034-1-shakeelb@google.com> <20191206081710.GK28317@dhcp22.suse.cz>
In-Reply-To: <20191206081710.GK28317@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 6 Dec 2019 08:51:21 -0800
Message-ID: <CALvZod4VgNJOXy+bMLvzDhpYUu8tBe-63aDA842LH4-O5f5zKw@mail.gmail.com>
Subject: Re: [PATCH] memcg: account security cred as well to kmemcg
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 6, 2019 at 12:17 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 05-12-19 14:37:21, Shakeel Butt wrote:
> > The cred_jar kmem_cache is already memcg accounted in the current
> > kernel but cred->security is not. Account cred->security to kmemcg.
> >
> > Recently we saw high root slab usage on our production and on further
> > inspection, we found a buggy application leaking processes. Though that
> > buggy application was contained within its memcg but we observe much
> > more system memory overhead, couple of GiBs, during that period. This
> > overhead can adversely impact the isolation on the system. One of source
> > of high overhead, we found was cred->secuity objects.
>
> I am not familiar with this area much. What is the timelife of these
> objects? Do they go away with a task allocating them?
>

Lifetime is at least the life of the process allocating them.

> > Signed-off-by: Shakeel Butt <shakeelb@google.com>
> >
> > ---
> >  kernel/cred.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/kernel/cred.c b/kernel/cred.c
> > index c0a4c12d38b2..9ed51b70ed80 100644
> > --- a/kernel/cred.c
> > +++ b/kernel/cred.c
> > @@ -223,7 +223,7 @@ struct cred *cred_alloc_blank(void)
> >       new->magic = CRED_MAGIC;
> >  #endif
> >
> > -     if (security_cred_alloc_blank(new, GFP_KERNEL) < 0)
> > +     if (security_cred_alloc_blank(new, GFP_KERNEL_ACCOUNT) < 0)
> >               goto error;
> >
> >       return new;
> > @@ -282,7 +282,7 @@ struct cred *prepare_creds(void)
> >       new->security = NULL;
> >  #endif
> >
> > -     if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> > +     if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
> >               goto error;
> >       validate_creds(new);
> >       return new;
> > @@ -715,7 +715,7 @@ struct cred *prepare_kernel_cred(struct task_struct *daemon)
> >  #ifdef CONFIG_SECURITY
> >       new->security = NULL;
> >  #endif
> > -     if (security_prepare_creds(new, old, GFP_KERNEL) < 0)
> > +     if (security_prepare_creds(new, old, GFP_KERNEL_ACCOUNT) < 0)
> >               goto error;
> >
> >       put_cred(old);
> > --
> > 2.24.0.393.g34dc348eaf-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
