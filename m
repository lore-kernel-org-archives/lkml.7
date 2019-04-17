Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54955C10F12
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E9D20872
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555474420;
	bh=qmGrhJHNHxMV4n0I9ShPd2bnUMFpdPtpNBGJSS9pjoU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KSN0/fZ6fWqEsb9wwx+vOYZfLOP+pT7vrr4FaxjdvVHh9mKS/ruvL1DS9cR+zf6cF
	 I2+abIvH09Ukm+z01kBMpaDk0Kg2snOLN9o/Eb+0ytfrgixgX9n0NEPGrKgvzDXs5Y
	 Oe/CbR4KJz/lXd6gdN6xiPf69b+gr6QVtEIbCeBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfDQENi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 00:13:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41667 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbfDQENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 00:13:38 -0400
Received: by mail-lj1-f194.google.com with SMTP id k8so21101779lja.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Scd0mxLNvddMA/EuL7KgAfLfPq4A2d2A+jt31P9MYwQ=;
        b=f5LPUMydRgoieOXcslgprAzTIXLGrkdJ4t2S8woBSwJXvjjtlVT8iDFx/1ghkcZUGh
         TZTtsQjCJGNB//d2GFXCDvOKk5h8AXP8fCW1qGx8gml+SB2p8iffhIOQtqwHfr/8Ndxv
         Z0QzY8plk8LPA73p03U7k1H7fhKlySUGyOuzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Scd0mxLNvddMA/EuL7KgAfLfPq4A2d2A+jt31P9MYwQ=;
        b=M/2ewF4ZNH2+nrlxfSIz1fxpp7a0acYHFFkd3qyArA/F55GWXJCMoooiZEGHrW6+HE
         bWQMtfRM/URjU8tVoyMVUQ6nt6MGGt6BoDYMD1pXCmIkA+NUaY3EMjJRvA1QcmieygBr
         kkP9ediPay+aXQ+2E3qe9R7uL1uMAfLJGRrb2cs12AErih09L9GRMoV5R5fV4TCy6FPO
         WSVzKKnwfnZN+wVReRbWzSnZ9wSF5B/PbehqrUIW+g9nODUYfJaYnT5TsGiJbfGM2lD/
         C2jDRdIti+DMLp5j/RJcOBoU0bG8em4NttcIiCQLPvculbjc97zbt8zGh00ullTCD8hp
         Po4Q==
X-Gm-Message-State: APjAAAWWaHpMmfM5XyUPfohHOItUFrksqflQXIZIXmTApimtHKRnPk/O
        JDWUmjOpidTDO4innkA8xqCwlJVmhGs=
X-Google-Smtp-Source: APXvYqwyKzcNjevC+XPToMx4J/vD9k5YZJtcAtSDMYNrQx/UlcICn2wqIGIzlVuT9dNuCKQbC5eKyA==
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr5087788ljk.78.1555474415687;
        Tue, 16 Apr 2019 21:13:35 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id m1sm10955438lfk.84.2019.04.16.21.13.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 21:13:34 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id j11so17750795lfm.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 21:13:33 -0700 (PDT)
X-Received: by 2002:ac2:495e:: with SMTP id o30mr24639187lfi.35.1555474413536;
 Tue, 16 Apr 2019 21:13:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjvcuyCQGnfOhooaL1H4H63qXO=xgo+9yncSOG=eK+kbA@mail.gmail.com>
 <20190415051919.GA31481@infradead.org> <CAHk-=wj7jgMOVFW0tiU-X+zhg6+Rn7mEBTej+f26rV3zXezOSA@mail.gmail.com>
 <87sguhti6e.fsf@concordia.ellerman.id.au>
In-Reply-To: <87sguhti6e.fsf@concordia.ellerman.id.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 16 Apr 2019 21:13:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2HxyJoH3xhr_ytM3gf1mkvq8Dq9Do+EdNZrm8KjV_6w@mail.gmail.com>
Message-ID: <CAHk-=wi2HxyJoH3xhr_ytM3gf1mkvq8Dq9Do+EdNZrm8KjV_6w@mail.gmail.com>
Subject: Re: Linux 5.1-rc5
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 8:38 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> > That said, powerpc and s390 should at least look at maybe adding a
> > check for the page ref in their gup paths too. Powerpc has the special
> > gup_hugepte() case
>
> Which uses page_cache_add_speculative(), which handles the case of the
> refcount being zero but not overflow. So that looks like it needs
> fixing.

Note that unlike the zero check, the "too many refs" check does _not_
need to be atomic.

Because it's not a correctness issue right at some magical exact
point, it's a much more ambiguous a "the refcount is now so large that
I'm not going to do GUP on this page any more". Being off by a number
of pages in case there's a race is just fine.

So you could do something like this (TOTALLY UNTESTED, and
whitespace-damaged on purpose - I don't want you to apply it blindly)
appended patch.

> And we have a few uses of bare get_page() in KVM code which might be
> subject to the same attack.

Note that you really have to have not just a get_page(), but some way
of lining up *billions* of them. Which really tends to be pretty hard.

            Linus

----

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9e732bb2c84a..52db7ff7c756 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -523,7 +523,8 @@ struct page *follow_huge_pd(struct vm_area_struct *vma,
                page = pte_page(*ptep);
                page += ((address & mask) >> PAGE_SHIFT);
                if (flags & FOLL_GET)
-                       get_page(page);
+                       if (!try_get_page(page))
+                               page = NULL;
        } else {
                if (is_hugetlb_entry_migration(*ptep)) {
                        spin_unlock(ptl);
@@ -883,6 +884,8 @@ int gup_hugepte(pte_t *ptep, unsigned long sz,
unsigned long addr,

        refs = 0;
        head = pte_page(pte);
+       if (page_ref_count(head) < 0)
+               return 0;

        page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
        do {
