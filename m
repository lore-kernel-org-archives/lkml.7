Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300DFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1B120840
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 00:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554078349;
	bh=ZNxxPy9yUtqYZ4fvskaae4J9LcmjEtiuI2O1NsIIDAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xGCpU67/l3mblndKQUwj7Bv/d0QFOncybTSDdDXwCDEfZwY3fLna5xolFoQWs4Ani
	 YokNS0Sao8lks5tTcjwn/e6WxSn/kCtf2hwyXRlQHE1mA2P7A4Pg7K7wdt5oURyt+s
	 1F/Vh/+tlZKysEDHgOMqIuTI7JhminEPNwSaDtro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfDAAZr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 20:25:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40134 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731421AbfDAAZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 20:25:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so6458098ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CgOzCwH/SJ7qK2581G3q02wSm71bzzx5pKRzupg3V7Q=;
        b=Qje35hWW/Cxw0pQE0rus6V9YXVEDHnfyXSVeOG0YG9QkZoi+9esE8tdOFKqvmBVY2f
         N8HqJXGUN/BMhWIklF2IYG3ORFWpjku5CeBYDigwwOxMgrJs+YRgPFd5OlHsBodWnJ+N
         fgyE+9dG+U6cOZvGFktFDMPpaUbBawYAYkmiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CgOzCwH/SJ7qK2581G3q02wSm71bzzx5pKRzupg3V7Q=;
        b=P46JTTC5AlIaRCxkxBGxl6ysIeu4wKAXJNptpVQ8uqNF3hR9sa3aJYcKO5UKlqnfFR
         yPM+3DpsPRMdphN00LzezMymchXw5hXEeVFCRXXTLdrouWRKqqya9xvXTrRzufrlfenF
         87lzMWA9ojRA9kDTk3AMFctbYjsENjhlk4ASHmfjgAq/yS9qWIVRrSiVbCki7TMMqlK9
         Q7DVDZynsFtqT2GPNBTlH4if2LFxWsVjP/zd2odGrJGhMx8Qu/xBcN12ADwJH2XgBN+t
         emqBZq8cvZFrmlJl6p+3kuKDDk8iyQ9Hv6JXhDheMpMXtbK6bafRDmnmWc6BuMXEMGk/
         jwyw==
X-Gm-Message-State: APjAAAUJSNQXbFiiCrnHkvxibBz2uQgNTR6bYvJXBxs6hzdj/76xba+F
        2Pj6b0CCbXIdjsbt0u7cwSjqs46wBck=
X-Google-Smtp-Source: APXvYqz5y5EXD3a90GR+5wGsAVlgBO3YhmoLF1wwBGhkjB79hG0S2dQRSfuPq2Lyhh7RNinJAHPd0A==
X-Received: by 2002:a2e:711a:: with SMTP id m26mr33322685ljc.40.1554078344668;
        Sun, 31 Mar 2019 17:25:44 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id e5sm1731432lja.96.2019.03.31.17.25.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 17:25:44 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q66so6458081ljq.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 17:25:44 -0700 (PDT)
X-Received: by 2002:a2e:22c4:: with SMTP id i187mr24151086lji.94.1554077907148;
 Sun, 31 Mar 2019 17:18:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io> <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
 <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com> <20190401000937.GG2217@ZenIV.linux.org.uk>
In-Reply-To: <20190401000937.GG2217@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 17:18:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi39-Ozq5zb22s7ZB4J_Nd6nTwE_9A3+qjp5nCY4iTSEg@mail.gmail.com>
Message-ID: <CAHk-=wi39-Ozq5zb22s7ZB4J_Nd6nTwE_9A3+qjp5nCY4iTSEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Al Viro <viro@zeniv.linux.org.uk>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 5:09 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Ugh...  Which vfsmount would you have to go with it?

I'd literally just do a lookup of "/proc" in the current root
directory in the lookup() function for that special pseudo-dentry.

If it's not mounted, or not a /proc filesystem, screw it.

> Except that we never let unattached _directory_ dentries out - if
> we can't reattach them to the tree, open-by-handle will tell you to
> take a hike.

Absolutely. Which is why I said it's _conceptually_ similar to the alias lookup.

And I suspect we can even use some of the same practical logic, but
it's definitely not _exactly_ the same. This thing very much involves
magic hooking into the lookup() function (but we then have to look up
the alias not for the path we're looking up, but for the _parent_
we're looking that path up in, which is very different from the normal
case).

> It's more than a tiny bit too clever for mine...

Fair enough. The whole "just do the whole lookup at pidfd creation
time" is certainly a whole lot simpler.

> Al, back to normal life and digging through several flamefests from
> hell...

Yeah, I would like to see the actual aio.c pull request and the
use-after-free fixes. All the patches look fine, I just don't have the
final end result..

And that takes precedence anyway. Right now the "open_pidfd()" is a
future discussion.

                Linus
