Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D397C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3E2C21881
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 19:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Jj6m40Qe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfICTve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 15:51:34 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42078 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfICTvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 15:51:33 -0400
Received: by mail-oi1-f194.google.com with SMTP id o6so13803922oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 12:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgYlgaCvmPzwNL4vIzZhgHzp4QTn4NW2XoH49Hc+J0E=;
        b=Jj6m40QehoTxStYkDvHkU2/J7qgY4tQcYojx4CsPnqNZejNYzY7O8UszxKYZrn0shO
         MagFaazYjBFbKduFEDCG/yTX7i0SAdQBJa1wUgADO2WoVGdruYa0AsnXhf7dUaQadomX
         QbhvahmtA43UsLmzMLau8jAAYhNxaA9enkJx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgYlgaCvmPzwNL4vIzZhgHzp4QTn4NW2XoH49Hc+J0E=;
        b=fCRiQ0VOx4eE+1RciFFSwopYTSBiHVfPJtFbCelqtNmcUZaJ0hqQcaTxCGtbZS7N2V
         qSkP+6ubmPeJFdgcUxwI2hBBhZfiY4aSTD1uQ+MIQQtmZYP0hpvNfFhqBnPmUIVb5Tuc
         vr0w/Mi6BYS01+ng+WkbDShSQnMwjikWjmJoedRWzxXlSKLe9/puWolkc1fOoO8uG6WN
         fERfvsDab1CK+c91gAVKLPpR+SDblZ2bjDNBhl2/FasPYkuqPgIe6nXZ6/3d+mcEJeEm
         ZZg1ds0Oxlm5KsvideTJiF0Xi5tnu20fGgYryaz8N3rjN1viMDvbhHiM2MAv96twhwu3
         0wPw==
X-Gm-Message-State: APjAAAXKXAD5SeY8g4lgH+oY+dqag6U7em9inMOMNAP+oy0V/rsjo7qU
        pNnQWNLoXZUrwt7b9lCpSx9ZTKFW8ZX7TYLZr1nJfQ==
X-Google-Smtp-Source: APXvYqxh4wg+YHA6xLKtnOFhR49pKMDfhYOGcLE/Dn9QIGHUsJcswnhJvqbrYcK86pW92y+nv/aMJLH7s0EET6/U1GI=
X-Received: by 2002:aca:5697:: with SMTP id k145mr692111oib.101.1567540292740;
 Tue, 03 Sep 2019 12:51:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org> <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
In-Reply-To: <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 3 Sep 2019 21:51:21 +0200
Message-ID: <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        pv-drivers@vmware.com,
        VMware Graphics <linux-graphics-maintainer@vmware.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 9:38 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> This whole thing looks like a fascinating collection of hacks. :)
>
> ttm is taking a stack-alllocated "VMA" and handing it to vmf_insert_*()
> which obviously are expecting "real" VMAs that are linked into the mm.
> It's extracting some pgprot_t information from the real VMA, making a
> psuedo-temporary VMA, then passing the temporary one back into the
> insertion functions:
>
> > static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
> > {
> ...
> >         struct vm_area_struct cvma;
> ...
> >                 if (vma->vm_flags & VM_MIXEDMAP)
> >                         ret = vmf_insert_mixed(&cvma, address,
> >                                         __pfn_to_pfn_t(pfn, PFN_DEV));
> >                 else
> >                         ret = vmf_insert_pfn(&cvma, address, pfn);
>
> I can totally see why this needs new exports.  But, man, it doesn't seem
> like something we want to keep *feeding*.
>
> The real problem here is that the encryption bits from the device VMA's
> "true" vma->vm_page_prot don't match the ones that actually get
> inserted, probably because the device ptes need the encryption bits
> cleared but the system memory PTEs need them set *and* they're mixed
> under one VMA.
>
> The thing we need to stop is having mixed encryption rules under one VMA.

The point here is that we want this. We need to be able to move the
buffer between device ptes and system memory ptes, transparently,
behind userspace back, without races. And the fast path (which is "no
pte exists for this vma") must be real fast, so taking mmap_sem and
replacing the vma is no-go.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
