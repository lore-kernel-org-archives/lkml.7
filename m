Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C854C2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCNHqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:46:44 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:45676 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbfCNHqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:46:43 -0400
Received: by mail-ua1-f66.google.com with SMTP id u1so1583161uae.12;
        Thu, 14 Mar 2019 00:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L97NnGMCl4BnlTuoDr4Rd58JPbFnSdz9CZR7iGvBamM=;
        b=pKSkhS44PXsLtC+qaTr+eXXMXvSrUuUhMW6v7t+T9B5NWckFIl5LxO6isdoaxNXaoC
         +fEMJBzEP4C71wOkTx3Hd7VvVP/IkGAUYBix/3IdEIYaqq1DEltiyjooZdmw1uDQCs8L
         DwVBNqK7yg0Trwuq2+qGptUxWb6lAX3caTP3tnxjUitmKie/vUDpg7fC4wyPF8hr91JI
         PejbPoH59vakw0Yh0UH9PUG1Y3lLRBwITFfHMRdHuRCO9fAlcIdiyEsVODt2V9zR6dNq
         5CBVLZSNcusUg4dCGsd4soZPA8dMJMYx0gUkb4Ka1AZQuKcktmOZUAg8lyVYRTEnYZGl
         nIZQ==
X-Gm-Message-State: APjAAAUSUGgOsy6DECFGXUvT1JX+nFDGlHWuUItW2+lQ5RlrpRqcZihC
        +zThO8W5KnleBHnhWR8ZoOppRmJJek1o0ODQE+XtRA==
X-Google-Smtp-Source: APXvYqzWX9jsN/wOINvCVAC14pxD2wVUqT+IORLDqpH46clRq/wcW8LZ+fNF10n0mSXWO4TR7jpaKiaogQyeJZgq2CY=
X-Received: by 2002:ab0:6419:: with SMTP id x25mr24959564uao.20.1552549602929;
 Thu, 14 Mar 2019 00:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <153754740781.17872.7869536526927736855.stgit@warthog.procyon.org.uk>
 <153754746514.17872.4993763624097980573.stgit@warthog.procyon.org.uk>
In-Reply-To: <153754746514.17872.4993763624097980573.stgit@warthog.procyon.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 14 Mar 2019 08:46:31 +0100
Message-ID: <CAMuHMdUo7QA+xtWWoyBtFHghwYYp4XUWeHYRM2Mt5QXq+ACTww@mail.gmail.com>
Subject: Re: [PATCH 07/34] vfs: Add configuration parser helpers [ver #12]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Sep 21, 2018 at 6:33 PM David Howells <dhowells@redhat.com> wrote:
> Because the new API passes in key,value parameters, match_token() cannot be
> used with it.  Instead, provide three new helpers to aid with parsing:

> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -8,6 +8,13 @@ menu "File systems"
>  config DCACHE_WORD_ACCESS
>         bool
>
> +config VALIDATE_FS_PARSER
> +       bool "Validate filesystem parameter description"
> +       default y
> +       help
> +         Enable this to perform validation of the parameter description for a
> +         filesystem when it is registered.
> +

When would I want to disable this?

It seems this option was introduced in "ver #10" of your patch series,
without being mentioned in the changelog for that version.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
