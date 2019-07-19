Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3259CC76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110532184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 16:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbfGSQOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 12:14:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54430 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfGSQOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 12:14:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3E636300B916;
        Fri, 19 Jul 2019 16:14:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.136])
        by smtp.corp.redhat.com (Postfix) with SMTP id 35F40646CF;
        Fri, 19 Jul 2019 16:14:05 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 19 Jul 2019 18:14:07 +0200 (CEST)
Date:   Fri, 19 Jul 2019 18:14:05 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        kernel-team@android.com, Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH RFC v1] pidfd: fix a race in setting exit_state for pidfd
 polling
Message-ID: <20190719161404.GA24170@redhat.com>
References: <20190717172100.261204-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190717172100.261204-1-joel@joelfernandes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 19 Jul 2019 16:14:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it seems that I missed something else...

On 07/17, Joel Fernandes (Google) wrote:
>
> @@ -1156,10 +1157,11 @@ static int wait_task_zombie(struct wait_opts *wo, struct task_struct *p)
>  		ptrace_unlink(p);
>  
>  		/* If parent wants a zombie, don't release it now */
> -		state = EXIT_ZOMBIE;
> +		p->exit_state = EXIT_ZOMBIE;
>  		if (do_notify_parent(p, p->exit_signal))
> -			state = EXIT_DEAD;
> -		p->exit_state = state;
> +			p->exit_state = EXIT_DEAD;
> +
> +		state = p->exit_state;
>  		write_unlock_irq(&tasklist_lock);

why do you think we also need to change wait_task_zombie() ?

pidfd_poll() only needs the exit_state != 0 check, we know that it
is not zero at this point. Why do we need to change exit_state before
do_notify_parent() ?

Oleg.

