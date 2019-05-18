Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE839C072A4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4D6B2087E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 09:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="jbJ+akl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbfERJsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 05:48:07 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729583AbfERJsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 05:48:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id c6so4861948pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 May 2019 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iehYO9/3dGuR87aVQtHa+k708l2fZGn5LAWJUJw+bI=;
        b=jbJ+akl1Oebe/G2zixKM7D3g8/7+hvJdUcG9NJHMi65TbSXZ/qBbCGH1hwdCWFXEia
         v5u721IWYUqsCoQEJBSjN5yxaOqNgOIUlFkv4bfOYzMj0px06ZqOaLQiVXwSfSdOtkCb
         eut+PHPZD1xgK0wVWmv7MP53RNVrElPU0eYIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iehYO9/3dGuR87aVQtHa+k708l2fZGn5LAWJUJw+bI=;
        b=Wdsa1KFmY6Z31a8xPJfdV6qr8w+dsfU2A1CQs38MGYCxpDhZ5y8rqBNcFW+BSUwINL
         7xS9N+QT+N9mTWVexCeIwtAJIiyyxCOfiI8Mca7JpNQtbEb4DjCtJZo+eDBGn3Khe1pj
         HSIBlQpRhTLfTaas6RkEBNbifvTEx4PVNUgVT92di6qp2NXLOvKA3TOHRSKUDvGdnSso
         YGjZiCmyLZAh0PWFi/Dpu6aIIGYdgeF7ZTZ1T58LQ0hAZ7ZouaPACcjW62doAbx3U2w/
         s5uq/Yqk9PgaAGaASKDg7wAGTAmozYr/08dSYteMFf1YeMGm18gztQcFwaQfCSETViaw
         kQOg==
X-Gm-Message-State: APjAAAVf6YK+bV7TdhRyR0+qrwPVcC3PkA4uIKlf9TU91Gpt/p1HtOKV
        D0mNqN8cDogoGhuOTQEiEmC+Kg==
X-Google-Smtp-Source: APXvYqxxxsUFV7eN5OTaebnkzWDt0kd+NHIjUI5fT4y6JUXpDdAsQ8fqEFtPRx00MMYQQHacYxzw8Q==
X-Received: by 2002:a63:f813:: with SMTP id n19mr60994204pgh.273.1558172886290;
        Sat, 18 May 2019 02:48:06 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q4sm14705283pgb.39.2019.05.18.02.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 May 2019 02:48:05 -0700 (PDT)
Date:   Sat, 18 May 2019 05:48:03 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     jannh@google.com, oleg@redhat.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, cyphar@cyphar.com,
        dhowells@redhat.com, ebiederm@xmission.com,
        elena.reshetova@intel.com, keescook@chromium.org,
        luto@amacapital.net, luto@kernel.org, tglx@linutronix.de,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.orgg, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        dancol@google.com, serge@hallyn.com, surenb@google.com,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v1 1/2] pid: add pidfd_open()
Message-ID: <20190516224949.GA15401@localhost>
References: <20190516135944.7205-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190516135944.7205-1-christian@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

For next revision, could you also CC surenb@google.com as well? He is also
working on the low memory killer. And also suggest CC to
kernel-team@android.com. And mentioned some comments below, thanks.

On Thu, May 16, 2019 at 03:59:42PM +0200, Christian Brauner wrote:
[snip]  
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..4afca3d6dcb8 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -38,6 +38,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/proc_ns.h>
>  #include <linux/proc_fs.h>
> +#include <linux/sched/signal.h>
>  #include <linux/sched/task.h>
>  #include <linux/idr.h>
>  
> @@ -451,6 +452,55 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
>  	return idr_get_next(&ns->idr, &nr);
>  }
>  
> +/**
> + * pidfd_open() - Open new pid file descriptor.
> + *
> + * @pid:   pid for which to retrieve a pidfd
> + * @flags: flags to pass
> + *
> + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> + * the process identified by @pid. Currently, the process identified by
> + * @pid must be a thread-group leader. This restriction currently exists
> + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> + * leaders).
> + *
> + * Return: On success, a cloexec pidfd is returned.
> + *         On error, a negative errno number will be returned.
> + */
> +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> +{
> +	int fd, ret;
> +	struct pid *p;
> +	struct task_struct *tsk;
> +
> +	if (flags)
> +		return -EINVAL;
> +
> +	if (pid <= 0)
> +		return -EINVAL;
> +
> +	p = find_get_pid(pid);
> +	if (!p)
> +		return -ESRCH;
> +
> +	ret = 0;
> +	rcu_read_lock();
> +	/*
> +	 * If this returns non-NULL the pid was used as a thread-group
> +	 * leader. Note, we race with exec here: If it changes the
> +	 * thread-group leader we might return the old leader.
> +	 */
> +	tsk = pid_task(p, PIDTYPE_TGID);

Just trying to understand the comment here. The issue is that we might either
return the new leader, or the old leader depending on the overlap with
concurrent de_thread right? In either case, we don't care though.

I suggest to remove the "Note..." part of the comment since it doesn't seem the
race is relevant here unless we are doing something else with tsk in the
function, but if you want to keep it that's also fine. Comment text should
probably should be 'return the new leader' though.

> +	if (!tsk)
> +		ret = -ESRCH;

Perhaps -EINVAL?  AFAICS, this can only happen if a CLONE_THREAD pid was
passed as argument to pidfd_open which is invalid. But let me know what you
had in mind..

thanks,

 - Joel

> +	rcu_read_unlock();
> +
> +	fd = ret ?: pidfd_create(p);
> +	put_pid(p);
> +	return fd;
> +}
> +
>  void __init pid_idr_init(void)
>  {
>  	/* Verify no one has done anything silly: */
> -- 
> 2.21.0
> 
