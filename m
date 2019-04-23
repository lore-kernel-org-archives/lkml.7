Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DB7C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39706217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="1OqYevV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728743AbfDWXe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:34:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45096 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728353AbfDWXe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:34:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id o5so3943628pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 16:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MALde4lP6rh1PWXA9hrzqydO+Q6wyHbiYvOGH6NfwQ4=;
        b=1OqYevV8mEckbYGIr8SKov85rltfHacI8M18qlOuHIvNBoRI1AKSm5XWUSEP9tpngr
         e7bQ0+fn7q9lTMIdoZjdzSXUxPqTQxqwrpgZ9nhY4aXLzfjHydb+RKc831rI69bnlB95
         4FfGfPhYwFiqp23w5OhKAr1bZpEJ84eU1BB6ftNzh7Mc74CF5R1aOCLkY7sRtfvqX3dT
         sdVtB4pgo9uk1xgQcfHHl1gDivaNq/ld707TWnAYtwSlJcXmQ0jrNYVJMxNZ6L4VcSx5
         p8gQgIUmj17O5g6WsHuoNro6vd5zHNtP7zUFQHOXC1USuJEOIlidR8FjKhnmI9doZWWZ
         Yg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MALde4lP6rh1PWXA9hrzqydO+Q6wyHbiYvOGH6NfwQ4=;
        b=ls1NaCdi8L3V0wg2XbHyVDdtwnYqb58tXHQnJS7K9XCG7erHt1EPywF6LMw5mVYjoa
         GEFS2F8vHVqfE2RmTC9R/hQK6Uc9gaqqVzeBTalyppjIfHGcIGY8ujAi3Evx8dd5aMwU
         Wiu0cJE2dNfgVZ6TIhuVq83tTtztEKKmxr/TBKA6Tj1wbKNTJmyIkF0j6PfSuACLwKYk
         V/A7GCPdNXCu8KIQ9AyVm37E+eh4bNJT6P2EUF9bvNMBrHyVHjD52aVN8+bTfRVjgPlu
         NOFYQPAKCU4wk6PNbZF1nrZT14oWFg+wcYHoBLpmcSEYXuMUZ0+qgT2gj8c4GnGNtKud
         jO7Q==
X-Gm-Message-State: APjAAAWlo+Tjb16n96y3zvkHZtZcu5RfwOg4ShZbnXznUy90bkRUcRo1
        UdvbvbTCvRaMQD/t5YmTEwuYLHoTNal/9Q==
X-Google-Smtp-Source: APXvYqz6oQadzjqXmCLYny9+EwJPJNCbWQCOXNxSgWoh7UCkvtX/hLtcjTA3VzI65AP3BkvVrW9Z+A==
X-Received: by 2002:a17:902:505:: with SMTP id 5mr16201485plf.323.1556062465013;
        Tue, 23 Apr 2019 16:34:25 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
        by smtp.gmail.com with ESMTPSA id 17sm31327648pfw.65.2019.04.23.16.34.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Apr 2019 16:34:24 -0700 (PDT)
Date:   Tue, 23 Apr 2019 17:34:22 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
Message-ID: <20190423233422.GK3758@cisco>
References: <20190306201413.14153-1-tycho@tycho.ws>
 <20190306201413.14153-2-tycho@tycho.ws>
 <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
 <CAGXu5jKM1k0roNJEqtns2fe-yY_2G_qhvBHids-ZWimL-ddWsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jKM1k0roNJEqtns2fe-yY_2G_qhvBHids-ZWimL-ddWsw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 23, 2019 at 04:31:45PM -0700, Kees Cook wrote:
> On Tue, Apr 23, 2019 at 3:09 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Wed, Mar 6, 2019 at 12:14 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > As the comment notes, the return codes for TSYNC and NEW_LISTENER conflict,
> > > because they both return positive values, one in the case of success and
> > > one in the case of error. So, let's disallow both of these flags together.
> > >
> > > While this is technically a userspace break, all the users I know of are
> > > still waiting on me to land this feature in libseccomp, so I think it'll be
> > > safe. Also, at present my use case doesn't require TSYNC at all, so this
> > > isn't a big deal to disallow. If someone wanted to support this, a path
> > > forward would be to add a new flag like
> > > TSYNC_AND_LISTENER_YES_I_UNDERSTAND_THAT_TSYNC_WILL_JUST_RETURN_EAGAIN, but
> > > the use cases are so different I don't see it really happening.
> > >
> > > Finally, it's worth noting that this does actually fix a UAF issue: at the end
> > > of seccomp_set_mode_filter(), we have:
> > >
> > >         if (flags & SECCOMP_FILTER_FLAG_NEW_LISTENER) {
> > >                 if (ret < 0) {
> > >                         listener_f->private_data = NULL;
> > >                         fput(listener_f);
> > >                         put_unused_fd(listener);
> > >                 } else {
> > >                         fd_install(listener, listener_f);
> > >                         ret = listener;
> > >                 }
> > >         }
> > > out_free:
> > >         seccomp_filter_free(prepared);
> > >
> > > But if ret > 0 because TSYNC raced, we'll install the listener fd and then free
> > > the filter out from underneath it, causing a UAF when the task closes it or
> > > dies. This patch also switches the condition to be simply if (ret), so that
> > > if someone does add the flag mentioned above, they won't have to remember
> > > to fix this too.
> > >
> > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > > Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> > > CC: stable@vger.kernel.org # v5.0+
> >
> > Thanks! Sorry I missed this. James, can you take this for Linus's
> > fixes for v5.1? (Or should I send a pull request to you?)
> >
> > Acked-by: Kees Cook <keescook@chromium.org>
> >
> > Let's also add:
> >
> > Reported-by: syzbot+b562969adb2e04af3442@syzkaller.appspotmail.com
> >
> > > ---
> > >  kernel/seccomp.c | 17 +++++++++++++++--
> > >  1 file changed, 15 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index d0d355ded2f4..79bada51091b 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -500,7 +500,10 @@ seccomp_prepare_user_filter(const char __user *user_filter)
> > >   *
> > >   * Caller must be holding current->sighand->siglock lock.
> > >   *
> > > - * Returns 0 on success, -ve on error.
> > > + * Returns 0 on success, -ve on error, or
> > > + *   - in TSYNC mode: the pid of a thread which was either not in the correct
> > > + *     seccomp mode or did not have an ancestral seccomp filter
> > > + *   - in NEW_LISTENER mode: the fd of the new listener
> > >   */
> > >  static long seccomp_attach_filter(unsigned int flags,
> > >                                   struct seccomp_filter *filter)
> > > @@ -1256,6 +1259,16 @@ static long seccomp_set_mode_filter(unsigned int flags,
> > >         if (flags & ~SECCOMP_FILTER_FLAG_MASK)
> > >                 return -EINVAL;
> > >
> > > +       /*
> > > +        * In the successful case, NEW_LISTENER returns the new listener fd.
> > > +        * But in the failure case, TSYNC returns the thread that died. If you
> > > +        * combine these two flags, there's no way to tell whether something
> > > +        * succeded or failed. So, let's disallow this combination.
> >
> > also a tiny typo: succeeded
> >
> > > +        */
> > > +       if ((flags & SECCOMP_FILTER_FLAG_TSYNC) &&
> > > +           (flags && SECCOMP_FILTER_FLAG_NEW_LISTENER))
> 
> also a typo: && should be &

Oh, yes. Do you want me to send another version?

Tycho
