Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED3AC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22B5720868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 11:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ljtMKRsj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfFGLyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 07:54:21 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:64681 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbfFGLyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 07:54:20 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x57Bs4T6021276
        for <linux-kernel@vger.kernel.org>; Fri, 7 Jun 2019 20:54:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x57Bs4T6021276
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1559908445;
        bh=yjJIkGv4N/Xf1t1dfhzEbr33tkWF/j1kDW4mhPzpoi8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ljtMKRsjd34H40D8XOCp892dtvuyr0JsD4TFSVL79eBcHny4O0bYUaPs/55qK6Oxs
         w0EvELYb06nQ4FK80AX9WbnlTTX6oqGMZSfCggWZhgs5u7POvfEhVRATsvD+aj4sAC
         2Ztb1TBX7+sk4oIQzNDsRJUB2p1p4wcG1W1zR31Wzs9pGyiLwzs5wv5Qtu8Y8HEpIx
         twpZCw4jaS6OIPWLyWmUp/pfEJp9YKJWrvT6T22IAFxatq9xLCnyS/cA8MWWS+amvg
         rXaoPSOTXtYFZQWiq8iSnOeWjYaP1fYRynKHL0p+VKqjaKu4MZXcIRnGNZ56PfeQmq
         14ZTHh4o67sDQ==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id g24so962876vso.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 04:54:05 -0700 (PDT)
X-Gm-Message-State: APjAAAWXF2bM+izKZ1Df1Ko+xJKFdYTynnsoN2bIdr8hV+UK4nZbOuVo
        2U63Wjpsb9+4/eW/H7Qbdr04jvGDlWUT9Ga/uFQ=
X-Google-Smtp-Source: APXvYqx3nRjMerLd604okkquDXA2Hqfe1B88+1xal339VII15Zixeunjgspw3qhHsgZOa/YXUi7NIE8gcphAeFPfoMI=
X-Received: by 2002:a67:de99:: with SMTP id r25mr27157338vsk.215.1559908443989;
 Fri, 07 Jun 2019 04:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190604174412.13324-1-yamada.masahiro@socionext.com> <CAJZ5v0jXKNr3_W9B_raetj42UOdphA3GEE_Qh7nBSwDzwXfA1Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0jXKNr3_W9B_raetj42UOdphA3GEE_Qh7nBSwDzwXfA1Q@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 7 Jun 2019 20:53:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNASboJSJ969T_WZ041RTr1RvtARAyyxCg46zBu-vL0+jtw@mail.gmail.com>
Message-ID: <CAK7LNASboJSJ969T_WZ041RTr1RvtARAyyxCg46zBu-vL0+jtw@mail.gmail.com>
Subject: Re: [PATCH] kobject: return -ENOSPC when add_uevent_var() fails
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 5, 2019 at 5:53 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jun 4, 2019 at 8:00 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > This function never attempts to allocate memory, so returning -ENOMEM
> > looks weird to me.
>
> And why is the "looks weird to me" a good enough reason for making
> changes like this?


Since the code is read much more than written,
this change eliminates the question of "why -ENOMEM here?"



Masahiro Yamada


> The existing behavior is known and documented AFAICS and is it really
> so confusing?
>
> > The reason of the failure is there is no more space
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
> >         if (env->envp_idx >= ARRAY_SIZE(env->envp)) {
> >                 WARN(1, KERN_ERR "add_uevent_var: too many keys\n");
> > -               return -ENOMEM;
> > +               return -ENOSPC;
> >         }
> >
> >         va_start(args, format);
> > @@ -668,7 +668,7 @@ int add_uevent_var(struct kobj_uevent_env *env, const char *format, ...)
> >
> >         if (len >= (sizeof(env->buf) - env->buflen)) {
> >                 WARN(1, KERN_ERR "add_uevent_var: buffer size too small\n");
> > -               return -ENOMEM;
> > +               return -ENOSPC;
> >         }
> >
> >         env->envp[env->envp_idx++] = &env->buf[env->buflen];
> > --
> > 2.17.1
