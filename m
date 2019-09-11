Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C7C5ACAE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D6F21479
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 18:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568225017;
	bh=0OW0R0944mrm7VDRjfWc+dTciELz4dFGwuNUyC/pvHY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RVs6BYu3T+VezGl+RzexQPxLke7+nwEgMusDdxhqYm7Uthatdxc/76KXZF+H0hcxY
	 615nDJhasSSzuZhNxBZ2C7J7qkaZsZi3jgPKrpmClkctI/lXnqrqPsj4ZAHgc0P9a1
	 qKxRgAlspAHfg35lvdeOIpB7XZUwMOIt3OrN4V0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730081AbfIKSDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 14:03:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:45294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729699AbfIKSDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 14:03:35 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 069BD21D7B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 18:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568225014;
        bh=0OW0R0944mrm7VDRjfWc+dTciELz4dFGwuNUyC/pvHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rh25mxvWIo9i4lbqkPpHwEhMSxYb6KHnc8BEwdrdZfJGK8o5lCM+/eMKmj5iC6v2d
         bj+jPhZ9Lq137zzKXuSEpdEph2AQ2LxhEMQa4WBJK22sY4V02ZUY2LXbeesrtI8QY0
         1QDOUTbyfLvXI5BYAX9ioK7Z8k6JeqkT8D8Fps+4=
Received: by mail-wr1-f42.google.com with SMTP id t16so25625910wra.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 11:03:33 -0700 (PDT)
X-Gm-Message-State: APjAAAX1qogk5Hky6wkChx4kgiERKbVh+HdCXFgOyG7ITtY+F1hr8hr4
        XJaUEal3kboLWfBhQCJ1DwS41tZDGJJa9OeEUIs+EA==
X-Google-Smtp-Source: APXvYqw8eh1PfkTVVWq6aHusd2tHhF/sjG45JwIeuzTO2HIz/Br6hch9j+hZ/Kg9MDK9PrsKz6esUNSJD4zmCk3CAfY=
X-Received: by 2002:adf:ee10:: with SMTP id y16mr4387873wrn.47.1568225012407;
 Wed, 11 Sep 2019 11:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190905103541.4161-1-thomas_os@shipmail.org> <20190905103541.4161-2-thomas_os@shipmail.org>
 <608bbec6-448e-f9d5-b29a-1984225eb078@intel.com> <b84d1dca-4542-a491-e585-a96c9d178466@shipmail.org>
 <20190905152438.GA18286@infradead.org> <10185AAF-BFB8-4193-A20B-B97794FB7E2F@amacapital.net>
 <92171412-eed7-40e9-2554-adb358e65767@shipmail.org> <CALCETrWEzctRxiv9AY0hhPGNPhv8k0POCMzMi30Bgh2aPY7R3w@mail.gmail.com>
 <76f89b46-7b14-9483-e552-eb52762adca0@shipmail.org>
In-Reply-To: <76f89b46-7b14-9483-e552-eb52762adca0@shipmail.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 11 Sep 2019 11:03:19 -0700
X-Gmail-Original-Message-ID: <CALCETrVKg=xjG5qyHbCY7P1H17v8LBV3FmQmqGKsPz_4qovFZQ@mail.gmail.com>
Message-ID: <CALCETrVKg=xjG5qyHbCY7P1H17v8LBV3FmQmqGKsPz_4qovFZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        pv-drivers@vmware.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 12:49 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> Hi, Andy.
>
> On 9/11/19 6:18 AM, Andy Lutomirski wrote:

> >
> > As a for-real example, take a look at arch/x86/entry/vdso/vma.c.  The
> > "vvar" VMA contains multiple pages that are backed by different types
> > of memory.  There's a page of ordinary kernel memory.  Historically
> > there was a page of genuine MMIO memory, but that's gone now.  If the
> > system is a SEV guest with pvclock enabled, then there's a page of
> > decrypted memory.   They all share a VMA, they're instantiated in
> > .fault, and there is no hackery involved.  Look at vvar_fault().
>
> So this is conceptually identical to TTM. The difference is that it uses
> vmf_insert_pfn_prot() instead of vmf_insert_mixed() with the vma hack.
> Had there been a vmf_insert_mixed_prot(), the hack in TTM wouldn't be
> needed. I guess providing a vmf_insert_mixed_prot() is a to-do for me to
> pick up.

:)

>
> Having said that, the code you point out is as fragile and suffers from
> the same shortcomings as TTM since
> a) Running things like split_huge_pmd() that takes the vm_page_prot and
> applies it to new PTEs will make things break, (although probably never
> applicable in this case).

Hmm.  There are no vvar huge pages, so this is okay.

I wonder how hard it would be to change the huge page splitting code
to copy the encryption and cacheability bits from the source entry
instead of getting them from vm_page_prot, at least in the cases
relevant to VM_MIXEDMAP and VM_PFNMAP.

> b) Running mprotect() on that VMA will only work if sme_me_mask is part
> of _PAGE_CHG_MASK (which is addressed in a reliable way in my recent
> patchset),  otherwise, the encryption setting will be overwritten.
>

Indeed.  Thanks for the fix!

>
> >> We could probably get away with a WRITE_ONCE() update of the
> >> vm_page_prot before taking the page table lock since
> >>
> >> a) We're locking out all other writers.
> >> b) We can't race with another fault to the same vma since we hold an
> >> address space lock ("buffer object reservation")
> >> c) When we need to update there are no valid page table entries in the
> >> vma, since it only happens directly after mmap(), or after an
> >> unmap_mapping_range() with the same address space lock. When another
> >> reader (for example split_huge_pmd()) sees a valid page table entry, i=
t
> >> also sees the new page protection and things are fine.
> >>
> >> But that would really be a special case. To solve this properly we'd
> >> probably need an additional lock to protect the vm_flags and
> >> vm_page_prot, taken after mmap_sem and i_mmap_lock.
> >>
> > This is all horrible IMO.
>
> I'd prefer to call it fragile and potentially troublesome to maintain.

Fair enough.

>
> That distinction is important because if it ever comes to a choice
> between adding a new lock to protect vm_page_prot (and consequently slow
> down the whole vm system) and using the WRITE_ONCE solution in TTM, we
> should know what the implications are. As it turns out previous choices
> in this area actually seem to have opted for the lockless WRITE_ONCE /
> READ_ONCE / ptl solution. See __split_huge_pmd_locked() and
> vma_set_page_prot().

I think it would be even better if the whole thing could work without
ever writing to vm_page_prot.  This would be a requirement for vvar in
the unlikely event that the vvar vma ever supported splittable huge
pages.  Fortunately, that seems unlikely :)
