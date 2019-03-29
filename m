Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F4FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:46:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BCB218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 23:46:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="corx/B8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730337AbfC2XqO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 19:46:14 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44102 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730154AbfC2XqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 19:46:13 -0400
Received: by mail-oi1-f193.google.com with SMTP id i21so3002148oib.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2019 16:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/g/fHQBksrx3ws5RjN+7gkaT5AJmakYOWM6OLZLQbM0=;
        b=corx/B8FFW48Deh8UoywlUT3M3m5tB07cWLbPghGvVw2d7Ouf1PTT5MEawQxwMjTue
         jjTCF5OqSTrRPFRrxYceOTsQHEhBvqq6O+5N4MUGFR/DzTkxK34YjBcANaOZ7/NUscj4
         OcV6Juucjj36CxfLyODKkKdC+X/d78cI+71jdBhHtkaKcQJHz1PugyB6vw+l7VbYxJei
         W4Es8vvdrR8P2dV7YPZOYLbndZU8fHVW3dWgvWi3AFde/yqRkEGUBni/4PJXlAtl4wMI
         KZfx6qEy/CAcjK9Ys6faHZJqbswHzvznIV2AC8XSWep+IZy+veEDzKXCES3v+9T9APqb
         azFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g/fHQBksrx3ws5RjN+7gkaT5AJmakYOWM6OLZLQbM0=;
        b=az1rDcBmj01PE7IrLPQels2ZMtF7ANR7SlIbzat74McvgGBzTcgCjL1sK/F6SjfEyc
         pDnc+0IUoNY3PsLnROJLV4eisEOH1S50aIkXvxXfmJB14JhjnGx6Vuq6pX0fFkss3DQk
         +gaImlA+tnpAsGGGd74KXbO3gHr/NaVyON94Djbk+s0F5cbVKQEYtV4KiI5nUhKJCAUh
         sVSaRymIO9fHKLA3gtbcfAV0miszTKP/hWknem72Q07T4Yai0VtGmRUtMG48OFds6WyJ
         kV1XvhkWgFsxrv5Tznj+Vej9tt5RLCHFNKWyZt0TaBIGJku+qZfrItsBuY6Z6v/N08Xc
         pukQ==
X-Gm-Message-State: APjAAAU5arPEXGDC3LWxRtU9UqGznqn1aMH0u22ZHbvp0vsd8OmEDkMe
        AHnPiVCGlEmuDFdbx2MmZg8uqa+eVGspqJuSRUMXwg==
X-Google-Smtp-Source: APXvYqzvfwbT0GlGMEFw92e9xE1TqpiASY/Vqk/MF8+AZWZK0rRkhn4+O4aON0gO5TUfTX8xIC3PY+4OryFaMTkAtAA=
X-Received: by 2002:aca:e4cc:: with SMTP id b195mr5598724oih.39.1553903172643;
 Fri, 29 Mar 2019 16:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190329155425.26059-1-christian@brauner.io> <20190329155425.26059-3-christian@brauner.io>
In-Reply-To: <20190329155425.26059-3-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 30 Mar 2019 00:45:46 +0100
Message-ID: <CAG48ez0Arzdtjxj9zVVTaL=T6tX16e6OcR75rtk9mavCbnMK6w@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] pid: add pidfd_open()
To:     Christian Brauner <christian@brauner.io>
Cc:     Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
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
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 4:54 PM Christian Brauner <christian@brauner.io> wrote:
> /* Introduction */
> This adds the pidfd_open() syscall.
> pidfd_open() allows to retrieve file descriptors for a given pid. This
> includes both file descriptors for processes and file descriptors for
> threads.

Looks good to me, overall. Apart from a few nits below:
Reviewed-by: Jann Horn <jannh@google.com>

[...]
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 20881598bdfa..8c9e15e0e463 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
[...]
> +static struct file *pidfd_open_proc_pid(const struct file *procf, pid_t pid,
> +                                       const struct pid *pidfd_pid)
> +{
> +       char name[12]; /* int to strlen + \0 but with */

nit: comment suddenly ends at "but with"?

[...]
> +}
> +
> +static inline int pidfd_to_procfd(int procfd, struct file *pidfd_file)
> +{
> +       long fd;

nit: This should probably be an int?

[...]
> +       return fd;
> +}
[...]
> +static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +       int procfd = arg;

nit: I think it'd be semantically cleaner to move this assignment into
the switch case, but I don't feel about it strongly.

> +       switch (cmd) {
> +       case PIDFD_GET_PROCFD:
> +               return pidfd_to_procfd(procfd, file);
> +       default:
> +               return -ENOTTY;
> +       }
> +}
