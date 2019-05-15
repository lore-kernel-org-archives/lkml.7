Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92912C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACB020873
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfEOScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:36396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbfEOScu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:32:50 -0400
Received: from oasis.local.home (50-204-120-225-static.hfc.comcastbusiness.net [50.204.120.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9887720843;
        Wed, 15 May 2019 18:32:48 +0000 (UTC)
Date:   Wed, 15 May 2019 14:32:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?UTF-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
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
Subject: Re: [RFC] simple_lmk: Introduce Simple Low Memory Killer for
 Android
Message-ID: <20190515143248.17b827d0@oasis.local.home>
In-Reply-To: <20190515172728.GA14047@sultan-box.localdomain>
References: <20190319231020.tdcttojlbmx57gke@brauner.io>
        <20190320015249.GC129907@google.com>
        <20190507021622.GA27300@sultan-box.localdomain>
        <20190507153154.GA5750@redhat.com>
        <20190507163520.GA1131@sultan-box.localdomain>
        <20190509155646.GB24526@redhat.com>
        <20190509183353.GA13018@sultan-box.localdomain>
        <20190510151024.GA21421@redhat.com>
        <20190513164555.GA30128@sultan-box.localdomain>
        <20190515145831.GD18892@redhat.com>
        <20190515172728.GA14047@sultan-box.localdomain>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 May 2019 10:27:28 -0700
Sultan Alsawaf <sultan@kerneltoast.com> wrote:

> On Wed, May 15, 2019 at 04:58:32PM +0200, Oleg Nesterov wrote:
> > Could you explain in detail what exactly did you do and what do you see in dmesg?
> > 
> > Just in case, lockdep complains only once, print_circular_bug() does debug_locks_off()
> > so it it has already reported another false positive __lock_acquire() will simply
> > return after that.
> > 
> > Oleg.  
> 
> This is what I did:
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 774ab79d3ec7..009e7d431a88 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3078,6 +3078,7 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
>         int class_idx;
>         u64 chain_key;
> 
> +       BUG_ON(!debug_locks || !prove_locking);
>         if (unlikely(!debug_locks))
>                 return 0;
> 
> diff --git a/lib/debug_locks.c b/lib/debug_locks.c
> index 124fdf238b3d..4003a18420fb 100644
> --- a/lib/debug_locks.c
> +++ b/lib/debug_locks.c
> @@ -37,6 +37,7 @@ EXPORT_SYMBOL_GPL(debug_locks_silent);
>   */
>  int debug_locks_off(void)
>  {
> +       return 0;

I'm confused why you did this?

-- Steve

>         if (debug_locks && __debug_locks_off()) {
>                 if (!debug_locks_silent) {
>                         console_verbose();
> 
>
