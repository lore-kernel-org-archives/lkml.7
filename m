Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FED8C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AA7C206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 22:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AERbP4Rz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbfHZW5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 18:57:52 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35561 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbfHZW5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 18:57:51 -0400
Received: by mail-pf1-f193.google.com with SMTP id d85so12779480pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 15:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xA1R9dD2TutV2Z170ahV4G14Z1OgTzuJeruk3z7eV2c=;
        b=AERbP4Rztk3SN5GtGKXtX3TrZ3m/fScubto0XvP+6FDz7VMVU42cAXy6NC3pczw2bc
         Gwxkpv1s0w69sq4xkWimuKQLIT+DUYruxRwHOVqU8Pqd7P5EpsPGoCEGJchwJ2MUVgEw
         UPr6LTjpKdJYBCt3d81empjWYPFoCDP7TInHRL9WzZcBx+p4f82RulMm5fIBPu0leQlp
         TCJajvb8StSXaK8V136MGkMNIhdzdQvoG3y4157iLyd7IQKR75LcVeQz3bsfeD8N15kx
         CaSDRuOoUl7fNQWbXkKzDPA0yuQelVrDAHr0nEPpM5alelZU1mWOAZvT6b3nAbmuc6iH
         af1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xA1R9dD2TutV2Z170ahV4G14Z1OgTzuJeruk3z7eV2c=;
        b=lsv6Di/zpDU59wESEgIDLdYProOdjsCUpsh1qBGycHRyUPCe1IG/cxqHsGE8os7QwB
         LuzsXTxbAAvuvJCcxg3bWNcgFLnczOLx8+pKFulotBsNerFt/MZqP3uYVO6wYF4Sj0E+
         a//V0KFyIfrW7ZudKTIZLoTf3jFN3+2TypazDsNiSPUQzhRQwlwp/+B1v0t3to/h+4Q8
         d/VqsYh8G3puoQSOFi+9mjqWCXPBSD87p7ac8TnYoBMzNBgEyBI2fcurnd2CP/YywngR
         6RQy4PQ2DPE02jF+UWih4S2wqNzHTXS+J6xIg6delr2a+VmFw7VhM62p1ezelKNu4N/G
         qVsQ==
X-Gm-Message-State: APjAAAUOFIsPN7Q4/ENQRYuNlQXuV4z/hARB1gmeq2PQhFcYGYw6Ai5j
        CHEZWDgbXgzPCHEPfdwz7cYQRCpuiaCuX/94g+qb1A==
X-Google-Smtp-Source: APXvYqwsVh+pvKpidVTgJBtumnmGK6qLp5RvX6P4qW6oQbh5YH03k6WRn6z+v36x1ZDdGAdycHp/gkbUV9RaoXI2BK0=
X-Received: by 2002:a17:90a:c20f:: with SMTP id e15mr21969838pjt.123.1566860270396;
 Mon, 26 Aug 2019 15:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
In-Reply-To: <CAKwvOdnJAApaUhTQs7w_VjSeYBQa0c-TNxRB4xPLi0Y0sOQMMQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 26 Aug 2019 15:57:39 -0700
Message-ID: <CAKwvOdkbY_XatVfRbZQ88p=nnrahZbvdjJ0OkU9m73G89_LRzg@mail.gmail.com>
Subject: Re: a bug in genksysms/CONFIG_MODVERSIONS w/ __attribute__((foo))?
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2019 at 2:22 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> I'm looking into a linkage failure for one of our device kernels, and
> it seems that genksyms isn't producing a hash value correctly for
> aggregate definitions that contain __attribute__s like
> __attribute__((packed)).
>
> Example:
> $ echo 'struct foo { int bar; };' | ./scripts/genksyms/genksyms -d
> Defn for struct foo == <struct foo { int bar ; } >
> Hash table occupancy 1/4096 = 0.000244141
> $ echo 'struct __attribute__((packed)) foo { int bar; };' |
> ./scripts/genksyms/genksyms -d
> Hash table occupancy 0/4096 = 0
>
> I assume the __attribute__ part isn't being parsed correctly (looks
> like genksyms is a lex/yacc based C parser).
>
> The issue we have in our out of tree driver (*sadface*) is basically a
> EXPORT_SYMBOL'd function whose signature contains a packed struct.
>
> Theoretically, there should be nothing wrong with exporting a function
> that requires packed structs, and this is just a bug in the lex/yacc
> based parser, right?  I assume that not having CONFIG_MODVERSIONS
> coverage of packed structs in particular could lead to potentially
> not-fun bugs?  Or is using packed structs in exported function symbols
> with CONFIG_MODVERSIONS forbidden in some documentation somewhere I
> missed?

Ah, looks like I'm late to the party:
https://lwn.net/Articles/707520/
-- 
Thanks,
~Nick Desaulniers
