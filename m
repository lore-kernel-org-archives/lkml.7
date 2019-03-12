Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7117C21734
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 21:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552425538;
	bh=mdwYHCNzYnNXR63q/rimcgbiy47jplcX9r3y2cJmXNA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dygiSuFvngQDnsa7tv0xWNuSvBYFIP2XLm+jK/EyiukJBkJbZKa+kqLamoOih4hCh
	 wHASH/y1Zvocd1DpvRGUCA2Eg9iftprLyms9KyezP7oPMEkqmKc80u9W7hxmjy0KNV
	 hDQnU1YDcpGIMoLYaej6fKqOyFq5DZN1VGzYtzrI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbfCLVS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 17:18:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60034 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfCLVS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 17:18:56 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 47AACE3F;
        Tue, 12 Mar 2019 21:18:55 +0000 (UTC)
Date:   Tue, 12 Mar 2019 14:18:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: remove unused variable
Message-Id: <20190312141854.7a06e640a611344243a25461@linux-foundation.org>
In-Reply-To: <CAMpxmJVeeMRPaXMKp29mE08pKFU4RRMetY=9-pWmazLg3DMLbg@mail.gmail.com>
References: <20190312132852.20115-1-brgl@bgdev.pl>
        <c86234af-a83a-712a-8dc8-0ec2a5dad103@oracle.com>
        <CAMpxmJVeeMRPaXMKp29mE08pKFU4RRMetY=9-pWmazLg3DMLbg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2019 15:03:52 +0100 Bartosz Golaszewski <bgolaszewski@baylibre.com> wrote:

> wt., 12 mar 2019 o 14:59 Khalid Aziz <khalid.aziz@oracle.com> napisał(a):
> >
> > On 3/12/19 7:28 AM, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > The mm variable is set but unused. Remove it.
> >
> > It is used. Look further down for calls to set_pte_at().
> >
> > --
> > Khalid
> >
> > >
> > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > ---
> > >  mm/mprotect.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index 028c724dcb1a..130dac3ad04f 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -39,7 +39,6 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
> > >               unsigned long addr, unsigned long end, pgprot_t newprot,
> > >               int dirty_accountable, int prot_numa)
> > >  {
> > > -     struct mm_struct *mm = vma->vm_mm;
> > >       pte_t *pte, oldpte;
> > >       spinlock_t *ptl;
> > >       unsigned long pages = 0;
> > >
> >
> >
> 
> Oops, I blindly assumed the compiler is right, sorry for that. GCC
> complains it's unused when building usermode linux. I guess it's a
> matter of how set_pte_at() is defined for ARCH=um. I'll take a second
> look.
> 

The problem is that set_pte_at() is implemented as a macro on some
architectures.

The appropriate fix is to make all architectures use a static inline C
functions in all cases.  That will make the compiler think that the
`mm' arg is used, even if it is not.

