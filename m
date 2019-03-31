Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD9DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 23:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C562085A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 23:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554076049;
	bh=GXrUT6ELa2i48gFESZQ1P1esBol6+VafK8QvsCtOfqw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mrIgMmxyijaK38qRV4mlYr7dutFeOtizUcg+TTQssIo0UhaPNN3Qpd5K3RGf49mLP
	 ttjmDpFvU9SljO6Sr0tiBoKOEL4k7oYk2OCJJzld4Vr+7bHeTbKQHPAWifuYaaecdz
	 K2JZbApEffcBDxa6YE3DsOPW2cMKv34It2qrFUeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbfCaXr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 19:47:28 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33038 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731324AbfCaXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 19:47:27 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so6451083ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 16:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WBTeo2qxUB9ieNEd8dfLth/F+dGxSavIKp4cc9JjaeI=;
        b=g6hw4WyiuNavWvkqNS46pi8KkrNLZlpvOL/MBNgMVbho0MGtcLOU/j0/yssaxlv7n0
         UOVFSP3OyBBtbtN36UUQTGd4pILdChm2JDYF2yB3xIIwylDnRdOdr7JDoOMlHCqbRp8J
         j2PsKeUM6jghTEfPCtPU1gdGeDSksvjYsLyIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WBTeo2qxUB9ieNEd8dfLth/F+dGxSavIKp4cc9JjaeI=;
        b=WUQC5g9HmXwZRwHlAEBfvE856jnXCXKOL/fxbcbboTT7/5xwrcNe9oS4PxnFDfwk7j
         ZTOrtimUJpN9iq4itSH6V+xoImVN6LsVWfYh4PuviFcPWM0sq8o6jjm9H0ZKzpHulOKc
         hrxidnD5xkhOHzsYrteUfZMKE8WbiEM5TRDcWrPW6f0qli549wX1Hs2qRD4aTk7seSJ/
         C0qu94F3eBZSeP1KCcvBfsoCTHPVW5mgMc18oLli+PvstsG5w7XKSbaaGn4819tOvJta
         7uF5lCnpCSQ9ZiBD4+NjCT9TIqKmfD6vLxElVgejs4LJP7QFV2hlEZUBZTZz6aWyV3jC
         V2rQ==
X-Gm-Message-State: APjAAAVu1O48VL6KMHUt/czDz0M1l1rBBsmi6rrv98utEt+09GnB2Yd0
        H3KatbUcOg9MF7fLXvWw4nLBqH1L3XY=
X-Google-Smtp-Source: APXvYqzbThRxg3Hz92fN/GTxfRzWI0clzjImuFK14jZVvWxy/TBomk99ehqvY9lhwW9JpCK+2AaB2w==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr32708089ljk.123.1554076045095;
        Sun, 31 Mar 2019 16:47:25 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id s67sm1714526lja.57.2019.03.31.16.47.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 16:47:24 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id f23so6451069ljc.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 16:47:24 -0700 (PDT)
X-Received: by 2002:a2e:960b:: with SMTP id v11mr23033871ljh.135.1554075631490;
 Sun, 31 Mar 2019 16:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <BCD99947-5F55-4116-8F74-D6832E50340B@brauner.io>
 <CAHk-=whcA0kAWGqet9oJdyttjhP7J4PcU2Ly=n_Qyo6rMJNxRg@mail.gmail.com>
 <CAKOZuevv_QgvzmusA+yey76vo4hn9bEVwud2RumuOr0K4++15A@mail.gmail.com>
 <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io> <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net> <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io> <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <20190331220259.qntxynluk765hpnt@brauner.io> <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
In-Reply-To: <CAHk-=wh0jgRkZiNdFD96Zpjx+_G+NVSHieAt+QgWCQBJ2A-5Aw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 16:40:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com>
Message-ID: <CAHk-=whw1cnWPSWw1tHXT5xTMbnJFbCtx9_re6U1RZ_7LE9gXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@amacapital.net>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 3:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I would actually suggest we just make the rules be that the
> pidfd_open() always return the internal /proc entry regardless of any
> mount-point (or any "hidepid")

The clever alternative, which might be the RightWay(tm) is to just
create a completely unattached dentry, and basically tie it into the
actual /proc filesystem hierarchy at lookup() time when somebody does
the openat() using it for the first time. You'd get a very simple
callback: since the dentry would be unattached, you'd be guaranteed to
get a "lookup()" from the VFS layer, and that lookup would then do the
"hook into the actual /proc filesystem".

We already kind of do things like that in the VFS layer when we have
unattached dentries (because of "look up by filehandle" etc). In many
ways the "pidfd_open()" really is exactly a "look up by file handle"
operation, it just so happens that the "file handle" is just the
pid/namespace combination.

And if the splice alias (which is what the VFS layer calls that "tie
aliased dentry to the parent" operation) fails, because the /proc
filesystem isn't mounted or whatever, then trying to look up names off
the thing will also fail.

It's a tiny bit too clever for my taste, and it's not *exactly* the
same thing as our normal inode alias handling, but it's pretty close
conceptually (and even practically).

So it would basically do something very similar to the ioctl, but it
would do it implicitly and automatically at that first lookup.

That would also mean that you'd not actually pay the cost of doing any
of this *unless* you also end up trying to open things in /proc using
that pidfd.

                    Linus
