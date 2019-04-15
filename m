Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073A6C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A832075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 16:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="cZM0tsmj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbfDOQZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:25:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35189 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfDOQZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 12:25:46 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so8862801pfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Kv51A9NZcOFkd2xZwLrm10H5Q11JeOUU4uR7MMM4cKQ=;
        b=cZM0tsmjcFuX35sAEMbLybikGA6rsbZ2pweIzNT2EF73NihBIQjlhZ1yCChf7vpCqq
         6VsvNYNM92yk/j6rrtgdg3xMuANx/yRY0JRM+fCROhPg+AcN6YamfDDhDLD1kN1Lq+hE
         yvxsCa3rHXXWASM3R4UZT9lRA3WNmN8zEZLrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kv51A9NZcOFkd2xZwLrm10H5Q11JeOUU4uR7MMM4cKQ=;
        b=Jy7YMCmrco7dOIf1TswMcXfWSpVhrt+7tTZ79asbPG4xWBWD5yz+2/SrbCDHvvHmlC
         k1LzKCSfRxt/BlxJceYM17GiwQJDaflj7eSge0W1goat/2sXnCUnljxiPQpZxP4iBtlj
         6+Tqx8j2LYte/RWN7OanWsYRK/53Fs+TjVZPQPAI9PySlzSn5jUFUwecnoZPHX3fCXUL
         kfas8rU5eEw5FCwgrOWTeht3HZm71uDXwYA/HHnyoUZYEPskwep40rvyVEexrYikBGCn
         z1qPPNkGv2qnfVHCa87ldyJN0IE2gduesO//q2IyXdCtW2uoNdmsnUjkH8DMZA/F/V6R
         6aBA==
X-Gm-Message-State: APjAAAVjELDZ3x17X293DOdXXmCTmbvbOPH4LYZHWd1zJBZ+vdmdBF8N
        SfwPacGYYpO+OjDhF9Snfq5Gyg==
X-Google-Smtp-Source: APXvYqyv9wCVAfbmksEIfW5OHe27pSaEYLIoFJCiKjrvw+ALq/bAlZ1t43LbcWVe3/xgeajnQpu1jQ==
X-Received: by 2002:aa7:943b:: with SMTP id y27mr52448203pfo.59.1555345544730;
        Mon, 15 Apr 2019 09:25:44 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id b16sm67626644pfo.168.2019.04.15.09.25.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Apr 2019 09:25:43 -0700 (PDT)
Date:   Mon, 15 Apr 2019 12:25:42 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Christian Brauner <christian@brauner.io>
Cc:     Oleg Nesterov <oleg@redhat.com>, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, jannh@google.com, dhowells@redhat.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        serge@hallyn.com, luto@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, keescook@chromium.org, tglx@linutronix.de,
        mtk.manpages@gmail.com, akpm@linux-foundation.org,
        cyphar@cyphar.com, dancol@google.com
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
Message-ID: <20190415162542.GA246478@google.com>
References: <20190414201436.19502-1-christian@brauner.io>
 <20190414201436.19502-3-christian@brauner.io>
 <20190415105209.GA22204@redhat.com>
 <20190415114204.ydczeuwmi74wfsuv@brauner.io>
 <20190415132416.GB22204@redhat.com>
 <20190415135246.d6pvyf3pkt3sbh6t@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190415135246.d6pvyf3pkt3sbh6t@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:52:48PM +0200, Christian Brauner wrote:
> On Mon, Apr 15, 2019 at 03:24:16PM +0200, Oleg Nesterov wrote:
> > On 04/15, Christian Brauner wrote:
> > >
> > > > CLONE_PARENT_SETTID doesn't look very usefule, so what if we add
> > > >
> > > > 	if ((clone_flags & (CLONE_PIDFD|CLONE_PARENT_SETTID)) ==
> > > > 	                   (CLONE_PIDFD|CLONE_PARENT_SETTID))
> > > > 		return ERR_PTR(-EINVAL);
> > > >
> > > > at the start of copy_process() ?
> > > >
> > > > Then it can do
> > > >
> > > > 	if (clone_flags & CLONE_PIDFD) {
> > > > 		retval = pidfd_create(pid, &pidfdf);
> > > > 		if (retval < 0)
> > > > 			goto bad_fork_free_pid;
> > > > 		retval = put_user(retval, parent_tidptr)
> > > > 		if (retval < 0)
> > > > 			goto bad_fork_free_pid;
> > > > 	}
> > >
> > > Uhhh Oleg, that is nifty. I have to say I like that a lot. This would
> > > let us return the pid and the pidfd in one go and we can also start
> > > pidfd numbering at 0.
> > 
> > Christian, sorry if it was already discussed, but I can't force myself to
> > read all the previous discussions ;)
> > 
> > If we forget about CONFIG_PROC_FS, why do we really want to create a file?
> > 
> > 
> > Suppose we add a global u64 counter incremented by copy_process and reported
> > in /proc/$pid/status. Suppose that clone(CLONE_PIDFD) writes this counter to
> > *parent_tidptr. Let's denote this counter as UNIQ_PID.
> > 
> > Now, if you want to (say) safely kill a task and you have its UNIQ_PID, you
> > can do
> > 
> > 	kill_by_pid_uniq(int pid, u64 uniq_pid)
> > 	{
> > 		pidfd = open("/proc/$pid", O_DIRECTORY);
> > 
> > 		status = openat(pidfd, "status");
> > 		u64 this_uniq_pid = ... read UNIQ_PID from status ...;
> > 
> > 		if (uniq_pid != this_uniq_pid)
> > 			return;
> > 
> > 		pidfd_send_signal(pidfd);
> > 	}
> > 
> > Why else do we want pidfd?
> 
> I think this was thrown around at one point but this is rather
> inelegant imho. It basically makes a process unique by using a
> combination of two identifiers. You end up with a similar concept but
> you make it way less flexible and extensible imho. With pidfds you can
> not care about pids at all if you don't want to. The UNIQ_PID thing
> would require you to always juggle two identifiers.
> 
> Your example would also only work if CONFIG_PROC_FS is set (Not sure if
> that's what you meant by "forget about CONFIG_PROC_FS")? Say, you get
> a pid from clone() and your UNIQ_PID thing. Then you still can't
> reliably kill a process because pidfd_send_signal() is not useable since
> you can't get pidfds. And if you go the kill way you end up with the same
> problem. Yes, you could solve this by probably extending syscalls to
> take a UNIQ_PID argument but that seems very inelegant.
> 
> The UNIQ_PID implementation would also require being tracked in the
> kernel either in task_struct or struct pid potentially and thus would
> probably add more infrastructure in the kernel. We don't need any of
> that if we simply rely on pidfds.
> 
> Most of all, the pidfd concept allows one way more flexibility in
> extending it. For example, Joel is working on a patchset to make pidfds
> pollable so you can get information about a process death by polling
> them. We also want to be able to potentially wait on a process with
> waitid(W_PIDFD) or similar as suggested by Linus in earlier threads. At
> that point you end up in a similar situation as tgkill() where you pass
> a tgid and a pid already to make sure that the pid you pass has the tgid
> as thread-group leader. That is all way simpler with pidfds.

I agree the pidfd file descriptor approach is simpler than dealing with 2
pids and is needed for the poll notification support I posted.

Also in the future it allows for a pidfd to sent over IPC to another
process using binder or unix domain sockets.

thanks,

 - Joel

