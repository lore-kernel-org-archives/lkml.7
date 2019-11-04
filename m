Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF90CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B503C2080F
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="jMQA21nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729640AbfKDSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:47:44 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39845 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbfKDSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:47:44 -0500
Received: by mail-ot1-f66.google.com with SMTP id e17so6795813otk.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MAScZrMfcRjQQzWjos/ItVtsj2/Z80jqafi9Q8Gdat4=;
        b=jMQA21nktp7RKopIBS9wqFi6i1U/MgPY5om64JS4h+GGqMA1oI7IlIGbqbfdfrqdIA
         saCXi155JGBspLMG3er88AVUNsSmcsmIrx3Rav1KuF7BAVQDk1/UtICpwtaJeNyn9lpN
         zv7tUe2iDUpaiQ/lqfsdmsnlFBr2CFbMzBl+xVYpZUv4idw/1LM1jFM8OFJEqOKzAJHY
         LQ0Td6Y4IYI6qCqDnpk/+1znuoijhf3k3Umd2uq7wjPCm6RcGCgZXjVOYnmE7u/3h7WO
         bI1st2WpH0q9W/DyZwwx/RNqbWoMWwui8IsU8NhzYfZxOmVl9QynvfalKGl80BKpI4Vj
         x6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MAScZrMfcRjQQzWjos/ItVtsj2/Z80jqafi9Q8Gdat4=;
        b=iCJe7I/WX8VKgC/qFAIBz3922wROD1fgN+O3WBx+JoGbx8xzrxfg0hTXQSBGcmTjHq
         g2wuesDxQ6qRLSZpvoEiZFIZKW8NSk74QVcGJ1TbMb7Q+myFgGWZirNOSf2HqzAJDZWP
         Dm+NH+IMQgu8UWMGynWLfsm4XiTRwA761Jf7LsDUoeMfvkoakb7V8w8GC6b9HpW8ABlz
         CH1p+x/8ZECW0Z0Ca6aTAUCuHXrWFMFMWc/SKU4Ol/dHmKm9NFzZJgbRoIaGJesCgVp5
         hMd1zdHbvyV1ocV9yg2ubE6TUIegvBJGFLQ73xXEMq1Wf4mwQVc0QMCJmow30SepKPgu
         q4iw==
X-Gm-Message-State: APjAAAWVY1bUt1ZdYjTpsXdGPMu77mknRWN7GOTyvGRKQpI7Po5+9C08
        INTOqdTHEmo94dd4lyDUd9mHIPKrzBovwxmGu/7iUg==
X-Google-Smtp-Source: APXvYqxMRWfUR8/8l4v/V1zDDPZJXYUW0sZlQfmt7b99qT10zFVdxsT5JqBY5W/7oDGnO9lc4SylLnvGzYiFdEHrW8M=
X-Received: by 2002:a05:6830:1e5a:: with SMTP id e26mr3118340otj.71.1572893263132;
 Mon, 04 Nov 2019 10:47:43 -0800 (PST)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
 <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
 <x494kznctuc.fsf@segfault.boston.devel.redhat.com> <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
 <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
In-Reply-To: <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 4 Nov 2019 10:47:30 -0800
Message-ID: <CAPcyv4iWifdYsrrcs0TQ0Fd0Eoa5uXwe3CP-VzGCWAL6yKT3WA@mail.gmail.com>
Subject: Re: [PATCH 4/4] modpost: do not set ->preloaded for symbols from Module.symvers
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jeff Moyer <jmoyer@redhat.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 3, 2019 at 10:43 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Sun, Nov 3, 2019 at 7:12 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> >
> > On Sat, Nov 2, 2019 at 3:52 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >
> > > Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > >
> > > > On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > > >>
> > > >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > > >>
> > > >> > Now that there is no overwrap between symbols from ELF files and
> > > >> > ones from Module.symvers.
> > > >> >
> > > >> > So, the 'exported twice' warning should be reported irrespective
> > > >> > of where the symbol in question came from. Only the exceptional case
> > > >> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> > > >> > typically occurs for EXPORT_SYMBOL in .S files.
> > > >>
> > > >> Hi, Masahiro,
> > > >>
> > > >> After apply this patch, I get the following modpost warnings when doing:
> > > >>
> > > >> $ make M=tools/tesing/nvdimm
> > > >> ...
> > > >>   Building modules, stage 2.
> > > >>   MODPOST 12 modules
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported
> > > >> twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev'
> > > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > > >> ...
> > > >>
> > > >> There are a lot of these warnings.  :)
> > > >
> > > > These warnings are correct since
> > > > drivers/nvdimm/Makefile and
> > > > tools/testing/nvdimm/Kbuild
> > > > compile the same files.
> > >
> > > Yeah, but that's by design.  Is there a way to silence these warnings?
> > >
> > > -Jeff
> > >
> >
> > "rm -f Module.symvers; make M=tools/testing/nvdimm" ?
> >
> > I'd like the _design_ fixed though.
>
> This design is deliberate. The goal is to re-build the typical nvdimm
> modules, but link them against mocked version of core kernel symbols.
> This enables the nvdimm unit tests which have been there for years and
> pre-date Kunit. That said, deleting Module.symvers seems a simple
> enough workaround.

This workaround triggers:

  WARNING: Symbol version dump ./Module.symvers
           is missing; modules will have no dependencies and modversions.

Which is a regression from the previous working state.
