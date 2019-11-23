Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB70C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C06BD2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 16:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gpMCYQSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbfKWQtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 11:49:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46691 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfKWQtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 11:49:00 -0500
Received: by mail-qt1-f194.google.com with SMTP id r20so11753585qtp.13
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2019 08:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+66vHYsH7JVPePei6Sqt5pEwqov7Jl4jYo/VgAZ7vnA=;
        b=gpMCYQSFpmd4mTdfW7RZoAjmqjlGANKf89gWOCz9vY0k4KIf2oGke+YgIwvMr23GhK
         SDoJm8og7z58h8YqwxpCOx2AVbV5RmMLJoFBjrMLcsjemnXhNMTsZnxXf426a+vlEK1/
         +NSiP46mA9Bc2RHXfYZql2ncpubyp3Jxh4Q3zWDtq1b1Q5yEw0BDHjsMfwBwhMx/AN1a
         0ESXgIPifE6WJwD0i72IhNUvSAgVW+nIhsVqRFv+igR6ZEmhXMmQ0pWuQVtV00udXtWu
         0/DGViJOP34zHvJVqUq/sQdT11cIdIiBDYChBMO8U0aQ3rRYpPxFMCRNN2ZsUXzC0SIu
         iDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+66vHYsH7JVPePei6Sqt5pEwqov7Jl4jYo/VgAZ7vnA=;
        b=hzb36L949ljJoSncEzObeEXZ6PvPG483uJZTuxmXpXbwkQNJt61Guojw2/vsS+AyAJ
         o1H5AFOlBxMCsYxr/ooDoqaLusL+gezXL4jiH5akiK/+njUZRjTxOkRcd8j06ODoT7Ql
         I6PuS9hMa/F7iGhk1OY9s1vv6ih7iUjjkoXHlqvhEggyd6iUFfLWMN/jv35EFNJU7Hi8
         n1Z4MlrY+ttkmRlL9S8R00m4QLV6tYE4aUir5hTCA4lFxcQ08BE9fwQeXyK0K+boDmNr
         wxq73tqu744gerYU7RPKPI/P/0KGxAypIXAOvYxAZt88j8WnYvuROCsc7mpUI9ei0H7x
         sqQg==
X-Gm-Message-State: APjAAAXyVqk+NfXufDEzdtGZCy5TMfB7u9k8uuh0lkYjeWtOI1Q+qbP7
        s4EA/IT0pDfnY2CYQXlJsyRfyRhQ4nraTkIXqH65gA==
X-Google-Smtp-Source: APXvYqwyxjsh8dA/s2OkM/ns+ygqQG93FdFlPYlZeOwCIwjddgPt9JS5O8BWopdMn7MMTrUZIk7GnILurulL2cuB3xE=
X-Received: by 2002:aed:33c2:: with SMTP id v60mr8462945qtd.168.1574527739339;
 Sat, 23 Nov 2019 08:48:59 -0800 (PST)
MIME-Version: 1.0
References: <20191121191536.186051-1-pterjan@google.com> <20191122100844.2e9b22c6@lwn.net>
In-Reply-To: <20191122100844.2e9b22c6@lwn.net>
From:   Pascal Terjan <pterjan@google.com>
Date:   Sat, 23 Nov 2019 16:48:42 +0000
Message-ID: <CAANdO=KoAPXh+ZuXOW7XMibvbTchj96vr_aEUtqEDg-H2OVmHw@mail.gmail.com>
Subject: Re: [PATCH] Delete obsolete magic constants from documentation
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Nov 2019 at 17:08, Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Thu, 21 Nov 2019 19:15:36 +0000
> Pascal Terjan <pterjan@google.com> wrote:
>
> > Those no longer appear in the code.
> > I have some more patches to cleanup some of them from the code but this
> > is an easy first step.
> >
> > Signed-off-by: Pascal Terjan <pterjan@google.com>
> > ---
> >  Documentation/process/magic-number.rst        | 44 -------------------
> >  .../it_IT/process/magic-number.rst            | 44 -------------------
> >  .../zh_CN/process/magic-number.rst            | 44 -------------------
> >  3 files changed, 132 deletions(-)
>
> So I absolutely love this patch; we really need to clean this kind of
> cruft out of the docs.
>
> Unfortunately, it doesn't apply to docs-next; did you prepare it against
> linux-next, perhaps?  Is there any chance I could get a version against
> docs-next?

Right, that probably because of the lack of my previous patch
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=fba67e8f897870403e1a4f5fe3835c870cd589e0
which hasn't finished its journey yet

I am not sure how to proceed as there are a few other patches for
various subsystems I am planning to send out (like deleting
RFCOMM_TTY_MAGIC from net/bluetooth/rfcomm/tty.c or GDTIOCTL_MAGIC
from drivers/scsi/gdth_ioctl.h) which will also be touching this file
and I'd rather not cause some merge problems...
Maybe I should not update the documentation in the patches removing
the constants from the code and clean it up separately?

> If you're up for further work on this file, it would be nice to get rid of
> the 2.x "changelog" text at the beginning; I don't think that has any real
> value now.

Sure, I picked this file and initially started cleaning it up,
including deleting that changelog, but then decided to first clean up
the code referencing some of those constants without using them.
There are lots of other things to delete in this file, like references
to OSS and maybe even the file itself given that the practice of using
a magic field in structs is no longer common, but I can start sending
a few simple cleanups.

> Thanks,
>
> jon
