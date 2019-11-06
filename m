Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DBC5DF65
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC7E218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbfKFTCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:02:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732219AbfKFTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:02:35 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iSQZY-0001bU-7m; Wed, 06 Nov 2019 20:02:28 +0100
Date:   Wed, 6 Nov 2019 20:02:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Yi Wang <wang.yi59@zte.com.cn>
cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, Yang Tao <yang.tao172@zte.com.cn>
Subject: Re: [PATCH] Robust-futex wakes up the waiters will be missed
In-Reply-To: <1573010582-35297-1-git-send-email-wang.yi59@zte.com.cn>
Message-ID: <alpine.DEB.2.21.1911061919320.1869@nanos.tec.linutronix.de>
References: <1573010582-35297-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yi,

On Wed, 6 Nov 2019, Yi Wang wrote:

thanks for addressing Peters comments. Just a few nitpicks.

> Subject: [PATCH] Robust-futex wakes up the waiters will be missed

When you send a new version of a patch then please say so in the subject
line, i.e.

 [PATCH v2] ....

Ideally you also add a short change notice _after_ the '---' seperator
which follows the Signed-off-by lines, i.e.

  Signed-off-by: ......

  ---
  v2: Added a proper comment in handle_futex_death() (Peter)

That's helpful for reviewers to see what you changed, so they know where
they should look for. You obviously do not have to document every tiny
change, but the ones which address review comments and those which change
the implementation. So for a follow up on a large set of comments it's
sufficient to mention classes of changes, e.g.

      - Correct the code flow in foo() (Reviewer 1)
      - Fixup coding style (Reviewer 2)
      - Use inlines instead of macros (Reviewer 1)

Not applicaple here, but you get the idea.

  v1: https://lore.kernel.org/r/1572573789-16557-1-git-send-email-wang.yi59@zte.com.cn

A link to previous versions is helpful for people who were not involved in
the V1 discussion. It makes it easy to follow the history via the archives.
The part after '...org/r/' is the message id of your v1 mail.

This section is not part of the changelog when the patch is applied in a
maintainer tree as the text between the '---' seperator and the start of
the patch is discarded along with the diffstat below.

---
  diffstat ...


Also all subjects should start with a subsystem prefix, in this case
'futex:', i.e.

 [PATCH v2] futex: ....

The easy way to figure the right prefix out is with git:

 git log --oneline kernel/futex.c

That lists the subjects of the commits which touched that file. The most
used one is 'futex:' which makes a lot of sense obviously.

There are a few other prefixes as well due to treewide changes of
infrastructure, but it's again pretty obvious that 'hrtimer:', 'treewide:',
'mm/gup:' etc. are not the right ones.

> We found two scenarios:
> (1)When the owner of a mutex lock with robust attribute and no_pi
> will release the lock and executes pthread_mutex_unlock(),it is
> killed after setting mutex->__data.__lock = 0 and before wake
> others. It will go through the robust process, but it will not wake
> up watiers because mutex->__data.__lock = 0.

...

Just for curiosity. How did you manage to trigger these races?

> We don't need to set "mutex->__data.__count"(in mutex structure),
> which will not affect repeated lock holding.

This is interesting in the context of pthread_mutexes, but irrelevant for
the kernel because the kernel does not know at all how the users space data
structure which contains the futex value looks like. The kernel really does
not care and while the problem happened with pthread_mutex it's the same
for any other implementation which uses the robust futex mechanism.

> Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>

This is missing your Signed-off-by: As you are sending the patch and not
the author you have to add your Signed-off-by after the authors to document
the handling chain. i.e.

  Signed-off-by: Yang Tao <yang.tao172@zte.com.cn>
  Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>

Ok?

> -static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
> +static int handle_futex_death(u32 __user *uaddr,
> +			      struct task_struct *curr, int pi,
> +			      bool pending)

If you break the existing line after 'curr,' then you spare an extra one.

>  {
>  	u32 uval, uninitialized_var(nval), mval;
>  	int err;
> @@ -3469,6 +3471,35 @@ static int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int p
>  	if (get_user(uval, uaddr))
>  		return -1;
>  
...

> +	 *	1) task->robust_list->list_op_pending != NULL
> +	 *	2) mutex->__data.__lock = 0 (uval = 0)
> +	 *	3) no_pi
> +	 */
> +	if (pending && !pi && uval == 0)
> +		futex_wake(uaddr, 1, 1, FUTEX_BITSET_MATCH_ANY);

This really wants an explict return here. Yes, the check below returns the
correct value, but it's not obvious at all. The futex code is complex
enough already, no need to introduce code which forces people to look
twice.

Please keep that in mind for future patches. No need to resend this one as
I already picked it up and fixed up the tiny issues already.

Thanks for the great detective work and profund analysis!

       tglx
