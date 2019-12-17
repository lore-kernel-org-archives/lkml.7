Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019EAC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5ECB2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzoKApoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLQKuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 05:50:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34023 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfLQKuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 05:50:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id x17so5936530pln.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 02:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PEqr4tF+K/RwZOy6+fwTqo6tw/GDcU3HsVyOkyr11Co=;
        b=rzoKApoBsOPZhxt3OdPNaeBkbToy4eag8irm77JlG5BBp4iJm/wAOwKpEwukvNaLO7
         fhP0q2zdoFg/GVO6896AtRHQL3a5xkGcSH/ciJIRE2RZS0p/6eLDyS4wlcHwfZV4IE/T
         4IQyg/GeH65SIHQ9N25E4hT15wuJC6Y1McIqQeDOg0HUIsWyP93yk+BBzvZVrkFqDqbc
         Dh3GcCxzBl8DpskaUSIY23JHc4mDWtcwznu0beo1F+X/XK8i4sziCUIUTTWXyy8Exucd
         5gIutaiYcSuoicS9yLOr4tDfUXD+uzcrevNLAZuswxgj+OuNhBVnjAyeBxWyRtbiW2QZ
         lC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PEqr4tF+K/RwZOy6+fwTqo6tw/GDcU3HsVyOkyr11Co=;
        b=QtkNvzJoCZWmoXMkwoiV79kI24dSp/10B+QS0/VYfi2BW697xTiWDfLnvBnPeU1U0B
         Owv+fEheT1RXrkhSkyGC/iMmITm0SqamDRJgnNvHxLE8bVhQcchkGwIKlPNnrY7D+erh
         2pNVoSj5oNI7glv5eRPSxMQmBJdPn2AhFOp9rpFN2bSapv1aM+1S1mDhFA6mxuaDtkd2
         UZtaMI3Whzgu/V5/Dmk5D3ED1EHH4tjSOSlZzAP68KKNWnMzU3wVdWKAnYk5ONFiPUkv
         jk44GTqyYJHqZa5iL88zzqIxQet8tXShIqF2Y8axOLj+beqdPRAK1KwkP9jnBn1C50Af
         xOfg==
X-Gm-Message-State: APjAAAV3GSvk+NaM0Tgzt+0k5IwIUNn2gy55uGRaTC4FVl7ID9PLP8ey
        S4TEmfbxwrVVyEnQp8vACds=
X-Google-Smtp-Source: APXvYqxpYmMPeUadmvsPhwwN/hnUzzl/AHBZuZKfdB4kSmCvA1pZVyyncH01HrwphxSQ/0o38ZFodg==
X-Received: by 2002:a17:902:bb8c:: with SMTP id m12mr22221451pls.320.1576579845375;
        Tue, 17 Dec 2019 02:50:45 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id d23sm25766472pfo.176.2019.12.17.02.50.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 17 Dec 2019 02:50:44 -0800 (PST)
Date:   Tue, 17 Dec 2019 18:50:42 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>, oleg@redhat.com,
        peterz@infradead.org, mingo@kernel.org
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org,
        chenqiwu@xiaomi.com
Subject: Re: [PATCH v2] kernel/exit: do panic earlier to get coredump if
 global init task exit
Message-ID: <20191217105042.GA21784@cqw-OptiPlex-7050>
References: <1576466324-6067-1-git-send-email-qiwuchen55@gmail.com>
 <20191216172841.GA10466@redhat.com>
 <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216174410.xiqurqnqyipbuy4e@wittgenstein>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2019 at 06:44:11PM +0100, Christian Brauner wrote:
> On Mon, Dec 16, 2019 at 06:28:41PM +0100, Oleg Nesterov wrote:
> > On 12/16, qiwuchen55@gmail.com wrote:
> > >
> > > +	 * If all threads of global init have exited, do panic imeddiately
> > > +	 * to get the coredump to find any clue for init task in userspace.
> > > +	 */
> > > +	group_dead = atomic_dec_and_test(&tsk->signal->live);
> > > +	if (unlikely(is_global_init(tsk) && group_dead))
> > > +		panic("Attempted to kill init! exitcode=0x%08lx\n", code);
> >                                                                     ^^^^
> > 
> > No, we should not throw out the useful info, please use
> > 
> > 	signal->group_exit_code ?: code
> > 
> > as the current code does.
> > 
> > And I am worried atomic_dec_and_test() is called too early...
> > 
> > Say, acct_process() can report the exit while some sub-thread sleeps
> 
> Hm, I'm not following here. I might just be slow. acct_process() doesn't
> seem to report exit status and has been called after group_dead before.
> 
> Christian

I agree using signal->group_exit_code ?: code is better, because there is a
possibilty that the exit of main init thread is called by complete_and_exit()
not by a normal exit route (get_signal()->do_group_exit()). For this case,
signal->group_exit_code maybe NULL, so the arg of code should be the exitcode.

And I agree we should not move up group_dead too much. What Oleg has mentioned
is just one case, what's more, there is a possibilty that some sub-threads sleep
in exit_signals()->threadgroup_change_begin() and not do real exit, the main
thread will do panic if all sub-threads do exit since the group_dead is 0.

For workaroud such case, I think the patch should be:

diff --git a/kernel/exit.c b/kernel/exit.c
index bcbd598..58d90e1 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -517,10 +517,6 @@ static struct task_struct *find_child_reaper(struct task_struct *father,
        }

        write_unlock_irq(&tasklist_lock);
-       if (unlikely(pid_ns == &init_pid_ns)) {
-               panic("Attempted to kill init! exitcode=0x%08x\n",
-                       father->signal->group_exit_code ?: father->exit_code);
-       }

        list_for_each_entry_safe(p, n, dead, ptrace_entry) {
                list_del_init(&p->ptrace_entry);
@@ -728,6 +724,15 @@ void __noreturn do_exit(long code)
                panic("Attempted to kill the idle task!");

        /*
+        * If all threads of global init have exited, do panic imeddiately
+        * to get the coredump to find any clue for init task in userspace.
+        */
+       if (unlikely(is_global_init(tsk) &&
+               (atomic_read(&tsk->signal->live) == 1)))
+               panic("Attempted to kill init! exitcode=0x%08x\n",
+                       tsk->signal->group_exit_code ?: (int)code);
+
+       /*
         * If do_exit is called because this processes oopsed, it's possible
         * that get_fs() was left as KERNEL_DS, so reset it to USER_DS before
         * continuing. Amongst other possible reasons, this is to prevent



