Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 889F0C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B28022CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 21:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567547202;
	bh=OP29gy/q+Cu68z+EtjpWoGyc83iGnUe1WahW7rKmtJU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dQGAqgkjAXFek3lBmakHFpgO6wTDMFgdHP+RpGqdepTzoU8y+PoCaZ04tqIbKKPS3
	 olEgcnX7VLortbpN05rb6THz68dJ5ncsXnQAeKhugej0nRl/i+9xl/AzIpJxAOLsTP
	 dxDD5niVdT2yT+9OUkZBWKQoGo/1gDlveHggApEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfICVql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 17:46:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbfICVql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 17:46:41 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C18C022CF8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2019 21:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567547200;
        bh=OP29gy/q+Cu68z+EtjpWoGyc83iGnUe1WahW7rKmtJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CD6/9CM1nKcIzrbPVDQFlgnKevgZNXmRfLLC6PyzUU/mCHfU3iVEH4CGTWufDJwfm
         qS1yJoSThByNKWmHG8XrhXhForrSoQrkKjc/rwJBxAjJDMqkBbjYony0DU8r71kWro
         3KTryIXmbZM88cQ6U4i08+KJlFlSkKvQ8zduc6hY=
Received: by mail-wr1-f54.google.com with SMTP id y8so18999593wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 14:46:39 -0700 (PDT)
X-Gm-Message-State: APjAAAV0foZD80Mc3sysMQBXac7BBYkg4TVMa0b501L/vIa9NrTD+F5o
        xm7OCCCSCR+SlzcJQ9hd/5vgFSj0UH9SP3Y/mIE37Q==
X-Google-Smtp-Source: APXvYqz4RxECik3SSeHnQ6uGsdoUHoPvfoX8v95tD35kbPoLbUJAHEgyU34VuuCfEWn1rCU4+4Q1Ye17KG1ilOuoQ0w=
X-Received: by 2002:adf:eec5:: with SMTP id a5mr45408830wrp.352.1567547198323;
 Tue, 03 Sep 2019 14:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190903131504.18935-1-thomas_os@shipmail.org>
 <20190903131504.18935-4-thomas_os@shipmail.org> <b54bd492-9702-5ad7-95da-daf20918d3d9@intel.com>
 <CAKMK7uFv+poZq43as8XoQaSuoBZxCQ1p44VCmUUTXOXt4Y+Bjg@mail.gmail.com>
 <6d0fafcc-b596-481b-7b22-1f26f0c02c5c@intel.com> <bed2a2d9-17f0-24bd-9f4a-c7ee27f6106e@shipmail.org>
 <7fa3b178-b9b4-2df9-1eee-54e24d48342e@intel.com> <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
In-Reply-To: <ba77601a-d726-49fa-0c88-3b02165a9a21@shipmail.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 3 Sep 2019 14:46:27 -0700
X-Gmail-Original-Message-ID: <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
Message-ID: <CALCETrVnNpPwmRddGLku9hobE7wG30_3j+QfcYxk09hZgtaYww@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] drm/ttm, drm/vmwgfx: Correctly support support AMD
 memory encryption
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 2:05 PM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> On 9/3/19 10:51 PM, Dave Hansen wrote:
> > On 9/3/19 1:36 PM, Thomas Hellstr=C3=B6m (VMware) wrote:
> >> So the question here should really be, can we determine already at mma=
p
> >> time whether backing memory will be unencrypted and adjust the *real*
> >> vma->vm_page_prot under the mmap_sem?
> >>
> >> Possibly, but that requires populating the buffer with memory at mmap
> >> time rather than at first fault time.
> > I'm not connecting the dots.
> >
> > vma->vm_page_prot is used to create a VMA's PTEs regardless of if they
> > are created at mmap() or fault time.  If we establish a good
> > vma->vm_page_prot, can't we just use it forever for demand faults?
>
> With SEV I think that we could possibly establish the encryption flags
> at vma creation time. But thinking of it, it would actually break with
> SME where buffer content can be moved between encrypted system memory
> and unencrypted graphics card PCI memory behind user-space's back. That
> would imply killing all user-space encrypted PTEs and at fault time set
> up new ones pointing to unencrypted PCI memory..
>
> >
> > Or, are you concerned that if an attempt is made to demand-fault page
> > that's incompatible with vma->vm_page_prot that we have to SEGV?
> >
> >> And it still requires knowledge whether the device DMA is always
> >> unencrypted (or if SEV is active).
> > I may be getting mixed up on MKTME (the Intel memory encryption) and
> > SEV.  Is SEV supported on all memory types?  Page cache, hugetlbfs,
> > anonymous?  Or just anonymous?
>
> SEV AFAIK encrypts *all* memory except DMA memory. To do that it uses a
> SWIOTLB backed by unencrypted memory, and it also flips coherent DMA
> memory to unencrypted (which is a very slow operation and patch 4 deals
> with caching such memory).
>

I'm still lost.  You have some fancy VMA where the backing pages
change behind the application's back.  This isn't particularly novel
-- plain old anonymous memory and plain old mapped files do this too.
Can't you all the insert_pfn APIs and call it a day?  What's so
special that you need all this magic?  ISTM you should be able to
allocate memory that's addressable by the device (dma_alloc_coherent()
or whatever) and then map it into user memory just like you'd map any
other page.

I feel like I'm missing something here.
