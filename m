Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15038C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D35B1206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 19:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="qjE2rB1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfDPTUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 15:20:55 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42791 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfDPTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 15:20:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id cv12so10828183plb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TrAm6vZVRZkbHa9xfVw2z0t5FjVA5JjlGIUsDGc5sOM=;
        b=qjE2rB1WR7XMk2ceKl0pQM9EkxGpGGNT4K2yz89eJdvd2w0EkeGFMAmoy0pS/zS4AZ
         1sDQnuHUtIBna7IAXrpnJjN0BufaymcEOovSF2ohlXLup7Zzgl0iZX4HAv1FPUfNmihQ
         Ds02YEstREl5Ot2TdtQa05RMtQWkCsldUu4xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TrAm6vZVRZkbHa9xfVw2z0t5FjVA5JjlGIUsDGc5sOM=;
        b=eaXcleR0/+NuZbEoWVPyN8tV6YAMqBPyHPP8nBy7R/VdnSGYnNp0ERCYKFFDheC042
         S3RoJ0QBPkyVb7dzFPvm5Eed/kpQICNMGi/mgGe4RMl8cEhoxdh6hxTslhj+VitWfF+6
         qpXrMjf1eSa9O7LOYxhJW5/TyAVZsWMwZwAbphYxQCn55OQiGaeHT964r83zz98nwE2+
         UrGIFKD+23z+yaQ7LxXFJJ6f2gZ3t8K0mPwOfriKx9Gmq+1oIRxByVWH4sE9HO7P1ohG
         BgaKLhGZY6qT/sICvyXpPSl8lLje/puScKLiwAgfynhe927ZCaGBY5HFja7Hv5wVJtUw
         3hQQ==
X-Gm-Message-State: APjAAAXvxprn3F0eXlWGTfyKq9CMMk70uRc8HZrrJG049BEqVjf1Qzr9
        iAQaBz8877fj06vL/XENKvrF5g==
X-Google-Smtp-Source: APXvYqwyN1I+J2jXryJq7ybnAd8xb2bOtQ4rBzZDleoJkLn07KFlL1Tqt0Uef4o2G2NsP81KOqtQBA==
X-Received: by 2002:a17:902:28ab:: with SMTP id f40mr63045912plb.297.1555442453472;
        Tue, 16 Apr 2019 12:20:53 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id f20sm40016503pff.176.2019.04.16.12.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Apr 2019 12:20:52 -0700 (PDT)
Date:   Tue, 16 Apr 2019 15:20:51 -0400
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
Message-ID: <20190416192051.GA184889@google.com>
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416120430.GA15437@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 02:04:31PM +0200, Oleg Nesterov wrote:
> On 04/11, Joel Fernandes (Google) wrote:
> >
> > +static unsigned int proc_tgid_base_poll(struct file *file, struct poll_table_struct *pts)
> > +{
> > +	int poll_flags = 0;
> > +	struct task_struct *task;
> > +	struct pid *pid;
> > +
> > +	task = get_proc_task(file->f_path.dentry->d_inode);
> > +
> > +	WARN_ON_ONCE(task && !thread_group_leader(task));
> > +
> > +	/*
> > +	 * tasklist_lock must be held because to avoid racing with
> > +	 * changes in exit_state and wake up. Basically to avoid:
> > +	 *
> > +	 * P0: read exit_state = 0
> > +	 * P1: write exit_state = EXIT_DEAD
> > +	 * P1: Do a wake up - wq is empty, so do nothing
> > +	 * P0: Queue for polling - wait forever.
> > +	 */
> > +	read_lock(&tasklist_lock);
> > +	if (!task)
> > +		poll_flags = POLLIN | POLLRDNORM | POLLERR;
> > +	else if (task->exit_state == EXIT_DEAD)
> > +		poll_flags = POLLIN | POLLRDNORM;
> > +	else if (task->exit_state == EXIT_ZOMBIE && thread_group_empty(task))
> > +		poll_flags = POLLIN | POLLRDNORM;
> > +
> > +	if (!poll_flags) {
> > +		pid = proc_pid(file->f_path.dentry->d_inode);
> > +		poll_wait(file, &pid->wait_pidfd, pts);
> > +	}
> 
> can't understand...
> 
> Could you explain when it should return POLLIN? When the whole process exits?

It returns POLLIN when the task is dead or doesn't exist anymore, or when it
is in a zombie state and there's no other thread in the thread group.

> Then all you need is
> 
> 	!task || task->exit_state && thread_group_empty(task)

Yes this works as well, all the tests pass with your suggestion so I'll
change it to that. Although I will the be giving up returing EPOLLERR if the
task_struct doesn't exit. We don't need that, but I thought it was cool to
return it anyway.

> Please do not use EXIT_DEAD/EXIT_ZOMBIE. And ->wait_pidfd should probably
> live in task->signal_struct.

About wait_pidfd living in signal_struct, that wont work since the waitqueue
has to survive for the duration of the poll system call. Linus also confirmed
this: https://lore.kernel.org/patchwork/patch/1060650/#1257371

Also the waitqueue living in struct pid solves the de_thread() issue I
mentioned later in the following thread and in the commit message:
https://lore.kernel.org/patchwork/comment/1257175/

thanks,

 - Joel

