Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC266C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D3B2086C
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Y5fKM58I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfCaWDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:03:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40381 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:03:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so6471879edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wxBxVa2cdfR2v2qkq4obTrkEO/FDOn1wy2ZovTdGIXg=;
        b=Y5fKM58I+mf5EeQLXqRZbc02eBLjlJ3c4Q7avqhZyvwyzjBAlSN4FXli/D12rDNnCm
         H9hq7aqztrjhv1cW6SUezCCYiW9RTj0EsxIBE86VuUxC01u2Gqu/JLbNUY6epYp0wD96
         UQtLtmqYtVTSq+9zcz7LHUX3ePEHvxvfzlnxSgS693Tucy1qXoKBFKZ1yxkzFDYlkJDl
         A1+gKDCUyxCMn01DSle+dYtc46wDZoSnhVVs3tr9iDOFhyjYpW18xykILGOnW3t8d1sj
         t7RJErkJNeSEW+NlJueYAEOu9pfy+NZ6appXl9N8swGuLBGzGFIzUsz0tyhhyatkuErx
         y73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wxBxVa2cdfR2v2qkq4obTrkEO/FDOn1wy2ZovTdGIXg=;
        b=AVO1bpBdb/MCqX3mPz6jyU4XFo31Z/uWX4qdtCtQHCzyaFQovfyMI3T6Nhx+UYsaHK
         Ol+O9f6tOZYPwkJBdatq6xuo8P3Yp81cHCnjPMLkD3nwo3hV1Pb5lfOYEkMCL+5lLL9V
         wTr5ZRrs7J2Xr9vSLRCbYbEeHOeIMvr0Px5Ul0mFbM7xK1A/UXY76A2yjKXwNsDZroM+
         qQtnP3BiQy9ibXETnwh6EYJKMDiezM6DEhrN7zAXuybnbENAHW9KbX0Jd06wBVMK7oka
         HyzT454ZLxdji2v2M8xvP3nIbqctCLSPJfnhcFnKnlo6M7Bz3Ffhl81Ipo0O741mXnFl
         ds/A==
X-Gm-Message-State: APjAAAV724XmBC/vGWZ1nDAFs9q+law2SNuje6cT+Rv2K5NAEvPvdqZk
        RxIxlc7X6E5jOBak3b0hQqkvrA==
X-Google-Smtp-Source: APXvYqzAhPFGKQAPobjVoM6uhxGZHMt51zlvuwtuq8Fv/tFXIvGbLc+7mVsMvdDrqnKf7ymV+V/hFg==
X-Received: by 2002:aa7:c258:: with SMTP id y24mr21721597edo.68.1554069782242;
        Sun, 31 Mar 2019 15:03:02 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id r27sm2620122eda.0.2019.03.31.15.03.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 15:03:01 -0700 (PDT)
Date:   Mon, 1 Apr 2019 00:03:00 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190331220259.qntxynluk765hpnt@brauner.io>
References: <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 02:17:48PM -0700, Linus Torvalds wrote:
> On Sun, Mar 31, 2019 at 2:10 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > I don't think that we want or can make them equivalent since that would
> > mean we depend on procfs.
> 
> Sure we can.
> 
> If /proc is enabled, then you always do that dance YOU ALREADY WROTE
> THE CODE FOR to do the stupid ioctl.
> 
> And if /procfs isn't enabled, then you don't do that.
> 
> Ta-daa. Done. No stupid ioctl, and now /proc and pidfd_open() return
> the same damn thing.
> 
> And guess what? If /proc isn't enabled, then obviously pidfd_open()
> gives you the /proc-less thing, but at least there is no crazy "two
> different file descriptors for the same thing" situation, because then
> the /proc one doesn't exist.
> 
> Notice? No incompatibility. No crazy stupid new "convert one to the
> other", because "the other model" NEVER EXISTS. There is only one
> pidfd - it might be proc-less if CONFIG_PROC isn't there, but let's
> face it, nobody even cares, because nobody ever disabled /proc anyway.

Thanks for the input. The problem Jann and I saw with this is that it
would be awkward to have the kernel open a file in some procfs instance,
since then userspace would have to specify which procfs instance the fd
should come from.  Yes, it could probably always be the callers procfs
instance. But I'm concerned how this will interact with procfs mount
options such as hidepid={1,2} and pid namespaces.
One concern is what should happen when there's no procfs mount in the
callers mount namespace. Do we check for that in pidfd_open() and at
CLONE_PIDFD time and then refuse to give the caller a pidfd in that case
or do they still get a dirfd to /proc/<pid>? If we refuse it would mean
that having procfs mounted is necessary to get a pidfd if we don't
refuse it would mean that we're making process metadata available
without procfs being mounted which an administrator migh not want by not
having mounted procfs.
Another question is what happens when procfs is mounted with
hidepid={1,2}. If the caller accidently learns a pid they could
pidfd_open() it and circumvent hidepid={1,2}. So we would need to verify
the procfs mount options as well. I think these problems would be gone
if pidfds were opaque handles.

Christian
