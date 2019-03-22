Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2535EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC72521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Zb9Bl7Bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbfCVWNI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:13:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37288 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbfCVWNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:13:08 -0400
Received: by mail-it1-f196.google.com with SMTP id z124so5766936itc.2;
        Fri, 22 Mar 2019 15:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnWfr5Cz9g8Ts5McgdJK3bb2nMan4nq5nXqWONnMsfs=;
        b=Zb9Bl7Bn4sqZs4rM2mwfzJd7rKnn+/+6ONyGGwJqa1scMrXWXjmi9yoQBAbfMlLpgS
         RGV1LtFJyFJAtRyqt7x4phr5CYLMLHxyjOqtaGBIgKlABbih3LbLp5n0OYCbWIHRLaHd
         TTQ98w8krLJnK39QE8Dp0ik11E8+01Sgyn1wW72V9bUGSzJ08oA4QbCqRZA5AnJQLOtm
         o3basMsLTQYqNorbmDjd4KoyjPrND/z4P2rEoZfVYQnDMfAEdcsp9b63663QinvyZoJp
         HOu5mHwb07RCBU+1v7ChvrPznU5/HmjF8OEnSTsQgs+cld8MrdbVwNZKadLpnlT93nHs
         Yb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnWfr5Cz9g8Ts5McgdJK3bb2nMan4nq5nXqWONnMsfs=;
        b=ccLQBoMktj+EGlvYTMnJ5ebXJJXkpSI17oyqZDEwmFSSCVRurSA6lDn53Bf1q2N4Zi
         /mfNhg/da013n5C8g37oCBgu+s7ZwvOd00iQlWY/6pU+5Ka8Cf46p3+YIsggiA5Qb31F
         DYB9PqNJB2svbkkxKrXdq4cQfsLCiLUS90WgKbOTSKqmt4RpjT6TmlSe8ohOTuyCaD9Z
         uJeAAmFhMRRmB5OpWMDkLrNxp5putajre62dwMJK/JXrQx7BEJPAJs04rHVvkcVpALC+
         ryL8THaArahcarhgknapFHuhBV+vdP2J3Jn742KsMBOS+cYRf2yoOZKLPEtZUF203Jlw
         TrYA==
X-Gm-Message-State: APjAAAUuLGoy3fMVubGbbqGOtpN5QdZhK61fveUtg2A9wDgBPNPXrO4+
        clm9fbFR3BmLnP7CS2wcTKKh2IXLSdHU39RJ7aM=
X-Google-Smtp-Source: APXvYqwPCPjaWzKVXpURWg65K5fkBoLbrluPEoFqqgn2rT6o/InM1ko8UbBUfBaLU8H/oERd+79+VhkVDmrMWUaE2i4=
X-Received: by 2002:a02:c007:: with SMTP id y7mr8517902jai.1.1553292786464;
 Fri, 22 Mar 2019 15:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190317183438.2057-1-ira.weiny@intel.com> <20190317183438.2057-5-ira.weiny@intel.com>
In-Reply-To: <20190317183438.2057-5-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 22 Mar 2019 15:12:55 -0700
Message-ID: <CAA9_cmcx-Bqo=CFuSj7Xcap3e5uaAot2reL2T74C47Ut6_KtQw@mail.gmail.com>
Subject: Re: [RESEND 4/7] mm/gup: Add FOLL_LONGTERM capability to GUP fast
To:     ira.weiny@intel.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 7:36 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> DAX pages were previously unprotected from longterm pins when users
> called get_user_pages_fast().
>
> Use the new FOLL_LONGTERM flag to check for DEVMAP pages and fall
> back to regular GUP processing if a DEVMAP page is encountered.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  mm/gup.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)
>
> diff --git a/mm/gup.c b/mm/gup.c
> index 0684a9536207..173db0c44678 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1600,6 +1600,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>                         goto pte_unmap;
>
>                 if (pte_devmap(pte)) {
> +                       if (unlikely(flags & FOLL_LONGTERM))
> +                               goto pte_unmap;
> +
>                         pgmap = get_dev_pagemap(pte_pfn(pte), pgmap);
>                         if (unlikely(!pgmap)) {
>                                 undo_dev_pagemap(nr, nr_start, pages);
> @@ -1739,8 +1742,11 @@ static int gup_huge_pmd(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>         if (!pmd_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pmd_devmap(orig))
> +       if (pmd_devmap(orig)) {
> +               if (unlikely(flags & FOLL_LONGTERM))
> +                       return 0;
>                 return __gup_device_huge_pmd(orig, pmdp, addr, end, pages, nr);
> +       }
>
>         refs = 0;
>         page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
> @@ -1777,8 +1783,11 @@ static int gup_huge_pud(pud_t orig, pud_t *pudp, unsigned long addr,
>         if (!pud_access_permitted(orig, flags & FOLL_WRITE))
>                 return 0;
>
> -       if (pud_devmap(orig))
> +       if (pud_devmap(orig)) {
> +               if (unlikely(flags & FOLL_LONGTERM))
> +                       return 0;
>                 return __gup_device_huge_pud(orig, pudp, addr, end, pages, nr);
> +       }
>
>         refs = 0;
>         page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
> @@ -2066,8 +2075,20 @@ int get_user_pages_fast(unsigned long start, int nr_pages,
>                 start += nr << PAGE_SHIFT;
>                 pages += nr;
>
> -               ret = get_user_pages_unlocked(start, nr_pages - nr, pages,
> -                                             gup_flags);
> +               if (gup_flags & FOLL_LONGTERM) {
> +                       down_read(&current->mm->mmap_sem);
> +                       ret = __gup_longterm_locked(current, current->mm,
> +                                                   start, nr_pages - nr,
> +                                                   pages, NULL, gup_flags);
> +                       up_read(&current->mm->mmap_sem);
> +               } else {
> +                       /*
> +                        * retain FAULT_FOLL_ALLOW_RETRY optimization if
> +                        * possible
> +                        */
> +                       ret = get_user_pages_unlocked(start, nr_pages - nr,
> +                                                     pages, gup_flags);

I couldn't immediately grok why this path needs to branch on
FOLL_LONGTERM? Won't get_user_pages_unlocked(..., FOLL_LONGTERM) do
the right thing?
