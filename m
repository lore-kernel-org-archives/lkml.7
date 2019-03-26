Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F24D8C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97F020651
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 16:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z14uX4f2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731894AbfCZQum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 12:50:42 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42591 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbfCZQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 12:50:42 -0400
Received: by mail-oi1-f195.google.com with SMTP id w139so10472428oie.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 09:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jlvcTNFnmcegufVrQErIjtXY+Zg44N3gqJW/xOCBErQ=;
        b=Z14uX4f2oKOPa3cvg3EtrxDW95HmPywK5QtPyFfwZenwe3qWvF4CafTgDOgj98O/0G
         ppy/2Rs7PKhYcnxPZH4CR/n4TbubzvLzURUFiGKIqBdTTOJBq+NAoOnDsLBJ5eoduA2+
         TCFcZ3++xFlkUY3sqHm8Jpm3recpOEh+1vnPNxwUl2wXg8b1mvNU5MEit8nXLsP6WJ/J
         mgTETIxuD9kG8+wrNEKSPHlpyidfZppW7hR57vXiTd9gSplXMcREEH3x+MB+DgLiinJg
         dFdGb/wqWRCHl28XYWou1F4xkfSatFt2+eHJRYN620bgn/Q0xxPZl7/DD/WsvohnVB36
         mv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jlvcTNFnmcegufVrQErIjtXY+Zg44N3gqJW/xOCBErQ=;
        b=hSqDzOxQ2OmPisNT6nBh+SVjYxyRD6/UvzgsUSgxV0rTVO0phlA1oSmX73uymDnE16
         tDNMtJtqIBTtItrGDttwJh4jBgrJvyV3PyEH16SU/tuWnJXRLiu7HnNXDhSJhyka+FSF
         Grf8gnVp5dmpo0dT83UU7DJelkl9ihk/CuGhSHVUipuRne/xkEynu6MxgRcYT5SN1XXF
         S0U1ITqFNRFuMs9KqgZZLvl7e7OA4wA+q3fTLBe7Vy2Xa0Ej810RFg9cdX3g6hEWh7Sn
         N21wOfzp+pKoxZupMYwRw4HDJ9Pbc3/X6P9BqrAci5P9rSBDWsdwSfeDh/OxqRcM6nUm
         2XWQ==
X-Gm-Message-State: APjAAAVGQ33TRjeAfa9gVoCNLnSjQX3l79oggioeZheliP16BPgW3FwK
        wOrQybfQBVzhOeJX4/ZUU1aqhP+ofEBIqSRJ+h2zRw==
X-Google-Smtp-Source: APXvYqw2OwZceSFkaPzm84fjYSruZyYl+zr0oez4INgL7ajq/4R9MUZN7P+DkV9kf86reeoGevap4Knsga4G2on6Y7w=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr16573467oif.117.1553619040234;
 Tue, 26 Mar 2019 09:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190326155513.26964-1-christian@brauner.io> <20190326155513.26964-3-christian@brauner.io>
 <CAKOZuet18Lc+N7NaXN=cOcg_q8CxDkhYVss9enVhh6RBRUXpjg@mail.gmail.com>
 <20190326162337.o256x7hiodu2qfyg@brauner.io> <20190326163142.4eh5qpgiqvygf26w@brauner.io>
 <20190326163452.uku4bgkessxzxvai@brauner.io> <CAKOZuetcp=UPRWDkLUxLTmu-vqdN6qSmN9=0uP8MUuwyLoYfEA@mail.gmail.com>
 <20190326164354.qecuzkqz6ic2433i@brauner.io>
In-Reply-To: <20190326164354.qecuzkqz6ic2433i@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 26 Mar 2019 09:50:28 -0700
Message-ID: <CAKOZueuXtWwC+U9-q3QG41p-fwjMxmujTUegmVkorLzFcY2-SA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] pid: add pidctl()
To:     Christian Brauner <christian@brauner.io>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 9:44 AM Christian Brauner <christian@brauner.io> wrote:
>
> On Tue, Mar 26, 2019 at 09:38:31AM -0700, Daniel Colascione wrote:
> > On Tue, Mar 26, 2019 at 9:34 AM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Tue, Mar 26, 2019 at 05:31:42PM +0100, Christian Brauner wrote:
> > > > On Tue, Mar 26, 2019 at 05:23:37PM +0100, Christian Brauner wrote:
> > > > > On Tue, Mar 26, 2019 at 09:17:07AM -0700, Daniel Colascione wrote:
> > > > > > Thanks for the patch.
> > > > > >
> > > > > > On Tue, Mar 26, 2019 at 8:55 AM Christian Brauner <christian@brauner.io> wrote:
> > > > > > >
> > > > > > > The pidctl() syscalls builds on, extends, and improves translate_pid() [4].
> > > > > > > I quote Konstantins original patchset first that has already been acked and
> > > > > > > picked up by Eric before and whose functionality is preserved in this
> > > > > > > syscall:
> > > > > >
> > > > > > We still haven't had a much-needed conversation about splitting this
> > > > > > system call into smaller logical operations. It's important that we
> > > > > > address this point before this patch is merged and becomes permanent
> > > > > > kernel ABI.
> > > > >
> > > > > I don't particularly mind splitting this into an additional syscall like
> > > > > e.g.  pidfd_open() but then we have - and yes, I know you'll say
> > > > > syscalls are cheap - translate_pid(), and pidfd_open(). What I like
> > > > > about this rn is that it connects both apis in a single syscall
> > > > > and allows pidfd retrieval across pid namespaces. So I guess we'll see
> > > > > what other people think.
> > > >
> > > > There's something to be said for
> > > >
> > > > pidfd_open(pid_t pid, int pidfd, unsigned int flags);
> > > >
> > > > /* get pidfd */
> > > > int pidfd = pidfd_open(1234, -1, 0);
> > > >
> > > > /* convert to procfd */
> > > > int procfd = pidfd_open(-1, 4, 0);
> > > >
> > > > /* convert to pidfd */
> > > > int pidfd = pidfd_open(4, -1, 0);
> > >
> > > probably rather:
> > >
> > > int pidfd = pidfd_open(-1, 4, PIDFD_TO_PROCFD);
> > > int procfd = pidfd_open(-1, 4, PROCFD_TO_PIDFD);
> > > int pidfd = pidfd_open(1234, -1, 0);
> >
> > These three operations look like three related but distinct functions
> > to me, and in the second case, the "pidfd_open" name is a bit of a
> > misnomer. IMHO, the presence of an "operation name" field in any API
> > is usually a good indication that we're looking at a family of related
> > APIs, not a single coherent operation.
>
> So I'm happy to accommodate the need for a clean api even though I
> disagree that what we have in pidctl() is unclean.
> But I will not start sending a pile of syscalls. There is nothing
> necessarily wrong to group related APIs together.

In the email I sent just now, I identified several specific technical
disadvantages arising from unnecessary grouping of system calls. We
have historical evidence in the form of socketcall that this grouping
tends to be regrettable. I don't recall your identifying any
offsetting technical advantages. Did I miss something?

> By these standards the
> new mount API would need to be like 30 different syscalls, same for
> keyring management.

Can you please point out the problem that would arise from splitting
the mount and keyring APIs this way? One could have made the same
argument about grouping socket operations, and this socket-operation
grouping ended up being a mistake.
