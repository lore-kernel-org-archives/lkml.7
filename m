Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56FEC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 866C820866
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 22:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZoX/Sfis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfCaWeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 18:34:00 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40104 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731172AbfCaWd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 18:33:59 -0400
Received: by mail-ed1-f67.google.com with SMTP id h22so6503987edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 15:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LGHPCkilx8rq8Do6cGLs4RYJVLdG3bSlxpBgseCpd8I=;
        b=ZoX/SfisD4/HKwjammMPZCDtCXxAdSknWeCk8cMTqiAAejMReVW01NWZ7QLMvqydM0
         NGX4JQsqT4JJ+1dvro2NM6z2UD1p/Is9yuLy/xHw5cs5W4hU8UZWl4MhdidXJbGLkUbV
         DEbbAX95j1wY8fT73Rh/5u3gD5lFkSQwzo5f19m87IhMd2FaHVT41O85kIH/LVRGSm6k
         pQ6uiqFi5I55Sd9wQFY8J3dVSnVFRJMzrjG9BUE5/F8AD5B/yLSXyDZoK72h95SlCFQ9
         t6wF9PMzCchmV76fzZ14CXa0rNm1HzQ9gkXnx9dc9STPbt/wKxH2SlRN+5VA+ne+2eN7
         h/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LGHPCkilx8rq8Do6cGLs4RYJVLdG3bSlxpBgseCpd8I=;
        b=iCfE6ayKyjszOEU6C4okZlz5+Wk88i8Xz3WDoy2Hf3N1JJfEkvvQgRPNTf0huMMyYR
         SuMwjTb1fi3NWtYUPVtOvaiWbhNuJ5zomu6wCIgqyA+rCm5JDP7bkMnCY+EgG/BbMlNR
         23z2MxId7uL+ZYEv7uypfZpHi26HV7P8IaaYxcAvhaI+OuiggX6NXePc8E2+Qw9QPWqK
         e/ub16ZB1RYQXrSsQZ8YGm35HHzDCk8yI2oXROIZQMthAotLoleTAfaVsIE4TYdBfDIs
         1u7iVYdCVzO0dTefRXz4jDQz7xff2Or1gYCdLIaUlYfRKDtO7qczjmvILoell+mlUQvE
         6Enw==
X-Gm-Message-State: APjAAAUuCoGPA1QEBe/Xy4l1cr+wcpvgxfknPhV6yAnwctYSqBahG5+l
        KlKC5B7K7NoNLG4ffqJyuK4igg==
X-Google-Smtp-Source: APXvYqzDgWzYgF1ebT6UG1AEuDKKKqAbxUDeOOzDJ8423IbPc3/YtAYbRqMUWzR5ME6xaAeSZPHgbg==
X-Received: by 2002:a50:a704:: with SMTP id h4mr30969652edc.7.1554071637990;
        Sun, 31 Mar 2019 15:33:57 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id 21sm1532774ejj.75.2019.03.31.15.33.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 31 Mar 2019 15:33:57 -0700 (PDT)
Date:   Mon, 1 Apr 2019 00:33:56 +0200
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
Message-ID: <20190331223355.vfbnnkmevl63etvv@brauner.io>
References: <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io>
 <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 03:16:47PM -0700, Linus Torvalds wrote:
> On Sun, Mar 31, 2019 at 3:03 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > Thanks for the input. The problem Jann and I saw with this is that it
> > would be awkward to have the kernel open a file in some procfs instance,
> > since then userspace would have to specify which procfs instance the fd
> > should come from.
> 
> I would actually suggest we just make the rules be that the
> pidfd_open() always return the internal /proc entry regardless of any
> mount-point (or any "hidepid") but also suggest that exactly *because*
> it gives you visibility into the target pid, you'd basically require
> the strictest kind of control of the process you're trying to get the
> pidfd of.
> 
> Ie likely something along the lines of
> 
>         ptrace_may_access(task, PTRACE_MODE_ATTACH_REALCREDS)

I can live with that but I would like to hear what Jann thinks too if
that's ok.

Christian
