Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73EC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB1021473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 16:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfEMQiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 12:38:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbfEMQiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 12:38:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9C7313001822;
        Mon, 13 May 2019 16:38:18 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7526160856;
        Mon, 13 May 2019 16:38:17 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 13 May 2019 18:38:16 +0200 (CEST)
Date:   Mon, 13 May 2019 18:38:14 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     linux-kernel@vger.kernel.org, tj@kernel.org, guro@fb.com,
        kernel-team@fb.com
Subject: Re: [REGRESSION] ptrace broken from "cgroup: cgroup v2 freezer"
 (76f969e)
Message-ID: <20190513163814.GA31756@redhat.com>
References: <1557709124.798rxdb4l3.astroid@alex-desktop.none>
 <20190513121703.GA24724@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513121703.GA24724@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 13 May 2019 16:38:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/13, Oleg Nesterov wrote:
>
> Probably we add leave_frozen(true) after freezable_schedule() for now, then
> think try to make something better...

And again, this is what I thought ptrace_stop() does, somehow I didn't notice
that the last version doesn't have leave_frozen() in ptrace_stop().

Perhaps we can do a bit better, change only tracehook_report_syscall_entry() and
PTRACE_EVENT_EXIT/SECCOMP paths to do leave_frozen() ?

At first glance other callers look fine in that they can do nothing "interesting"
befor get_signal(), but we need to re-check...

Oleg.

> But I am not sure I 100% understand whats going on in this case, could you
> try the patch below? (Just in case, of course it is wrong).
> 
> Oleg.
> 
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -149,8 +149,7 @@
>  {
>  	if ((t->jobctl & (JOBCTL_PENDING_MASK | JOBCTL_TRAP_FREEZE)) ||
>  	    PENDING(&t->pending, &t->blocked) ||
> -	    PENDING(&t->signal->shared_pending, &t->blocked) ||
> -	    cgroup_task_frozen(t)) {
> +	    PENDING(&t->signal->shared_pending, &t->blocked) {
>  		set_tsk_thread_flag(t, TIF_SIGPENDING);
>  		return true;
>  	}
> 

