Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E17C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEFF2089E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qwjMMotT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406018AbfFKRV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 13:21:27 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45187 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405786AbfFKRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 13:21:26 -0400
Received: by mail-pl1-f193.google.com with SMTP id bi6so4998925plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 10:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BqY+/YK4he+mJtH+liZ691VHoEXekm5Z7axwayEiyqI=;
        b=qwjMMotTsYQLcBdOxTImLWEPM7dYSviXaJ3bwpIH5bTHBV5rk8kXbLfsovR4nh5X+r
         jmRE7ph/ZEy3MAYKVes4N8c6/Ktxl1Ush2MtVhNHnam3/dlDrWXNDSOQhmlKsgj2BnmC
         voQbsoYr6uu+ISBkpnOyTZuGn17P/VWEBcINluDLEycw/epbUsdx2IQU4UhQXLYSQW93
         X4WqYogjsuzpBa5UA18rS6bogmqexa27OLXTOqzJhdZtHNSIURqb0imdA4LOhwZg+rp6
         nhYgMtpXEKINSVCHlODqmLFeeTgv3/cDI9bgiWud03UUBrGA52iID7O/JTKm7RoFWyJt
         TcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=BqY+/YK4he+mJtH+liZ691VHoEXekm5Z7axwayEiyqI=;
        b=dZmrj3EJwWs+e00tONvLyMKQpAn8bUCq/H6yUJzzqd8diAeUiGC2CyM5sFn1ldx/9v
         XmwCQmCd8nn1i3qZlpcAQ2K8mrrEBDJqHstETngml23ingm6ulpeH1zE2VAYykOmkJ0c
         Nm91YbaJA4dW7JeCq4JI5Jzd+nxAkyMkp2nlC9QuqIdIQudQbbEhD9jrS3e+kBU44Opw
         6m4dW6uF0Vsg9rUrjlQ1TXJGkcNcLu/w+/NqpicNfOe2bIYy69989diga8pip7cpOb9C
         gNLsa1icT5v7sSWbkVOY711wcHrKDFvVijA1THMia9RI5vWezG1FF0VjDd2QlIKJ6/uQ
         yJEA==
X-Gm-Message-State: APjAAAVDnh9W0jy4UCOMK8s8rDZdSDs6EP1Dn5Kpur+wX9/yFnP63W+9
        MQXbxizJJ9pQeQQo7LAdgYc=
X-Google-Smtp-Source: APXvYqz7uI2Qmwz9JEnpIliJNayf/qQ2faVw+nEuOaS5Sof99wLkycZSvOoPTTHh6/ipSo8bsJvhbA==
X-Received: by 2002:a17:902:9b81:: with SMTP id y1mr52592445plp.194.1560273685452;
        Tue, 11 Jun 2019 10:21:25 -0700 (PDT)
Received: from [10.2.189.129] ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id z3sm2940090pjn.16.2019.06.11.10.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 10:21:24 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH v4 3/9] mm: Add write-protect and clean utilities for
 address space ranges
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20190611122454.3075-4-thellstrom@vmwopensource.org>
Date:   Tue, 11 Jun 2019 10:21:22 -0700
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
        linux-mm@kvack.org, Ralph Campbell <rcampbell@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1CDAE797-4686-4041-938F-DE0456FFF451@gmail.com>
References: <20190611122454.3075-1-thellstrom@vmwopensource.org>
 <20190611122454.3075-4-thellstrom@vmwopensource.org>
To:     =?utf-8?Q?=22Thomas_Hellstr=C3=B6m_=28VMware=29=22?= 
        <thellstrom@vmwopensource.org>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Jun 11, 2019, at 5:24 AM, Thomas Hellstr=C3=B6m (VMware) =
<thellstrom@vmwopensource.org> wrote:
>=20
> From: Thomas Hellstrom <thellstrom@vmware.com>
>=20

[ snip ]

