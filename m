Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC5BC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95AE0218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 14:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFZn1vZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfCPOk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 10:40:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfCPOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 10:40:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id a3so8301016pff.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2019 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BI4phSIYvJ5zNjy4A6WTpRIF2kY9XnnnxtzrVhl/7Uk=;
        b=pFZn1vZo/PyKPpaTG1P8nNbpgAa1ELwIIXdvRoo7S5DZziW560gaPYxXOkdKRmHNmk
         OcpLA1NVZ8BhM3743q0HcMY1hpKQ8FinDia6GQp9/UkTgctDO7J3BwUDhKxNHV7/OVdj
         bfxTPPlg5Pv9eVuY/5/TQmGl6S2S194ho0S0Y91BFuwobtSb/06AsQHUObVomSXND7pA
         mWVaYQTIbVBcp1NdJWn0FBJer1wUFiUdm7GU0o+IUGMFx4XSVsOlaz/xcJFMmS90XiKx
         nmzA6XSnwfFp5CZNPb17GaDqYWLofyJdm5oK8/XdYtWoQDWuPyi67UKajdIHAHSjReoF
         w1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BI4phSIYvJ5zNjy4A6WTpRIF2kY9XnnnxtzrVhl/7Uk=;
        b=JAJN3Jja/S4sXq2ITA1kDfVDli2EftVnza6aWqmdpGqVV2Z0L9ZrOGEni0mU3wDk4S
         nj9dqSOu3rTPRoJI1mCJ+ibOjqJcbjX2iKGjKPww0b6HaUkJaXK/6dSoWKBOsI+d4j+D
         FCaLh8TXGu2IdK6bw6u7Ti3nAYyJ5ZuegyC8kth/QItcdZYu4oeJoxAQVwWVUvdwaUlI
         GwugpQ1XhuGvir7VAmno/5rtJROsZzCHMu5sv77/TXUmGjVlGFTEg4uU71FOneGKwyJv
         phzDOZaD4UqfXkpHpg3jHmwCg8uu5+nQuBDNsutGXgnX5ntrhtDMKoXv03COeu6UUdUm
         CsPg==
X-Gm-Message-State: APjAAAXep4xCIO6QI+nTZpzq+szK2+CaI5w+4xbV/Xyjt2V7WiMVUTtB
        JxWVD+oG/g13Nx5wV4UsZio=
X-Google-Smtp-Source: APXvYqzPhFexScRgFALaKE4YwpBvdfCXFqmsMEXkECp62fnW9NmYvACO0s4HQDKaPiVXXA1axqzUWw==
X-Received: by 2002:a62:3047:: with SMTP id w68mr9675640pfw.17.1552747255013;
        Sat, 16 Mar 2019 07:40:55 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id m8sm12235976pgr.82.2019.03.16.07.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 07:40:53 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Sat, 16 Mar 2019 23:40:51 +0900
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [syzbot? printk?] no WARN_ON() messages printed before "Kernel
 panic - not syncing: panic_on_warn set ..."
Message-ID: <20190316144051.GB10815@tigerII.localdomain>
References: <0a0d282b-6757-5f42-b888-ef52b040aaa1@i-love.sakura.ne.jp>
 <CACT4Y+ZBpfLpk0FRp7O8Ut=mmf-uddK_fLMDHtPkf6FnMGMqPA@mail.gmail.com>
 <f015f007-2402-27a0-1694-93b1bcffe84b@i-love.sakura.ne.jp>
 <20190316141410.GA18654@tigerII.localdomain>
 <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YEx5PF7QqaLdYpkyBCr_eBgp1n2yuY2LyrN9iZANXgzQ@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/16/19 15:16), Dmitry Vyukov wrote:
> > Hmm... sysctl, may be?
> >
> > > > I figured out that we should restrict it from doing
> > > > syslog(SYSLOG_ACTION_CONSOLE_OFF). And I also restricted its access o
> > > > /dev/console. But maybe there is something else? It _should_ not be
> > > > able to write to random sysctl's.
> > >
> > > Maybe try running with "ignore_loglevel" kernel command line option added?
> >
> > Right, that's something I would expect 0-day and syzkaller to do.
> 
> to double-check: enabling this won't lead to verbose/debug level of logging?

My bad, Saturday night.

You are right, this will make it very verbose. May be we can set
ignore_loglevel when we set loglevel to CONSOLE_LOGLEVEL_MOTORMOUTH.


Technically, we can have something like this

	CPU0						CPU1

	foo()						panic
	loglevel_save = console_loglevel
	....						console_verbose()
	console_loglevel = ABC
	....
	console_loglevel = loglevel_save		smp_send_stop()
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	killed
							console_flush_on_panic()
							// console is
							// NOT verbose


So we either can set ignore_loglevel in console_verbose(). Or call
call console_verbose() one more time, once we stopped other CPUs
and before we console_flush_on_panic().

---

diff --git a/kernel/panic.c b/kernel/panic.c
index 0ae0d7332f12..11784d37f625 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -263,6 +263,7 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
+	console_verbose();
 #ifdef CONFIG_VT
 	unblank_screen();
 #endif

---

But I think that setting ignore_loglevel in console_verbose() is more
reliable.

	-ss
