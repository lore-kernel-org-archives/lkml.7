Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BAEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0556520693
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="CccCLRso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731991AbfCZQe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:34:58 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40143 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCZQe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:34:57 -0400
Received: by mail-ed1-f66.google.com with SMTP id h22so11341692edw.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uhKIZ8TUnlMSSQGGMRtLqbaYuRj+7mZCO6B+dsUkCqY=;
        b=CccCLRsoGNz69rhZaHHllAZ2djVdT9wcbzWzSlPXcm/dpS60RE8ukVlDX/ig+9hPBj
         N3yEQu+bgrNvHV3hH/mgZnQA9A5W8UBOBxw1fOpPwDNZDA0o2qvq2fn5iL/ojaRucek4
         i8Gx4tIP96CyG0Dw9CJ6wfCNoo4cpVkZAd14+eifQGWLb35S+/i6vwp8GmzyX1Nt/tDz
         ecQNBHf7makUomgg+6q6ARNJoIi6lF0Mh5SOd2tnmpdu0oGQbbwIIw9uEVbUPS9WyKi2
         hdhmauxG6xcNw6j7WlVPYKbp4egppkwfVrGpqYhDyLRY3hcdqqD2D7RBxhO1RtSf3TmK
         UsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uhKIZ8TUnlMSSQGGMRtLqbaYuRj+7mZCO6B+dsUkCqY=;
        b=pYMIb1n75WEnrzKrcvCN6g4uz34chaAH03EYaLMLoKvdd9mJnxyhviYok0QW7PyZe8
         SW5k7sLO1QQz82bWQMoqcXa/MeTX76tSGShy0v46wS2Zs/DF8AxE+GgnhAIq0iplizfE
         4ZfCaXuFSyd0L4WTvn3rUi3ViSwVVs4i3O2LfV9fmhgEdNSVrUO3lHuHSVXvdr6RxVLl
         lIHW2mj6EYMgon/OXwMdCQCMolb/kwN64E77p9zcL5cfyWVsePvNFM2Q1i9RvLwBg6Xc
         KafVd9wx0aFaZGDohtVicbhh+lcv2QQW38iS8PWBBUk9GDwxIxTNUJf48kzoJCAKmx4C
         paYw==
X-Gm-Message-State: APjAAAXVQ1Lhvw2F+pD+0AKHFx8Pz6V7SALLDlC3dq+znBpVDZG6Lfjm
        YvE1kaHurT2Uq8U8BxwwuFJvHQ==
X-Google-Smtp-Source: APXvYqyocoGdZNqeXotbuOvrE/6ASfsKPWrzMcN/tj1GT4/LvNcZVlWbP1SyHtyw/NdxbjVAUExttA==
X-Received: by 2002:aa7:c697:: with SMTP id n23mr20631407edq.231.1553618095657;
        Tue, 26 Mar 2019 09:34:55 -0700 (PDT)
Received: from brauner.io (x59cc895e.dyn.telefonica.de. [89.204.137.94])
        by smtp.gmail.com with ESMTPSA id z2sm4170721ejn.37.2019.03.26.09.34.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 26 Mar 2019 09:34:55 -0700 (PDT)
Date:   Tue, 26 Mar 2019 17:34:52 +0100
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
Message-ID: <20190326163452.uku4bgkessxzxvai@brauner.io>
References: <20190326155513.26964-1-christian@brauner.io>
 <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io>
 <20190326163142.4eh5qpgiqvygf26w@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190326163142.4eh5qpgiqvygf26w@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > Thanks for the patch.
> > > 
> > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > I quote Konstantins original patchset first that has already been acked and
> > > > picked up by Eric before and whose functionality is preserved in this
> > > > syscall:
> > > 
> > > We still haven't had a much-needed conversation about splitting this
> > > system call into smaller logical operations. It's important that we
> > > address this point before this patch is merged and becomes permanent
> > > kernel ABI.
> > 
> > I don't particularly mind splitting this into an additional syscall like
> > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > about this rn is that it connects both apis in a single syscall
> > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > what other people think.
> 
> There's something to be said for
> 
> pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> 
> /* get pidfd */
> int pidfd = pidfd_open(1234, -1, 0);
> 
> /* convert to procfd */
> int procfd = pidfd_open(-1, 4, 0);
> 
> /* convert to pidfd */
> int pidfd = pidfd_open(4, -1, 0);

probably rather:

int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
int procfd = pidfd_open(-1, 4, PROCFD_TO_PIDFD);
int pidfd = pidfd_open(1234, -1, 0);
