Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F94FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B84820811
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553618595;
	bh=0tfxmRPyDL+6TieH2j63s77iLPVQYtSyxbar+zBk5QY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O1t0bN+hqeLz7ILxnvv+L3juLhkHd5/GywfFYek3ES5dgzH2Wk+xYYJJ4usRQGRfp
	 m0jl8XggTjYVIFvfnsZr6KecY4wvEpx+HUBTKNDG8SZ6lpvnl7qBBc0M9TsbPm/xYz
	 zq4xi3Ov/YKX8BTMwT6UkoaYThNXuRSkvuuxwL+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfCZQnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730451AbfCZQnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:43:13 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6768A20866
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553618592;
        bh=0tfxmRPyDL+6TieH2j63s77iLPVQYtSyxbar+zBk5QY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qY6V7NpUZT1W0sBFdMu38Ffb6y+3ojkkBpRlMdyZFrhfQ9CpDlySHOuR8kVBqbxgb
         /AEvZ+Hf3h6MqxabmB3Bb2Cg5J91h9Fi2siXsC57YempGQm541gxChHzAWIDQ92tWK
         O4A5c2ex87C34clOhw0X9r2vIe4LjFMeUuPW+e8Y=
Received: by mail-wr1-f50.google.com with SMTP id w10so15198631wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:43:12 -0700 (PDT)
X-Gm-Message-State: APjAAAXMhW5adQ4Q4GMei36ZmsGazH58aIAO7DwPPO32uFD/vVNE0uiB
        mQNoEI+z6O84eu5PGp6f3T8LoyfvjD4Zvv5Q7rhTUg==
X-Google-Smtp-Source: APXvYqy5D8yuxXRDBqy+V1WQHcTakQoltVVHofMwBVCCUk6EjtCJVseD7lFytX4+X7CXpxRjXs4jzoek4xcsrm/2fmQ=
X-Received: by 2002:a5d:6252:: with SMTP id m18mr19171451wrv.199.1553618590971;
 Tue, 26 Mar 2019 09:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io> <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io>
In-Reply-To: <20190326163452.uku4bgkessxzxvai@brauner.io>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 09:42:59 -0700
X-Gmail-Original-Message-ID: <CALCETrXdyTxJZBXR02Dd=fnZYNLxFYgiJfnJCONBK5khy7JPVQ@mail.gmail.com>
Message-ID: <CALCETrXdyTxJZBXR02Dd=fnZYNLxFYgiJfnJCONBK5khy7JPVQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
Cc:     Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > Thanks for the patch.
> > > >
> > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > syscall:
> > > >
> > > > We still haven't had a much-needed conversation about splitting this
> > > > system call into smaller logical operations. It's important that we
> > > > address this point before this patch is merged and becomes permanent
> > > > kernel ABI.
> > >
> > > I don't particularly mind splitting this into an additional syscall like
> > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > about this rn is that it connects both apis in a single syscall
> > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > what other people think.
> >
> > There's something to be said for
> >
> > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> >
> > /* get pidfd */
> > int pidfd = pidfd_open(1234, -1, 0);
> >
> > /* convert to procfd */
> > int procfd = pidfd_open(-1, 4, 0);
> >
> > /* convert to pidfd */
> > int pidfd = pidfd_open(4, -1, 0);
>
> probably rather:
>
> int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);

Do you mean:

int procrootfd = open("/proc", O_DIRECTORY | O_RDONLY);
int procfd = pidfd_open(procrootfd, pidfd, PIDFD_TO_PROCFD);

or do you have some other solution in mind to avoid the security problem?
