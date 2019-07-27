Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DDDC7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82782084C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564245327;
	bh=tHF1NxjPMpWpMZzvHerZQqtIsaHKqxqsNpzcrXIgAKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=c/pFNYC9eVbnpXvNBNeczTqpy4848OggvsBxSYK7UappogJKLMZecE3qt8noXuU2g
	 WrebnTuAppnmO6z6McA3UGk66Tz1/nZ8+VicAqNc5/LBu41uETt21kKSi5sSxvQHew
	 C/C6DxRwVaaz0FCeXre9ZTVjqIziZRSx66oKctlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387880AbfG0Qf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 12:35:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37873 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728856AbfG0QfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 12:35:19 -0400
Received: by mail-lj1-f193.google.com with SMTP id z28so126937ljn.4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMt3Dip69HxsJytg4yVDJuHJalu5ybWoDVCuTko6OO4=;
        b=MJy3/ok5XyvWk6FJ4PplvzCbdcjfBIZF7gqdtNFDi1l2KLQms1yg8a7ubS4VlAHghm
         D82xRbcnUsbnTpdNRZOfJCtPBnQRdKjbfsWmPIAbuQOo94y8QSXmA56K1Wq/UT1daQ76
         PplvjHeA4gcbYSESZq21nUXUjjmdRe1JiBYvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMt3Dip69HxsJytg4yVDJuHJalu5ybWoDVCuTko6OO4=;
        b=D5b5jFFiQcfYR9qYJzqfsCD/ex1wnTZn225Jnu9PSAtnJy8HPGkWYfQmZ6s9kQRg05
         cAeqk7fq1iIK948PcdARqdoZxRJ5xK0QbJHNFpJScrIojYEiWV0Lyawoku11SsGZ6MuA
         JYJ6NXzloxqBCfiskX7DOpg3ADyqMtK6o/1FQDM9kxZ5Dov8fxzAjIaTAgtVQnTEpTuy
         5WKzHc12QMb6KIXR7Kpc/xEeqXKnLiQMTzntKvjVHAI1PRh4f4x25Jc+ZKqP7JulvEOh
         sTM9KWBJljS9Quk2xVQKJu5nWQ9d7EaKBySAPW4MIk7stNrRUbx2Ofu5rBDKlY4OCM9b
         g69A==
X-Gm-Message-State: APjAAAWZ36X0WO18zjZpk0pfQgab7dFige4fyqHhKsg1oITxG7NBzk1N
        w42KBE+cgX9zk1q++7DzqeZeRfr26lk=
X-Google-Smtp-Source: APXvYqyajN26pS+ca/WL/b/pk/Y1RqKJOc87Ewzu3SP+iTaof95E+TJT7McauzBJq8mCiCJnW6rBVg==
X-Received: by 2002:a2e:5b0f:: with SMTP id p15mr51173440ljb.82.1564245316981;
        Sat, 27 Jul 2019 09:35:16 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id j14sm11218296ljc.67.2019.07.27.09.35.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 09:35:16 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id m8so20780147lji.7
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 09:35:16 -0700 (PDT)
X-Received: by 2002:a2e:a0cf:: with SMTP id f15mr31325995ljm.180.1564244935984;
 Sat, 27 Jul 2019 09:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190727085201.11743-1-christian@brauner.io> <20190727085201.11743-2-christian@brauner.io>
In-Reply-To: <20190727085201.11743-2-christian@brauner.io>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jul 2019 09:28:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
Message-ID: <CAHk-=whrh5+aHmgqP9YhZ-yzCtUWT8fPi08ZSJdxusx7aHXOQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] pidfd: add P_PIDFD to waitid()
To:     Christian Brauner <christian@brauner.io>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tejun Heo <tj@kernel.org>, David Howells <dhowells@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry to keep pestering about the patch series, but with the addition
of P_PIDFD, I react once again..

On Sat, Jul 27, 2019 at 1:53 AM Christian Brauner <christian@brauner.io> wrote:
>
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -1555,6 +1555,7 @@ static long do_wait(struct wait_opts *wo)
>  static long kernel_waitid(int which, pid_t upid, struct waitid_info *infop,
>                           int options, struct rusage *ru)
>  {
> +       struct fd f;

Please don't do 'struct fd' at this level. That results in this ugly code later:

> -       put_pid(pid);
> +       if (which == P_PIDFD)
> +               fdput(f);
> +       else
> +               put_pid(pid);

which just looks nasty.

Instead, do all the 'file descriptor to pid' games here:

> +       case P_PIDFD:
> +               type = PIDTYPE_PID;
> +               if (upid < 0)
> +                       return -EINVAL;
> +
> +               f = fdget(upid);
> +               if (!f.file)
> +                       return -EBADF;
> +
> +               pid = pidfd_pid(f.file);
> +               if (IS_ERR(pid)) {
> +                       fdput(f);
> +                       return PTR_ERR(pid);
> +               }
>                 break;

and make thus just do something like

        pid = get_pid_from_fd(upid);
        if (IS_ERR(pid))
                return PTR_ERR(pid);

and now do that "fd to pid" in that helper function, and get the
reference to 'struct pid *' there instead.

Which you can actually do efficiently and lightly without even getting
a ref to the 'struct file'. Something like

  struct pid *fd_to_pid(unsigned int fd)
  {
        struct fd f;
        struct pid *pid;

        f = fdget(fd);
        if (!f.file)
                return ERR_PTR(-EBADF);
        pid = pidfd_pid(f.file);
        if (!IS_ERR(pid))
                get_pid(pid);
        fdput(f);
        return pid;
  }

is the stupid and straightforward thing, but if you want to be
*clever* you can actually avoid getting a reference to the 'struct
file *" entirely, and do the fd->pid lookup under rcu_read_lock()
instead. It's slightly more complex, but it avoids the fdget/fdput
reference count games entirely.

And then all that kernel_waitid() ever worries about is "struct pid
*", and the ending goes back to just that simple

        put_pid(pid);
        return ret;

instead.

This was kind of my point of doing all the "find_get_pid()" games in
the "switch()" statement - the different cases have different ways to
look up what the "struct pid *" pointer should be, but they should all
just look up a pid pointer, and then nothing else needs to care about
'type' any more. See?

Hmm?

                Linus
