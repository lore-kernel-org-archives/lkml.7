Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F56C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC17420818
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 05:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="jjkZEjQy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfGQFWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 01:22:36 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:31373 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbfGQFWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 01:22:36 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id x6H5MLIw019393;
        Wed, 17 Jul 2019 14:22:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com x6H5MLIw019393
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1563340942;
        bh=8wyTio6eWyGUXfWyfehEhhkmdilatgeueQHXUAhXgr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jjkZEjQyqgPxgWTOy06lg4XiFphMdGWD0dkUcdUYRoSjTfEzKCyWDbeA5l31sjtlm
         zqOouOpTmUUR1fjahmM8X+/YdO8qcyiNNe/EGkudDoubXi/RlIem/UE/RAAkEjKJgh
         himXcjVNPka+DQQXDdOxZ2i3rvRxdvBbWHupkJ9TKhcVkX/7Yl+V6prx8J69e33QVH
         S9lLWYrJ+8F5i/cfhRFNjb8TthMvCpEoI8s5kfke/nBaxQwTDWKJ+Bxw4OlQxLrnBs
         sg97P4FS1Ng2YABVXz8w+/L7e2Y0z2G7Lx2h2kyckTDcFpr+rpm9z+ZdGcr4193J/2
         NCmvyHeUWB/VQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id v129so15558763vsb.11;
        Tue, 16 Jul 2019 22:22:22 -0700 (PDT)
X-Gm-Message-State: APjAAAVl3Sjbdfsq2mHM/rp+f7FllZQ7mPBUJBo8jkYZSwNvehRO8lRZ
        4OPRzgpyVDLwOM5ESjmuVdY/CZUJJErvkmIg1yg=
X-Google-Smtp-Source: APXvYqwM5DJTshi4lT6RxsMUMhzPLDUhdj8WyuK6eYGDHz2arKntCfRETXQ1UAKIK0Q4h8X3O1m1X0VZa1fFkqSF56c=
X-Received: by 2002:a67:cd1a:: with SMTP id u26mr22707775vsl.155.1563340941315;
 Tue, 16 Jul 2019 22:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190711054434.1177-1-yamada.masahiro@socionext.com>
 <20190711054434.1177-9-yamada.masahiro@socionext.com> <20190716214023.GA15159@redhat.com>
In-Reply-To: <20190716214023.GA15159@redhat.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 17 Jul 2019 14:21:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ41NhPPO6xoVObgFctTO6WewSXPfZkE7_bZXsdAtKSpA@mail.gmail.com>
Message-ID: <CAK7LNAQ41NhPPO6xoVObgFctTO6WewSXPfZkE7_bZXsdAtKSpA@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] kbuild: create *.mod with full directory path
 and remove MODVERDIR
To:     Joe Lawrence <joe.lawrence@redhat.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe

On Wed, Jul 17, 2019 at 6:40 AM Joe Lawrence <joe.lawrence@redhat.com> wrote:
>
> On Thu, Jul 11, 2019 at 02:44:31PM +0900, Masahiro Yamada wrote:
> > While descending directories, Kbuild produces objects for modules,
> > but do not link final *.ko files; it is done in the modpost.
> >
> > To keep track of modules, Kbuild creates a *.mod file in $(MODVERDIR)
> > for every module it is building. Some post-processing steps read the
> > necessary information from *.mod files. This avoids descending into
> > directories again. This mechanism was introduced in 2003 or so.
> >
> > Later, commit 551559e13af1 ("kbuild: implement modules.order") added
> > modules.order. So, we can simply read it out to know all the modules
> > with directory paths. This is easier than parsing the first line of
> > *.mod files.
> >
> > $(MODVERDIR) has a flat directory structure, that is, *.mod files
> > are named only with base names. This is based on the assumption that
> > the module name is unique across the tree. This assumption is really
> > fragile.
> >
> > Stephen Rothwell reported a race condition caused by a module name
> > conflict:
> >
> >   https://lkml.org/lkml/2019/5/13/991
> >
> > In parallel building, two different threads could write to the same
> > $(MODVERDIR)/*.mod simultaneously.
> >
> > Non-unique module names are the source of all kind of troubles, hence
> > commit 3a48a91901c5 ("kbuild: check uniqueness of module names")
> > introduced a new checker script.
> >
> > However, it is still fragile in the build system point of view because
> > this race happens before scripts/modules-check.sh is invoked. If it
> > happens again, the modpost will emit unclear error messages.
> >
> > To fix this issue completely, create *.mod in the same directory as
> > *.ko so that two threads never attempt to write to the same file.
> > $(MODVERDIR) is no longer needed.
> >
> > Since modules with directory paths are listed in modules.order, Kbuild
> > is still able to find *.mod files without additional descending.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Acked-by: Nicolas Pitre <nico@fluxnic.net>

> >
>
> Hi Masahiro,
>
> I'm following this patchset changes as they will affect the klp-convert
> series [1] that the livepatching folks have been working on...

Empty files .tmp_versions/*.livepatch are touched
to keep track of 'LIVEPATCH_* := y', right?

Perhaps, adding a new field
to *.mod files might be cleaner.



> Just wondering if these other files should be checked for more MODVERDIR
> fallout:
>
>   % grep -R 'tmp_versions'
>   tools/power/cpupower/debug/kernel/Makefile:     - rm -rf .tmp_versions* Module.symvers modules.order
>   scripts/export_report.pl:    while (<.tmp_versions/*.mod>) {
>   scripts/adjust_autoksyms.sh:# .tmp_versions/*.mod files.
>
> export_report.pl is probably the only interesting one on this list.

Good catch. I will fix it.

> Also, can you cc me on subsequent patchset versions?

Yes, will do.



--
Best Regards
Masahiro Yamada
