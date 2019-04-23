Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EACC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F25820449
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VMu+Wj6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbfDWXcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:32:02 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46773 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfDWXcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:32:02 -0400
Received: by mail-vs1-f68.google.com with SMTP id e2so9310077vsc.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8+kW8bKsMARMlPqiiJiCdwyj3Fd3gvr9k9+st84wkXc=;
        b=VMu+Wj6IS2oJBa1CN0LDVQKnAhjeprqkqt6TaEdydVe+HYkW1mkWW+6UHCBJ8nn12G
         CoZyhx4qZ46CvyluwaVHukaHVZ0C8WmUC6GIk3THRGXXP0qLw6SmHnB/rHBqr7CjJ39B
         vHLo4uqHFhwy3MatZguo1ndCbkbe8le9Vhms4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8+kW8bKsMARMlPqiiJiCdwyj3Fd3gvr9k9+st84wkXc=;
        b=SNe4Nvw4U27PGRokJi5/hh0JOrYxH7dT8uUXIGnt0mTh0+CQrWdUMzuP9uJMTJ/qaP
         2EwrY6pEdeJlXpLwIHbjQNdeMBimI03U8dzg5alXk6G7U4HDpHBrT3urLbxySRsEyZ+p
         sdtf0Bd2zwI9IbnMJai7RVA97yr6diH4gS9tBhhF4tTAiTwtEAS5GVb2y5OI1yEwQx00
         B4BrLON0gapm0NJ/msdsSSpR5NU4pDLKXAKAZcgGP3Xpxdk2dae/G+cNPV9p+mWNLwlw
         6vyEdiIa0j/QXImIm9VOHwR0iGcRaexgQK1MF0uY1Zp8XH0Laom55/wuTSAJcQy46W/p
         WDCA==
X-Gm-Message-State: APjAAAW7Vh7KwT2cl7+amaoF7aGk4HwLcSEl1TvJHhFX/b1kc2J6Hf/k
        rKxTHuBd7jCNLcSiZkGXH4JjJ+jQ63M=
X-Google-Smtp-Source: APXvYqygFLZxeGqQ0qhcMyxH7ADNtdY5Z6CBuGHfXINT+R+MGaL+if3AY7uN4MQfIT15Q6sj6ljIww==
X-Received: by 2002:a67:bd01:: with SMTP id y1mr14461410vsq.167.1556062320365;
        Tue, 23 Apr 2019 16:32:00 -0700 (PDT)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com. [209.85.222.45])
        by smtp.gmail.com with ESMTPSA id 2sm19378731vke.27.2019.04.23.16.31.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:31:59 -0700 (PDT)
Received: by mail-ua1-f45.google.com with SMTP id l22so5397228uao.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:31:59 -0700 (PDT)
X-Received: by 2002:a9f:2d88:: with SMTP id v8mr3945340uaj.2.1556062318840;
 Tue, 23 Apr 2019 16:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190306201413.14153-1-tycho@tycho.ws> <20190306201413.14153-2-tycho@tycho.ws>
 <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
In-Reply-To: <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 16:31:45 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKM1k0roNJEqtns2fe-yY_2G_qhvBHids-ZWimL-ddWsw@mail.gmail.com>
Message-ID: <CAGXu5jKM1k0roNJEqtns2fe-yY_2G_qhvBHids-ZWimL-ddWsw@mail.gmail.com>
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
To:     Tycho Andersen <tycho@tycho.ws>, James Morris <jmorris@namei.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 3:09 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Mar 6, 2019 at 12:14 PM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > As the comment notes, the return codes for TSYNC and NEW_LISTENER conflict,
> > because they both return positive values, one in the case of success and
> > one in the case of error. So, let's disallow both of these flags together.
> >
> > While this is technically a userspace break, all the users I know of are
> > still waiting on me to land this feature in libseccomp, so I think it'll be
> > safe. Also, at present my use case doesn't require TSYNC at all, so this
> > isn't a big deal to disallow. If someone wanted to support this, a path
> > forward would be to add a new flag like
> > TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN, but
> > the use cases are so different I don't see it really happening.
> >
> > Finally, it's worth noting that this does actually fix a UAF issue: at the end
> > of seccomp_set_mode_filter(), we have:
> >
> >         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> >                 if (ret < 0) {
> >                         listener_f->private_data = NULL;
> >                         fput(listener_f);
> >                         put_unused_fd(listener);
> >                 } else {
> >                         fd_install(listener, listener_f);
> >                         ret = listener;
> >                 }
> >         }
> > out_free:
> >         seccomp_filter_free(prepared);
> >
> > But if ret > 0 because TSYNC raced, we'll install the listener fd and then free
> > the filter out from underneath it, causing a UAF when the task closes it or
> > dies. This patch also switches the condition to be simply if (ret), so that
> > if someone does add the flag mentioned above, they won't have to remember
> > to fix this too.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> > CC: stable@vger.kernel.org # v5.0+
>
> Thanks! Sorry I missed this. James, can you take this for Linus's
> fixes for v5.1? (Or should I send a pull request to you?)
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Let's also add:
>
> Reported-by: syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com
>
> > ---
> >  kernel/seccomp.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index d0d355ded2f4..79bada51091b 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -500,7 +500,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
> >   *
> >   * Caller must be holding current->sighand->siglock lock.
> >   *
> > - * Returns 0 on success, -ve on error.
> > + * Returns 0 on success, -ve on error, or
> > + *   - in TSYNC mode: the pid of a thread which was either not in the correct
> > + *     seccomp mode or did not have an ancestral seccomp filter
> > + *   - in NEW_LISTENER mode: the fd of the new listener
> >   */
> >  static long seccomp_attach_filter(unsigned int flags,
> >                                   struct seccomp_filter *filter)
> > @@ -1256,6 +1259,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
> >         if (flags & ~SECCOMP_FILTER_FLAG_MASK)
> >                 return -EINVAL;
> >
> > +       /*
> > +        * In the successful case, NEW_LISTENER returns the new listener fd.
> > +        * But in the failure case, TSYNC returns the thread that died. If you
> > +        * combine these two flags, there's no way to tell whether something
> > +        * succeded or failed. So, let's disallow this combination.
>
> also a tiny typo: succeeded
>
> > +        */
> > +       if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
> > +           (flags && SECCOMP_FILTER_FLAG_NEW_LISTENER))

also a typo: && should be &

> > +               return -EINVAL;
> > +
> >         /* Prepare the new filter before holding any locks. */
> >         prepared = seccomp_prepare_user_filter(filter);
> >         if (IS_ERR(prepared))
> > @@ -1302,7 +1315,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
> >                 mutex_unlock(&current->signal->cred_guard_mutex);
> >  out_put_fd:
> >         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > -               if (ret < 0) {
> > +               if (ret) {
> >                         listener_f->private_data = NULL;
> >                         fput(listener_f);
> >                         put_unused_fd(listener);
> > --
> > 2.19.1
> >
>
> -Kees
>
> --
> Kees Cook



-- 
Kees Cook
