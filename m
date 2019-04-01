Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A4BC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5153820857
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 15:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Z9PMaxKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbfDAPrn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 11:47:43 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42327 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfDAPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 11:47:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id x61so8656135edc.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 08:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Nvu1LCcmwP9NHO2GvShnBuawhhm6XWmgmn1M2GVb8nU=;
        b=Z9PMaxKiQhXqyoAwIcdK2YNS28TaZM8TrdogKVE1NBR2O4Ai8p0Nc2zog2m0ln6SZy
         d9MLeMfaexPu+H4mIBFyECeRWSHjmx5DXU4nPzdHRMyhBRkn27FZXzJsnOm8ienMRbT/
         Kkl3Nt/bBg2Z6IcisLmyj1Cs8YSCRp7BuNTRdvYCSNGmKV2NRo94fex0hsIxA4UN3r63
         PdOyeL/E5L63CoX6pKflJSz0Bhh+AxzUH98uAiy6urOaXOL4nOYfZDyfXEJ6obgxvHjC
         isYeV3QYpM1DjKlXrgpS6IqwxSIYAgJtuykjLYW9nmlqaL+E/+8CRyQ7nYM0Ye4kgNuI
         gjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nvu1LCcmwP9NHO2GvShnBuawhhm6XWmgmn1M2GVb8nU=;
        b=T/twB+pfXwyBZzNEVn50g4bZt5oW9gVablrW13CnNHRFivI7l8JO5arkx/cUiw6Hrp
         v7dzSc1UgGpbJdN0aIDvimxyW6ZREt0kn+h1a0JIjQD5OT7cD7hDvC6HkachG00v1ZRk
         ojPSn+FF6MLtameX/Fc7ta2pyKEOjZZsNY25PrfJjpjQrSl+drzuYK+4pE/uokbjCkJW
         cdZj4DX9J6J/pWMSx4H2z7fTLqIB7V0FhN7hs2vSsqzFmC+u2UZsn9qgEdlHkbGZno53
         LMggPx4jIqKK7uVRrdUWBceWpSCSczQz/grGg0LeeQAnY0ZMBg1BPAPniaXLzk9zMTYO
         rGhQ==
X-Gm-Message-State: APjAAAVl5Z7mgRpgY58Jqjl5NO4MYzI4PaqCqdc8G7nq0srWcu/oKC3f
        Aa2AJkCsgAZkiD131amtD2FB4g==
X-Google-Smtp-Source: APXvYqy6vtacghUsbNhBdlH+vbuQaLS/qRo7idsylXQG1Q+Whkhm83U9L8rsEC6JHDqTF4s7kswEeA==
X-Received: by 2002:a17:906:6051:: with SMTP id p17mr24152127ejj.243.1554133660600;
        Mon, 01 Apr 2019 08:47:40 -0700 (PDT)
Received: from brauner.io (x59cc8b8e.dyn.telefonica.de. [89.204.139.142])
        by smtp.gmail.com with ESMTPSA id y4sm3232180edq.53.2019.04.01.08.47.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Apr 2019 08:47:40 -0700 (PDT)
Date:   Mon, 1 Apr 2019 17:47:37 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
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
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH v2 0/5] pid: add pidfd_open()
Message-ID: <20190401154736.ufprsmwjpvp5444z@brauner.io>
References: <CAHk-=wj0o8BiUrYiM5ZcTS6JxBh1M60O36Ms8-EqLQ139=1L4g@mail.gmail.com>
 <20190330171215.3yrfxwodstmgzmxy@brauner.io>
 <CAHk-=whF6gnRVbJaArZna4e=tejfrzmNQtRbWjnuSSKpBn+jQg@mail.gmail.com>
 <132107F4-F56B-4D6E-9E00-A6F7C092E6BD@amacapital.net>
 <CAHk-=wiaLtH41Mc5qAjOeCWavPqV0DhS581KYa0QBt8uraTK1Q@mail.gmail.com>
 <20190331211041.vht7dnqg4e4bilr2@brauner.io>
 <CAHk-=wi3AE1-iRQ_7LOeSMNAMrGxRdC=gTjD30duVw4XRchcNQ@mail.gmail.com>
 <18C7FCB9-2CBA-4237-94BB-9C4395A2106B@amacapital.net>
 <20190401114059.7gdsvcqyoz2o5bbz@yavin>
 <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgKqBQznZdTQaM6yQ+_5dcz-+q8=2sbQsAoDh55hQTLMA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 08:36:26AM -0700, Linus Torvalds wrote:
> On Mon, Apr 1, 2019 at 4:41 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > Eric pitched a procfs2 which would *just* be the PIDs some time ago (in
> > an attempt to make it possible one day to mount /proc inside a container
> > without adding a bunch of masked paths), though it was just an idea and
> > I don't know if he ever had a patch for it.
> 
> I wonder if we really want a fill procfs2, or maybe we could just make

No, I don't think we want a full procfs2.

> the pidfd readable (yes, it's a directory file descriptor, but we
> could allow reading).

Hm, if I understand this correctly, then the pidfd we return from
pidfd_open() would still be a dirfd but not tied to procfs? So I would
implement a "dummy" procfs anon_procfs that is a kernel internal mount
from which we allocate inodes, stash struct pid and off to userspace we
go?

> 
> What are the *actual* use cases for opening /proc files through it? If
> it's really just for a small subset that android wants to do this
> (getting basic process state like "running" etc), rather than anything
> else, then we could skip the whole /proc linking entirely and go the
> other way instead (ie open_pidfd() would get that limited IO model,
> and we could make the /proc directory node get the same limited IO
> model).

From the original thread where metadata access was apparently very
important things that were listed:

<quote>
And how do you propose, given one of these handle objects, getting a
process's current priority, or its current oom score, or its list of
memory maps? As I mentioned in my original email, and which nobody has
addressed, if you don't use a dirfd as your process handle or you
don't provide an easy way to get one of these proc directory FDs, you
need to duplicate a lot of metadata access interfaces.
<quote>
( https://lore.kernel.org/lkml/CALCETrUFrFKC2YTLH7ViM_7XPYk3LNmNiaz6s8wtWo1pmJQXzg@mail.gmail.com/ )

Joel can probably speak best to this.
