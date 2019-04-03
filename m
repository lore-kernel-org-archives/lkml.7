Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D79C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35302082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfDCMoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:44:07 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39430 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbfDCMoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:44:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 620D6374;
        Wed,  3 Apr 2019 05:44:06 -0700 (PDT)
Received: from fuggles.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71CE53F59C;
        Wed,  3 Apr 2019 05:44:04 -0700 (PDT)
Date:   Wed, 3 Apr 2019 13:44:02 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Waiman Long <longman@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lockdep: avoid bogus clang warning
Message-ID: <20190403124402.GD16362@fuggles.cambridge.arm.com>
References: <20190325125807.1437049-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325125807.1437049-1-arnd@arndb.de>
User-Agent: Mutt/1.11.1+86 (6f28e57d73f2) ()
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 01:57:57PM +0100, Arnd Bergmann wrote:
> When lockdep is enabled, and -Wuninitialized warnings are enabled,
> clang produces a silly warning for every file we compile:
> 
> In file included from  kernel/sched/fair.c:23:
>  kernel/sched/sched.h:1094:15: error: variable 'cookie' is uninitialized when used here [-Werror,-Wuninitialized]
>         rf->cookie = lockdep_pin_lock(&rq->lock);
>                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
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
>  #define lockdep_repin_lock(l, c)		do { (void)(l); (void)(c); } while (0)
>  #define lockdep_unpin_lock(l, c)		do { (void)(l); (void)(c); } while (0)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
