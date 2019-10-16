Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCBECE599
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 144F220854
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 20:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dtthg5EZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394639AbfJPUCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 16:02:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36981 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbfJPUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 16:02:21 -0400
Received: by mail-oi1-f196.google.com with SMTP id i16so117341oie.4
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FHNz99ZfBU4H/6+e3BXs4XfNAFX8LVbryN5UqXjbu7I=;
        b=dtthg5EZZ6M5n+jDlRO+XUgJ7uRzwWsrmdYf51cen7Gcgu4XipcrmMUfzXFgudSK4x
         burC4NFvhRNF3ykdCqRgQWCkURUpUAymbeF6gDH5VQIRLHQVSKHTNDnRbBeKtEiSYGeg
         INMiCFLVO64voTtuLWiPiHJ5i2/wWAePJVvmK/an+fOcJZfKRF2x+MHntSCc/AgwaRZA
         ytUMMSIX9vdcGG2ZIotBaJRV2ziIfVC97BuxS84OmCcDXY188d/+uXkWKhJKdk/pgsGT
         CnDVim+xlg1ES+K1vIE1gFXHeAQzAX72hRZTo4ehTgcQkXukG+ExCbw+qZd9xfyAtUoO
         2eVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FHNz99ZfBU4H/6+e3BXs4XfNAFX8LVbryN5UqXjbu7I=;
        b=k+9oF82VLYcvXfXQU7jmP4Ata1owKpI2FUT3HCxhw4g5UBn31DCUd5tqZmAp6irICG
         WNrmM8gBh2VG9qzL4LVNlV1k9/ezxPyg/z2sJcwsRmzqoOVGxV0/JM3uSaEAiBD7TEk5
         i1dBkovgxOWNdAFSR+lqa3+yh+mcWaBNza0OOjGd4b+taZsKvrc5EjX/cp2f3ONSJD0O
         ChxsriaRMsyRwv19miuedDcHqkHC50b6bW76YxOiE29bnY5Ub5R3uZeyP6q+jYVi61B8
         PjR+Y6eAP2p9EmSG5vSJ38Jz3EeAoHZVmUac05psriMQOkmfTMOsZwbr9nk3j4TTBj7G
         nHbA==
X-Gm-Message-State: APjAAAX0rNzEkReBGj9GtFJZ8RT7E8vAJ2aVWboTeEfcKS5X+pnNcuRd
        HzB+VNftsR6nbGuyXExPS/GLRlqaIXkGCUKh+JhPIw==
X-Google-Smtp-Source: APXvYqwcJcti+SIQuAW47j8ngZ+NPZclH4h0ArtC1oKNxg9RonHLIJ2S/EfU3D3UB1hu9GkydPYLCNDntlwygRVUFZw=
X-Received: by 2002:aca:620a:: with SMTP id w10mr118318oib.0.1571256140474;
 Wed, 16 Oct 2019 13:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <20191008093711.3410-1-thomas_os@shipmail.org> <20191015100653.ittq4b2mx7pszky5@box>
 <CAA9_cmcSXYB1jo1=CQ78eXVcyGWm1_TjQKd-Gmg0yAO3tObOFw@mail.gmail.com> <3a16a199-a4bd-5503-3146-3fb24bfb2638@shipmail.org>
In-Reply-To: <3a16a199-a4bd-5503-3146-3fb24bfb2638@shipmail.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 16 Oct 2019 13:02:08 -0700
Message-ID: <CAPcyv4ifG5_jCyURNVNHE2cYKbVWYuzVydstaXWr6VPOZxoZ-A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: Fix a huge pud insertion race during faulting
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 10:59 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Hi, Dan,
>
> On 10/16/19 3:44 AM, Dan Williams wrote:
> > On Tue, Oct 15, 2019 at 3:06 AM Kirill A. Shutemov <kirill@shutemov.nam=
e> wrote:
> >> On Tue, Oct 08, 2019 at 11:37:11AM +0200, Thomas Hellstr=C3=B6m (VMwar=
e) wrote:
> >>> From: Thomas Hellstrom <thellstrom@vmware.com>
> >>>
> >>> A huge pud page can theoretically be faulted in racing with pmd_alloc=
()
> >>> in __handle_mm_fault(). That will lead to pmd_alloc() returning an
> >>> invalid pmd pointer. Fix this by adding a pud_trans_unstable() functi=
on
> >>> similar to pmd_trans_unstable() and check whether the pud is really s=
table
> >>> before using the pmd pointer.
> >>>
> >>> Race:
> >>> Thread 1:             Thread 2:                 Comment
> >>> create_huge_pud()                               Fallback - not taken.
> >>>                      create_huge_pud()         Taken.
> >>> pmd_alloc()                                     Returns an invalid po=
inter.
> >>>
> >>> Cc: Matthew Wilcox <willy@infradead.org>
> >>> Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent =
hugepages")
> >>> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> >>> ---
> >>> RFC: We include pud_devmap() as an unstable PUD flag. Is this correct=
?
> >>>       Do the same for pmds?
> >> I *think* it is correct and we should do the same for PMD, but I may b=
e
> >> wrong.
> >>
> >> Dan, Matthew, could you comment on this?
> > The _devmap() check in these paths near _trans_unstable() has always
> > been about avoiding assumptions that the corresponding page might be
> > page cache or anonymous which for dax it's neither and does not behave
> > like a typical page.
>
> The concern here is that _trans_huge() returns false for _devmap()
> pages, which means that also _trans_unstable() returns false.
>
> Still, I figure someone could zap the entry at any time using madvise(),
> so AFAICT the entry is indeed unstable, and it's a bug not to include
> _devmap() in the _trans_unstable() functions?

Yes, I can't think a case where it is wrong to include _devmap() in a
_trans_unstable(). It may be unnecessary if the given path can't
reasonably ever encounter a file-backed dax mapping, but it's
otherwise ok to always consider _devmap().
