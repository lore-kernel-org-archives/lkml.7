Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1191AC3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A5621726
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 19:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="gxEPt1uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfHPTTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 15:19:33 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37923 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHPTTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 15:19:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id r12so6061897edo.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3jF3dCb2clsfRC1m94tcLbnSszpxa5sBshy2qiTh8jg=;
        b=gxEPt1uocQDpIezjyohy2qto3E8gIiDnEHN32P3VqscpBrrNMwtA3BtMF3s++tzJxq
         6kgB6+aBZI1uAPe20Dd93//Rou1NZFSa+MlWea7a4apfw6OU+WNkDTTxBkPNID2GHATe
         t42yFyoLnXCko8curvYSSF1lf9tSApzuS5XLuzSVHL9RU+7/PgPybAIRNb6GRoBqh9Q9
         KP9CSr87IGrsAbI+1alnAZVLaVXDAH3e9VQ9vu7x04WDBbFucF0TwGDhQspBGA4nRKhj
         45N8ABX3JDmEvTNT0c2XvkyGQESg+VonUAvhTVD8r9TF95vOAVrW+WProjVr0iUCAO/2
         7GUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3jF3dCb2clsfRC1m94tcLbnSszpxa5sBshy2qiTh8jg=;
        b=E9aH9/u93ZFnvr0jq+LFeQvet65IFo9ccRzfsgPiQfCDVg1iYEPNT4sa/r2KCuSr8V
         Q4yMz35DlCFC3gJ01q2I6KOum1FHdC9XuqPQp3o03EEPfN8tK3ZzQfONz/ev1vFWjT8F
         g8277URrNAKVx9aaVP3F3ljG9TG7hCI5rDUhD/vrPJFofNSADOyN0W3xyi6asFlP4jHB
         c2UKhm5LOhxKUmMmLwZ17SHEh9d/n5zVvsa65iEk9Dxzm8JMdWI1Ffq17JwlwiJ1WG+L
         VLnR7cttF5FALZIlyMM4vsrlNxFkBhLtQSxlN30L6UkEm7e4VRBS5btVa3WKTZ44baib
         ItQw==
X-Gm-Message-State: APjAAAVcB4MF5MJt6cagM4/1gwKSAWUWO4NSIhN8AEvhZMqZG7OlmtE0
        o39E7seJzcQ3CxgHSr7YRVFJs3kMYsrFEnRtkv9Ofw==
X-Google-Smtp-Source: APXvYqxtnJ7RnETBEd87ybXfkvbUZMocGjLwMeZ0V/1j7afCA1u9g/f9Sqry1klH6iFYLjEc8dWocaje0P2sPtZ57pc=
X-Received: by 2002:a17:906:1112:: with SMTP id h18mr10882905eja.165.1565983171200;
 Fri, 16 Aug 2019 12:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190801152439.11363-1-pasha.tatashin@soleen.com>
 <CA+CK2bADiBMEx9cJuXT5fQkBYFZAtxUtc7ZzjrNfEjijPZkPtw@mail.gmail.com>
 <ba8a2519-ed95-2518-d0e8-66e8e0c14ff5@arm.com> <CA+CK2bAqBi43Cchr=md7EPRuEWH-iuToK0PxN3ysSBQ42Hd0-g@mail.gmail.com>
 <746ceee3-43a7-231d-b2f6-0991a4148a28@arm.com>
In-Reply-To: <746ceee3-43a7-231d-b2f6-0991a4148a28@arm.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 16 Aug 2019 15:19:20 -0400
Message-ID: <CA+CK2bAEFU2s5v9seo4Y_5M0WLp0PCQGAZ=ovgO855jR7zDSwg@mail.gmail.com>
Subject: Re: [PATCH v1 0/8] arm64: MMU enabled kexec relocation
To:     James Morse <james.morse@arm.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

Thank you for your feedback, my replies below:

> > It is not really an all-new implementation of hibernate (for kexec it
> > is true though). I used the current implementation of hibernate as
> > bases, and simply generalized the functions by providing a flexible
> > interface. So what you are asking is actually exactly what I am doing.
>
> I disagree. The resume page-table code is the bulk of the complexity in hibernate.c. Your
> first patch dumps ~200 lines of differently-complex code, and your second switches
> hibernate over to it.

OK, I will make the change incremental.

>
> Instead, please move that code, keeping it as it is. git will spot the move, and the
> generated diffstat should only reflect the build-system changes. You don't need to 'switch
> hibernate to transitional page tables.'
>
> Adding kexec will then show-up what needs changing, each change comes with a commit
> message explaining why. Having these as 'generalisations' in the first patch is a mess.

