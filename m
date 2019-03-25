Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A46A20700
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:19:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V3YZDTHG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbfCYSTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:19:10 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42491 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYSTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:19:09 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so7757341oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kpfZEB8seTa5rcxqxvtG1a1pQgXUVafxXpBfTveNUuA=;
        b=V3YZDTHGdewcTOVjIzQCzIq9kUZ8v8nnV2JhmhAwF+0wvlSRSL4L/xI7fGjiMJS8Sa
         kPCrbA3l/HheWbwq6LIpQiWCuNNX/GHSq91JRJASAJI8sfKuiLHGGkIxplKOeZk02/8Z
         PeUV5hwdTcM2dcVngctKQjnp3sKKbdcitOEXnr+asnMmVnbH7a0LXBu6o15wL147+ef3
         QUQ8zvEQUv1x4r9WD1rX/FuLEkLSyxUzvVmryGbyCvwy7a338B4m3z4bMQyvYknOd9A0
         2uaDWR5rlnOCm1hhMmipy6aWIQmnLzjOWSyVwO/q9/Duflb/VUyaMvEt/gGM1cZeMvEH
         MGVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kpfZEB8seTa5rcxqxvtG1a1pQgXUVafxXpBfTveNUuA=;
        b=WFy23lRFw62aAqx8k907ybzAJY2BJTRChEN3/aPcWNjoOPpJpeRkYMdCDUuyBVThHx
         BEDuzWSpCN6rsAPCtxaxhstg+vgpQoYsNBnJ5H3LGqv29XwDh8a0SBs+mj8UiD4xqqB1
         7WR7wFw6zbL9xpZoKCKkS5vyCpWzLcvKGVpxOwl82XZ8Y2unuE7xXmuutEa9z2gMNNaY
         DQyLOiT35D65TJUqCLKBODCuNGrbI47f9SN32diufpT/xaHTQZBnvLh5Y4o4tQpI41sv
         hWhOHTzYyyCL2oIp3sP6poNChagqGNWuwJI97ySHmx7ouqvbedqSs3RMRun2+R/z4zIH
         OhWA==
X-Gm-Message-State: APjAAAWXg3NArOd4FDG9j3nfmKYgwF15YhT6j9g2beyhVd7EDkglY1yP
        8m6P0EUsa++XTMOYYj9n7A5kyNyPl3UrOXVvInpt1g==
X-Google-Smtp-Source: APXvYqwPZIe93KhYEWTVOZ8Y3uZuELlvhDH8NDA3ujkOeJIEAJgbnuNUU0RAyy9iKMk0nw+vQLvzqGrTCFZkuCm8GMo=
X-Received: by 2002:aca:360a:: with SMTP id d10mr12691911oia.68.1553537948348;
 Mon, 25 Mar 2019 11:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <20190325162052.28987-3-christian@brauner.io>
