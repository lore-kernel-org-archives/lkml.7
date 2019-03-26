Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA424C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5D7205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="bq/BZra0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbfCZQoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:44:01 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44626 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:44:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id x10so11324916edh.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nXA+Zc94jeiwxcjEMbXHEF8ZsU3HvIEy2/wORExzlsI=;
        b=bq/BZra0vOCmLOlVieAJFyf7+DBsZgqOJq1ZUC4eztSOtrOlsP3aIAdU2+v4D+O35t
         YIpRT1VED+M1y+cq01AmWAh33M2uOh1Q3pLyV6KrhSEo5jiYSBt+uv+30Rc1SWRAFqEf
         7Dn2iXdhDQtGwuC5YZybe+0JUewMkNXZpDOLauhQlpF2GodCeV+Yii2Kz8WP4GPBntTq
         pxi6R0u66HhuVTahROKvEeeBdi4c4TAUqiQtm1BRwkAZ6JRUSvocR0KQVFs2Vaf9ijkK
         yvVcbCMa1eTpwvzBmjJ/Z9eZAANf7FyfE8ax3uD07cUESsb6nBcx7woK5pN8d6SZrdTK
         bF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nXA+Zc94jeiwxcjEMbXHEF8ZsU3HvIEy2/wORExzlsI=;
        b=Q6/nkQssiHaZ7TAspUOya5Tk9F7Q5fwwMY3GADEbOSS67fQiqZtr00JsJ3jv+OvqPm
         u/Z5iMUQoaXiXUJR++jAz8ySWAEjPp34/AyzXwVRazw50LkvnGfJmxv76CdqgZ4eTiy8
         uvb1MN+u+4vHBM0D+vpy9jHduYuAnEDttdjG6YtGOfsWng+WGAjTfVncUFJAsNgaD6Sg
         XhpQM77CJ/0gcUhAF+t9wo/M/tiD1ZmKdyWU0jEy1AVA7EzJInp6vvCSez6I9Jo4xwIu
         mxQ7YAiAHsHKxWAJTvXYQUQbzt8dhpU0CmNb/xEbQjizxrMRHQU7IKO4nJCXxsCo/a8b
         KBjA==
X-Gm-Message-State: APjAAAXoQ0zqDxfI5yTARqzFbTp2mALtDDfzhL+DQFkNd2JYpDr1sbsH
        GVuPL/zFRhC6mrVeb1Hr2BRiMg==
X-Google-Smtp-Source: APXvYqyRi2MN4G+2So+BkVBpkaAc5x2YFAqdWZsJUZduLWUFlW0uzEHgf/Of2mDTGnPoWafiEcsSPw==
X-Received: by 2002:a17:906:33c5:: with SMTP id w5mr18240582eja.61.1553618638292;
        Tue, 26 Mar 2019 09:43:58 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id t1sm120165eds.27.2019.03.26.09.43.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:43:57 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:43:55 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Daniel Colascione <dancol@google.com>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
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
Message-ID: <20190326164354.qecuzkqz6ic2433i@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io>
 <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io>
 <CAKOZuetcp=UPRWDkLUxLTmu-vqdN6qSmN9=0uP8MUuwyLoYfEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKOZuetcp=UPRWDkLUxLTmu-vqdN6qSmN9=0uP8MUuwyLoYfEA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 09:38:31AM -0700, Daniel Colascione wrote:
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
> > int procfd = pidfd_open(-1, 4, PROCFD_TO_PIDFD);
> > int pidfd = pidfd_open(1234, -1, 0);
> 
> These three operations look like three related but distinct functions
> to me, and in the second case, the "pidfd_open" name is a bit of a
> misnomer. IMHO, the presence of an "operation name" field in any API
> is usually a good indication that we're looking at a family of related
> APIs, not a single coherent operation.

So I'm happy to accommodate the need for a clean api even though I
disagree that what we have in pidctl() is unclean.
But I will not start sending a pile of syscalls. There is nothing
necessarily wrong to group related APIs together. By these standards the
new mount API would need to be like 30 different syscalls, same for
keyring management.
