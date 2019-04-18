Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8694EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E043214C6
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555614920;
	bh=yF0ASliWFGOqtTNFNd9ApfMVJnOQNOqpPdAJCnRMduQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WXMX1p1jR4hbWAyM8exemqy2duwIUQRpx6XWeWkdTPn9y164P4ab7rDrJ9g7cPLP/
	 jxO3boV3nKa1Q76BVH0aw0sWsat8oC++kHiVogRlJgYafPovTmCPBwskJZA0cTsK/G
	 EQ8eaiMdC9BNuhwB5ZfOBTVZEwSXJvcE/8P1smBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389832AbfDRTPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:15:19 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38245 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfDRTPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:15:18 -0400
Received: by mail-lf1-f67.google.com with SMTP id v1so2439832lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WjkwEC2X7f81mf9W5bTPXnbaAR/cw3xla7sDK1DJ93w=;
        b=F93MvXeFPx4zJosWUg3P8P/z7oNIbI6Qc31xGEhP9uUkp8ZZXigB717fkcgW2iZm7x
         yAf2QBmvG1U+saXwrvJhAYl5DQs3BzgDa9DlCw8Y6qbenblzJVlE/GGzUnnVPwPeojnT
         4Bs6Eg5kV9rpCyc2NrUBw4hFQl/7filqMQWfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WjkwEC2X7f81mf9W5bTPXnbaAR/cw3xla7sDK1DJ93w=;
        b=CpjRNJogAtAmfySgIJynjA3cXfzuOSkzgziph+aA25x7o08DL3JQ+g8J0eeQDzBrHw
         W7+qbkxhAGptV5nMzqGKfEvEG6Ntk4hSyVIbMG0NoarqYuXXG784bxHFXZur33PtcdT1
         mKdbjSEStHbZtwJjyujbBmBnRQexk/NIZq7oboK2c2g/oXp3PsoyfYC/cOtuC1pQZjYd
         bQGsY/Of87fO8Nq5VrtEX+VfYKJ/In4JEclglUsaXJ0kEiucpd8grwbGTS/Fa20UEYv0
         7T+wFa9sSFTqrxGAQBVv+NDfytCT0n5FfqZ9gc1Vf4qAZ7JRwtQNyN1ujpEUCIrr/Mxs
         J/jA==
X-Gm-Message-State: APjAAAV8Wff3AqXbV8ploBO0qbVd/G1uET9B4KlDRcURAupUanE0MQpK
        rff5r+WIV1ht4YcCcv+G/xH+vhbzT2s=
X-Google-Smtp-Source: APXvYqw8BO81rK9TCLSShHBKsywji0aOsVTtFufRS5wVkCaBwnq3ENus2JEZiFRHA0LnK7dpGZElAg==
X-Received: by 2002:ac2:48bb:: with SMTP id u27mr264855lfg.17.1555614916143;
        Thu, 18 Apr 2019 12:15:16 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id k2sm607233lfb.62.2019.04.18.12.15.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:15:15 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id l7so2834923ljg.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:15:14 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr51112790lji.94.1555614914550;
 Thu, 18 Apr 2019 12:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190411175043.31207-1-joel@joelfernandes.org>
 <20190416120430.GA15437@redhat.com> <20190416192051.GA184889@google.com>
 <CAGLj2rELsr0PUgu41uZX_TKCpT-Q00X+cvgBhJ-U7RU3EBo5tA@mail.gmail.com> <CAKOZueu=5aNf+oDFBM56TbqZwKpB6q1y81V1cbL+k4DTyV53+A@mail.gmail.com>
In-Reply-To: <CAKOZueu=5aNf+oDFBM56TbqZwKpB6q1y81V1cbL+k4DTyV53+A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Apr 2019 12:14:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi79KTxCYZgMZNapULR-ratPiZVt+fgh=DhgtYR_gYPAA@mail.gmail.com>
Message-ID: <CAHk-=wi79KTxCYZgMZNapULR-ratPiZVt+fgh=DhgtYR_gYPAA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] Add polling support to pidfd
To:     Daniel Colascione <dancol@google.com>
Cc:     Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrei Vagin <avagin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Serge Hallyn <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Taehee Yoo <ap420073@gmail.com>, Tejun Heo <tj@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Android Kernel Team <kernel-team@android.com>,
        Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 11:58 AM Daniel Colascione <dancol@google.com> wrote:
>
> On Thu, Apr 18, 2019 at 11:44 AM Jonathan Kowalski <bl0pbl33p@gmail.com> wrote:
> >
> > Would using something other than POLLIN be an option (maybe POLLPRI)?
> > The convention is to use it to indicate readability on the descriptor,
> > and also possibly POLLHUP instead of POLLERR (the latter is less of a
> > problem, but FreeBSD also does the same, so it'd help with some
> > consistency for libraries wanting to use this, which aren't interested
> > in other sub states).
>
> Existing event loop libraries generally support checking only for
> readability and writability. Not setting POLLIN would make these FDs
> more difficult to use with existing event loop libraries. What
> advantage would compensate for this difficulty?

Right.

Usually you'd set POLLIN in _addition_ to any other more specialized poll flag.

For example, when a socket has shut down the read side, we do

        if (sk->sk_shutdown & RCV_SHUTDOWN)
                mask |= EPOLLRDHUP | EPOLLIN | EPOLLRDNORM;

because while it's true that EPOLLRDHUP is the most _specific_ poll
bit, it's _also_ true that a read shutdown means that the read() will
return immediately.

So generally a HUP condition should mean that POLLIN and POLLOUT also
get set. Not because there's any actual _data_ to be read, but simply
because the read will not block.

                   Linus
