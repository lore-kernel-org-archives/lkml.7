Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6DCC4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 567EF2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLVh8ndn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407455AbfFKTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:10:25 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42932 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404699AbfFKTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:10:24 -0400
Received: by mail-pf1-f193.google.com with SMTP id q10so8012151pff.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ibLXHh9gOCz8UAVU3oGSsVlBsgj7i5ksH7w1IIw8CbE=;
        b=NLVh8ndnIdL25bpkE0OKsp7TSN6a439c7PMwkG1sg0dQCgPfkSF+jeN9GRonwqsTUW
         I26Nd+lZJrR+1LkVGGFADKmhkUtKnjMzWm+/l5mAlIalWlyYgCgxRSfL4wZdqPqvXW0d
         m+r6vscFcsAyDAjF9OnLhdvARR3vUD6BdjqQFSaV5pVMDNMVEC5PP+TwGEL+H5Wx2/G7
         d/kJG2Gh7m9amAjqHqDByapwBeyMpeevCMgoQex2iiF1WW/XVq1a4du+9dALwapqGwCz
         m0I3jREGbBVA2X5gbU67jxaTxZdzv5ZCSUZdG2fCw/19G2rD5Y5/Mv/skatF8m+m9ta4
         dBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ibLXHh9gOCz8UAVU3oGSsVlBsgj7i5ksH7w1IIw8CbE=;
        b=Bjvh0HtQ6+TLeVHkq41QRlSoqAwFkHRjCWEbOZ6hYHOXy4L+5SbNJua/6jbfaK4W1r
         cLzl+Btd9yTxZtRz6GN8whHbUkU6PD0xq12uldZQHks+BsU/vqUE7I2Rp2hlbb0XKBik
         1DouYPhE8mvzrBjlC2UmENUc7HNwrHignkarMgZNQ2nTi9oQosMaGlkGI7vCiavOEOcs
         W7Ldb3zJpmb2eR31fP45weApAuGTJWs0pzb+V+q3Lo05rOEPErMhk7lUJn10bLAc3e9m
         soH+La6SfOMoFIZMVzq52s9n++uD3+PqaxpnoTHqF1hHApByNHDj1jgwppmgtmQk7Jbs
         jgQQ==
X-Gm-Message-State: APjAAAVPByGrAEfRe/r0hv5buD/5igGk4O6h+a6yEHnxLTKfsES5DZ2N
        rkQrrvY+wHTPuhg6IIlPTP0=
X-Google-Smtp-Source: APXvYqw+CTNxM/o3ggVxCO5OrY4rYDo3SJY8NFApEU+IPZmG9vm/KW5addob7bCi3sgpNagiIJDS6w==
X-Received: by 2002:a63:81c6:: with SMTP id t189mr21196300pgd.293.1560280222945;
        Tue, 11 Jun 2019 12:10:22 -0700 (PDT)
Received: from [10.2.189.129] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id j22sm14809198pfh.71.2019.06.11.12.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 12:10:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 3/9] mm: Add write-protect and clean utilities for
 address space ranges
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <ac0b0ef5-8f76-5e55-2be2-f1860878841a@vmwopensource.org>
Date:   Tue, 11 Jun 2019 12:10:20 -0700
Cc:     dri-devel@lists.freedesktop.org,
        linux-graphics-maintainer@vmware.com,
        "VMware, Inc." <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <39CC6294-52B5-4ED7-852E-A644132DEA18@gmail.com>
References: <20190611122454.3075-1-thellstrom@vmwopensource.org>
 <20190611122454.3075-4-thellstrom@vmwopensource.org>
 <1CDAE797-4686-4041-938F-DE0456FFF451@gmail.com>
 <ac0b0ef5-8f76-5e55-2be2-f1860878841a@vmwopensource.org>
To:     =?utf-8?Q?=22Thomas_Hellstr=C3=B6m_=28VMware=29=22?= 
        <thellstrom@vmwopensource.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 11, 2019, at 11:26 AM, Thomas Hellstr=C3=B6m (VMware) =
