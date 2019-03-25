Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B38C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DC0720879
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 13:13:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbfCYNM7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:12:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCYNM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 09:12:58 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B9F620854;
        Mon, 25 Mar 2019 13:12:57 +0000 (UTC)
Date:   Mon, 25 Mar 2019 09:12:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: avoid bogus clang warning
Message-ID: <20190325091255.7df58df3@gandalf.local.home>
In-Reply-To: <20190325125807.1437049-1-arnd@arndb.de>
References: <20190325125807.1437049-1-arnd@arndb.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 13:57:57 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> When lockdep is enabled, and -Wuninitialized warnings are enabled,
> clang produces a silly warning for every file we compile:
> 
> In file included from  kernel/sched/fair.c:23:
>  kernel/sched/sched.h:1094:15: error: variable 'cookie' is uninitialized when used here [-Werror,-Wuninitialized]
>         rf->cookie = lockdep_pin_lock(&rq->lock);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Sad it warns as struct pin_cookie is of size zero. But hey.

>  include/linux/lockdep.h:474:60: note: expanded from macro 'lockdep_pin_lock'
>  #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
>                                                                              ^~~~~~
>  kernel/sched/sched.h:1094:15: note: variable 'cookie' is declared here
>  include/linux/lockdep.h:474:34: note: expanded from macro 'lockdep_pin_lock'
>  #define lockdep_pin_lock(l)                     ({ struct pin_cookie cookie; cookie; })
>                                                    ^
> As the 'struct pin_cookie' structure is empty in this configuration,
> there is no need to initialize it for correctness, but it also
> does not hurt to set it to an empty structure, so do that to
> avoid the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/lockdep.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 79c3873d58ac..31d7549933eb 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -471,7 +471,7 @@ struct pin_cookie { };
>  
>  #define NIL_COOKIE (struct pin_cookie){ }
>  
> -#define lockdep_pin_lock(l)			({ struct pin_cookie cookie; cookie; })
> +#define lockdep_pin_lock(l)			({ struct pin_cookie cookie = {}; cookie; })

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

>  #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
>  #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
>  

