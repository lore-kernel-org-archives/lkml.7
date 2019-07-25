Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35961C76191
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 146F1229F9
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8onZfDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfGYSdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:33:38 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43082 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfGYSdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:33:38 -0400
Received: by mail-ed1-f65.google.com with SMTP id e3so51122279edr.10;
        Thu, 25 Jul 2019 11:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuU4nyrEtuT3w9Jo5wyp3Jkj2G36pS00KDYO2VYJxyQ=;
        b=V8onZfDZKgE1lCY1sJyvGaCLF6wKkftziOVch1g1x7yGvEJx8cQ4qQPLlYVp5WeRwG
         wuwNzvyBsCghliDlAPtHciGL+inTAtGwkR2FNHtZR7PQJalcCO5AJgEZBpr8l+e3Ro9Q
         mq8R2UFa5rXD5zFBnsDKGPWpMGskEsNfOCeFaDa3DEReI579ufl0sPtTtrmXnOdPNtq6
         ZzBwY4lmd+uULWigAkZnORDpRnZX3+mJ1JOsDmNGsSND4xSuVNLTfFZ31DJaYsPI9MX+
         iGO7KZLGipzMomMi1m+KKgSBwAifGOukD+I0Cj67NYopeSi/nJ2TNV04LPOPsff9eIMN
         pfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuU4nyrEtuT3w9Jo5wyp3Jkj2G36pS00KDYO2VYJxyQ=;
        b=gb7eicHiO2f8+wJTr73v0zc8HUD1MySPAuzA1mIhsYlblc7s9FoIn8/mkogYc6NNL4
         jg32Eygn2UC6KiqWoEc+xcnMZAVm10ac3aaCKjXBm7YrjK3uuM+J4TX+FbNW/mzi213A
         mQvxjKDx5YIN/C2D+xXkp8I9zHXZF2rkpw/g+i2cJFMYwxaD2wYvcAukNpO9xxafYE1k
         FFKotDXcxpzELjIDQ4Pw2CcSXBlgYx0XMUINTHKDsKCv58uYg5BKLD2nR+Rf2zq7F+OB
         jt5Iyf9VXRZOmZq0CVugPshafeE48LbK0RgPHFnsZD9cmxwvsnV0il0ZtKJ954MwDudM
         eO2w==
X-Gm-Message-State: APjAAAVS+w/QCp0C6LIaT+4Boxo0Ozvz2VOWnBcehlFcjZguDOjgLGgK
        D5FGJ2XQDidisfWl0KOW9bAg1D3PQKJTnTag99o=
X-Google-Smtp-Source: APXvYqw6N86vVfRIvU7fAQubRb8w6XpUTYh/1QgHCfg6AtGs50OjwIiv0MuuIZJdRWpqC1GXgwzbAcukhf1vb9fnmIE=
X-Received: by 2002:a05:6402:1446:: with SMTP id d6mr79749937edx.37.1564079616259;
 Thu, 25 Jul 2019 11:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190717215956.GA30369@altlinux.org> <20190718.141405.1070121094691581998.davem@davemloft.net>
 <CADxRZqx-jEnm4U8oe=tJf5apbvcMuw5OYZUN8h4G68sXFvDsmQ@mail.gmail.com> <20190724.131324.1545677795217357026.davem@davemloft.net>
In-Reply-To: <20190724.131324.1545677795217357026.davem@davemloft.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Thu, 25 Jul 2019 21:33:24 +0300
Message-ID: <CADxRZqw0oCpw=wKUrFTOJF1dUKrCU6k5MQXj3tVGachu4zPcgw@mail.gmail.com>
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
To:     David Miller <davem@davemloft.net>
Cc:     "Dmitry V. Levin" <ldv@altlinux.org>,
        Christoph Hellwig <hch@lst.de>, khalid.aziz@oracle.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm@kvack.org,
        Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 11:13 PM David Miller <davem@davemloft.net> wrote:
>
> From: Anatoly Pugachev <matorola@gmail.com>
> Date: Wed, 24 Jul 2019 22:32:17 +0300
>
> > the first test where it was discovered was done on my test LDOM named
> > ttip, hardware (hypervisor) is T5-2 server, running under Solaris 11.4
> > OS.
> > ttip LDOM is debian sparc64 unstable , so with almost all the latest
> > software (gcc 8.3.0, binutils 2.32.51.20190707-1, debian GLIBC
> > 2.28-10, etc..)
> >
> > For another test, i also installed LDOM with oracle sparc linux
> > https://oss.oracle.com/projects/linux-sparc/ , but I've to install a
> > more fresh version of gcc on it first, since system installed gcc 4.4
> > is too old for a git kernel (linux-2.6/Documentation/Changes lists gcc
> > 4.6 as a minimal version), so I choose to install gcc-7.4.0 to /opt/
> > (leaving system installed gcc 4.4 under /usr/bin). Compiled and
> > installed git kernel version, i.e. last tag 5.3.0-rc1 and ran the
> > test. Kernel still produced oops.
>
> I suspect, therefore, that we have a miscompile.
>
> Please put your unstripped vmlinux image somewhere so I can take a closer
> look.

David,

http://u164.east.ru/kernel/

there's vmlinuz-5.3.0-rc1 kernel and archive 5.3.0-rc1-modules.tar.gz
of /lib/modules/5.3.0-rc1/
this is from oracle sparclinux LDOM , compiled with 7.4.0 gcc

Thank you.
