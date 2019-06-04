Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBADC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1824871
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:36:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbfFDKgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:36:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40534 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDKgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:36:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id c70so2445418qkg.7;
        Tue, 04 Jun 2019 03:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjwGWW2yz3qNxJjLz48mB7YErJQmZWWLeiG4UEnZ79o=;
        b=ZR6LS1y/aRLkM3oj1r10QWFMvhBROsh5el9qpl01J9a7m0Ich+AHla6Ic1E0nn2OzD
         o+WFbYi889drvAwOA/NazLjQIVEafNmuKIwcM5xuTOfuHBpE5AiFWPxNd/g0Cb8Y2Qau
         x3QCNhN2lO2PKUvuuJhiDADOnNX1+wgO7a5RVP7l0rS8Mu+lw3v6GiXx+8IfNMs3SrW6
         oUD5J3WVtJGG1f4dw+AwjEWC70eV6VG5+2sV9TIi0Ats4SDW9/7a7+M5vFTpPIdbdL+z
         iUWvVJVzQtYTkl6RFW3iSuz+2S8GZbJQR0MoECeIx06YmRfAMk68wkV/W/wXM9uymoh4
         BPug==
X-Gm-Message-State: APjAAAXgbaU8X0vymm0SmKhD0mrNanjvQaDhGKUClL+iKBd7uWHwzlSl
        9zXuFsGtRBB+azAHQh7k83rbHi0legm2vJA51RA=
X-Google-Smtp-Source: APXvYqzD+p43MfoFIJlKR5FFEQTyAXqF9xeCYk7RQ7IeOd2cSyHe6ot8pMntwiqAY9+MAT7pTiyhy8uAgQ/yNlUTyyw=
X-Received: by 2002:a05:620a:35e:: with SMTP id t30mr26539414qkm.14.1559644601064;
 Tue, 04 Jun 2019 03:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190603144331.16760-1-christian@brauner.io>
In-Reply-To: <20190603144331.16760-1-christian@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jun 2019 12:36:24 +0200
Message-ID: <CAK8P3a0qBaQGu2h3yG45kvf=cgiQfkeiFw60WvD47H4BoEJiyQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fork: add clone3
To:     Christian Brauner <christian@brauner.io>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Reber <adrian@lisas.de>,
        Andrei Vagin <avagin@gmail.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 3, 2019 at 4:44 PM Christian Brauner <christian@brauner.io> wrote:

> +
> +#ifdef __ARCH_WANT_SYS_CLONE
> +asmlinkage long sys_clone3(struct clone_args __user *uargs, size_t size);
> +#endif

I would leave it outside of __ARCH_WANT_SYS_CLONE, as far
as I can tell the only reason for that #ifdef is so architectures that
have their own sys_clone implementation can opt out of the generic
one, but we don't want that for new syscalls.

In fact, I'd prefer to drop the symbol entirely and have a different
symbol with the opposite meaning such as
__ARCH_NONSTANDARD_SYS_CLONE that only gets
selected by sparc, ia64 and m68k. That should be a separate
patch though, and I'm not asking you to do it, unless you
want to clean up a little more.

       Arnd
