Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410ADC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098AB21901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="b6vFYLpu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbfGVQji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:39:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39569 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfGVQji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:39:38 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so40082872wrt.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 09:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vXMQszqTXtbz44RJeVR4Q3qEWx4tGJ67dj6Kjpugq0c=;
        b=b6vFYLpuqkzCb4rbrMRd/6Wm5WKqJqhzApgLtwBQSt8LgSdCIEwznJPylrHlrtopsZ
         PFtFSqy2iqdF5ELHkIKP3Rn2xFQmojsnq8QDqwiHcnowZKJYnfDg1rgsaRnP7CzrPMwT
         nap9Vq6OHBeJ4vklkzk0lPGjNzxEJ01VILlNBIGR0GUkpVQSpspbK0SNJpdHsY8y6FO9
         ZiNvFoUIvWBQ8EpfqiW6eXkHzbSzWzXQYf9kDF3lWFgIAwrp2ZBEmJuyI7pYWTTicfCp
         3F2SvwXyuyrnlcWNMl3qM4F0MpLQ6iGaUx5FMRQk5EAt2kHN5FskjUVz8YVj8JwFHwU1
         CfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXMQszqTXtbz44RJeVR4Q3qEWx4tGJ67dj6Kjpugq0c=;
        b=Opc/0SlSOkGBovYebDKqt583XDyG8+cmIaqjar5M4v2sLXXPeC4qwQUMjXmjHeD5fs
         kkQ77KFA2zh0vqsxdmFWJBQetB2+TWtOogxTTOgkkcRwNGNbQon7zzTsgPiFMglweR5p
         uOLEHBAI0UvYXNcUv/mOcwOO1hEvZD9/RDmiRSu1TPSnJtNJDdHlq8jvYkvAUfhmUDqx
         dhDkxEEKALGpjIkamsIA5YAvytvkKybHCMX4dXD1niryHMnJfl0xjGxJBrMIIZL9N54o
         bV/MHL+Op0dB7iamPBYLCFII+huFSZ5Dl5T8CW6cqqwF1oggsf0MXN1UB5apIC3m2RUh
         3AAA==
X-Gm-Message-State: APjAAAVIlFNbbBGEB3XWwUBmYMu3swFzkuMDasK7v3RxV3wEuwBkTfFg
        VhmZgSuMMX3KLRb6EIITwno=
X-Google-Smtp-Source: APXvYqwUIWW1x0v3DlbdgVelmSoqTagZi72UuQpc8Rt/c41dIAut70C6MfQxhVB9O9opDu85jz0QuA==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr72352225wro.162.1563813576168;
        Mon, 22 Jul 2019 09:39:36 -0700 (PDT)
Received: from brauner.io ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id d10sm47854501wro.18.2019.07.22.09.39.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 09:39:35 -0700 (PDT)
Date:   Mon, 22 Jul 2019 18:39:34 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [GIT PULL] pidfd fixes
Message-ID: <20190722163933.e472vezklqfxdhmm@brauner.io>
References: <20190722142238.16129-1-christian@brauner.io>
 <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 09:27:08AM -0700, Linus Torvalds wrote:
> On Mon, Jul 22, 2019 at 7:26 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > This contains a fix for pidfd polling. It ensures that the task's exit
> > state is visible to all waiters:
> 
> Hmm.
> 
> I've pulled this, but the exit_state thing has been very fragile
> before, and I'm not entirely happy with how this just changes where it
> is set. I guess the movement here is all inside the tasklist_lock, so
> it's not that big of a deal, but still..
> 
> I would *really* like Oleg to take a look.

Oh, sorry. Oleg did take a look. See:

https://lore.kernel.org/lkml/20190718150057.GB13355@redhat.com/
https://lore.kernel.org/lkml/20190719161404.GA24170@redhat.com/

> 
> Also, and the primary reason I write this email is that this basically
> makes the "EXIT_ZOMBIE / EXIT_DEAD" state handling look all kinds of
> crazy. You set it to EXIT_ZOMBIE potentially _twice_. Whaa?
> 
> So if we set EXIT_ZOMBIE early, then I think we should change the
> EXIT_DEAD case too. IOW, do something like this on top:
> 
>   --- a/kernel/exit.c
>   +++ b/kernel/exit.c
>   @@ -734,9 +734,10 @@ static void exit_notify(struct task_struct
> *tsk, int group_dead)
>                 autoreap = true;
>         }
> 
>   -     tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
>   -     if (tsk->exit_state == EXIT_DEAD)
>   +     if (autoreap) {
>   +             tsk->exit_state = EXIT_DEAD;
>                 list_add(&tsk->ptrace_entry, &dead);
>   +     }
> 
>         /* mt-exec, de_thread() is waiting for group leader */
>         if (unlikely(tsk->signal->notify_count < 0))
> 
> where now the logic becomes "ok, we turned into a zombie above, and if
> we autoreap this thread then we turn the zombie into a fully dead
> thread".
> 
> Because currently we end up having "first turn it into a zombie", then
> "set it to zombie or dead depending on autoreap" and then "if we
> turned it into dead, move it to the dead list".
> 
> That just feels confused to me. Comments?

Agreed. But that codepath is so core-kernel that I really felt more
comfortable just doing the absolut minimal thing so that when things
bite us we see it right away.

There's no harm in sending a cleanup for this later I think, when we
haven't hit any weirdness with the current change. Does that sound ok?

Christian
