Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1824C4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B098920820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ITbLXu6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbfFJVK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:10:56 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:65110 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFJVK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:10:56 -0400
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x5ALAWZE002713
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 06:10:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x5ALAWZE002713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1560201033;
        bh=lNPyQit/PTVpbltD9uErMFNxvWNgSdq7GxMwpnt7v0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ITbLXu6jY/b6NkIh298KyjmCUcYAF+qt4/FbSWApfTS8GtT0qRQ7QVi3fYahThQmB
         j6LG4L8mOQUUEyw5teFFT45LCMbHEoxc1YuQwFYEh+/S1NtykOr6jaQXpkoEb/wuKY
         6+qdSwkf6wlbIMo3FowUtf5Nv1tJGk0CbaJmgfJ2VYASXawh44fwQpR0v/+aCuvi4c
         APk79aO3zYNhA2eY2ppsbOw04MfQr1YvewJ4h7hHcwdfO8kigRPJQjCj1jwnwfomjD
         nFFkRl3Cp0IHZ1bsf7PaIF6Bv+zKJWrGZlsGSPtMyzS020QBWFWpf/ugmgOC/A7E8f
         3qEYiX2yEWefQ==
X-Nifty-SrcIP: [209.85.217.45]
Received: by mail-vs1-f45.google.com with SMTP id a186so4606713vsd.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:10:33 -0700 (PDT)
X-Gm-Message-State: APjAAAUbxi8ajTD3UNf/Yy93gA/697UWDicvOVOHo+wSfXpq88t4AdMU
        BR6QT+PmGG/QlJkSezG+dyN2FvY8aUwiKYPTLts=
X-Google-Smtp-Source: APXvYqweJme3llImNA/qFC9wfjG0KEpluu7ZSNcLFL9FXISg9pYRvY9Og9Fi5f/+CEmA6sD9QKffU/JzbDto8XnSarI=
X-Received: by 2002:a67:de99:: with SMTP id r25mr38156248vsk.215.1560201032036;
 Mon, 10 Jun 2019 14:10:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190604174412.13324-1-yamada.masahiro@socionext.com> <20190610174538.GA10617@kroah.com>
In-Reply-To: <20190610174538.GA10617@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 11 Jun 2019 06:09:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS=Vt__0E_WXzTB76gkJ6bUng9P1_wiWCi5aRLTP=1Www@mail.gmail.com>
Message-ID: <CAK7LNAS=Vt__0E_WXzTB76gkJ6bUng9P1_wiWCi5aRLTP=1Www@mail.gmail.com>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2019 at 2:47 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 05, 2019 at 02:44:12AM +0900, Masahiro Yamada wrote:
> > This function never attempts to allocate memory, so returning -ENOMEM
> > looks weird to me. The reason of the failure is there is no more space
> > in the given kobj_uevent_env structure.
> >
> > No caller of this function relies on this functing returning a specific
> > error code, so just change it to return -ENOSPC. The intended change,
> > if any, is the error number displayed in log messages.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  lib/kobject_uevent.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/kobject_uevent.c b/lib/kobject_uevent.c
> > index 7998affa45d4..5ffd44bf4aad 100644
> > --- a/lib/kobject_uevent.c
> > +++ b/lib/kobject_uevent.c
> > @@ -647,7 +647,7 @@ EXPORT_SYMBOL_GPL(kobject_uevent);
> >   * @env: environment buffer structure
> >   * @format: printf format for the key=value pair
> >   *
> > - * Returns 0 if environment variable was added successfully or -ENOMEM
> > + * Returns 0 if environment variable was added successfully or -ENOSPC
> >   * if no space was available.
> >   */
> >  int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> > @@ -657,7 +657,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> >
> >       if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
> >               WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> > -             return -ENOMEM;
> > +             return -ENOSPC;
>
> As Rafael says, changing this for no good reason is not a good idea,
> sorry.  Let's live with it as-is unless you can show some place where
> this specific error value is causing problems.



Didn't you see WARN() above the return code?
I rephrased the commit log for clarification in v2.

Thanks.


-- 
Best Regards
Masahiro Yamada