> +/**
> + * apply_pt_wrprotect - Leaf pte callback to write-protect a pte
> + * @pte: Pointer to the pte
> + * @token: Page table token, see apply_to_pfn_range()
> + * @addr: The virtual page address
> + * @closure: Pointer to a struct pfn_range_apply embedded in a
> + * struct apply_as
> + *
> + * The function write-protects a pte and records the range in
> + * virtual address space of touched ptes for efficient range TLB =
flushes.
> + *
> + * Return: Always zero.
> + */
> +static int apply_pt_wrprotect(pte_t *pte, pgtable_t token,
> +			      unsigned long addr,
> +			      struct pfn_range_apply *closure)
> +{
> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), =
base);
> +	pte_t ptent =3D *pte;
> +
> +	if (pte_write(ptent)) {
> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, =
pte);
> +
> +		ptent =3D pte_wrprotect(old_pte);
> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, =
ptent);
> +		aas->total++;
> +		aas->start =3D min(aas->start, addr);
> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * struct apply_as_clean - Closure structure for apply_as_clean
> + * @base: struct apply_as we derive from
> + * @bitmap_pgoff: Address_space Page offset of the first bit in =
@bitmap
> + * @bitmap: Bitmap with one bit for each page offset in the =
address_space range
> + * covered.
> + * @start: Address_space page offset of first modified pte relative
> + * to @bitmap_pgoff
> + * @end: Address_space page offset of last modified pte relative
> + * to @bitmap_pgoff
> + */
> +struct apply_as_clean {
> +	struct apply_as base;
> +	pgoff_t bitmap_pgoff;
> +	unsigned long *bitmap;
> +	pgoff_t start;
> +	pgoff_t end;
> +};
> +
> +/**
> + * apply_pt_clean - Leaf pte callback to clean a pte
> + * @pte: Pointer to the pte
> + * @token: Page table token, see apply_to_pfn_range()
> + * @addr: The virtual page address
> + * @closure: Pointer to a struct pfn_range_apply embedded in a
> + * struct apply_as_clean
> + *
> + * The function cleans a pte and records the range in
> + * virtual address space of touched ptes for efficient TLB flushes.
> + * It also records dirty ptes in a bitmap representing page offsets
> + * in the address_space, as well as the first and last of the bits
> + * touched.
> + *
> + * Return: Always zero.
> + */
> +static int apply_pt_clean(pte_t *pte, pgtable_t token,
> +			  unsigned long addr,
> +			  struct pfn_range_apply *closure)
> +{
> +	struct apply_as *aas =3D container_of(closure, typeof(*aas), =
base);
> +	struct apply_as_clean *clean =3D container_of(aas, =
typeof(*clean), base);
> +	pte_t ptent =3D *pte;
> +
> +	if (pte_dirty(ptent)) {
> +		pgoff_t pgoff =3D ((addr - aas->vma->vm_start) >> =
PAGE_SHIFT) +
> +			aas->vma->vm_pgoff - clean->bitmap_pgoff;
> +		pte_t old_pte =3D ptep_modify_prot_start(aas->vma, addr, =
pte);
> +
> +		ptent =3D pte_mkclean(old_pte);
> +		ptep_modify_prot_commit(aas->vma, addr, pte, old_pte, =
ptent);
> +
> +		aas->total++;
> +		aas->start =3D min(aas->start, addr);
> +		aas->end =3D max(aas->end, addr + PAGE_SIZE);
> +
> +		__set_bit(pgoff, clean->bitmap);
> +		clean->start =3D min(clean->start, pgoff);
> +		clean->end =3D max(clean->end, pgoff + 1);
> +	}
> +
> +	return 0;

Usually, when a PTE is write-protected, or when a dirty-bit is cleared, =
the
TLB flush must be done while the page-table lock for that specific table =
is
taken (i.e., within apply_pt_clean() and apply_pt_wrprotect() in this =
case).

Otherwise, in the case of apply_pt_clean() for example, another core =
might
shortly after (before the TLB flush) write to the same page whose PTE =
was
changed. The dirty-bit in such case might not be set, and the change get
lost.

Does this function regards a certain use-case in which deferring the TLB
flushes is fine? If so, assertions and documentation of the related
assumption would be useful.

