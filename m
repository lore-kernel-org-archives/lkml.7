Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB12CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2045B20650
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzLMxhHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbfKAQUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 12:20:43 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33547 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbfKAQUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 12:20:42 -0400
Received: by mail-lf1-f67.google.com with SMTP id y127so7632084lfc.0;
        Fri, 01 Nov 2019 09:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDxL/9y811Z5nJM6Y5gJFSYgQI7x3MvaiflUEhpC+a4=;
        b=TzLMxhHTQ83j1KiZCts5nJ0fFYQ6I7amj6HjTJ1W8tF/mxgqsv8yFgHXeONrx9bspH
         DsPISG3I/Lof0f8vEHpEPeZikhCFl2LwE4UZ95B6OJ6Mcct2PklaUJY0Onjkj7F32X+P
         nSGI/IEmoChrva++IhyLaRaFArG6v0Nbn+nzg8a7yteLL8inGp2H1vgNugXu5qjhWpXJ
         RO6iYg0NTJtGAr/idELataxJXINKBvwvxMyzCrh+CaVhYHzsbmCti7zqP+fBEvhDhS+N
         PNuCwchiwlUuIwL8iGMYXYeaVYqWclhgCfANAo97bYkq6K84iTBkoopDg0DY33S5dY6y
         jlAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDxL/9y811Z5nJM6Y5gJFSYgQI7x3MvaiflUEhpC+a4=;
        b=iYUlUr/fSqZjWH8/Zw5v8XboNaVVcVtIyIiI6U7Cioi4sCa8OaMn1kUA3SF6gWouHf
         XpC8+9tlhkY6Z6hxr0QK3X5+8KkrqKTi3bi4/kTLmsdtQ2NGbwNud705YP3wor9Jlu4K
         PxKc3qEhVxhnYSx7E4h+IHRTvgJyj6N1HZGxgfNZpCys8D8a4mjL4piYl/KDUbHT78VG
         8QTqlTQTvmcqX+BNpqWFWXY05TIQD7dUaoFHSMfibC4wsr5vIcevG4SvCgydvR4Qa/sO
         PNQiHvQFWi0E/D0tyQQC6UQm4aHbSYxfnnfTSon9rch0zWRXSmzqbWkN1BBUNBNZSve2
         eeIg==
X-Gm-Message-State: APjAAAWcgGb/LPviSO7uzSKPZotv5zKqA9Kbr6v7riGUJKGOs+IWL/ky
        NUToq9ZXshqc2/M8LhSLbibdxyI+X+65FRFBPgM=
X-Google-Smtp-Source: APXvYqyBHGDySk0Vd6YhzSIKHg7CaAhmCpinTscezOyZG7qrbnFNJA+Fb2gFjeXKcD8zNnP4KkekqFNN3Rr0OmGdePg=
X-Received: by 2002:ac2:4919:: with SMTP id n25mr2371545lfi.58.1572625240350;
 Fri, 01 Nov 2019 09:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20191029200001.9640-1-jim.cromie@gmail.com> <07db7036-b46f-c157-5737-e3d96c808f14@rasmusvillemoes.dk>
In-Reply-To: <07db7036-b46f-c157-5737-e3d96c808f14@rasmusvillemoes.dk>
From:   jim.cromie@gmail.com
Date:   Fri, 1 Nov 2019 10:20:14 -0600
Message-ID: <CAJfuBxyE8Ju5S2bM28LSqULZzX6eFqDKJGVsRXP0Qhi6n+Y0kQ@mail.gmail.com>
Subject: Re: [PATCH 01/16] dyndbg: drop trim_prefix, obsoleted by __FILE__s
 relative path
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
        clang-built-linux@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cool, thanks!


On Wed, Oct 30, 2019 at 3:20 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 29/10/2019 21.00, Jim Cromie wrote:
> > Regarding:
> > commit 2b6783191da7 ("dynamic_debug: add trim_prefix() to provide source-root relative paths")
> > commit a73619a845d5 ("kbuild: use -fmacro-prefix-map to make __FILE__ a relative path")
> >
> > 2nd commit broke dynamic-debug's "file $fullpath" query form, but
> > nobody noticed because 1st commit trimmed prefixes from control-file
> > output, so the click-copy-pasting of fullpaths into new queries had
> > ceased; that query form became unused.
> >
> > So remove the function and callers; its purpose was to strip the
> > prefix from __FILE__, which is now gone.
>
> I agree with the intent, but I wonder if this is premature. I mean, the
> -fmacro-prefix-map is only for gcc 8+, so this ends up printing the full
> paths when the compiler is just a little old (and the kernel was built
> out-of-tree).
>
> I don't think keeping the current workaround for a year or two more
> should hurt; when int skip = strlen(__FILE__) -
> strlen("lib/dynamic_debug.c"); evaluates to 0 (in-tree build, or build
> with new enough gcc), I'm pretty sure gcc optimizes the rest of the
> function away (it should know that strncmp(x, y, 0) gives 0, and even if
> it didn't, the conditional assigns 0 to skip which it already is, so gcc
> just needs to know that strncmp() is pure).
>
> >
> > Also drop "file $fullpath" from docs, and tweak example to cite column
> > 1 of control-file as valid "file $input".
>
> That part certainly makes sense, since the $fullpath hasn't actually
> been in the control file for a long time.
>
> Rasmus
>


I agree.  Ive split the patch, am keeping the doc change.
