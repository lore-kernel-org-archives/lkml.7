Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 381D820850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="R4IQA6d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfCYT6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:58:50 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37826 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYT6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:58:50 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so11677747wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 12:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IflRecgAXem3q7nTcLDtmSy1TfeTC3yRC+f5KaxRF0E=;
        b=R4IQA6d5HoKaAuTtZn5J1vHA5V3WC0Z6ikf+LAa96EIauHn6m1TUbg0w2Pb+eQm/21
         hN0plB9m5HLVw8X+d+9dDpRlCouZWX2i3gevVuHRGSe2lxYWZQVJ0MQvAZeG4oR6KTBS
         FyjZCJTFhhiwptcPN06v+dvuhE2lcGRjBPXGm1a8Klv9gdfUb0SvOwq7YfbgFk+VZrrz
         T/TOShHC0GCpGVqmqdZZvqD5WQuVQqUjqff2gKBJCeWNmjLGaBUzwRhCuMJO/aSnPAWj
         IG8yLjIgrg5Qo1pWgg5FvMZo7s0FNYO5zJ4Wj0AD4il88kdtf9iVmW/efptJGNdFNYjD
         fLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IflRecgAXem3q7nTcLDtmSy1TfeTC3yRC+f5KaxRF0E=;
        b=PHu5oS17Sn1e6mskJedJ6jxFGvZQH/e4rYpF5z8VjaCGJE1TW/LgRIKlB6wwkw9Uf6
         oRYLJunnfPMt4f2IzmlOBRUd3YMawtMSVpCkFjAui0G67zr/4NHkwWB+NB9/mHnkXaqj
         XQkRhEUV9D9nfyJ9G1J+I5rL08LW1q2F6v+JYm3/w/MqBfx7fBVtlm/kIvB08Yu4zL2I
         XsLMV5UwRrnCklZDKaVEGuIeopctA8FBehlvOIbX9Llzagxdsok4Vf6+dfZBIvXfogeH
         op7qi+CsRl6h3DNAj7PKWp9qNgQ96AoY2Womepwgm6TUo5s1YHgSY75KnisZl+V82Kue
         VVqQ==
X-Gm-Message-State: APjAAAWSn8lB4GiPQGDq4w00Jz2pd971GNsXfrSU0+9zPpjcuQiAG3Eo
        i2xGr+7xMmB3O5E3gque6ti0hQ==
X-Google-Smtp-Source: APXvYqxxrDcaBKn55IEreKQ4ZRq6BN0rMjtvu4JhwsP2RQjrH0Q7UYJxWP1xuu6xMugCA0eWu+8IOQ==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr17896290wru.186.1553543927858;
        Mon, 25 Mar 2019 12:58:47 -0700 (PDT)
