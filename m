Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4012C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D0020657
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 17:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552240622;
	bh=YKlQhc+3xwVfIkir+oMl4E9ELow6HKN8pWFc0Y2JaQc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S2SMxBBTxXLLaN1NGrGffiWUjdE9MvL3ewAEDJimV0tLoxFZpph8vMsaGTdrZcssP
	 FSk9WcWaVUEMFdLOTF/9m99Z/PqULSgYwRApBmqBCEQTYunlJ7VtyVt1MVLpKZeL4h
	 Y8rPzqG2L1CXdf6G9LlVBz1qAUHBNQQ0N0YvkN5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfCJR5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 13:57:00 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33322 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbfCJR4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 13:56:55 -0400
Received: by mail-lf1-f65.google.com with SMTP id h71so1743389lfe.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 10:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YNjjXZADjhmJVaKjYy+j0qqaxm7Gg8fP7jq8b4+YfQk=;
        b=FDLicbUmCuRizhZ0rvzSrdZk5xbiWaLIpsCpG9IcziikBpdke4T8VKBMQqOquZAwQu
         W6UtoNSOnxRO19+e5tpBiPFXowj5l0lTuu4Np0zMVzc7tokV0LNdIGxYQOnKTkun1s6T
         E/i1YN4e6Ut9Tom+gMqXPvfwAKJsnRpKnNTAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YNjjXZADjhmJVaKjYy+j0qqaxm7Gg8fP7jq8b4+YfQk=;
        b=TTuEAnsQMfM1Jy1GsUe/T/jNB+tBdj/s891H+znmwYMnaYARwTE6GneYgGBbpWh0XY
         M+rcfT5cstQ3QSFGgLHmdCyh2hHvJIkZsmgY1YiL1edIx6iuX4ma/OtikSnuLkA3ScG4
         9D6mvpMHBNRS3ssEvxx+ckKGtUCYSb+ZozxCJc50+RWGdiizw0bcrfu5jqA8u8NXksfX
         1NwNoXQRfhGvQQsTgFZV0wajWnk+rWMBgdSnn8H8JpHkfBCBydcngEsnUh5pd4znRcy6
         ADswRQoyma6h97Z7K5Fp3YOriqDuC5coDDBrBnS12IFfuF2hIer9ZyLPTJnCJkp5HI31
         zagw==
X-Gm-Message-State: APjAAAUogALQhCkZK39lTeIEAdjFcwkxauxCIxEF3NaIJT7gp+3apV2T
        WQ1KeLiJ+cPx2u/Y0TKoeHpqOx6YHpg=
X-Google-Smtp-Source: APXvYqwrR9BFrPwJEio4A0U8Y3w4QpNywHNL6QYM8FW9HnRONOY021SDS9Dw4RE6rFh8qH1jACyROA==
X-Received: by 2002:ac2:52a1:: with SMTP id r1mr10423506lfm.155.1552240612221;
        Sun, 10 Mar 2019 10:56:52 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id u11sm736912lfl.87.2019.03.10.10.56.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 10:56:51 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id g80so2056113ljg.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2019 10:56:50 -0700 (PDT)
X-Received: by 2002:a2e:9117:: with SMTP id m23mr14276429ljg.94.1552240609957;
 Sun, 10 Mar 2019 10:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190306132938.hzyb7gee5actx3l3@pathway.suse.cz>
In-Reply-To: <20190306132938.hzyb7gee5actx3l3@pathway.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Mar 2019 10:56:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=m7vcLJB2uqTPcVd603ygCeKr7NBtR5y0M8KHtMzFWg@mail.gmail.com>
Message-ID: <CAHk-=wi=m7vcLJB2uqTPcVd603ygCeKr7NBtR5y0M8KHtMzFWg@mail.gmail.com>
Subject: Re: [question] panic() during reboot -f (reboot syscall)
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocky" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-ext4@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 5:29 AM Petr Mladek <pmladek@suse.com> wrote:
>
> I wonder if it is "normal" to get panic() when the system is rebooted
> using "reboot -f". I looks a bit weird to me.

No, a panic is never normal (except possibly for test modules etc, of course).

> Now, "reboot -f" just calls the reboot() syscall. I do not see
> anything that would stop processes.

There isn't supposed to be anything. It's meant for "things are
screwed up, just reboot *now* without doing anything else".

The "reboot now" is basically meant to be a poor man's power cycle.

> But it shuts down devices very early, via:
>
>   + kernel_restart()
>     + kernel_restart_prepare()
>       + blocking_notifier_call_chain(&reboot_notifier_list, SYS_RESTART, cmd);
>       + device_shutdown()

The problem is that there are conflicting goals here, and the kernel
doesn't even *know* if this is supposed to be a normal clean reboot,
or a "reboot -f" that just shuts down everything.

On a nice clean reboot (where init has shut everything down) we
obviously _do_ want to shut devices down etc. Quite often you need to
do it just to make sure they come up nicely again (because the
firmware isn't even always re-initializing things properly on a soft
reboot).

But on a "reboot -f", user space _hasn't_ cleaned up, and just wants
things to reboot. But the kernel doesn't really know. It just gets the
reboot system call in both cases.

> By other words. It looks like the panic() is possible by design.
> But it looks a bit weird. Any opinion?

It's definitely not "by design", but it might be unavoidable in this case.

Of course, "unavoidable" is relative. There could be workarounds that
are reasonably ok in practice.

Like having the filesystem panic code see "oh, system_state isn't
SYSTEM_RUNNING, so I shouldn't be panicing".

                Linus
