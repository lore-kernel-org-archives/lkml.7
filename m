Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 398EAC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4037206B8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="To2J9hU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfICOb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:31:59 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17012 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfICOb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:31:58 -0400
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x83EVtVI008834
        for <linux-kernel@vger.kernel.org>; Tue, 3 Sep 2019 23:31:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x83EVtVI008834
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567521116;
        bh=peXU42EyKwQnnz8I8342mhS/H7burl4NL19/9YgGjD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=To2J9hU4oq963etpjneGoIRkK8muL4ge1eFeFd+JOKSAJyIFu3eQLEfFuPe/7fCfD
         T6Ev74+Bkwbd1zwYdlvOP/d2NpKZCY+Hzd8zQD1nzMEigbEsphDDV/eIrwuyVYscvM
         j0A2ou96yem5vS0c3y30DGhGUicO2XSK2Rst8fxojqelE7n4rTVQBy1a5c0h8ImzIr
         rGlQg/N9hc6wngoGrFAX16cLhWEnalbrkeA0kX3OCEtSbM1PYQQre9cTthEKjkO2A7
         ECX/HlIMqBK/5owGmVEGMlrjUp2m2wbc6DhoPmskMp4Gs9OBrMAgV/SpAdK3DsI0ri
         PBR0ztSiH6jAA==
X-Nifty-SrcIP: [209.85.222.53]
Received: by mail-ua1-f53.google.com with SMTP id n13so5548575uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 07:31:55 -0700 (PDT)
X-Gm-Message-State: APjAAAWoMQbXdaMTiosmZ7GQYXkAyPtz+/ZmXHykP1frurHNeKOb1v8k
        2c5rafJMhSZ5V8vbvKnw5gtv2hGqusewGgIjOTY=
X-Google-Smtp-Source: APXvYqx4IX1fbc76BZv6H/GxXFHjyN7GN25SCkBJrPe9gxiGH6cezOB6+0NoGTi8i0Op3jHd2IuwId/eGsLoOtOPNkg=
X-Received: by 2002:a9f:2213:: with SMTP id 19mr4944903uad.25.1567521114572;
 Tue, 03 Sep 2019 07:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190821092658.32764-1-yamada.masahiro@socionext.com>
 <20190826113526.GA23425@infradead.org> <CAK7LNAQ_5Hz_CXAdx8W0bLjMWQ08KDWK3gG2pfDZOEE+cr0KEw@mail.gmail.com>
 <20190830155322.GA30046@infradead.org> <CAK7LNAR2JuZkdJGxO=f2hUxmQca5d7430NC-2hiqZwkJphJ9sA@mail.gmail.com>
 <20190902074256.GA754@infradead.org>
In-Reply-To: <20190902074256.GA754@infradead.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 3 Sep 2019 23:31:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNASMx7XBDUALd+UOj1jw=0kU-XoJBExCpSvKyQwV37mz7A@mail.gmail.com>
Message-ID: <CAK7LNASMx7XBDUALd+UOj1jw=0kU-XoJBExCpSvKyQwV37mz7A@mail.gmail.com>
Subject: Re: [PATCH] riscv: add arch/riscv/Kbuild
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 2, 2019 at 4:42 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Sat, Aug 31, 2019 at 10:04:53PM +0900, Masahiro Yamada wrote:
> > Kbuild support two file names, "Makefile" and "Kbuild"
> > for describing obj-y, obj-m, etc.
>
> <snipping the basic explanation, which is documented pretty well,
> I I think I full understand>
>
> > Similarly, arch/$(SRCARCH)/Makefile is very special
> > in that it is included from the top-level Makefile,
> > and specify arch-specific compiler flags etc.
> >
> > We can use arch/$(SRCARCH)/Kbuild
> > to specify obj-y, obj-m.
> > The top-level Makefile does not need to know
> > the directory structure under arch/$(SRCARCH)/.
> >
> > This is logical separation.
>
> But only if we document this specific split and eventually stop allowing
> to build objects from arch/$(SRCARCH)/Makefile.

I like this idea, but it would change the link order (i.e. probe order)

For example, I want move all drivers-y in arch/x86/Makefile
to arch/x86/Kbuild.

I do not know how much we care about the probe order.


>  And in my perfect world
> we'd eventually phase out the magic arch/$(SRCARCH)/Makefile entire=C5=80=
y.
> In addition to the normal Kbuild file we'd then have say (names entirely
> made up and probably not the best idea)
>
>   arch/$(SRCARCH)/flags.mk to set the various compiler flags and co
>   arch/$(SRCARCH)/targets.mk for extra arch-specific targets

I am not sure whether this split is a good idea.
What is the problem with having the single arch-Makefile?


--=20
Best Regards
Masahiro Yamada