<thellstrom@vmwopensource.org> wrote:
>=20
> Hi, Nadav,
>=20
> On 6/11/19 7:21 PM, Nadav Amit wrote:
>>> On Jun 11, 2019, at 5:24 AM, Thomas Hellstr=C3=B6m (VMware) =
<thellstrom@vmwopensource.org> wrote:
>>>=20
>>> From: Thomas Hellstrom <thellstrom@vmware.com>
>> [ snip ]
>>=20
>>> +/**
>>> + * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
>>> + * @pte: Pointer to the pte
>>> + * @token: Page table token, see apply_to_pfn_range()
>>> + * @addr: The virtual page address
>>> + * @closure: Pointer to a struct pfn_range_apply embedded in a
>>> + * struct apply_as
>>> + *
>>> + * The function write-protects a pte and records the range in
>>> + * virtual address space of touched ptes for efficient range TLB =
flushes.
>>> + *
>>> + * Return: Always zero.
>>> + */
>>> +static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
>>> +			      unsigned long addr,
>>> +			      struct pfn_range_apply *closure)
>>> +{
>>> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), =
base);
>>> +	pte_t ptent =3D *pte;
>>> +
>>> +	if (pte_write(ptent)) {
>>> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, =
pte);
>>> +
>>> +		ptent =3D pte_wrprotect(old_pte);
>>> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, =
ptent);
>>> +		aas->total++;
>>> +		aas->start =3D min(aas->start, addr);
>>> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +/**
>>> + * struct apply_as_clean - Closure structure for apply_as_clean
>>> + * @base: struct apply_as we derive from
>>> + * @bitmap_pgoff: Address_space Page offset of the first bit in =
@bitmap
>>> + * @bitmap: Bitmap with one bit for each page offset in the =
address_space range
>>> + * covered.
>>> + * @start: Address_space page offset of first modified pte relative
>>> + * to @bitmap_pgoff
>>> + * @end: Address_space page offset of last modified pte relative
>>> + * to @bitmap_pgoff
>>> + */
>>> +struct apply_as_clean {
>>> +	struct apply_as base;
>>> +	pgoff_t bitmap_pgoff;
>>> +	unsigned long *bitmap;
>>> +	pgoff_t start;
>>> +	pgoff_t end;
>>> +};
>>> +
>>> +/**
>>> + * apply_pt_clean - Leaf pte callback to clean a pte
>>> + * @pte: Pointer to the pte
>>> + * @token: Page table token, see apply_to_pfn_range()
>>> + * @addr: The virtual page address
>>> + * @closure: Pointer to a struct pfn_range_apply embedded in a
>>> + * struct apply_as_clean
>>> + *
>>> + * The function cleans a pte and records the range in
>>> + * virtual address space of touched ptes for efficient TLB flushes.
>>> + * It also records dirty ptes in a bitmap representing page offsets
>>> + * in the address_space, as well as the first and last of the bits
>>> + * touched.
>>> + *
>>> + * Return: Always zero.
>>> + */
>>> +static int apply_pt_clean(pte_t *pte, pgtable_t token,
>>> +			  unsigned long addr,
>>> +			  struct pfn_range_apply *closure)
>>> +{
>>> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), =
base);
>>> +	struct apply_as_clean *clean =3D container_of(aas, =
typeof(*clean), base);
>>> +	pte_t ptent =3D *pte;
>>> +
>>> +	if (pte_dirty(ptent)) {
>>> +		pgoff_t pgoff =3D ((addr - aas->vma->vm_start) >> =
PAGE_SHIFT) +
>>> +			aas->vma->vm_pgoff - clean->bitmap_pgoff;
>>> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, =
pte);
>>> +
>>> +		ptent =3D pte_mkclean(old_pte);
>>> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, =
ptent);
>>> +
>>> +		aas->total++;
>>> +		aas->start =3D min(aas->start, addr);
>>> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
>>> +
>>> +		__set_bit(pgoff, clean->bitmap);
>>> +		clean->start =3D min(clean->start, pgoff);
>>> +		clean->end =3D max(clean->end, pgoff + 1);
>>> +	}
>>> +
>>> +	return 0;
>> Usually, when a PTE is write-protected, or when a dirty-bit is =
cleared, the
>> TLB flush must be done while the page-table lock for that specific =
table is
>> taken (i.e., within apply_pt_clean() and apply_pt_wrprotect() in this =
case).
>>=20
>> Otherwise, in the case of apply_pt_clean() for example, another core =
might
>> shortly after (before the TLB flush) write to the same page whose PTE =
was
>> changed. The dirty-bit in such case might not be set, and the change =
get
>> lost.
>=20
> Hmm. Let's assume that was the case, we have two possible situations:
>=20
> A: pt_clean
>=20
> 1. That core's TLB entry is invalid. It will set the PTE dirty bit and =
continue. The dirty bit will probably remain set after the TLB flush.

I guess you mean the PTE is not cached in the TLB.

> 2. That core's TLB entry is valid. It will just continue. The dirty =
bit will remain clear after the TLB flush.
>=20
> But I fail to see how having the TLB flush within the page table lock =
would help in this case. Since the writing core will never attempt to =
take it? In any case, if such a race occurs, the corresponding bit in =
the bitmap would have been set and we've recorded that the page is =
dirty.

I don=E2=80=99t understand. What do you mean =E2=80=9Crecorded that the =
page is dirty=E2=80=9D?
IIUC, the PTE is clear in this case - you mean PG_dirty is set?

To clarify, this code actually may work correctly on Intel CPUs, based =
on a
recent discussion with Dave Hansen. Apparently, most Intel CPUs set the
dirty bit in memory atomically when a page is first written.=20

But this is a generic code and not arch-specific. My concern is that a
certain page might be written to, but would not be marked as dirty in =
either
the bitmap or the PTE.

The practice of flushing cleaned/write-protected PTEs while hold the
page-table lock related (sorry for my confusion).

> B: wrprotect situation, the situation is a bit different:
>=20
> 1. That core's TLB entry is invalid. It will read the PTE, cause a =
fault and block in mkwrite() on an external address space lock which is =
held over this operation. (Is it this situation that is your main =
concern?)
> 2. That core's TLB entry is valid. It will just continue regardless of =
any locks.
>=20
> For both mkwrite() and dirty() if we act on the recorded pages *after* =
the TLB flush, we're OK. The difference is that just after the TLB flush =
there should be no write-enabled PTEs in the write-protect case, but =
there may be dirty PTEs in the pt_clean case. Something that is =
mentioned in the docs already.

The wrprotect might work correctly, I guess. It does work to mprotect()
(again, sorry for confusing).

>> Does this function regards a certain use-case in which deferring the =
TLB
>> flushes is fine? If so, assertions and documentation of the related
>> assumption would be useful.
>=20
> If I understand your comment correctly, the page table lock is =
sometimes used as the lock in B1, blocking a possible software fault =
until the TLB flush has happened.  Here we assume an external address =
space lock taken both around the wrprotect operation and in mkwrite(). =
Would it be OK if I add comments about the necessity of an external lock =
to the doc? Ok with a follow-up patch?

I think the patch should explain itself. I think the comment:

> + * WARNING: This function should only be used for address spaces that
> + * completely own the pages / memory the page table points to. =
Typically a
> + * device file.=20

... should be more concrete (define address spaces that completely own
memory), and possibly backed by an (debug) assertion to ensure that it =
is
only used correctly.

