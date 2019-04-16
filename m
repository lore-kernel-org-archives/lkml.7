Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C94C10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:33:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8B4206BA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ZUyiriGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbfDPTdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:33:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35561 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbfDPTdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:33:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id w24so10836015plp.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecAH/AfrBr0oGigRUjGY9TiLUCx3szmbK4ak+dbNs3s=;
        b=ZUyiriGcNLJfLpySSaNnsPoGx4fNr1jc7z7n6ghgnZwyCFvuhXNiVYfln/NNfR7d11
         jxH9q9HmmawH4oihUijXgAlKqrxjRMigXiLqPcByZb3vtWhmvK6LWSQO2D34GQDKyARR
         dDSpxOcUEG414nTvNxrh0H3FHhb4ujAgA0cYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecAH/AfrBr0oGigRUjGY9TiLUCx3szmbK4ak+dbNs3s=;
        b=s9OWbQLFAMerBEK1obsX22Ii5vmTNgc2YegJlzkTYlaCoFFLkF3JhK/Q89wEhHtuFw
         3lFbsOZpnFd0sTORmFOUMWjRljfO/TMBbBhh6djIJ7NthUvES8cO6W3h3QWJZAjdPHnh
         e6iIniiPungqLc97OInjInTwY/m3xHSv4zQYsi1fEZZp+f+nkfPvC9wG4xswmjROVZRt
         qTmH0VypRg1Bp0fIuZ7bVPphYLBwdSU0Kr/MASCqz9biLwI3tunfXqd519qdhKxY1wf2
         vG01B0cwQY0Eu6e3Q5BAqDDQO8RA30XkI5Fgy7XQRmYfWcGIp3UnEQ2Khoe1uEGt6JMO
         MCIg==
X-Gm-Message-State: APjAAAWGbLSs5HLaRMBkvGpFtG4RmzrHoVArn/exqVADl90dcMFmzoYA
        n8Tj0OvfTJHyH01LLkSYqoaKnw==
X-Google-Smtp-Source: APXvYqwiQijuIEyXbow78gIqBXMnqJ5bshKw4dl6OA9i+JR9uXk4ez6KP2/HhOwTmrz/xktko5uWdA==
X-Received: by 2002:a17:902:9341:: with SMTP id g1mr46998728plp.81.1555443182145;
        Tue, 16 Apr 2019 12:33:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p20sm71111904pgh.83.2019.04.16.12.33.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:33:01 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:32:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        rostedt@goodmis.org, dancol@google.com, christian@brauner.io,
        jannh@google.com, surenb@google.com, torvalds@linux-foundation.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, Nadav Amit <namit@vmware.com>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
Message-ID: <20190416193259.GA206245@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
 <20190416192051.GA184889@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416192051.GA184889@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 03:20:51PM -0400, Joel Fernandes wrote:
> On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> > On 04/11, Joel Fernandes (Google) wrote:
> > >
> > > +static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
> > > +{
> > > +	int poll_flags = 0;
> > > +	struct task_struct *task;
> > > +	struct pid *pid;
> > > +
> > > +	task = get_proc_task(file->f_path.dentry->d_inode);
> > > +
> > > +	WARN_ON_ONCE(task && !thread_group_leader(task));
> > > +
> > > +	/*
> > > +	 * tasklist_lock must be held because to avoid racing with
> > > +	 * changes in exit_state and wake up. Basically to avoid:
> > > +	 *
> > > +	 * P0: read exit_state = 0
> > > +	 * P1: write exit_state = EXIT_DEAD
> > > +	 * P1: Do a wake up - wq is empty, so do nothing
> > > +	 * P0: Queue for polling - wait forever.
> > > +	 */
> > > +	read_lock(&tasklist_lock);
> > > +	if (!task)
> > > +		poll_flags = POLLIN | POLLRDNORM | POLLERR;
> > > +	else if (task->exit_state == EXIT_DEAD)
> > > +		poll_flags = POLLIN | POLLRDNORM;
> > > +	else if (task->exit_state == EXIT_ZOMBIE && thread_group_empty(task))
> > > +		poll_flags = POLLIN | POLLRDNORM;
> > > +
> > > +	if (!poll_flags) {
> > > +		pid = proc_pid(file->f_path.dentry->d_inode);
> > > +		poll_wait(file, &pid->wait_pidfd, pts);
> > > +	}
> > 
> > can't understand...
> > 
> > Could you explain when it should return POLLIN? When the whole process exits?
> 
> It returns POLLIN when the task is dead or doesn't exist anymore, or when it
> is in a zombie state and there's no other thread in the thread group.
> 
> > Then all you need is
> > 
> > 	!task || task->exit_state && thread_group_empty(task)
> 
> Yes this works as well, all the tests pass with your suggestion so I'll
> change it to that. Although I will the be giving up returing EPOLLERR if the
> task_struct doesn't exit. We don't need that, but I thought it was cool to
> return it anyway.

Here I actually meant "task_struct doesn't exist" , sorry.

thanks,

 - Joel
 
