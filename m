Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA4AC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CF42070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 08:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573718654;
	bh=1PyO5+dQPDTpXCmhdbg0KDpb08buZBrMmvB/Mf+5GAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HCnO/Hv+CvKlfb4Xl68kPqYphdjTL4swmiHYLdoxw4IcuXrPS8ZSHQefi64jdJhI2
	 eDAGvfHjvmR72q9zRyOI6ni0oKEE0TIZS+cTs6kZ0Nt2mF8zIIA/nmOPOsslQmsIip
	 /L+RDqq4HVA0lo/b6V4DBkwV8FwsmxDSCwtlsUPw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfKNIEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 03:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfKNIEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 03:04:12 -0500
Received: from rapoport-lnx (unknown [84.88.5.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A472070E;
        Thu, 14 Nov 2019 08:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573718652;
        bh=1PyO5+dQPDTpXCmhdbg0KDpb08buZBrMmvB/Mf+5GAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ehOgQ1GBZQoyqSmTjQ94gv5ZG32CoqqZkGFCYmCmtTbtUOuatpozWB4V8aQllTv25
         BH64kHoGVvn9EsZUbg1oVnV9CPy7m63WSe7kBYMXPDcrJY2SmSgW9F1Ca0I0imgorD
         CuAQ+9ovR4auo2ZKgpUqHN09CEvD54G3NhStx9A0=
Date:   Thu, 14 Nov 2019 09:04:06 +0100
From:   Mike Rapoport <rppt@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 2/2] xtensa: get rid of __ARCH_USE_5LEVEL_HACK
Message-ID: <20191114080405.GA13838@rapoport-lnx>
References: <1572964400-16542-1-git-send-email-rppt@kernel.org>
 <1572964400-16542-3-git-send-email-rppt@kernel.org>
 <CAMo8BfLpdy4biZ4UvE4PDhscCFOj75nHWTwO+HFXpWx1qQOmEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLpdy4biZ4UvE4PDhscCFOj75nHWTwO+HFXpWx1qQOmEQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 12:30:39PM -0800, Max Filippov wrote:
> Hi Mike,
> 
> On Tue, Nov 5, 2019 at 6:33 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > xtensa has 2-level page tables and already uses pgtable-nopmd for page
> > table folding.
> >
> > Add walks of p4d level where appropriate and drop usage of
> > __ARCH_USE_5LEVEL_HACK.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  arch/xtensa/include/asm/pgtable.h |  1 -
> >  arch/xtensa/mm/fault.c            | 10 ++++++++--
> >  arch/xtensa/mm/kasan_init.c       |  6 ++++--
> >  arch/xtensa/mm/mmu.c              |  3 ++-
> >  arch/xtensa/mm/tlb.c              |  5 ++++-
> >  5 files changed, 18 insertions(+), 7 deletions(-)
> 
> This change missed a spot in arch/xtensa/include/asm/fixmap.h.
> I've added the following hunk and queued both patches to the xtensa tree:

Thanks!
 
> diff --git a/arch/xtensa/include/asm/fixmap.h b/arch/xtensa/include/asm/fixmap.h
> index 7e25c1b50ac0..cfb8696917e9 100644
> --- a/arch/xtensa/include/asm/fixmap.h
> +++ b/arch/xtensa/include/asm/fixmap.h
> @@ -78,8 +78,10 @@ static inline unsigned long virt_to_fix(const
> unsigned long vaddr)
> 
>  #define kmap_get_fixmap_pte(vaddr) \
>         pte_offset_kernel( \
> -               pmd_offset(pud_offset(pgd_offset_k(vaddr), (vaddr)), (vaddr)), \
> -               (vaddr) \
> -       )
> +               pmd_offset(pud_offset(p4d_offset(pgd_offset_k(vaddr), \
> +                                                (vaddr)), \
> +                                     (vaddr)), \
> +                          (vaddr)), \
> +               (vaddr))
> 
>  #endif
> 
> 
> -- 
> Thanks.
> -- Max

-- 
Sincerely yours,
Mike.
