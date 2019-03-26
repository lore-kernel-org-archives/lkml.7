Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 197E12075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="YlYN2FnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbfCZTTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:19:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45864 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730449AbfCZTTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:19:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id m16so11785362edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TJKNmsp1PEVgNOak7EZ1hfWpRJIC4oh3binZcRJgeG8=;
        b=YlYN2FnZ8RQ02GMMpH3sFiQUDLu2M/scIEYvb74ybDQH1zlQDwuLXt3qqrYyjWObtV
         i2y0aGuCj6227H8obiBxlGlZl34qYvRO5MzmZw8OAZ3apmycDAqCs1T8y+rqlKhuqXlQ
         5mfKrgGXL/7q5bkdQXXiwFl9cqaNmSG858m1L4AUcTPsTTUNuixfMvBZ1B1EC0AlN3mt
         4Cdu+UxfvBUAbHg1cWmlycwALmfs5VN2oz4HzWqOQZbzLQzzPASpEOnGmsilAxmPb3y/
         gFrMxTcyWuiYeETtJQHqCqbN9iahkPOmux04qj0gf4cfVUDWdPvtzM+qQKw0n/VCW//s
         l7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TJKNmsp1PEVgNOak7EZ1hfWpRJIC4oh3binZcRJgeG8=;
        b=HxcBHizWqR/bOhLdrZ8jyxYRvgrninwiGfBFTwKJR3QudxPnp2ukKRcDs2TvjTv5FZ
         TK0ZJAA/HwR7KMFrys4tPU6lEUPVvFXfl1RuQo7Fe9Mqw0t0j35LKkRbEXsR9oHn1uM9
         yHHBtPQ4OOJ0XVJb+r2TnHrSQehyptbM4d2NpFNN2jUXa8BPRYb/06rkw1caxADwv6Hk
         XySJDMDk3OrA/sZi1fjzk/djxJs97K1DYeBh3Z78MEINzI6ecQQlsu71stFcRrCh962S
         4/sJg5wsZ4wpVyyqPiXenS2Rsn5ilK6QXEy2ZZJ4xqdcsGAr0otfmVxBPJhgKvxLwdx7
         F98w==
X-Gm-Message-State: APjAAAUKAm03TRjjiuf4iZgBIKfeP4UWnJNsT3+BhHQL8PwPQvjH0Wmr
        trF3uRjvKAfCpQ+PnQyZU5xQyQ==
X-Google-Smtp-Source: APXvYqxj/y8FrQvFy2eJjXCwqAVOgj6VY1UEgwrXikSBMGDCBbeiio2ZbzQMNO4mEuBYuQcAu3azxw==
X-Received: by 2002:aa7:d9d2:: with SMTP id v18mr21066044eds.74.1553627986215;
        Tue, 26 Mar 2019 12:19:46 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id c9sm6216691eds.92.2019.03.26.12.19.44
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 12:19:45 -0700 (PDT)
Date:   Tue, 26 Mar 2019 20:19:43 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     jannh@google.com, khlebnikov@yandex-team.ru, luto@kernel.org,
        dhowells@redhat.com, serge@hallyn.com, ebiederm@xmission.com,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, keescook@chromium.org, adobriyan@gmail.com,
        tglx@linutronix.de, mtk.manpages@gmail.com, bl0pbl33p@gmail.com,
        ldv@altlinux.org, akpm@linux-foundation.org, oleg@redhat.com,
        nagarathnam.muthusamy@oracle.com, cyphar@cyphar.com,
        viro@zeniv.linux.org.uk, dancol@google.com
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326191942.jyqpk3ehpbvhgvyz@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <20190326170601.GA101741@google.com>
 <20190326172231.daa5a53lxf6nz6jn@brauner.io>
 <20190326181012.GA138478@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326181012.GA138478@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 02:10:12PM -0400, Joel Fernandes wrote:
