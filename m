Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD89C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070720863
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 18:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uxddqbsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfCYSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:39:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40567 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729761AbfCYSjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 14:39:52 -0400
Received: by mail-ot1-f68.google.com with SMTP id t8so3737078otp.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 11:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x45bUFEz5McTWL0nkxEqH4VoXD4ICR3xYooNMEuLgZ4=;
        b=uxddqbsZ4KHUDBHScWt0/qgbEE35hYi1SkKyH6CmdxaYxaHbsXJVvj0/cQfwdrAePG
         +or3uM0nAscQpkVpgfHRn5/Wk4nT188wjHwUFL7oC8X9KSg/BeSCqIRYbnaEYlOKxqcc
         fvVbwdGa6GIPdqlyaHpr4gOj0Hnx7fN6E0O4fh0pYVKDDKDpOViNdzXG+cWdVQZcUX9K
         9O+uYd1Vko4E4MedkjkdZ1770bAw68aLP8WUJ64hHViYEYeE8pHehSjOoFTELss9bmkL
         qW1LXh1PO/HtAxGZuml0P6thwhWnh6QeUbFTJZCPQDnLrf3toYZ5qzPn/ghsQXx9s6Mm
         RP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x45bUFEz5McTWL0nkxEqH4VoXD4ICR3xYooNMEuLgZ4=;
        b=n0YWuApQZ4weuvunPHjDev6UCXq7Wvf+JvzMdbxxPg1Q7kDP95fU+u2MWFOqaoHGWu
         UC4dsi5ilOMeWhMp8l1C4dV9vtHfuAv1BuJ+gjMybAuG9pscGgStMf5pVkRNbGyZo5vh
         WApDGNgFDZyAoPfctm8Es7NMM2nGIWWxy2EAOn4pRcpF4eluGdrm1aPFUKjWLNDqAQA0
         quX8anpw52ctPSijB47Ysyk4Rf/R17+DRsjv9ZLkjR1A5VN2Rf0RzS4HmJu2a1W3ULhG
         9yJ0VRkT83FVlplQTlMHFBsCuKMhGrKgKfGaSMcLs9Bb8/gB8OJZVqcl+I7Kd/jom+9m
         Abcg==
X-Gm-Message-State: APjAAAVZ8z3i/cLw2M7Dr0mm/hRXlamAQ2/V/9QWMwi8daj8aNhtcEGl
        D2X/snYXfpaJvtkxMvNuKojAwMx5hZXrPptmYM4ZMQ==
X-Google-Smtp-Source: APXvYqy+iUjQZtqoPZ1aKBFukWO8Tr8uLVMyH7iUAlHXnMKk//gcnbvIvUE+B1pYg+F185BaAKPfg/9ieR6yS0GfErA=
X-Received: by 2002:a9d:309:: with SMTP id 9mr18543319otv.230.1553539191640;
 Mon, 25 Mar 2019 11:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190325162052.28987-1-christian@brauner.io> <20190325162052.28987-4-christian@brauner.io>
In-Reply-To: <20190325162052.28987-4-christian@brauner.io>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 25 Mar 2019 19:39:25 +0100
Message-ID: <CAG48ez1QSJTOb-DAQuVpa5feUe9K-pr8aYuyd=yXg0n9eSg-LQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] signal: support pidctl() with pidfd_send_signal()
To:     Christian Brauner <christian@brauner.io>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk-manpages <mtk.manpages@gmail.com>,
        bl0pbl33p@gmail.com, "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 5:21 PM Christian Brauner <christian@brauner.io> wrote:
> Let pidfd_send_signal() use pidfds retrieved via pidctl(). With this patch
> pidfd_send_signal() becomes independent of procfs. This fullfils the
> request made when we merged the pidfd_send_signal() patchset. The
> pidfd_send_signal() syscall is now always available allowing for it to be
> used by users without procfs mounted or even users without procfs support
> compiled into the kernel.
[...]
>  static bool access_pidfd_pidns(struct pid *pid)
>  {
> +       int ret;
>         struct pid_namespace *active = task_active_pid_ns(current);
>         struct pid_namespace *p = ns_of_pid(pid);
>
> -       for (;;) {
> -               if (!p)
> -                       return false;
> -               if (p == active)
> -                       break;
> -               p = p->parent;
> -       }
> +       ret = pidnscmp(active, p);
> +       if (ret < 0)
> +               return false;
>
>         return true;
>  }

Nit, if we keep this function: "if (...) return false; return true;"
seems like an antipattern to me. How about "return ret >= 0", or even
"return pidnscmp(active, p) >= 0"?
