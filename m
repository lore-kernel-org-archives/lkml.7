Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9C8C76196
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A7021852
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 12:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563539058;
	bh=Ck4eZ/5Sqk7t+dWiweDZ19MBs3yztrS1A6zmoiFGVAw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Hm30EjYd6bTc6c3gUAbQeyCEMZ1pwu23sTerEJbpekSkiNsex6D/n8SzAwGDvwNfi
	 R6pzOoNDnfBotQ14niWoxYRbQ5sY122MuVEhl1d8U293f41uLS3FUPTM8DTt60BOyY
	 1DOJkK/PhLoWVQTrjYK0vWjudzic7FJIpRE66ntU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfGSMYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 08:24:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:51794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSMYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 08:24:17 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 008D02187F
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563539056;
        bh=Ck4eZ/5Sqk7t+dWiweDZ19MBs3yztrS1A6zmoiFGVAw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZcNjefoh2NgQpIgYbn+H2tVOGJH8ErxcAhc6+nhkF2NKowZQmfV/bo9bFIeERf6V+
         e5lEbDQVV+FjMtX+0oLpIZOZOF9kLkX08V64y5bEm2Tk69vUbmMkunpHRdqm7EDgXk
         orAA3mbAq+W7VQCoANy++bomLiKbdAY+oZSYbb/s=
Received: by mail-wr1-f41.google.com with SMTP id r1so32066265wrl.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2019 05:24:15 -0700 (PDT)
X-Gm-Message-State: APjAAAUSBNyDsL8Jp4edPdlPKor17aaurZx3tSDWS0AYSGRLU9ROuXTR
        i57VJ3FPIrIozIvqe4voRa9+ABUo2l7wdR1XyRxEqQ==
X-Google-Smtp-Source: APXvYqwbf/NL9etE6iTEeE98k4Q7WxwDbyr6pULcKvmuiR7Rm2kxxUrs7jste1M0Depb2v/FP6vu8RxFKZXYMKPTr6A=
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr15129921wrm.265.1563539054479;
 Fri, 19 Jul 2019 05:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190717071439.14261-1-joro@8bytes.org> <20190717071439.14261-4-joro@8bytes.org>
 <CALCETrXfCbajLhUixKNaMfFw91gzoQzt__faYLwyBqA3eAbQVA@mail.gmail.com>
 <20190718091745.GG13091@suse.de> <CALCETrXJYuHN872F74kVTuw4dYOc5saKqoUFbgJ5X0EuGEhXcA@mail.gmail.com>
 <20190719122111.GD19068@suse.de>
In-Reply-To: <20190719122111.GD19068@suse.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 19 Jul 2019 05:24:03 -0700
X-Gmail-Original-Message-ID: <CALCETrUjATNr97ZWX41Tt3QyiMM+GSqG92Nn=qZTTG6XrvL8GQ@mail.gmail.com>
Message-ID: <CALCETrUjATNr97ZWX41Tt3QyiMM+GSqG92Nn=qZTTG6XrvL8GQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm/vmalloc: Sync unmappings in vunmap_page_range()
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andy Lutomirski <luto@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 5:21 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Thu, Jul 18, 2019 at 12:04:49PM -0700, Andy Lutomirski wrote:
> > I find it problematic that there is no meaningful documentation as to
> > what vmalloc_sync_all() is supposed to do.
>
> Yeah, I found that too, there is no real design around
> vmalloc_sync_all(). It looks like it was just added to fit the purpose
> on x86-32. That also makes it hard to find all necessary call-sites.
>
> > Which is obviously entirely inapplicable.  If I'm understanding
> > correctly, the underlying issue here is that the vmalloc fault
> > mechanism can propagate PGD entry *addition*, but nothing (not even
> > flush_tlb_kernel_range()) propagates PGD entry *removal*.
>
> Close, the underlying issue is not about PGD, but PMD entry
> addition/removal on x86-32 pae systems.
>
> > I find it suspicious that only x86 has this.  How do other
> > architectures handle this?
>
> The problem on x86-PAE arises from the !SHARED_KERNEL_PMD case, which was
> introduced by the  Xen-PV patches and then re-used for the PTI-x32
> enablement to be able to map the LDT into user-space at a fixed address.
>
> Other architectures probably don't have the !SHARED_KERNEL_PMD case (or
> do unsharing of kernel page-tables on any level where a huge-page could
> be mapped).
>
> > At the very least, I think this series needs a comment in
> > vmalloc_sync_all() explaining exactly what the function promises to
> > do.
>
> Okay, as it stands, it promises to sync mappings for the vmalloc area
> between all PGDs in the system. I will add that as a comment.
>
> > But maybe a better fix is to add code to flush_tlb_kernel_range()
> > to sync the vmalloc area if the flushed range overlaps the vmalloc
> > area.
>
> That would also cause needless overhead on x86-64 because the vmalloc
> area doesn't need syncing there. I can make it x86-32 only, but that is
> not a clean solution imo.

Could you move the vmalloc_sync_all() call to the lazy purge path,
though?  If nothing else, it will cause it to be called fewer times
under any given workload, and it looks like it could be rather slow on
x86_32.

>
> > Or, even better, improve x86_32 the way we did x86_64: adjust
> > the memory mapping code such that top-level paging entries are never
> > deleted in the first place.
>
> There is not enough address space on x86-32 to partition it like on
> x86-64. In the default PAE configuration there are _four_ PGD entries,
> usually one for the kernel, and then 512 PMD entries. Partitioning
> happens on the PMD level, for example there is one entry (2MB of address
> space) reserved for the user-space LDT mapping.

Ugh, fair enough.
