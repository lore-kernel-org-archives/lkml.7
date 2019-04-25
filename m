Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B9FCC4321A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C9C8206BF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 21:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edaqH3pX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbfDYVhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 17:37:24 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37252 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbfDYVhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 17:37:23 -0400
Received: by mail-oi1-f196.google.com with SMTP id k6so1312317oic.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 14:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RGUgSN/1MuaT0sEkx4/PHOTF00tRdaquGMmXyWySbhU=;
        b=edaqH3pXiEXpUmitUuXFWk+YsMBzEo/wRbafWYnIriVAmTmf/hZDKMWYzoNNH8oP+R
         bC+L8TVKnbipZ4SOAofD8rBq1yG2z/wZSk50Q9P9Yr1DrvXxI8TDrkMs++R6/OonwdO9
         74izLWERfec1GdE1xNOK3wfairC7wD1IwRBd6Vw26OFYxJBjlOnzqt22cTdMjpIcf37o
         S+DIWo9AGr3T1ABXIchf3VePE0iuwngS8Nc9fclUuQwhkZbwhtqheo4mssjcPl+ztLbU
         5EcZE3o5HkugWFjrsIq8GzxRoyNKX7lmKmESdN8Ehi+ur56DpKR30L5vQHX/a3wC1u6P
         D1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RGUgSN/1MuaT0sEkx4/PHOTF00tRdaquGMmXyWySbhU=;
        b=LDI6uwGOUvBLvX+Q0ZshEFZPf2jK+j6y3nkb7muYiBP8EXjfduEypBSBcS9R2vDYgs
         /fzMW8SutMuUeN3CannrprRVbYDWe8MwYbDEPpUJlFe+nIHGAWnFVbYHtFkZqEh6Tkf2
         Olhx+iixPOXCfdV70bPm+a3WTqNv6W2sWpZ7NGEkCWb2TGhRgm0y6JasdqvLLjsfrw1J
         mtQhvkXm3ZqmRWBVWLhx+AjXbfi5ysJ2eZJUvq7D9lD6ZCVYQ2AgaCsC6vQ/ATv4T6Z6
         oyw77pD2lMo17BDNEVq3AzOSC+hoDoIONkuLzkPhnzBK/HfJAEGTr6wKNFuwOqCoZjs8
         sM6Q==
X-Gm-Message-State: APjAAAWhlYsiSq8g5qHsZWs5EoXNpSHuOXlAwcV+i6C0ZpWmMYWjDjx8
        bdy9WH3237Da22KSU4J8wsZY/Z+ca8Xv1aJremW+Ng==
X-Google-Smtp-Source: APXvYqxNu7qXytlEj2RXMttlfz2eUzqPPX+vSS3fXl27uou+1aPJ+bT6BWbWn9cn6mf63VhaXUUe6QTIeJnzpNOZ4Z8=
X-Received: by 2002:aca:4586:: with SMTP id s128mr4538562oia.148.1556228242522;
 Thu, 25 Apr 2019 14:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190404220652.19765-1-brendanhiggins@google.com>
 <20190404220652.19765-15-brendanhiggins@google.com> <20190424185813.xabwr4lt6aunvpsd@gabell>
In-Reply-To: <20190424185813.xabwr4lt6aunvpsd@gabell>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 25 Apr 2019 14:37:11 -0700
Message-ID: <CAFd5g45CD7=dMvvRgmLKomirXDWpO59hFSed9A=o0kdBxp7v-w@mail.gmail.com>
Subject: Re: [PATCH v1 14/17] Documentation: kunit: add documentation for KUnit
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        yamada.masahiro@socionext.com, Petr Mladek <pmladek@suse.com>,
        linux-doc@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        linux-kselftest@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Knut Omang <knut.omang@oracle.com>,
        Felix Guo <felixguoxiuping@gmail.com>, wfg@linux.intel.com,
        Joel Stanley <joel@jms.id.au>, Jeff Dike <jdike@addtoit.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, "Bird, Timothy" <Tim.Bird@sony.com>,
        linux-um@lists.infradead.org, Steven Rostedt <rostedt@goodmis.org>,
        Julia Lawall <julia.lawall@lip6.fr>,
        kunit-dev@googlegroups.com, Richard Weinberger <richard@nod.at>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 11:58 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> Hi Brendan,
>
> KUNIT_ASSERT_NOT_ERR_OR_NULL() should be replaced to
> KUNIT_EXPECT_NOT_ERR_OR_NULL(), right?

Generally speaking, no.

There may be places that I have used it improperly, but I think it is
generally okay to use.

If you are refering to the discussion with Frank and Stephen in RFC
v4, my take was that the resolution was that there were some things I
needed to fix in its implementation, but it is conceptually okay, and
that Frank doesn't want me to use it in drivers/of/unittest.c.
Consequently, I fixed the implementation issues that Frank and Stephen
pointed out, and I am holding off on drivers/of/unittest.c for this
patchset. The usage in this file should be fine.

>
> On Thu, Apr 04, 2019 at 03:06:49PM -0700, Brendan Higgins wrote:
> > Add documentation for KUnit, the Linux kernel unit testing framework.
> > - Add intro and usage guide for KUnit
> > - Add API reference
> >
> > Signed-off-by: Felix Guo <felixguoxiuping@gmail.com>
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
>
> <snip>

<snip>

Cheers
