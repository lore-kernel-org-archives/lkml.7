Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CDEECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7639420B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfJJPVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:21:54 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57805 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfJJPVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:21:54 -0400
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iIaGE-0001BW-Vy; Thu, 10 Oct 2019 15:21:51 +0000
Date:   Thu, 10 Oct 2019 17:21:49 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
        libc-alpha@sourceware.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] clone3: add CLONE3_CLEAR_SIGHAND
Message-ID: <20191010152148.gdea35mi7s6ivev6@wittgenstein>
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
 <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 04:19:44PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > @@ -2567,7 +2572,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
> >  	 * All lower bits of the flag word are taken.
> >  	 * Verify that no other unknown flags are passed along.
> >  	 */
> > -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> > +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE3_CLEAR_SIGHAND))
> >  		return false;
> 
> Does the comment need updating?  I feel it's a bit misleading now.

Yeah, maybe just:

/* Verify that no unknown flags are passed along. */

?

Thanks!
Christian
