Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16749C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA158206E6
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 01:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ooZ3b25f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLQBNq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 20:13:46 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34882 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbfLQBNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 20:13:45 -0500
Received: by mail-oi1-f194.google.com with SMTP id k4so497155oik.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 17:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Gz2pfk83gxmeYwRdsPahvEeJS5pQqN1WazyBRjRhto=;
        b=ooZ3b25fI6kv5zyAhlRDYLL/Lta9UAjZJ2ZmjTaK4c2cUxFG5tRCt1GwUsnecOXmv0
         weNx0eHo2pfbzX+sN+l0tdj+Gffk6olg8jEEbD85Xl+1bcjK5TfC53gAAwPsCsaiMrRH
         4gC81AJVwIC2mJ8OVvtCxGrHnkVYDtxCJ37jx7j/r20D7EDiPk/13HcbQ+qzy38PBqRU
         sRqekF9HlX9Cy/9n6tMkJG4WxLFRJbS8oB2aqP9XC7RRgr/bYa3pfWeeAQb89HMWWjfX
         2ynQM6mRUlp9KVgvKaemyppKH/DDpbmDShwj5VLx6/DFE2gSjOODWaXZjWbAmh6P3z/v
         6swQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Gz2pfk83gxmeYwRdsPahvEeJS5pQqN1WazyBRjRhto=;
        b=grQNDZvp5Mskss+Lek9QKLPXhpvng1V1hmZON4YgidqCUmaxxc38Cbp36EOU0G+h+K
         q1uKlS37wNY2pnWZeVp7VqqhCfT5/NGWJb2ytiF5HzQYDtuuaCsvRgrpskjXtmnyS/iR
         dod6XtQCuQMup4eRCYwJ7bZRIysM7wsMOXZQAnvOV6JwuE/ZFXe4kxZpZsBjbHvPaacJ
         Hka95uJzrMKNAx2mO99Cb6hor2tQTayc9WeUVXUejXEBmIoSEZt0GSBkQtjzR7lYqVkv
         6SI+J+Z54yIIKJ4IOR9WNQdrtrjRKYUGrixO2FH4a+JKVzuyct4xyZ6LmZSVZNR6AwTW
         Fb/g==
X-Gm-Message-State: APjAAAUcT6ieiefBc++Ym14WkCByCbuUVW7zkCc/WMkx0Ci51oZiJ/vm
        D2s563E4rH0zyPcEj3/ZZKxoW6p2gw1Pwe4Pmm5anl1BCtXsuw==
X-Google-Smtp-Source: APXvYqw1K714n5uzrU/DqhE5hq4qTxDhMwll3wid7OcY1dyfJe66ZxpOeksE7ntSDlrUdkMp2vopw7scMlouv0aIqxo=
X-Received: by 2002:aca:c7cb:: with SMTP id x194mr1051074oif.157.1576545224611;
 Mon, 16 Dec 2019 17:13:44 -0800 (PST)
MIME-Version: 1.0
References: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20191217010001.GA14461@ircssh-2.c.rugged-nimbus-611.internal>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 17 Dec 2019 02:13:16 +0100
Message-ID: <CAG48ez0ooeZfdBf+u9uE3mzo2yc7f1D5EHZ09Jz5T8VVh6AWYw@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] pid: Add PIDFD_IOCTL_GETFD to fetch file
 descriptors from processes
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>, gpascutto@mozilla.com,
        ealvarez@mozilla.com, Florian Weimer <fweimer@redhat.com>,
        jld@mozilla.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2019 at 2:00 AM Sargun Dhillon <sargun@sargun.me> wrote:
> This adds an ioctl which allows file descriptors to be extracted
> from processes based on their pidfd.
[...]
> You must have the ability to ptrace the process in order to extract any
> file descriptors from it. ptrace can already be used to extract file
> descriptors based on parasitic code injections, so the permissions
> model is aligned.
[...]
> +       task = get_pid_task(pid, PIDTYPE_PID);
> +       if (!task)
> +               return -ESRCH;
> +       ret = -EPERM;

Please add something like

if (mutex_lock_killable(&task->signal->cred_guard_mutex))
  goto out;

here, and drop the mutex after fget_task().

> +       if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS))
> +               goto out;
> +       ret = -EBADF;
> +       file = fget_task(task, args.fd);
> +       if (!file)
> +               goto out;
> +
> +       fd = get_unused_fd_flags(fd_flags);
> +       if (fd < 0) {
> +               ret = fd;
> +               goto out_put_file;
> +       }
> +       /*
> +        * security_file_receive must come last since it may have side effects
> +        * and cannot be reversed.
> +        */
> +       ret = security_file_receive(file);
> +       if (ret)
> +               goto out_put_fd;
> +
> +       fd_install(fd, file);
> +       put_task_struct(task);
> +       return fd;
> +
> +out_put_fd:
> +       put_unused_fd(fd);
> +out_put_file:
> +       fput(file);
> +out:
> +       put_task_struct(task);
> +       return ret;
> +}
