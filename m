Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF665C10F11
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B2320850
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 00:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TZiliZIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbfDKAMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 20:12:13 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:43512 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfDKAMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 20:12:13 -0400
Received: by mail-vs1-f68.google.com with SMTP id t23so16571vso.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 17:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhhJrEgSnpGdPOxvbE0RnRdBbnjCFuj33XIQwLGk+j4=;
        b=TZiliZIs+m42kMuGA3ueXIYTfAhWML/YQc52g2kuSlr6Tkv7dQ49oDcavlQNxLqAGm
         7EGaFRsPmMJBK/7iBn5PmAjIVDueHfKBBTpgA5oonaCeemQj5PLhhuzlRzaA5TN9gHYa
         nafDeT/5ZJ7NTYToU0Ldiuv3XaGsoZP/Cz8wEV9b5oCS1ttmoFmQWj8RKYQU2VUoda3Y
         p3zdVDll3qFTkIm3+UrLlGyfVr09TzMsue3vW9kJ8ftnzeGL4WqSKppCnrBeueGdtChj
         5Z1DzMuKh3D8fXrlrqprhZViMMOfOFPS49WIyJdxgxi87Mbd/lK6OeQc97IuNx5NlKOt
         N8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhhJrEgSnpGdPOxvbE0RnRdBbnjCFuj33XIQwLGk+j4=;
        b=J+qse5lO3DnCDTrE8oYxs3dvPcEJ3EhsoCj0cIn44JR2SQbJAGCPrSy5s0AGAvFxPT
         h5KDBjQSDli6ZDmMAseB3Cn6gWJTAEWCciXDVqCqkmcwzxjSaPqmZNE0rG2RdRV7CL34
         fQzjJ+LEraS+m6eNv71ZfwKvC5/t5dPKWnABHvBl7YMU9lwTpOAqhNFe+Q3y+xtU075h
         bFELRwBnMuEO3kMdE9VymTZoTxCCScWtoNx379ZWkAxX/SMS9mRhzxmaLwNpN6t4G85j
         zTu8TVkItv2euXGjfPcIDhntPkqVtCZJhc06p/jrC/QoHoZOLR6Veiyun0HJ1IxllQL9
         lufA==
X-Gm-Message-State: APjAAAUEU9HYO2F0kSDp5iCe5ujLpEbsOkoi8q/B6/tA+CFgb/a6XcOz
        Gq9AGxCyrY3iDAIMbaoazFGh4f1VgFEdeVYfWd3HaA==
X-Google-Smtp-Source: APXvYqxQVsxJRxKxPuZYUZDNe6zJqMb5jzEChIm5i8gCFVa6mykPMwj7oBTtQMXBDnn8oLqj4n+etiRzxSOGEJthch4=
X-Received: by 2002:a05:6102:212:: with SMTP id z18mr26699112vsp.218.1554941531803;
 Wed, 10 Apr 2019 17:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190410234045.29846-1-christian@brauner.io>
In-Reply-To: <20190410234045.29846-1-christian@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 10 Apr 2019 17:12:00 -0700
Message-ID: <CAKOZuevU8Ke1jmnmdzzSEjb0GXfaCd_YVAm7ezGc5hy6xM8bxg@mail.gmail.com>
Subject: Re: [RFC PATCH] fork: add CLONE_PIDFD
To:     Christian Brauner <christian@brauner.io>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for trying it both ways.

On Wed, Apr 10, 2019 at 4:43 PM Christian Brauner <christian@brauner.io> wrote:
>
> Hey Linus,
>
> This is an RFC for adding a new CLONE_PIDFD flag to clone() as
> previously discussed.
> While implementing this Jann and I ran into additional complexity that
> prompted us to send out an initial RFC patchset to make sure we still
> think going forward with the current implementation is a good idea and
> also provide an alternative approach:
>
> RFC-1:
> This is an RFC for the implementation of pidfds as /proc/<pid> file
> descriptors.
> The tricky part here is that we need to retrieve a file descriptor for
> /proc/<pid> before clone's point of no return. Otherwise, we need to fail
> the creation of a process that has already passed all barriers and is
> visible in userspace. Getting that file descriptor then becomes a rather
> intricate dance including allocating a detached dentry that we need to
> commit once attach_pid() has been called.
> Note that this RFC only includes the logic we think is needed to return
> /proc/<pid> file descriptors from clone. It does *not* yet include the even
> more complex logic needed to restrict procfs itself. And the additional
> logic needed to prevent attacks such as openat(pidfd, "..", ...) and access
> to /proc/<pid>/net/ on top of the procfs restriction.

Why would filtering proc be all that complicated? Wouldn't it just be
adding a "sensitive" flag to struct pid_entry and skipping entries
with that flag when constructing proc entries?

> There are a couple of reasons why we stopped short of this and decided to
> sent out an RFC first:
> - Even the initial part of getting file descriptors from /proc/<pid> out
>   of clone() required rather complex code that struck us as very
>   inelegant and heavy (which granted, might partially caused by not seeing
>   a cleaner way to implement this). Thus, it felt like we needed to see
>   whether this is even remotely considered acceptable.
> - While discussing further aspects of this approach with Al we received
>   rather substantiated opposition to exposing even more codepaths to
>   procfs.
> - Restricting access to procfs properly requires a lot of invasive work
>   even touching core vfs functions such as
>   follow_dotdot()/follow_dotdot_rcu() which also caused 2.

Wasn't an internal bind mount supposed to take care of the parent
traversal problem?
