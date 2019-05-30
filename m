Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B473AC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0482A2575B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 10:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hWkLbGYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfE3KeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 06:34:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52888 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfE3KeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 06:34:13 -0400
Received: by mail-wm1-f68.google.com with SMTP id y3so3628857wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 03:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B9pXGgnYugj0/ik2ABlI402Ldxapsq6a6ECwu1vzmTc=;
        b=hWkLbGYH5hIzC5AZLiF3wawIfaq3RXDKTzP5UV69zSgwwweFujeBCzOl+zjwVh1oNO
         rt3sODjcZ48J7O/pYCQ7jKuSK4VvVPZJlL+2k8wD8An9FFXpoJtoYufdR2qddpT5tzuv
         vcf8AkEdZpDOqjO3ZUFKF2e9t02FinVnAcXTk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B9pXGgnYugj0/ik2ABlI402Ldxapsq6a6ECwu1vzmTc=;
        b=ZxKswnai30MFzg+3SFMp6CX0hMsxHYbNmGATohFvwT11TJSZkoTacby7nqT2BYQQTG
         oPmDeOD0W3Z6XlWtNM5QvSnYeyvSNw2iJ53sXVigloP2v0vVoT9kEaH1pqgQS8UxEGau
         vxwXLHzzxViDgsRxrG0BwecFtLVRwo/pBJPBrUt5GhibMzFUgU+6TXoo3ZVtXS4dzCW6
         +549+IQGCznWxGGnoD2/KaFoWOv+T6+Zl80hebw29XQivB42g/xVl9fuYYfJ5dtNrEam
         iuLk3WscPNlZ24QiwTMngsXVsJcruhNSM8g9pHBYeqSVirvYA0suFFPwUXt0x198VKFM
         w4Aw==
X-Gm-Message-State: APjAAAWMcVufa9JN0KBOw2/7sss6CISVTynN9pdJrSiRTElTzNBd/YP9
        tGSDPkcdxhof7yLzsB97QOrmhw==
X-Google-Smtp-Source: APXvYqytAjrhEanXCGO8QkDs35b3hA5kF1zIWDnEJ9+HL4KvYTZTus7RA6/jNqZfzO/eES1HQXVJ6g==
X-Received: by 2002:a7b:c043:: with SMTP id u3mr1284824wmc.56.1559212451294;
        Thu, 30 May 2019 03:34:11 -0700 (PDT)
Received: from andrea (86.100.broadband17.iol.cz. [109.80.100.86])
        by smtp.gmail.com with ESMTPSA id d10sm2174139wrh.91.2019.05.30.03.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 03:34:10 -0700 (PDT)
Date:   Thu, 30 May 2019 12:34:05 +0200
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: Re: [PATCH] ptrace: restore smp_rmb() in __ptrace_may_access()
Message-ID: <20190530103405.GA6392@andrea>
References: <20190529113157.227380-1-jannh@google.com>
 <20190529162120.GB27659@redhat.com>
 <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3S1c_cd8RNSb9TrF66d+1AMAxD4zh-kixQ6uSEnmS-tg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 07:38:46PM +0200, Jann Horn wrote:
> On Wed, May 29, 2019 at 6:21 PM Oleg Nesterov <oleg@redhat.com> wrote:
> > On 05/29, Jann Horn wrote:
> > > (I have no clue whatsoever what the relevant tree for this is, but I
> > > guess Oleg is the relevant maintainer?)
> >
> > we usually route ptrace changes via -mm tree, plus I lost my account on korg.
> >
> > > --- a/kernel/ptrace.c
> > > +++ b/kernel/ptrace.c
> > > @@ -324,6 +324,16 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
> > >       return -EPERM;
> > >  ok:
> > >       rcu_read_unlock();
> > > +     /*
> > > +      * If a task drops privileges and becomes nondumpable (through a syscall
> > > +      * like setresuid()) while we are trying to access it, we must ensure
> > > +      * that the dumpability is read after the credentials; otherwise,
> > > +      * we may be able to attach to a task that we shouldn't be able to
> > > +      * attach to (as if the task had dropped privileges without becoming
> > > +      * nondumpable).
> > > +      * Pairs with a write barrier in commit_creds().
> > > +      */
> > > +     smp_rmb();
> >
> > (I am wondering if smp_acquire__after_ctrl_dep() could be used instead, just to
> >  make this code look more confusing)
> 
> Uuh, I had no idea that that barrier type exists. The helper isn't
> even explicitly mentioned in Documentation/memory-barriers.rst. I
> don't really want to use dark magic in the middle of ptrace access
> logic...
> 
> Anyway, looking at it, I think smp_acquire__after_ctrl_dep() doesn't
> make sense here; quoting the documentation: "A load-load control
> dependency requires a full read memory barrier, not simply a data
> dependency barrier to make it work correctly". IIUC
> smp_acquire__after_ctrl_dep() is for cases in which you would
> otherwise need a full memory barrier - smp_mb() - and you want to be
> able to reduce it to a read barrier.

It is supposed to be used when you want an ACQUIRE but you only have a
control dependency (so you "augment the dependency" with this barrier).

FWIW, I do agree on the "dark magic"..., and I'd strongly recommend to
not use this barrier (or, at least, to use it with high suspicion).

  Andrea
