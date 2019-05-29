Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66874C28CC0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E29523FEB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 17:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tHGziVnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfE2RjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 13:39:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42864 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbfE2RjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 13:39:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id i2so1900762otr.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 10:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IL4grA2grC2uD2MfsPerYcOwRmk1qvHxFt7EjFCcCxc=;
        b=tHGziVntBwpAQvesQSGMXd8IKkFGQjWxP+Dn9UOMwzhbP/AVEkhN8tw3umvRN8A958
         qSHHs/dfYiTJiQ1jFQitSoEL2PHMUu4SkoRna6duQMtzWo6uPgYvTFGYLedmNJdLZ7uf
         6Fa/iBfaDY5ao60UglXngp0s4H2j5F9sU9eE6hXgU2aZB6sgRI6SpWLGJlBetbts4eyz
         8RpklQ3CnMElqKY+tVQTfCf/0C5SdI8k96NspSpqeGgNqxh0f31jAF+Dpv5zSzk1yOKU
         6M/3rNKaQ8ugfn2NkMWje1icUz80AhSlgh+SSI80hApjbFJ9+TntCNVTLDFaX6o2bJ1m
         z01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL4grA2grC2uD2MfsPerYcOwRmk1qvHxFt7EjFCcCxc=;
        b=iR/Ju4Y6wPL8h2MaGDtm5T4shuA/G1mBRJJo6SknmSA+S60kYqvLzuQNZuqP7bWxpg
         IWjDFG55fius4OTTG6B+tbEKhYUaNrNqGwOE9zAp7FleYAZMiAenwafil4fLPe0ydu3T
         2tSysw4629OKpJ+J2Xwyg9v6BOR9iwdqjZCf19r4dcVHvROfo6SEll7Vwp7LNhYKlGgX
         yHu9pj12bW24VcESxFdgASqTEKEhvgDm0fbE1YbEUxJz+/Qbef6rerja5w9UG5KbZlTQ
         ur7+96m78cYd0XOOLkn3/a9ge338ecFaivuECE8AYOdHN3LU6KXspEeRuqcmqkZ1BCUv
         LoXQ==
X-Gm-Message-State: APjAAAWW2J8mf5QDUcUzldOPtmCzDCUF7fB0wy3WmSL6neXzyz7DJYcr
        E3u9nve0mQ3sp6GQqjXLsT0CFSCzVNREHpQ8UdY3KA9U2GA=
X-Google-Smtp-Source: APXvYqz19197eZzTMJfGngt9PtgcOR2rfMiMkAMzU687ceHk7uS98vFHfvJbAwfFh1gcNmv+gUn3MuLFb0utkFecm3g=
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr16179otp.110.1559151552707;
 Wed, 29 May 2019 10:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190529113157.227380-1-jannh@google.com> <20190529162120.GB27659@redhat.com>
In-Reply-To: <20190529162120.GB27659@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 29 May 2019 19:38:46 +0200
Message-ID: <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
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

On Wed, May 29, 2019 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> On 05/29, Jann Horn wrote:
> > (I have no clue whatsoever what the relevant tree for this is, but I
> > guess Oleg is the relevant maintainer?)
>
> we usually route ptrace changes via -mm tree, plus I lost my account on korg.
>
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> >       return -EPERM;
> >  ok:
> >       rcu_read_unlock();
> > +     /*
> > +      * If a task drops privileges and becomes nondumpable (through a syscall
> > +      * like setresuid()) while we are trying to access it, we must ensure
> > +      * that the dumpability is read after the credentials; otherwise,
> > +      * we may be able to attach to a task that we shouldn't be able to
> > +      * attach to (as if the task had dropped privileges without becoming
> > +      * nondumpable).
> > +      * Pairs with a write barrier in commit_creds().
> > +      */
> > +     smp_rmb();
>
> (I am wondering if smp_acquire__after_ctrl_dep() could be used instead, just to
>  make this code look more confusing)

Uuh, I had no idea that that barrier type exists. The helper isn't
even explicitly mentioned in Documentation/memory-barriers.rst. I
don't really want to use dark magic in the middle of ptrace access
logic...

Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
make sense here; quoting the documentation: "A load-load control
dependency requires a full read memory barrier, not simply a data
dependency barrier to make it work correctly". IIUC
smp_acquire__after_ctrl_dep() is for cases in which you would
otherwise need a full memory barrier - smp_mb() - and you want to be
able to reduce it to a read barrier.

> >       mm = task->mm;
>
> while at it, could you also change this into mm = READ_ONCE(task->mm) ?

I'm actually trying to get rid of the ->mm access in
__ptrace_may_access() entirely by moving the dumpability and the
user_ns into the signal_struct, but I don't have patches for that
ready (yet).