> On Tue, Mar 26, 2019 at 06:22:33PM +0100, Christian Brauner wrote:
> > On Tue, Mar 26, 2019 at 01:06:01PM -0400, Joel Fernandes wrote:
> > > On Tue, Mar 26, 2019 at 04:55:11PM +0100, Christian Brauner wrote:
> > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > I quote Konstantins original patchset first that has already been acked and
> > > > picked up by Eric before and whose functionality is preserved in this
> > > > syscall:
> > > > 
> > > > "Each process have different pids, one for each pid namespace it belongs.
> > > >  When interaction happens within single pid-ns translation isn't required.
> > > >  More complicated scenarios needs special handling.
> > > > 
> > > >  For example:
> > > >  - reading pid-files or logs written inside container with pid namespace
> > > >  - writing logs with internal pids outside container for pushing them into
> > > >  - attaching with ptrace to tasks from different pid namespace
> > > > 
> > > >  Generally speaking, any cross pid-ns API with pids needs translation.
> > > > 
> > > >  Currently there are several interfaces that could be used here:
> > > > 
> > > >  Pid namespaces are identified by device and inode of /proc/[pid]/ns/pid.
> > > > 
> > > >  Pids for nested pid namespaces are shown in file /proc/[pid]/status.
> > > >  In some cases pid translation could be easily done using this information.
> > > >  Backward translation requires scanning all tasks and becomes really
> > > >  complicated for deeper namespace nesting.
> > > > 
> > > >  Unix socket automatically translates pid attached to SCM_CREDENTIALS.
> > > >  This requires CAP_SYS_ADMIN for sending arbitrary pids and entering
> > > >  into pid namespace, this expose process and could be insecure."
> > > > 
> > > > The original patchset allowed two distinct operations implicitly:
> > > > - discovering whether pid namespaces (pidns) have a parent-child
> > > >   relationship
> > > > - translating a pid from a source pidns into a target pidns
> > > > 
> > > > Both tasks are accomplished in the original patchset by passing a pid
> > > > along. If the pid argument is passed as 1 the relationship between two pid
> > > > namespaces can be discovered.
> > > > The syscall will gain a lot clearer syntax and will be easier to use for
> > > > userspace if the task it is asked to perform is passed through a
> > > > command argument. Additionally, it allows us to remove an intrinsic race
> > > > caused by using the pid argument as a way to discover the relationship
> > > > between pid namespaces.
> > > > This patch introduces three commands:
> > > > 
> > > > /* PIDCMD_QUERY_PID */
> > > > PIDCMD_QUERY_PID allows to translate a pid between pid namespaces.
> > > > Given a source pid namespace fd return the pid of the process in the target
> > > > namespace:
> > > 
> > > Could we call this PIDCMD_TRANSLATE_PID please? QUERY is confusing/ambigious
> > > IMO (see below).
> > 
> > Yes, doesn't matter to me too much what we call it.
> 
> Ok.
> 
> > > > 1. pidctl(PIDCMD_QUERY_PID, pid, source_fd, -1, 0)
> > > >   - retrieve pidns identified by source_fd
> > > >   - retrieve struct pid identifed by pid in pidns identified by source_fd
> > > >   - retrieve callers pidns
> > > >   - return pid in callers pidns
> > > > 
> > > > 2. pidctl(PIDCMD_QUERY_PID, pid, -1, target_fd, 0)
> > > >   - retrieve callers pidns
> > > >   - retrieve struct pid identifed by pid in callers pidns
> > > >   - retrieve pidns identified by target_fd
> > > >   - return pid in pidns identified by target_fd
> > > > 
> > > > 3. pidctl(PIDCMD_QUERY_PID, 1, source_fd, -1, 0)
> > > >   - retrieve pidns identified by source_fd
> > > >   - retrieve struct pid identifed by init task in pidns identified by source_fd
> > > >   - retrieve callers pidns
> > > >   - return pid of init task of pidns identified by source_fd in callers pidns
> > > > 
> > > > 4. pidctl(PIDCMD_QUERY_PID, pid, source_fd, target_fd, 0)
> > > >   - retrieve pidns identified by source_fd
> > > >   - retrieve struct pid identifed by pid in pidns identified by source_fd
> > > >   - retrieve pidns identified by target_fd
> > > >   - check whether struct pid can be found in pidns identified by target_fd
> > > >   - return pid in pidns identified by target_fd
> > > > 
> > > > /* PIDCMD_QUERY_PIDNS */
> > > > PIDCMD_QUERY_PIDNS allows to determine the relationship between pid
> > > > namespaces.
> > > > In the original version of the pachset passing pid as 1 would allow to
> > > > deterimine the relationship between the pid namespaces. This is inherhently
> > > > racy. If pid 1 inside a pid namespace has died it would report false
> > > > negatives. For example, if pid 1 inside of the target pid namespace already
> > > > died, it would report that the target pid namespace cannot be reached from
> > > > the source pid namespace because it couldn't find the pid inside of the
> > > > target pid namespace and thus falsely report to the user that the two pid
> > > > namespaces are not related. This problem is simple to avoid. In the new
> > > > version we simply walk the list of ancestors and check whether the
> > > > namespace are related to each other. By doing it this way we can reliably
> > > > report what the relationship between two pid namespace file descriptors
> > > > looks like.
> > > > 
> > > > 1. pidctl(PIDCMD_QUERY_PIDNS, 0, ns_fd1, ns_fd1, 0) == 0
> > > >    - pidns_of(ns_fd1) and pidns_of(ns_fd2) are unrelated to each other
> > > > 
> > > > 2. pidctl(PIDCMD_QUERY_PIDNS, 0, ns_fd1, ns_fd2, 0) == 1
> > > >    - pidns_of(ns_fd1) == pidns_of(ns_fd2)
> > > > 
> > > > 3. pidctl(PIDCMD_QUERY_PIDNS, 0, ns_fd1, ns_fd2, 0) == 2
> > > >    - pidns_of(ns_fd1) is ancestor of pidns_of(ns_fd2)
> > > > 
> > > > 4. pidctl(PIDCMD_QUERY_PIDNS, 0, ns_fd1, ns_fd2, 0) == 3
> > > >    - pidns_of(ns_fd2) is ancestor of pidns_of(ns_fd1)
> > > 
> > > Why not call this PIDCMD_COMPARE_PIDNS, since a comparison is what you're doing.
> > 
> > Same.
> 
> Ok, glad we agree on it.
> 
> > > 
> > > Again QUERY is ambigious here. Above you called QUERY to translate something,
> > > now you're calling QUERY to mean compare something. I suggest to be explicit
> > > about the operation PIDCMD_<OPERATION>_<OPERAND-TYPE>.
> > > 
> > > Arguably, 2 syscalls for this is cleaner:
> > > pid_compare_namespaces(ns_fd1, ns_fd2);
> > > pid_translate(pid, ns_fd1, nds_fd2);
> > 
> > I don't think we want to send out pid_compare_namespaces() as a separate
> > syscall. If that's the consensus I'd rather just drop this functionality
> > completely.
> 
> I mean, if pid-namespace fd comparison functionality is not needed in
> userspace, why add it all. I suggest to drop it if not needed and can be
> considered for addition later when needed.
> 
> Then you're just left with GET_PID and TRANSLATE_PID which we know we do need.
> 
> > > > These two commands - PIDCMD_QUERY_PID and PIDCMD_QUERY_PIDNS - cover and
> > > > improve the functionality expressed implicitly in translate_pid() before.
> > > > 
> > > > /* PIDCMD_GET_PIDFD */
> > > 
> > > And this can be a third syscall:
> > > pidfd_translate(pid, ns_fd1, ns_fd2).
> > 
> > Sigh, yes. But I honestly want other people other than us to come out
> > and say "yes, please send a PR to Linus with three separate syscalls for
> > very closely related functionality". There's a difference between "this
> > is how we would ideally like to do it" and "this is what is common
> > practice and will likely get accepted". But I'm really not opposed to it
> > per se.
> 
> Ok.
> 
> > > I am actually supportive of Daniel's view that by combining too many
> > > arguments into a single syscall, becomes confusing and sometimes some
> > > arguments have to be forced to 0 in the single shoe-horned syscall. Like you
> > 
> > There's a difference between an ioctl() and say seccomp() which this is
> > close to:
> > int seccomp(unsigned int operation, unsigned int flags, void *args);
> > The point is that the functionality is closely related not just randomly
> > unrelated stuff. But as I said I'm more than willing to compromise.
> 
> Sounds great, yeah whatever makes sense.

