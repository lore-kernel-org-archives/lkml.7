Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC0C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65BB22073F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 08:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbfDPIdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 04:33:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45021 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbfDPIdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 04:33:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id w5so22295758qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 01:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zBeeFlf/cjVNjvYso3Nk1PnWJN+m4zICoF+TNurIgLw=;
        b=iqY7kd4J+tq5OU7OHzQ1JHI7JkIBfrDd+7/PtswRFf/WHO1gmZID1SxTfiGXQ09uST
         SPBQiKnp65l5RVIvlh4GMVUd6h/sdDo03LVlhJIiVTG5iIucopsCIqFDD92kOwx+Qzzh
         JqY6pc7ErnsfiZQgBoJdgaDUPd445Vr3KhpsNur38g0hQd+z5kZCfCXH2lF7CYwZfwSn
         XaiDDSxBLJQuZS3L9x+6p2hsV6eFUq9pBx6ajkzDxq5aWGXQ3OIsHo3b48i4y3+7VvnJ
         4B52xNeNkZQj1CwzDZDeN3KghJF5n6WPkrmX9n9M1x7eoJ/yJ/iFm6QhzFwJSQcNsEOq
         D9zA==
X-Gm-Message-State: APjAAAXoFkMEqQbAfmf/cCCKdqAN2ATa3kDykOuJ4zl9fxkre0R6b4r0
        UV6FLx5IJoTHHNBWPcvxeAxeNs+T7TKSWpwMz7A=
X-Google-Smtp-Source: APXvYqzeD8OVn2/PDbLG9wdgbTQGuZrcLvXrgzZX2YtyEekDZMmMSKlHlD4f0wno/GE4wek7GJB+vkGjxidb+E3S84c=
X-Received: by 2002:aed:35e4:: with SMTP id d33mr64058313qte.58.1555403592877;
 Tue, 16 Apr 2019 01:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190416172937.6a7621f7@canb.auug.org.au>
In-Reply-To: <20190416172937.6a7621f7@canb.auug.org.au>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Apr 2019 10:32:55 +0200
Message-ID: <CAK8P3a31Cp_COwjuOm6uG_23M3Ys4tJTB33jBENj-so0jkhgzg@mail.gmail.com>
Subject: Re: [PATCH] kernel/compat.c: mark expected switch fall-throughs
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 9:29 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> This patch aims to suppress up to 3 missing-break-in-switch false
> positives on some architectures.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Deepa Dinamani <deepa.kernel@gmail.com>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Jann Horn <jannh@google.com>
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Arnd Bergmann <arnd@arndb.de>

> ---
>  kernel/compat.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> I know that this makes the lines longer than 80 characters, but I
> though that this was better than adding new lines.

It's a bit inconsistent though since put_compat_sigset() has the
comments in separate lines, as of commit 89976005536c
("include/linux/compat.h: mark expected switch fall-throughs").

I don't care either way, but it might be better to do it the same way
for both.

We could also consider just getting rid of put_compat_sigset() and
get_compat_sigset() but replacing them with a combined
put_sigset()/get_sigset() that does the right thing for both native
and compat tasks. This lets us kill a couple of compat system
calls that only differ in their sigset_t argument. On little-endian
systems (which are the vast majority of the installed base), there
is no difference anyway there is no overhead anyway since
native and compat sigset_t are identical.

        Arnd
