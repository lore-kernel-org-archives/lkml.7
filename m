Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC25C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB797205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CUo8nHTi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfCZQqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:46:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42704 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbfCZQqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:46:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id x61so5716680edc.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CUnsG4nZFUqlK9xMVi9XxULBtSGFwWhB5AMNqq5lCZ8=;
        b=CUo8nHTi1akTKAjwBghAYXcl0jRTdTclaEgYc3ltfrOnEzpTnmoh45F82+lfSt2ebH
         JWud442HMi86C3kPXWbG5yJbGD6OFUXNXbnD1tnic4gvge0CSQY137gKReHZgkSKUsA4
         CSnagauy1blVftDXr6F7PY+hFBqUZFwsAipR0ZDQ+DwV5hRdIMgftBu05hhPNwjrwzIX
         fjDU3XO69bkOi6m+LCJ9FM2FJWKGtCen7yb9f4UcSMTAM/USGhpFdPon2Sj7UBqhEDQQ
         bcuBb8Hd8cgt/FtbWqrJD3PbicXn7qnDEjIuu6FDHV9cQWe0oWi5Z1+ZrbIDkkm9NoP1
         Y8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CUnsG4nZFUqlK9xMVi9XxULBtSGFwWhB5AMNqq5lCZ8=;
        b=S3FPU7uDoBi/Dsux70sBkZ9UJ3D66b7gqdZBKuS0xknKa97EQ7iEd9FydRdhYuITS3
         OSUrripfhbYJi9NV9WTXGySKaj/SqY2kSw9v4LTLtWmbcvkdodwjGmk7ABpIgoOw1y0k
         QruQ/zpC2q7awajv9EOKKRLcV6bcEZuZq+5MbMxM3iyPIbPWBIXKPz2zprZzFEjti35u
         ILUKAkxYl18+ultOLEtdTl8cJ1W6hTmy15Zfg78HGJ8UzOiEyEeEBCk3Qd6+9p29IcPQ
         KMCp7d2UQvowHKCa3R3FoiBeoSFNx7SnpKEQEP/g4FE8YUllJazV17JlPmZttLEqgQlZ
         moNw==
X-Gm-Message-State: APjAAAWrGY7oUgdIyqAqM59LYTRFnmWmJXwBmSFLK7wCxp6LeAci3GeH
        bwbEd/gYUn4uV7sx7zCuH4P4Xw==
X-Google-Smtp-Source: APXvYqyc/OSfNgonVmP3tdVpWcIEur2tYtwTNAB60u+LUrDohjVqNFCS6ShjAtKSTelJeMnrnmiZRA==
X-Received: by 2002:a50:cccc:: with SMTP id b12mr21233010edj.94.1553618798235;
        Tue, 26 Mar 2019 09:46:38 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id l44sm6297030edb.37.2019.03.26.09.46.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:46:37 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:46:35 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
Message-ID: <20190326164634.ba5dko6weazp3zyd@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io>
 <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io>
 <CALCETrXdyTxJZBXR02Dd=fnZYNLxFYgiJfnJCONBK5khy7JPVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXdyTxJZBXR02Dd=fnZYNLxFYgiJfnJCONBK5khy7JPVQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:42:59AM -0700, Andy Lutomirski wrote:
> On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > > Thanks for the patch.
> > > > >
> > > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > >
> > > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > > syscall:
> > > > >
> > > > > We still haven't had a much-needed conversation about splitting this
> > > > > system call into smaller logical operations. It's important that we
> > > > > address this point before this patch is merged and becomes permanent
> > > > > kernel ABI.
> > > >
> > > > I don't particularly mind splitting this into an additional syscall like
> > > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > > about this rn is that it connects both apis in a single syscall
> > > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > > what other people think.
> > >
> > > There's something to be said for
> > >
> > > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> > >
> > > /* get pidfd */
> > > int pidfd = pidfd_open(1234, -1, 0);
> > >
> > > /* convert to procfd */
> > > int procfd = pidfd_open(-1, 4, 0);
> > >
> > > /* convert to pidfd */
> > > int pidfd = pidfd_open(4, -1, 0);
> >
> > probably rather:
> >
> > int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
> 
> Do you mean:
> 
> int procrootfd = open("/proc", O_DIRECTORY | O_RDONLY);
> int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD);
> 
> or do you have some other solution in mind to avoid the security problem?

Yes, we need the proc root obviously. I just jotted this down.

We probably would need where one of the fds can refer to the proc root.

pidfd_open(pid_t, int fd, int fd, 0)