One option is to do the following which removes the cmd argument all
together in favor of a flag GET_PIDFD:

+SYSCALL_DEFINE4(pidfd_translate, pid_t, pid, int, source, int, target,
+               unsigned int, flags)
+{
+       struct pid_namespace *source_ns, *target_ns;
+       struct pid *struct_pid;
+       pid_t result;
+
+       if (flags & ~GET_PIDFD)
+               return -EINVAL;
+
+       source_ns = get_pid_ns_by_fd(source);
+       if (IS_ERR(source_ns))
+               return PTR_ERR(source_ns);
+
+       target_ns = get_pid_ns_by_fd(target);
+       if (IS_ERR(target_ns)) {
+               put_pid_ns(source_ns);
+               return PTR_ERR(target_ns);
+       }
+
+       rcu_read_lock();
+       struct_pid = get_pid(find_pid_ns(pid, source_ns));
+       rcu_read_unlock();
+
+       if (struct_pid)
+               result = pid_nr_ns(struct_pid, target_ns);
+       else
+               result = -ESRCH;
+
+       if ((flags & GET_PIDFD) && (result > 0))
+               result = pidfd_create_fd(struct_pid, O_CLOEXEC);
+
+       if (!result)
+               result = -ENOENT;
+
+       put_pid(struct_pid);
+       put_pid_ns(target_ns);
+       put_pid_ns(source_ns);
+
+       return result;
+}
