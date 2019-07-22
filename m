Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0864C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B25342190F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 16:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563812850;
	bh=o12NqoZEmCj8E28uul2QfNlz/FhaMnYoQeuLJKQpsYk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tn5e7RfKHOn6Z1TcuUAS2O/sEWW/73CAGFAAPSJdI2E2B9LEXc62K1RpxHKuZJ18L
	 O/lxsPqE/NlwyLZUrE0QggxuR6XULeg+N4ySgfL1WQLreHFNruXaSB8OYaSSUnIKL9
	 muNykXwCbYe43jfot/xoXvySm1TPYbSRtIq6f+G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfGVQ13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 12:27:29 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40500 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfGVQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 12:27:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id m8so4618154lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 09:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lrQN0yqvzQ5aGg/mBBhYNrYwwouTDYMSmlFKnTYPITM=;
        b=R06cfJg6rDTpJOcz+/dVm6tW7Hg2Gq5+OJ2Mb79eMEPZzhTnacKiI8UjzVFFV5wx2t
         jnSg0L3jIm0BpiWrW+x4+NW2zZyrwVpae2mExWlxkQFnymW9eYp7cCoaI1bzVCBRxful
         DkyW4GKgJy/hPdl0FPq+YEQ0Wh0b8GkpoNGLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lrQN0yqvzQ5aGg/mBBhYNrYwwouTDYMSmlFKnTYPITM=;
        b=JIxa1qRBgkJn2r/wmumcOr7agdLmt4ZhJ7sfYStoPEGafv3HCoOIAGlEUp1VMLNmRb
         uC1BhiujqmpWF12F8rMfuafLS8SHinlGcXr3vKPNztw/9CG0qdxumKmoikvHyGPn/XOx
         dpmZC8njFo9WxGRtvP/tNs3U/UltCX/6sg47ypETyVqDjx5c3yQ9hk7A7YhuQVCpURaO
         6irLgdDWwR8Xx/GjoiLBYmi9asFKpB5vf9fqTcEVFBrURsD8nqoDtBVnTUCw1Y57lsA7
         4QWRaiW4llfQIyFF2AQzmTSKZQk7tX+Z0ciNdVeRR9NAT75lH9+dGuyBULWkna2YMBlM
         iZBw==
X-Gm-Message-State: APjAAAW5bm2Kej8ZTogI8LjmBjH7S9uC8OmNxxu38pzrT4/AC9nov1VD
        bBpYGWR6B2kM8vEPzckC7g9hpr+/bXs=
X-Google-Smtp-Source: APXvYqwQCWkM37Bsxh7KRM6d0TpCqVNK138Q2+XiATthIby+ACHkuTdeAzvo6QYrPmWwaDiU9KVtwA==
X-Received: by 2002:a2e:80c8:: with SMTP id r8mr36695899ljg.168.1563812846142;
        Mon, 22 Jul 2019 09:27:26 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id n10sm6114654lfe.24.2019.07.22.09.27.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 09:27:25 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id p17so38229193ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 09:27:24 -0700 (PDT)
X-Received: by 2002:a2e:9192:: with SMTP id f18mr7117663ljg.52.1563812844686;
 Mon, 22 Jul 2019 09:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190722142238.16129-1-christian@brauner.io>
In-Reply-To: <20190722142238.16129-1-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jul 2019 09:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
Message-ID: <CAHk-=wigcxGFR2szue4wavJtH5cYTTeNES=toUBVGsmX0rzX+g@mail.gmail.com>
Subject: Re: [GIT PULL] pidfd fixes
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 7:26 AM Christian Brauner <christian@brauner.io> wrote:
>
> This contains a fix for pidfd polling. It ensures that the task's exit
> state is visible to all waiters:

Hmm.

I've pulled this, but the exit_state thing has been very fragile
before, and I'm not entirely happy with how this just changes where it
is set. I guess the movement here is all inside the tasklist_lock, so
it's not that big of a deal, but still..

I would *really* like Oleg to take a look.

Also, and the primary reason I write this email is that this basically
makes the "EXIT_ZOMBIE / EXIT_DEAD" state handling look all kinds of
crazy. You set it to EXIT_ZOMBIE potentially _twice_. Whaa?

So if we set EXIT_ZOMBIE early, then I think we should change the
EXIT_DEAD case too. IOW, do something like this on top:

  --- a/kernel/exit.c
  +++ b/kernel/exit.c
  @@ -734,9 +734,10 @@ static void exit_notify(struct task_struct
*tsk, int group_dead)
                autoreap = true;
        }

  -     tsk->exit_state = autoreap ? EXIT_DEAD : EXIT_ZOMBIE;
  -     if (tsk->exit_state == EXIT_DEAD)
  +     if (autoreap) {
  +             tsk->exit_state = EXIT_DEAD;
                list_add(&tsk->ptrace_entry, &dead);
  +     }

        /* mt-exec, de_thread() is waiting for group leader */
        if (unlikely(tsk->signal->notify_count < 0))

where now the logic becomes "ok, we turned into a zombie above, and if
we autoreap this thread then we turn the zombie into a fully dead
thread".

Because currently we end up having "first turn it into a zombie", then
"set it to zombie or dead depending on autoreap" and then "if we
turned it into dead, move it to the dead list".

That just feels confused to me. Comments?

              Linus