In-Reply-To: <20190325162052.28987-3-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Mar 2019 19:18:42 +0100
Message-ID: <CAG48ez24xPM4f7ty=8k5p6_gVWd-bEUSxca5Ngy5svHgarhz+w@mail.gmail.com>
Subject: Re: [PATCH 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:21 PM Christian Brauner <christian@brauner.io> wrote:
> The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> I quote Konstantins original patchset first that has already been acked and
> picked up by Eric before and whose functionality is preserved in this
> syscall:
[...]
> +
> +static struct pid_namespace *get_pid_ns_by_fd(int fd)
> +{
> +       struct pid_namespace *pidns = ERR_PTR(-EINVAL);
> +
> +       if (fd >= 0) {
> +#ifdef CONFIG_PID_NS
> +               struct ns_common *ns;
> +               struct file *file = proc_ns_fget(fd);
> +               if (IS_ERR(file))
> +                       return ERR_CAST(file);
> +
> +               ns = get_proc_ns(file_inode(file));
> +               if (ns->ops->type == CLONE_NEWPID)
> +                       pidns = get_pid_ns(
> +                               container_of(ns, struct pid_namespace, ns));

This increments the refcount of the pidns...

> +
> +               fput(file);
> +#endif
> +       } else {
> +               pidns = task_active_pid_ns(current);

... but this doesn't. That's pretty subtle; could you please put a
comment on top of this function that points this out? Or even better,
change the function to always take a reference, so that the caller
doesn't have to worry about figuring this out.

> +       }
> +
> +       return pidns;
> +}
[...]
> +SYSCALL_DEFINE5(pidctl, unsigned int, cmd, pid_t, pid, int, source, int, target,
> +               unsigned int, flags)
> +{
> +       struct pid_namespace *source_ns = NULL, *target_ns = NULL;
> +       struct pid *struct_pid;
> +       pid_t result;
> +
> +       switch (cmd) {
> +       case PIDCMD_QUERY_PIDNS:
> +               if (pid != 0)
> +                       return -EINVAL;
> +               pid = 1;
> +               /* fall through */
> +       case PIDCMD_QUERY_PID:
> +               if (flags != 0)
> +                       return -EINVAL;
> +               break;
> +       case PIDCMD_GET_PIDFD:
> +               if (flags & ~PIDCTL_CLOEXEC)
> +                       return -EINVAL;
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       source_ns = get_pid_ns_by_fd(source);
> +       result = PTR_ERR(source_ns);

I very much dislike using PTR_ERR() on pointers before checking
whether they contain an error value or not. I understand that the
result of this won't actually be used, but it still seems weird to
have what is essentially a cast of a potentially valid pointer to a
potentially smaller integer here.

Could you maybe move the PTR_ERR() into the error branch? Like so:

if (IS_ERR(source_ns)) {
  result = PTR_ERR(source_ns);
  goto err_source;
}

> +       if (IS_ERR(source_ns))
> +               goto err_source;
> +
> +       target_ns = get_pid_ns_by_fd(target);
> +       result = PTR_ERR(target_ns);
> +       if (IS_ERR(target_ns))
> +               goto err_target;
> +
> +       if (cmd == PIDCMD_QUERY_PIDNS) {
> +               result = pidns_related(source_ns, target_ns);
> +       } else {
> +               rcu_read_lock();
> +               struct_pid = find_pid_ns(pid, source_ns);

find_pid_ns() doesn't take a reference on its return value, the return
value is only pinned into memory by the RCU read-side critical
section...

> +               result = struct_pid ? pid_nr_ns(struct_pid, target_ns) : -ESRCH;
> +               rcu_read_unlock();

... which ends here, making struct_pid a dangling pointer...

> +
> +               if (cmd == PIDCMD_GET_PIDFD) {
> +                       int cloexec = (flags & PIDCTL_CLOEXEC) ? O_CLOEXEC : 0;
> +                       if (result > 0)
> +                               result = pidfd_create_fd(struct_pid, cloexec);

... and then here you continue to use struct_pid. That seems bogus.

> +                       else if (result == 0)
> +                               result = -ENOENT;

You don't need to have flags for this for new syscalls, you can just
make everything O_CLOEXEC; if someone wants to preserve an fd across
execve(), they can just clear that bit with fcntl(). (I thiiink it was
Andy Lutomirski who said that before regarding another syscall? But my
memory of that is pretty foggy, might've been someone else.)

> +               }
> +       }
> +
> +       if (target)
> +               put_pid_ns(target_ns);
> +err_target:
> +       if (source)
> +               put_pid_ns(source_ns);

I think you probably intended to check for "if (target >= 0)" and "if
(source >= 0)" instead of these conditions, matching the condition in
get_pid_ns_by_fd()? The current code looks as if it will leave the
refcount one too high when used with target==0 or source==0, and leave
the refcount one too low when used with target==-1 or source==-1.
Anyway, as stated above, I think it would be simpler to
unconditionally take a reference instead.

> +err_source:
> +       return result;
> +}
