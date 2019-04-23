Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D861C282E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8BE4218D2
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 23:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDWXSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 19:18:08 -0400
Received: from namei.org ([65.99.196.166]:35470 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbfDWXSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 19:18:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x3NNI430029385;
        Tue, 23 Apr 2019 23:18:04 GMT
Date:   Wed, 24 Apr 2019 09:18:04 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 3.4.x" <stable@vger.kernel.org>
Subject: Re: [PATCH 2/2] seccomp: disallow NEW_LISTENER and TSYNC flags
In-Reply-To: <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1904240917350.29297@namei.org>
References: <20190306201413.14153-1-tycho@tycho.ws> <20190306201413.14153-2-tycho@tycho.ws> <CAGXu5jKaK-mTq=Qez7E_fYysz916_xEN7Houj-y8gdmNGkMMVw@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019, Kees Cook wrote:

> Thanks! Sorry I missed this. James, can you take this for Linus's
> fixes for v5.1? (Or should I send a pull request to you?)
> 
> Acked-by: Kees Cook <keescook@chromium.org>

These are standalone for v5.1 fixes currently so you can send them 
directly to Linus.

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
> 

-- 
James Morris
<jmorris@namei.org>

