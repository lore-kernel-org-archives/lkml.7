Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E34C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF0EC216C4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfEJPKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:10:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727346AbfEJPKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:10:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C50C86679;
        Fri, 10 May 2019 15:10:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id EDF0E5D9D5;
        Fri, 10 May 2019 15:10:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 May 2019 17:10:32 +0200 (CEST)
Date:   Fri, 10 May 2019 17:10:25 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        linux-mm <linux-mm@kvack.org>,
        kernel-team <kernel-team@android.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for Android
Message-ID: <20190510151024.GA21421@redhat.com>
References: <20190318235052.GA65315@google.com>
 <20190319221415.baov7x6zoz7hvsno@brauner.io>
 <CAKOZuessqcjrZ4rfGLgrnOhrLnsVYiVJzOj4Aa=o3ZuZ013d0g@mail.gmail.com>
 <20190319231020.tdcttojlbmx57gke@brauner.io>
 <20190320015249.GC129907@google.com>
 <20190507021622.GA27300@sultan-box.localdomain>
 <20190507153154.GA5750@redhat.com>
 <20190507163520.GA1131@sultan-box.localdomain>
 <20190509155646.GB24526@redhat.com>
 <20190509183353.GA13018@sultan-box.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509183353.GA13018@sultan-box.localdomain>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 10 May 2019 15:10:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09, Sultan Alsawaf wrote:
>
> On Thu, May 09, 2019 at 05:56:46PM +0200, Oleg Nesterov wrote:
> > Impossible ;) I bet lockdep should report the deadlock as soon as find_victims()
> > calls find_lock_task_mm() when you already have a locked victim.
>
> I hope you're not a betting man ;)

I am starting to think I am ;)

If you have task1 != task2 this code

	task_lock(task1);
	task_lock(task2);

should trigger print_deadlock_bug(), task1->alloc_lock and task2->alloc_lock are
the "same" lock from lockdep pov, held_lock's will have the same hlock_class().

> CONFIG_PROVE_LOCKING=y

OK,

> And a printk added in vtsk_is_duplicate() to print when a duplicate is detected,

in this case find_lock_task_mm() won't be called, and this is what saves us from
the actual deadlock.


> and my phone's memory cut in half to make simple_lmk do something, this is what
> I observed:
> taimen:/ # dmesg | grep lockdep
> [    0.000000] \x09RCU lockdep checking is enabled.

this reports that CONFIG_PROVE_RCU is enabled ;)

> taimen:/ # dmesg | grep simple_lmk
> [   23.211091] simple_lmk: Killing android.carrier with adj 906 to free 37420 kiB
> [   23.211160] simple_lmk: Killing oadcastreceiver with adj 906 to free 36784 kiB

yes, looks like simple_lmk has at least 2 locked victims. And I have no idea why
you do not see anything else in dmesg. May be debug_locks_off() was already called.

But see above, "grep lockdep" won't work.  Perhaps you can do
"grep -e WARNING -e BUG -e locking".

Oleg.

