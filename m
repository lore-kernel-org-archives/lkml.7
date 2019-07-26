Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7330C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 941C2216C8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:24:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XDoWhlgr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbfGZIYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:24:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39489 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfGZIYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:24:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so309150wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dTMNPgcZu4HQt+W+ALl15OWNsBN8EGFm2xC7fuOCMxg=;
        b=XDoWhlgrTjy8nEnWKI84CpOGl75WX6k3MDA1P9+BTioZTvmWdQRS4ZC9Q1+TOkXzCE
         GJs/2YEhRiDfDiiarbI0YdCi8yfrSZGxpWmYGJeLxl3/HYk5/BHh2snjfZh+5Is6P7el
         FEd+eOp0//3b8GIMdG+WHS5XCgtIT6VQmwtep6PI/Llc2+G6ptjhjXjT0kwBmhDT3l54
         JSf2hUYUlBh0bXLbBbtoZi4UGOQou20BF+Pi54dF88YiK1wzVavZRnwnd9d46pu83Qqs
         Oo3Mn/Bvlm6wqvQ53fM1WXE0bjpbnJy3cJezmNInO/+hmge8DLMyxTGJ9nIDaJPu092m
         /9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dTMNPgcZu4HQt+W+ALl15OWNsBN8EGFm2xC7fuOCMxg=;
        b=c/P2voYpm0Ev1ZcNT+ieVLiot/pWY/GutOEbFALoEq4WKfAuxtuTfZDjfbKGnyC09I
         o0VGna0CvhESNnTAXFmXzVGkWfWVVNbK4adOFG0YYj8ciMgQSgEutkTdnP/1D3TePcpm
         lcUw3Q6Q/Vot3F+zzkDOuHJ2T9N1qm4++edVfl10N29PafgTKjpqRHxqwxmmRnIwAkDV
         tqLCuziBF4FFpYT6XLdOe5yNJbt+dY8ymebTR4o5tBCo/QtHJS65khVLgdLbUOOOnAVO
         fukRUpD5S4AjsEC1WKxGJV+sNtYDhBD3EblG7t0GHQzZWVe5zYSVkLzyr7M2Ju5tMDZ4
         Vigg==
X-Gm-Message-State: APjAAAXvDnEw5TWvUk/ExEpyjbLutIFxDl481sXvKGQ1D9kVdooWa/kd
        EYh8VAdCasn0C4Ptj7x7xl4=
X-Google-Smtp-Source: APXvYqzsULmWtIDULDkA+WIoh8mpIFX33B80kNi3KvMPdIs02vFTrJnf2V/O8i3VtWRZkI8cILUEpA==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr94406604wrw.73.1564129454817;
        Fri, 26 Jul 2019 01:24:14 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id m24sm31242457wmi.39.2019.07.26.01.24.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 01:24:14 -0700 (PDT)
Date:   Fri, 26 Jul 2019 10:24:13 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/5] pidfd: add pidfd_wait()
Message-ID: <20190726082413.n7srvcrqxmvk67z7@brauner.io>
References: <20190724144651.28272-1-christian@brauner.io>
 <20190724144651.28272-3-christian@brauner.io>
 <CAK8P3a0+3wqCzQv-A-QmWTtioFRGjYUvq6QiLysqi9OFs3kJsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK8P3a0+3wqCzQv-A-QmWTtioFRGjYUvq6QiLysqi9OFs3kJsw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 10:19:55AM +0200, Arnd Bergmann wrote:
> On Wed, Jul 24, 2019 at 4:47 PM Christian Brauner <christian@brauner.io> wrote:
> 
> > +
> > +static int copy_rusage_to_user_any(struct rusage *kru, struct rusage __user *ru)
> > +{
> > +#ifdef CONFIG_COMPAT
> > +       if (in_compat_syscall())
> > +               return put_compat_rusage(kru, (struct compat_rusage __user *)ru);
> > +#endif
> > +       return copy_to_user(ru, kru, sizeof(*kru));
> > +}
> 
> I think this code needs a check for COMPAT_USE_64BIT_TIME in order
> to handle x32 correctly.

Similar to waitid(), indeed.

> 
> It would be nice to introduce it in a separate patch, and then use it
> to kill off
> compat_sys_getrusage() and compat_sys_wait4(), and possibly even
> compat_sys_waitid() in combination with your copy_siginfo_to_user_any().
> That could be done as a cleanup patch afterwards, or as part of your series.

Right, but we won't go the syscall route but instead go the P_PIDFD
route for waitid(). :)

Christian
