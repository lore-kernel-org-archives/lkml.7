Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9DFCA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9028B21744
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 06:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="HAFK9ZBN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfKDGnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 01:43:43 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33534 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727947AbfKDGnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 01:43:43 -0500
Received: by mail-oi1-f195.google.com with SMTP id m193so13188493oig.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVi5iAn9z9FIX4+R36z5iyM84YAlie4p4vOr8JLkA9Q=;
        b=HAFK9ZBNpKvG2W2+y1NYoDvTHPz0Ih82Jqp011X6KSmbJ1OgFdZTIc4d0/6vIbvxKL
         gs/6jFk8EYz5eDiKziCqdb7/8/dAzil45O7dvO+dDXp1z5/y2wIH43iLURPE4+F9d1Ka
         mztxNJCXNFIRQQLB4EtiifXijLtOJUcrUf3I7WhhP2AW4eD5w9B3bk0JQ3llROT4jdoA
         K3QGqKi6NCewRfVYH9qcFMvofHFLFTzqhx4DdXaDWK7X6EFm6mycQxkpgjQor9zzncoS
         Sb1Brgwghyca3G1DkJhJE3T9uHRx0/LMuWdW1Al8/QtDZSxZrlahzzw4tkVhcjvNCEfH
         ObHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVi5iAn9z9FIX4+R36z5iyM84YAlie4p4vOr8JLkA9Q=;
        b=J+/IRlhjTGkWaIzdPTxoj9T7p2nYx1oTHHHs5+JxrT4/M7NovKOzHsKwuzyUjBwWSw
         1RW8EXoa6PZ/yyNGJ8sFq4FG9piei1+CU2f6ktonXtJYy6YgoiDIaCWsjAos0tiyrUKJ
         fx5sz5iLnqtysocsmcDuAI8iqz4JjAkAKn9i3NmYnrR+CxX9u11RZcjMPdQxccn8JoW+
         TihD0RN0391A0ucVCIHRz6FVo8z15MQYUJWmOvDKezJiviXlhE9iKXovUizFpe7PljWV
         TJpmZr7XhoX8/drqvR8pKK7i+k5kTB38/rwipt3vp5V/81MCeFrfL1bEtMPesPAT6MOB
         0UpQ==
X-Gm-Message-State: APjAAAU3OqD8gitV1ivBT8iy8Fq9ptVnbq1oh5z09O5RXtUXgJ1DMn9x
        aSZHUh8EcCk4+r8VeeDQQSmFulNfzL3DfDGiYWKZ/A==
X-Google-Smtp-Source: APXvYqzYYiSRCLzgJDin99LR5fIfz6VmH9pke67vQaykCEY2cIpBFhjcU9jQxFNcNlHYIOGijfZuC9W/totY10rVFTU=
X-Received: by 2002:aca:ead7:: with SMTP id i206mr2880755oih.0.1572849822071;
 Sun, 03 Nov 2019 22:43:42 -0800 (PST)
MIME-Version: 1.0
References: <20191003102915.28301-1-yamada.masahiro@socionext.com>
 <20191003102915.28301-4-yamada.masahiro@socionext.com> <x497e4kluxq.fsf@segfault.boston.devel.redhat.com>
 <CAK7LNASmpO6Dn2M1DtoCDs=RM+jwW7_tRhq7nqDU1YZWdRafuw@mail.gmail.com>
 <x494kznctuc.fsf@segfault.boston.devel.redhat.com> <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
In-Reply-To: <CAK7LNAQnaBCkRCsRPjK9m6wLaDvTsgkiFgMEiObnfuncxOHZOg@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 3 Nov 2019 22:43:31 -0800
Message-ID: <CAPcyv4gFO=4EmObucuYyPNCS91y1H7d-M=0LebBK72YuD=ekNQ@mail.gmail.com>
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

On Sun, Nov 3, 2019 at 7:12 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Nov 2, 2019 at 3:52 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> >
> > Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> >
> > > On Fri, Nov 1, 2019 at 1:51 AM Jeff Moyer <jmoyer@redhat.com> wrote:
> > >>
> > >> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
> > >>
> > >> > Now that there is no overwrap between symbols from ELF files and
> > >> > ones from Module.symvers.
> > >> >
> > >> > So, the 'exported twice' warning should be reported irrespective
> > >> > of where the symbol in question came from. Only the exceptional case
> > >> > is when __crc_<sym> symbol appears before __ksymtab_<sym>. This
> > >> > typically occurs for EXPORT_SYMBOL in .S files.
> > >>
> > >> Hi, Masahiro,
> > >>
> > >> After apply this patch, I get the following modpost warnings when doing:
> > >>
> > >> $ make M=tools/tesing/nvdimm
> > >> ...
> > >>   Building modules, stage 2.
> > >>   MODPOST 12 modules
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_lock' exported
> > >> twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nvdimm_bus_unlock'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'is_nvdimm_bus_locked'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'devm_nvdimm_memremap'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'nd_fletcher64' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nd_desc' exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> WARNING: tools/testing/nvdimm/libnvdimm: 'to_nvdimm_bus_dev'
> > >> exported twice. Previous export was in drivers/nvdimm/libnvdimm.ko
> > >> ...
> > >>
> > >> There are a lot of these warnings.  :)
> > >
> > > These warnings are correct since
> > > drivers/nvdimm/Makefile and
> > > tools/testing/nvdimm/Kbuild
> > > compile the same files.
> >
> > Yeah, but that's by design.  Is there a way to silence these warnings?
> >
> > -Jeff
> >
>
> "rm -f Module.symvers; make M=tools/testing/nvdimm" ?
>
> I'd like the _design_ fixed though.

This design is deliberate. The goal is to re-build the typical nvdimm
modules, but link them against mocked version of core kernel symbols.
This enables the nvdimm unit tests which have been there for years and
pre-date Kunit. That said, deleting Module.symvers seems a simple
enough workaround.
