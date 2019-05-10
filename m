Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E6FC04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3902175B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfEJPg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 11:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:27909 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfEJPg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 11:36:57 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7872A30821B5;
        Fri, 10 May 2019 15:36:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.159])
        by smtp.corp.redhat.com (Postfix) with SMTP id 71B9C1001DF3;
        Fri, 10 May 2019 15:36:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 10 May 2019 17:36:54 +0200 (CEST)
Date:   Fri, 10 May 2019 17:36:47 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, arnd@arndb.de, arunks@codeaurora.org,
        cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, mhocko@suse.com,
        mingo@kernel.org, mtk.manpages@gmail.com, namit@vmware.com,
        peterz@infradead.org, riel@surriel.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wad@chromium.org,
        syzbot+3286e58549edc479faae@syzkaller.appspotmail.com
Subject: Re: [PATCH] fork: do not release lock that wasn't taken
Message-ID: <20190510153647.GB21421@redhat.com>
References: <20190510104913.27143-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510104913.27143-1-christian@brauner.io>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 10 May 2019 15:36:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10, Christian Brauner wrote:
>
> @@ -2102,7 +2102,7 @@ static __latent_entropy struct task_struct *copy_process(
>  	 */
>  	retval = cgroup_can_fork(p);
>  	if (retval)
> -		goto bad_fork_put_pidfd;
> +		goto bad_fork_cgroup_threadgroup_change_end;
>
>  	/*
>  	 * From this point on we must avoid any synchronous user-space
> @@ -2217,11 +2217,12 @@ static __latent_entropy struct task_struct *copy_process(
>  	spin_unlock(&current->sighand->siglock);
>  	write_unlock_irq(&tasklist_lock);
>  	cgroup_cancel_fork(p);
> +bad_fork_cgroup_threadgroup_change_end:
> +	cgroup_threadgroup_change_end(current);
>  bad_fork_put_pidfd:
>  	if (clone_flags & CLONE_PIDFD)
>  		ksys_close(pidfd);
>  bad_fork_free_pid:
> -	cgroup_threadgroup_change_end(current);
>  	if (pid != &init_struct_pid)
>  		free_pid(pid);
>  bad_fork_cleanup_thread:

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

