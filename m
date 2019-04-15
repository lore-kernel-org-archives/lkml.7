Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D42C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C650E20833
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 13:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Lp9LELas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfDONw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 09:52:57 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39545 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfDONw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 09:52:56 -0400
Received: by mail-it1-f196.google.com with SMTP id 139so26681414ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 06:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKliN+CleZjM9mQtQrs6RKPoYuKKa4aW1qqKFec5vzs=;
        b=Lp9LELas47AfNgSP0hyBKT1a7l2IOQGOew/QOcw0U2L8/yWIK+uypn8DMnoAElPB1J
         ijZoSg1V5NCdSPX1KEHbPVj+8zJBD2aEuA1Bn1vRl3G5hGkYuxM2nlfqFkEUB3aCdDXr
         p/PIevN9geVVaIyHDH0CNp1r7aoKKdk/i+MFZc8kvzFwpy4sHLEepR1RH9d9e/evvjki
         y00PkxYrqakpd7vkAYm9qUXiGKaP+Vp2o6p/7pkJSkLWyBCacaIW3Zz5LwhxuiWBBbTR
         GhaScTvQO1oVRd2XnTPEmxPzMSlGXUW6JIHow3r8wGqxTwvxlsMEFUenVVk/DcXZg16x
         4zkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKliN+CleZjM9mQtQrs6RKPoYuKKa4aW1qqKFec5vzs=;
        b=PPGFXdzYktukMFPPq/x2Prjg4sTPfnIRrwSIDd/l5B14VpIiwom6uqGtO8vGkLK40o
         knE0UBW8TItYQ8NOEQxI4N/rheHLbTlDXHHWCmG/v01isHNxyhlmz0nSU3+j9lYR+qRD
         CHQcMwl/+WkfoNbEfue/k3BscWZPctLUXhG7H3DmIa9JRqGmOI6r15Yyhd2U0njntIke
         f7bEk+DhvViQG9LXDvDVLTK5lpBvmYbnSm5pqa0G4t538WLYg0YQl/y+bSeh686S8eKx
         b1Seq5tW04hbjjkad/pJKYSSt/ZW2vyd+4TCFlm9pVmTQkeZ8IDiz8lMwYR4MH2ZPTUG
         7IPA==
X-Gm-Message-State: APjAAAUkhWliYGV95S39OQFHyLmIW2LppwHYZXGwGUurFA0cGmxcVtKw
        A/c1ZXnI/NoQUQWfO0xlOKrAzHgULuVx9Q==
X-Google-Smtp-Source: APXvYqwQM2BjLwm1bAPgrg9N3jmNgs3mLvL1E4QSTG4g0e/XM20QLhOc6e5OHauajOZgiD3dAGrpTQ==
X-Received: by 2002:a24:e184:: with SMTP id n126mr25414856ith.155.1555336375564;
        Mon, 15 Apr 2019 06:52:55 -0700 (PDT)
Received: from brauner.io ([208.54.80.237])
        by smtp.gmail.com with ESMTPSA id f197sm8579579itf.5.2019.04.15.06.52.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Apr 2019 06:52:54 -0700 (PDT)
Date:   Mon, 15 Apr 2019 15:52:48 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
        jannh@google.com, dhowells@redhat.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com, luto@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        tglx@linutronix.de, mtk.manpages@gmail.com,
        akpm@linux-foundation.org, cyphar@cyphar.com,
        joel@joelfernandes.org, dancol@google.com
Subject: Re: [PATCH 2/4] clone: add CLONE_PIDFD
Message-ID: <20190415135246.d6pvyf3pkt3sbh6t@brauner.io>
References: <20190414201436.19502-1-christian@brauner.io>
 <20190414201436.19502-3-christian@brauner.io>
 <20190415105209.GA22204@redhat.com>
 <20190415114204.ydczeuwmi74wfsuv@brauner.io>
 <20190415132416.GB22204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190415132416.GB22204@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 03:24:16PM +0200, Oleg Nesterov wrote:
> On 04/15, Christian Brauner wrote:
> >
> > > CLONE_PARENT_SETTID doesn't look very usefule, so what if we add
> > >
> > > 	if ((clone_flags & (CLONE_PIDFD|CLONE_PARENT_SETTID)) ==
> > > 	                   (CLONE_PIDFD|CLONE_PARENT_SETTID))
> > > 		return ERR_PTR(-EINVAL);
> > >
> > > at the start of copy_process() ?
> > >
> > > Then it can do
> > >
> > > 	if (clone_flags & CLONE_PIDFD) {
> > > 		retval = pidfd_create(pid, &pidfdf);
> > > 		if (retval < 0)
> > > 			goto bad_fork_free_pid;
> > > 		retval = put_user(retval, parent_tidptr)
> > > 		if (retval < 0)
> > > 			goto bad_fork_free_pid;
> > > 	}
> >
> > Uhhh Oleg, that is nifty. I have to say I like that a lot. This would
> > let us return the pid and the pidfd in one go and we can also start
> > pidfd numbering at 0.
> 
> Christian, sorry if it was already discussed, but I can't force myself to
> read all the previous discussions ;)
> 
> If we forget about CONFIG_PROC_FS, why do we really want to create a file?
> 
> 
> Suppose we add a global u64 counter incremented by copy_process and reported
> in /proc/$pid/status. Suppose that clone(CLONE_PIDFD) writes this counter to
> *parent_tidptr. Let's denote this counter as UNIQ_PID.
> 
> Now, if you want to (say) safely kill a task and you have its UNIQ_PID, you
> can do
> 
> 	kill_by_pid_uniq(int pid, u64 uniq_pid)
> 	{
> 		pidfd = open("/proc/$pid", O_DIRECTORY);
> 
> 		status = openat(pidfd, "status");
> 		u64 this_uniq_pid = ... read UNIQ_PID from status ...;
> 
> 		if (uniq_pid != this_uniq_pid)
> 			return;
> 
> 		pidfd_send_signal(pidfd);
> 	}
> 
> Why else do we want pidfd?

I think this was thrown around at one point but this is rather
inelegant imho. It basically makes a process unique by using a
combination of two identifiers. You end up with a similar concept but
you make it way less flexible and extensible imho. With pidfds you can
not care about pids at all if you don't want to. The UNIQ_PID thing
would require you to always juggle two identifiers.

Your example would also only work if CONFIG_PROC_FS is set (Not sure if
that's what you meant by "forget about CONFIG_PROC_FS")? Say, you get
a pid from clone() and your UNIQ_PID thing. Then you still can't
reliably kill a process because pidfd_send_signal() is not useable since
you can't get pidfds. And if you go the kill way you end up with the same
problem. Yes, you could solve this by probably extending syscalls to
take a UNIQ_PID argument but that seems very inelegant.

The UNIQ_PID implementation would also require being tracked in the
kernel either in task_struct or struct pid potentially and thus would
probably add more infrastructure in the kernel. We don't need any of
that if we simply rely on pidfds.

Most of all, the pidfd concept allows one way more flexibility in
extending it. For example, Joel is working on a patchset to make pidfds
pollable so you can get information about a process death by polling
them. We also want to be able to potentially wait on a process with
waitid(W_PIDFD) or similar as suggested by Linus in earlier threads. At
that point you end up in a similar situation as tgkill() where you pass
a tgid and a pid already to make sure that the pid you pass has the tgid
as thread-group leader. That is all way simpler with pidfds.
