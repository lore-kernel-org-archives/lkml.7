Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4084C282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A122175B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 20:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="dvJtRlOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbfDXUns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 16:43:48 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39403 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbfDXUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 16:43:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id k45so17187122edb.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3uQ6pt/79DaqV1w1HqJ3riyr5/sBvHSK6/Hzd6NMzp4=;
        b=dvJtRlOFxT2cfx81ZV1rLhKqHcn8wP2dkltllzCy9vGNw9dCzrxYafuNn9nXLujGYh
         r8KoU13+AeniwVXgc+5SvHyy9qPkc7xV8mX4t5Ed52uWdqlkciy8+zrrvBToREKKetCx
         pxTzVNN/CnXf7j+4dQlzA5QY3JiiQz92Hpz12WJH2+ZRoxvVV8GsZKUg9UmhLUN3M+lw
         JYhxE8Qqw62YesIQjDOqszN5E4+qjxPaCr3WTjbqXxAYnnL65L2o2yzdlmsYe1NcqCtJ
         r1EHPXmGQtacfX2M02uzrnZwa6pNZgYpC0gjFWqjsm9oCIFQqctsxRZaZfWoXNg54JXI
         LHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3uQ6pt/79DaqV1w1HqJ3riyr5/sBvHSK6/Hzd6NMzp4=;
        b=G1LM5tOeOD1s9lXbuUiETbDhgLQSW7yxVz3hSws0XpqlWdJYj9q6QFTsUqw99BNwgq
         jizZVDM0nr0DavrkQKBs6LOtnBjQMOxIUw7anmGc9WhS3YcdREVFVIckxAlLpmpXoRTb
         9CYWGAfEY0AcSaUExChjQ1CH2egEuU1hQ0wuCODE4XIjP0VzT57Nu8xWwuimZ1FgsJp3
         AzHM/hLSvoGjPw7w1GBaH4+Ka388Mkf0XKScw6R1emrJZUY6RFOlnLbyRDuhfDpNbitL
         T1S7jT2sbehZOjUnP8MvU6mSpJetn8tOi2ACCrBHH0Zo5v6vcPU18BW15NPHDFCGxvVI
         f0gQ==
X-Gm-Message-State: APjAAAXhNZVl2KwbEr4/eswCOD3x5WAFGPxjIGtcUgNyJ8QhSIBiChbk
        s0HY1Lmmsw+dw8ZEea3Ek3P89iMldSCR+kXcngsWs1bZ
X-Google-Smtp-Source: APXvYqwwtgxviomoeB178elsaWelBPDBbhr4KEN1wrW4lNWd86vBErwAgnmmMXG7JMKrSJmUjpuHPaC2EjvlBKqmsPs=
X-Received: by 2002:a50:978e:: with SMTP id e14mr21377731edb.91.1556138626271;
 Wed, 24 Apr 2019 13:43:46 -0700 (PDT)
MIME-Version: 1.0
References: <155552633539.2015392.2477781120122237934.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190417150331.90219ca42a1c0db8632d0fd5@linux-foundation.org>
 <CAPcyv4hB47NJrVi1sm+7msL+6dJNhBD10BJbtLPZRcK2JK6+pg@mail.gmail.com> <1556025416.2956.0.camel@suse.de>
In-Reply-To: <1556025416.2956.0.camel@suse.de>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Wed, 24 Apr 2019 16:43:35 -0400
Message-ID: <CA+CK2bBS_cWJCWDCQAXKU6t=r=nAC908jz8uQ90DjKT5XcuNtw@mail.gmail.com>
Subject: Re: [PATCH v6 00/12] mm: Sub-section memory hotplug support
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Toshi Kani <toshi.kani@hpe.com>,
        Jeff Moyer <jmoyer@redhat.com>, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        stable <stable@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am also taking a look at this work now. I will review and test it in
the next couple of days.

Pasha

On Tue, Apr 23, 2019 at 9:17 AM Oscar Salvador <osalvador@suse.de> wrote:
>
> On Wed, 2019-04-17 at 15:59 -0700, Dan Williams wrote:
> > On Wed, Apr 17, 2019 at 3:04 PM Andrew Morton <akpm@linux-foundation.
> > org> wrote:
> > >
> > > On Wed, 17 Apr 2019 11:38:55 -0700 Dan Williams <dan.j.williams@int
> > > el.com> wrote:
> > >
> > > > The memory hotplug section is an arbitrary / convenient unit for
> > > > memory
> > > > hotplug. 'Section-size' units have bled into the user interface
> > > > ('memblock' sysfs) and can not be changed without breaking
> > > > existing
> > > > userspace. The section-size constraint, while mostly benign for
> > > > typical
> > > > memory hotplug, has and continues to wreak havoc with 'device-
> > > > memory'
> > > > use cases, persistent memory (pmem) in particular. Recall that
> > > > pmem uses
> > > > devm_memremap_pages(), and subsequently arch_add_memory(), to
> > > > allocate a
> > > > 'struct page' memmap for pmem. However, it does not use the
> > > > 'bottom
> > > > half' of memory hotplug, i.e. never marks pmem pages online and
> > > > never
> > > > exposes the userspace memblock interface for pmem. This leaves an
> > > > opening to redress the section-size constraint.
> > >
> > > v6 and we're not showing any review activity.  Who would be
> > > suitable
> > > people to help out here?
> >
> > There was quite a bit of review of the cover letter from Michal and
> > David, but you're right the details not so much as of yet. I'd like
> > to
> > call out other people where I can reciprocate with some review of my
> > own. Oscar's altmap work looks like a good candidate for that.
>
> Thanks Dan for ccing me.
> I will take a look at the patches soon.
>
> --
> Oscar Salvador
> SUSE L3