Makes sense, I will fix it.

>
> There is existing code that we don't want to break. Any changes need to be done as a
> sequence of small incremental changes. It can't be reviewed any other way.
>
>
> > I realize, that I introduced a bug that I will fix.
>
> Done as a sequence of small incremental changes, I could bisect it to the patch that
> introduces the bug, and probably fix it from the description in the commit message.

BTW, I root caused it, there were two trivial errors:
1. In "arm64, mm: transitional tables"
int i = pgd_index(addr);
In trans_table_copy_*:
should be: pte_index(), pmd_index(), pud_index(), accordingly.
2. In trans_table_create_copy()
pgd_offset_k(PAGE_OFFSET) should be: mm_init.pgd

> >> It looks like you are creating the page tables just after the kexec:segments have been
> >> loaded. This will go horribly wrong if anything changes between then and kexec time. (e.g.
> >> memory you've got mapped gets hot-removed).
> >> This needs to be done as late as possible, so we don't waste memory, and the world can't
> >> change around us. Reboot notifiers run before kexec, can't we do the memory-allocation there?
>
> > Kexec by design does not allow allocate during kexec time. This is
> > because we cannot fail during kexec syscall.
>
> This problem needs solving.
>
> | Reboot notifiers run before kexec, can't we do the memory-allocation there?
>
>
> > All allocations must be done during kexec load time.
>
> This increases the memory footprint. I don't think we should waste ~2MB per GB of kernel
> memory on this feature. (Assuming 4K pages and rodata_full)
>
> Another option is to allocate this memory at load time, but then free it so it can be used
> in the meantime. You can keep the list of allocated pfn, as we know they aren't in use by
> the running kernel, kexec metadata, loaded images etc.

This is until a new kernel module is loaded, I do not think this is safe to do.

In my opinion 2M per 1 GB is a fair trade off for a faster kexec
performance. Unlike with crash kexec for which we do not add any
memory useage, the kernel does not have to be all the time in memory,
but can be loaded by user before reboot. If machine is so scare on
memory resources that 2M per 1G matters, user simply won't keep new
kernel in memory until it is actually needed.

>
> Memory hotplug would need handling carefully, as would anything that 'donates' memory to
> another agent. (I suspect the TEE stuff does this, I don't know how it interacts with kexec)
>
>
> > Kernel memory cannot be hot-removed, as
> > it is not part of ZONE_MOVABLE, and cannot be migrated.
>
> Today, yes. Tomorrow?, "arm64/mm: Enable memory hot remove":
> https://lore.kernel.org/r/1563171470-3117-1-git-send-email-anshuman.khandual@arm.com

I understand that ARM64 is about to get hot-remove feature, but what I
am saying is that my feature does not introduce new problem because
the current kexec code assumes that kernel memory is not movable
(array of sparse physical source dest addresses in kimage->head). It
is possible to offline and hot-remove only memory that can be freed by
page migration, the pages that were allocated for kexec kernel are not
one of them.

> >>>> Previously:
> >>>> kernel shutdown 0.022131328s
> >>>> relocation      0.440510736s
> >>>> kernel startup  0.294706768s
> >>>>
> >>>> Relocation was taking: 58.2% of reboot time
> >>>>
> >>>> Now:
> >>>> kernel shutdown 0.032066576s
> >>>> relocation      0.022158152s
> >>>> kernel startup  0.296055880s
> >>>>
> >>>> Now: Relocation takes 6.3% of reboot time
> >>>>
> >>>> Total reboot is x2.16 times faster.
> >>
> >> When I first saw these numbers they were ~'0.29s', which I wrongly assumed was 29 seconds.
> >> Savings in milliseconds, for _reboot_ is a hard sell. I'm hoping that on the machines that
> >> take minutes to kexec we'll get numbers that make this change more convincing.
>
> > Sure, this userland is very small kernel+userland is only 47M. Here is
> > another data point: fitImage: 380M, it contains a larger userland.
> > The numbers for kernel shutdown and startup are the same as this is
> > the same kernel, but relocation takes: 3.58s
> > shutdown: 0.02s
> > relocation: 3.58s
> > startup:  0.30s
> >
> > Relocation take 88% of reboot time. And, we must have it under one second.
>
> Where does this one second number come from? (was it ever a reasonable starting point?)

Currently we have two fitImages for this system in development: one
that has a bare minimal userland, only ~40 packages, and another has a
more complete userland. So, my first experiment shows the data from
this first bare minimum ftImage, the second experiment from the second
more complete fitImage. As I stated in cover letter, kexec time is
proportional to the size of the image and this series fixes this
scalability issue by making relocation  ~20 times faster.

Pasha
