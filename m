Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA123C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACF2B20B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 14:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfJJOUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 10:20:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5413 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfJJOT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 10:19:59 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 471F33CA00;
        Thu, 10 Oct 2019 14:19:59 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (dhcp-192-200.str.redhat.com [10.33.192.200])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D6D75DC18;
        Thu, 10 Oct 2019 14:19:46 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
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
References: <20191010133518.5420-1-christian.brauner@ubuntu.com>
Date:   Thu, 10 Oct 2019 16:19:44 +0200
In-Reply-To: <20191010133518.5420-1-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Thu, 10 Oct 2019 15:35:17 +0200")
Message-ID: <87d0f4of7j.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 10 Oct 2019 14:19:59 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> @@ -2567,7 +2572,7 @@ static bool clone3_args_valid(const struct kernel_clone_args *kargs)
>  	 * All lower bits of the flag word are taken.
>  	 * Verify that no other unknown flags are passed along.
>  	 */
> -	if (kargs->flags & ~CLONE_LEGACY_FLAGS)
> +	if (kargs->flags & ~(CLONE_LEGACY_FLAGS | CLONE3_CLEAR_SIGHAND))
>  		return false;

Does the comment need updating?  I feel it's a bit misleading now.

Thanks,
Florian
