Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81F3C76195
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8DAB20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vs748xKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388660AbfGPT0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:26:32 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43310 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbfGPT0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:26:32 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so21662835edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tAMcer/o92OFVt119e6yifT3N3R3a5gfAH/A3YrhyPY=;
        b=Vs748xKj2hviUzrn4HuUZQJnzrom7YeHQzEBrRW3chVySiB4qVTO8ok+BmdZd/0Hkp
         ds9XA1cCfWwC0UUGBF6Uec9vZkeWsZumHKY7C7CWILZXjTQYfi83Zxqp386+dGJXg2sk
         5m5/QXQPcctDZzGAHeVD4jUurF6StkJcJsA7S2MuvDb430nXwLW8oKl0zcWIv1k0X/QH
         LzPEQ87Qpbify0cfq0eAlzE32H7JJ2SbOspS9aGI/LYBh0ZlwCWHBL53kYyGcoxYeWHR
         +7odcl9aj6ERiBzV52OHC4hZZ5DMEtL4b3AUe+wrmPJKnLEQGGU/9Wk8KuDfgZOiqP1t
         uU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tAMcer/o92OFVt119e6yifT3N3R3a5gfAH/A3YrhyPY=;
        b=Ysh054/2+1XwZOaOx/KRofYsO4NB4EnVFPzrO0AdjT5fFLPHci0C4u0GxvvC4Y4q2r
         hW8B408h67Q35letNEBQ/1dwsuKqs10dYYmwqsBkRxfRUwoMIE333HfJvMVrvbG4g9iP
         MKWrYj1zfI6E8MpquRnB2iBGhd7J0EpF7UQ13epCehj/6+FpngbiBmSPgJ+srssOpYxc
         VZ5UpWT1sGB0z5MXNeZGY2osKck/dPaKj+HFPJWwTIEyIomUB/70Hz6UEOZcbomjoFCr
         QNVV9qDTYGa3gIE1znWOUU3Wam8KhojN2n2OnStNTl+/YREFvecugNioWbqVWD65bjIv
         qm/A==
X-Gm-Message-State: APjAAAVa1Wsq6Z/WGfbJABkFKuolukhJ6m8goMFNkDshdZHrCbrAADH4
        eMRp8+j4UbSErCnarFrn/pBIjIqAzLv/PJj6ZfA=
X-Google-Smtp-Source: APXvYqygM7bjRf5/q1NDCo6IIUu3Bn2fMgeKwA4WxUFuObu4eHPKtzeqoPz3euiFSNDs1KzoNjNAGmGQjtQzrhuFJUM=
X-Received: by 2002:a50:fb0a:: with SMTP id d10mr5479243edq.124.1563305190476;
 Tue, 16 Jul 2019 12:26:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190716165641.6990-1-pasha.tatashin@soleen.com> <CACi5LpOO+sF3o+5u4jHXzba+Ki8fZ5auekKLayxSwNOL6Lp=-w@mail.gmail.com>
In-Reply-To: <CACi5LpOO+sF3o+5u4jHXzba+Ki8fZ5auekKLayxSwNOL6Lp=-w@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 16 Jul 2019 15:26:19 -0400
Message-ID: <CA+CK2bCz5oZQZtmFzWCt_yscpeUuQKPCmajL1EQcav++n9=8Dw@mail.gmail.com>
Subject: Re: [RFC v1 0/4] arm64: MMU enabled kexec kernel relocation
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 3:14 PM Bhupesh Sharma <bhsharma@redhat.com> wrote:
>
> Hi Pavel,
>
> On Tue, Jul 16, 2019 at 10:26 PM Pavel Tatashin
> <pasha.tatashin@soleen.com> wrote:
> >
> > Added identity mapped page table, and keep MMU enabled while
> > kernel is being relocated from sparse pages to the final
> > destination during kexec.
> >
> > More description about the problem I am trying to solve here, can be
> > found here:
> > https://lore.kernel.org/lkml/20190709182014.16052-1-pasha.tatashin@soleen.com/
> >
> > This patch series works in terms, that I can kexec-reboot both in QEMU
> > and on a physical machine. However, I do not see performance improvement
> > during relocation. The performance is just as slow as before with disabled
> > caches.
>
> Thanks for the patchset, but if the changes still don't positively
> impact the kexec-reboot timings, I am not sure we if gain by adding
> these to the kernel.

Hi Bhupesh,

I am not asking to add these to the kernel (hence RFC), I am looking
for help to figure out why the relocation is still slow, once that is
understood I will submit the patches for integration. My previous
patch series fixed the relocation problem by pre-reserving space, but
because the culprit of the problem was narrowed down to disabled
caches it was decided that a better fix would be to do relocation with
MMU still enabled, this is why I created this new series.

>
> Like I mentioned in the previous threads, we have been carrying some
> relevant fixes for the same in Linux distros. I have been trying to
> find time to fix them and send them upstream, but I am caught up with
> some nasty kexec_file_load() issues on arm64 currently.

As I understood, the fixes were for slow purgatory checksum checking,
and not for relocation of there kernel. Are you saying redhat is
carrying some patches that address slow relocation problem as well?

Thank you,
Pasha

>
> So, I will find some time to work on them (may be next week) and will
> Cc you when I post them out after some checks on real physical
> hardware.
>
> Thanks,
> Bhupesh
>
> > Am I missing something? Perhaps, there is some flag that I should also
> > enable in page table? Please provide me with any suggestions.
> >
> > Pavel Tatashin (4):
> >   arm64, mm: identity mapped page table
> >   arm64, kexec: interface preparation for mmu enabled kexec
> >   arm64, kexec: add kexec's own identity page table
> >   arm64: Keep MMU on while kernel is being relocated
> >
> >  arch/arm64/include/asm/ident_map.h  |  26 ++++++
> >  arch/arm64/include/asm/kexec.h      |   5 +-
> >  arch/arm64/kernel/cpu-reset.S       |   8 --
> >  arch/arm64/kernel/cpu-reset.h       |   7 +-
> >  arch/arm64/kernel/machine_kexec.c   | 128 +++++++++++++++++++++-------
> >  arch/arm64/kernel/relocate_kernel.S |  36 +++++---
> >  arch/arm64/mm/Makefile              |   1 +
> >  arch/arm64/mm/ident_map.c           |  99 +++++++++++++++++++++
> >  8 files changed, 255 insertions(+), 55 deletions(-)
> >  create mode 100644 arch/arm64/include/asm/ident_map.h
> >  create mode 100644 arch/arm64/mm/ident_map.c
> >
> > --
> > 2.22.0
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
