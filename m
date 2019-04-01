Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9FCEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AA7F20872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731600AbfDAAJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:09:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:44934 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbfDAAJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 20:09:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hAkW9-0005yb-Rm; Mon, 01 Apr 2019 00:09:37 +0000
Date:   Mon, 1 Apr 2019 01:09:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Colascione <dancol@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
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
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401000937.GG2217@ZenIV.linux.org.uk>
References: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io>
 <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
 <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 04:40:15PM -0700, Linus Torvalds wrote:

> The clever alternative, which might be the RightWay(tm) is to just
> create a completely unattached dentry, and basically tie it into the
> actual /proc filesystem hierarchy at lookup() time when somebody does
> the openat() using it for the first time. You'd get a very simple
> callback: since the dentry would be unattached, you'd be guaranteed to
> get a "lookup()" from the VFS layer, and that lookup would then do the
> "hook into the actual /proc filesystem".

Ugh...  Which vfsmount would you have to go with it?

> We already kind of do things like that in the VFS layer when we have
> unattached dentries (because of "look up by filehandle" etc). In many
> ways the "pidfd_open()" really is exactly a "look up by file handle"
> operation, it just so happens that the "file handle" is just the
> pid/namespace combination.

Except that we never let unattached _directory_ dentries out - if
we can't reattach them to the tree, open-by-handle will tell you to
take a hike.

> And if the splice alias (which is what the VFS layer calls that "tie
> aliased dentry to the parent" operation) fails, because the /proc
> filesystem isn't mounted or whatever, then trying to look up names off
> the thing will also fail.

> It's a tiny bit too clever for my taste, and it's not *exactly* the
> same thing as our normal inode alias handling, but it's pretty close
> conceptually (and even practically).

It's more than a tiny bit too clever for mine...

> So it would basically do something very similar to the ioctl, but it
> would do it implicitly and automatically at that first lookup.
> 
> That would also mean that you'd not actually pay the cost of doing any
> of this *unless* you also end up trying to open things in /proc using
> that pidfd.

Al, back to normal life and digging through several flamefests from
hell...
