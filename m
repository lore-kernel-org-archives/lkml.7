Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9C2C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15B6E20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 14:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554043969;
	bh=oSBvfnV2idMF21pC3lnnGen0Yh8xrOOLeiUn3KCdygs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Be4rQql3+I1QYbceaa1+3qf7CNkIvCIze+yv6ZUUQUURmK2w+n8F8Txa6bYwo4A2H
	 b0rRdIObXO49v8LOMnyR0fC7FKDGmJ35E6wqGntM+OoTE7G6p1bons3ioJdbkSNqmA
	 KgSmGGn/QaKxFn9RzX2ono+WuEAXcOTrvhE9ax5k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbfCaOws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 10:52:48 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34909 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731146AbfCaOwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 10:52:47 -0400
Received: by mail-lj1-f193.google.com with SMTP id t4so5824375ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2y7OgXdpOdTE+br0K6QafAQdwQ5xYRbe0gstaLiCTtc=;
        b=Zlw0KAsuj3qtXgQM/1AUYXYLuKAP8JZoO8b6FkXvAVEf2M57udZ/hmvhE9CsJOvtTX
         HqyMCNidoPgwjh3iUvKcMza4Fw2FVRg7dbd6tk6/8yBkRql/4fs9IV3hQkYPV5Yi4lky
         H3VjMPFwIMt1zv/CQDZHky9I0uV0EE67lNEhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2y7OgXdpOdTE+br0K6QafAQdwQ5xYRbe0gstaLiCTtc=;
        b=rtwBWmGHiL4VjhMyb48O4zaHiXQKbnrNmny63ihvG5Nzd3nqCPe2RqWfEpXA+oQY81
         l1sDJiiejnX/IIC+nVonTxmFH+oR21U14vuj9/vHGTrCtPWahkAXEP6wyGF8+mLYT7aF
         eFcSJBepHXr3qPQkNfjyKFQ1aNIT+xUXQg0OWpHhf7y5AnHT8Yh5wC0KpGIk8KjDh9ZY
         ZVjlyuqMlQEA1nS0SMH2KYaCGBHZ7zDL8N0px0zFRT90o083MzUIxmbHyCmnwn128SMx
         l1jtanohnLLlTtryFxXADbHIkTWTojVsWMlXU6AB+uJ2nZwa6uE7BFe2Z6rlGfYPyhN5
         XHoA==
X-Gm-Message-State: APjAAAXlvsVEKmlqrXOVQjChCsD4eR4C2P3Zmb6tZFEM+srsPM7TTTMv
        iebvNRf2vR+6y88skVtaPSrkQ9ztPUw=
X-Google-Smtp-Source: APXvYqwi4OLownBqCl2qqK75bV9SrmcWexfV2ylFa+JAL9kiH9CfBnoEgoeGMW0wIdJpHrusAkv6tQ==
X-Received: by 2002:a2e:8089:: with SMTP id i9mr31416795ljg.137.1554043965495;
        Sun, 31 Mar 2019 07:52:45 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id t81sm1311565lff.21.2019.03.31.07.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 07:52:45 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 10so4447994lfr.8
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2019 07:52:44 -0700 (PDT)
X-Received: by 2002:a19:ca02:: with SMTP id a2mr29932559lfg.88.1554043964483;
 Sun, 31 Mar 2019 07:52:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <CAHk-=wjq4dTPcz-qsvhpm5F42SDHCoqEWv1V=rs_kt6MC=ZThA@mail.gmail.com>
 <CAKOZueuDWWYtg9gUpUgTG2k-gVPE1KBEkstr5eP=FC2EzdmaoA@mail.gmail.com>
 <CAHk-=wjka0W1g3asQp2H=5ot=kkS-Mp+Cx6KHr0rNkGFfCOLYA@mail.gmail.com>
 <CAHk-=wi1kQDVN22qv7M=bWU+CngZZXcPAMKCsDZMeuY3k2tkyg@mail.gmail.com>
 <20190331010716.GA189578@google.com> <CAG48ez387kGbD_dLqEbZ1U9rKFbfP0EF9cMVjQT6nwc9=Y9CNw@mail.gmail.com>
 <20190331040810.GB189578@google.com> <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
In-Reply-To: <CAG48ez2gb94SqS30Ai4+VBHhnzBp5Po9_u00nMrvUW6Wqq6hPA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Mar 2019 07:52:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
Message-ID: <CAHk-=wiZ40LVjnXSi9iHLE_-ZBsWFGCgdmNiYZUXn1-V5YBg2g@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
To:     Jann Horn <jannh@google.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>,
        Christian Brauner <christian@brauner.io>,
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
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 9:47 PM Jann Horn <jannh@google.com> wrote:
>
> Sure, given a pidfd_clone() syscall, as long as the parent of the
> process is giving you a pidfd for it and you don't have to deal with
> grandchildren created by fork() calls outside your control, that
> works.

Don't do pidfd_clone() and pidfd_wait().

Both of those existing system calls already get a "flags" argument.
Just make a WPIDFD (for waitid) and CLONE_PIDFD (for clone) bit, and
make the existing system calls just take/return a pidfd.

Side note: we could (should?) also make the default maxpid just be
larger. It needs to fit in an 'int', but MAXINT instead of 65535 would
likely alreadt make a lot of these attacks harder.

There was some really old legacy reason why we actually limited it to
65535 originally.  It was old and crufty even back when..

               Linus

              Linus