Received: from brauner.io (p200300EA6F14663DB13635B07C8C280A.dip0.t-ipconnect.de. [2003:ea:6f14:663d:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id c10sm14556766wrr.1.2019.03.25.12.58.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 25 Mar 2019 12:58:47 -0700 (PDT)
Date:   Mon, 25 Mar 2019 20:58:45 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 2/4] pid: add pidctl()
Message-ID: <20190325195844.lrf7kgutlyv77vmu@brauner.io>
References: <20190325162052.28987-1-christian@brauner.io>
 <20190325162052.28987-3-christian@brauner.io>
 <CAG48ez24xPM4f7ty=8k5p6_gVWd-bEUSxca5Ngy5svHgarhz+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez24xPM4f7ty=8k5p6_gVWd-bEUSxca5Ngy5svHgarhz+w@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 07:18:42PM +0100, Jann Horn wrote:
> On Mon, Mar 25, 2019 at 5:21 PM Christian Brauner <christian@brauner.io> wrote:
> > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > I quote Konstantins original patchset first that has already been acked and
> > picked up by Eric before and whose functionality is preserved in this
> > syscall:
> [...]
> > +
> > +static struct pid_namespace *get_pid_ns_by_fd(int fd)
> > +{
> > +       struct pid_namespace *pidns = ERR_PTR(-EINVAL);
> > +
> > +       if (fd >= 0) {
> > +#ifdef CONFIG_PID_NS
> > +               struct ns_common *ns;
> > +               struct file *file = proc_ns_fget(fd);
> > +               if (IS_ERR(file))
> > +                       return ERR_CAST(file);
> > +
> > +               ns = get_proc_ns(file_inode(file));
> > +               if (ns->ops->type == CLONE_NEWPID)
> > +                       pidns = get_pid_ns(
> > +                               container_of(ns, struct pid_namespace, ns));
> 
> This increments the refcount of the pidns...

I didn't touch that code. That's taken over from the orginial patchset.
Thanks for catching this.

> 
> > +
> > +               fput(file);
> > +#endif
> > +       } else {
> > +               pidns = task_active_pid_ns(current);
> 
> ... but this doesn't. That's pretty subtle; could you please put a
> comment on top of this function that points this out? Or even better,
> change the function to always take a reference, so that the caller
> doesn't have to worry about figuring this out.

Always taking a reference sounds more correct. Will do.

> 
> > +       }
> > +
> > +       return pidns;
> > +}
> [...]
> > +SYSCALL_DEFINE5(pidctl, unsigned int, cmd, pid_t, pid, int, source, int, target,
> > +               unsigned int, flags)
> > +{
> > +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
> > +       struct pid *struct_pid;
> > +       pid_t result;
> > +
> > +       switch (cmd) {
> > +       case PIDCMD_QUERY_PIDNS:
> > +               if (pid != 0)
> > +                       return -EINVAL;
> > +               pid = 1;
> > +               /* fall through */
> > +       case PIDCMD_QUERY_PID:
> > +               if (flags != 0)
> > +                       return -EINVAL;
> > +               break;
> > +       case PIDCMD_GET_PIDFD:
> > +               if (flags & ~PIDCTL_CLOEXEC)
> > +                       return -EINVAL;
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       source_ns = get_pid_ns_by_fd(source);
> > +       result = PTR_ERR(source_ns);
> 
> I very much dislike using PTR_ERR() on pointers before checking
> whether they contain an error value or not. I understand that the
> result of this won't actually be used, but it still seems weird to
> have what is essentially a cast of a potentially valid pointer to a
> potentially smaller integer here.
> 
> Could you maybe move the PTR_ERR() into the error branch? Like so:

Will do!

> 
> if (IS_ERR(source_ns)) {
>   result = PTR_ERR(source_ns);
>   goto err_source;
> }
> 
> > +       if (IS_ERR(source_ns))
> > +               goto err_source;
> > +
> > +       target_ns = get_pid_ns_by_fd(target);
> > +       result = PTR_ERR(target_ns);
> > +       if (IS_ERR(target_ns))
> > +               goto err_target;
> > +
> > +       if (cmd == PIDCMD_QUERY_PIDNS) {
> > +               result = pidns_related(source_ns, target_ns);
> > +       } else {
> > +               rcu_read_lock();
> > +               struct_pid = find_pid_ns(pid, source_ns);
> 
> find_pid_ns() doesn't take a reference on its return value, the return
> value is only pinned into memory by the RCU read-side critical
> section...
> 
> > +               result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
> > +               rcu_read_unlock();
> 
> ... which ends here, making struct_pid a dangling pointer...
> 
> > +
> > +               if (cmd == PIDCMD_GET_PIDFD) {
> > +                       int cloexec = (flags & PIDCTL_CLOEXEC) ? O_CLOEXEC : 0;
> > +                       if (result > 0)
> > +                               result = pidfd_create_fd(struct_pid, cloexec);
> 
> ... and then here you continue to use struct_pid. That seems bogus.

I'll just take a reference to struct pid once I found it to prevent that
from happening.

> 
> > +                       else if (result == 0)
> > +                               result = -ENOENT;
> 
> You don't need to have flags for this for new syscalls, you can just
> make everything O_CLOEXEC; if someone wants to preserve an fd across
> execve(), they can just clear that bit with fcntl(). (I thiiink it was
> Andy Lutomirski who said that before regarding another syscall? But my
> memory of that is pretty foggy, might've been someone else.)

If that's the way going forward this is fine with me!

> 
> > +               }
> > +       }
> > +
> > +       if (target)
> > +               put_pid_ns(target_ns);
> > +err_target:
> > +       if (source)
> > +               put_pid_ns(source_ns);
> 
> I think you probably intended to check for "if (target >= 0)" and "if
> (source >= 0)" instead of these conditions, matching the condition in
> get_pid_ns_by_fd()? The current code looks as if it will leave the
> refcount one too high when used with target==0 or source==0, and leave
> the refcount one too low when used with target==-1 or source==-1.
> Anyway, as stated above, I think it would be simpler to
> unconditionally take a reference instead.

Yep.

> 
> > +err_source:
> > +       return result;
> > +}
