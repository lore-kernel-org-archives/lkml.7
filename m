Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C54C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A01FF206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 03:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0DV7ewk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfCUDI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 23:08:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:39959 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727511AbfCUDI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 23:08:58 -0400
Received: by mail-it1-f196.google.com with SMTP id l139so2155639ita.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 20:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=krQUPeEhUeWHXrLxX44ZwDfZs9HTeNysg+aRzRJo4mk=;
        b=O0DV7ewkSoAZ/rqPwD5L5473opI76dKFPGAiGF1OEwhywBkZXgX0LqbWbZqlvBGki1
         JUgZihhN+9Eegjweh1YadYSub4LnZEHgYfGo2pJo2VsZV4Ptx3MBkLMGs+FcNQwrWmVm
         oE4tFDGaihV8Ir9e01BOPMcWIBq87rX1NxpRuNSgEzO51deT3tCnYfJym9Z2j/sEClaU
         CCZWJQmwrlkuCDH9iW0k1J4Dge2iudMPauqmu3TpSqHCQjx8j/3TVNMoJZ/CcIkcKiuj
         A/NQ87nXc4Ko7AlFTxb/8AxRdB9GfQeszs1EvWxmc2R58s7HGmYeh+wQ0AJXoQnN7eDM
         0Rdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=krQUPeEhUeWHXrLxX44ZwDfZs9HTeNysg+aRzRJo4mk=;
        b=stTNOrA4aReeWT/BSH1J1rShUriTT+HZIRw6G2tT4VM9CWy+Rm0bqO0VofGCAMd6Kb
         CgfMesSDRje8dn115DLUUGa77sqtch8CwrJOiggfcNCdw2ENrarm43sjAeIutNAs9qC1
         klRKz1NvUV6alAXjQE8RifdGuz2lTF+bCwWUMfVXTsGoYitPfm/oL/FSHxu/+Q7rMMLp
         UPs+ZI23pHhLeIpVpk+awD100kAoWGGL21LKChRVR2vgY3ccNJjsFxyCUWxTBD86JL4w
         tctN7VAUG3tOxnWyjPA3EZlYLeJ3UMjPy0N97oEgavxzj4OAdJ3eI945dEdjbuN+nfw7
         3fcA==
X-Gm-Message-State: APjAAAWfYzBo/y76eukDrcG34WzeA6TegIwqKh38VUHISXj5OU4qR4Vf
        EEe2Tg4YfpRn4dmDHeA5ufx2mkgbb2zEggvlxRk1FzU5
X-Google-Smtp-Source: APXvYqwRkBEj4osIJj129KBcDzogr3ZyjA2aRAcSNZSClpJrTRzqCvw6s6lxH3oEPU2CgdaZoAaEOubD8csvDUwrQ1A=
X-Received: by 2002:a24:eb0e:: with SMTP id h14mr1176796itj.100.1553137736931;
 Wed, 20 Mar 2019 20:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com> <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
 <871s3aqfup.fsf@linux.ibm.com> <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
 <87bm267ywc.fsf@linux.ibm.com> <878sxa7ys5.fsf@linux.ibm.com>
 <CAPcyv4iuAPg3HWh5e8-Ud3oCrvp5AoFmjOzf4bbA+VLgR7NLFg@mail.gmail.com> <CAPcyv4hMzVuOYzy2tTq-my8Z1y+X6Ug-fyObpKTxVU44p5rBZw@mail.gmail.com>
In-Reply-To: <CAPcyv4hMzVuOYzy2tTq-my8Z1y+X6Ug-fyObpKTxVU44p5rBZw@mail.gmail.com>
From:   Oliver <oohall@gmail.com>
Date:   Thu, 21 Mar 2019 14:08:45 +1100
Message-ID: <CAOSf1CEZoLw5QqEMTKwiZ+d_qPLp_D9pJZUtnQWMXWpAXOQ2YA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 7:57 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 20, 2019 at 8:34 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Wed, Mar 20, 2019 at 1:09 AM Aneesh Kumar K.V
> > <aneesh.kumar@linux.ibm.com> wrote:
> > >
> > > Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com> writes:
> > >
> > > > Dan Williams <dan.j.williams@intel.com> writes:
> > > >
> > > >>
> > > >>> Now what will be page size used for mapping vmemmap?
> > > >>
> > > >> That's up to the architecture's vmemmap_populate() implementation.
> > > >>
> > > >>> Architectures
> > > >>> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> > > >>> device-dax with struct page in the device will have pfn reserve area aligned
> > > >>> to PAGE_SIZE with the above example? We can't map that using
> > > >>> PMD_SIZE page size?
> > > >>
> > > >> IIUC, that's a different alignment. Currently that's handled by
> > > >> padding the reservation area up to a section (128MB on x86) boundary,
> > > >> but I'm working on patches to allow sub-section sized ranges to be
> > > >> mapped.
> > > >
> > > > I am missing something w.r.t code. The below code align that using nd_pfn->align
> > > >
> > > >       if (nd_pfn->mode == PFN_MODE_PMEM) {
> > > >               unsigned long memmap_size;
> > > >
> > > >               /*
> > > >                * vmemmap_populate_hugepages() allocates the memmap array in
> > > >                * HPAGE_SIZE chunks.
> > > >                */
> > > >               memmap_size = ALIGN(64 * npfns, HPAGE_SIZE);
> > > >               offset = ALIGN(start + SZ_8K + memmap_size + dax_label_reserve,
> > > >                               nd_pfn->align) - start;
> > > >       }
> > > >
> > > > IIUC that is finding the offset where to put vmemmap start. And that has
> > > > to be aligned to the page size with which we may end up mapping vmemmap
> > > > area right?
> >
> > Right, that's the physical offset of where the vmemmap ends, and the
> > memory to be mapped begins.
> >
> > > > Yes we find the npfns by aligning up using PAGES_PER_SECTION. But that
> > > > is to compute howmany pfns we should map for this pfn dev right?
> > > >
> > >
> > > Also i guess those 4K assumptions there is wrong?
> >
> > Yes, I think to support non-4K-PAGE_SIZE systems the 'pfn' metadata
> > needs to be revved and the PAGE_SIZE needs to be recorded in the
> > info-block.
>
> How often does a system change page-size. Is it fixed or do
> environment change it from one boot to the next? I'm thinking through
> the behavior of what do when the recorded PAGE_SIZE in the info-block
> does not match the current system page size. The simplest option is to
> just fail the device and require it to be reconfigured. Is that
> acceptable?

The kernel page size is set at build time and as far as I know every
distro configures their ppc64(le) kernel for 64K. I've used 4K kernels
a few times in the past to debug PAGE_SIZE dependent problems, but I'd
be surprised if anyone is using 4K in production.

Anyway, my view is that using 4K here isn't really a problem since
it's just the accounting unit of the pfn superblock format. The kernel
reading form it should understand that and scale it to whatever
accounting unit it wants to use internally. Currently we don't so that
should probably be fixed, but that doesn't seem to cause any real
issues. As far as I can tell the only user of npfns in
__nvdimm_setup_pfn() whih prints the "number of pfns truncated"
message.

Am I missing something?

> _______________________________________________
> Linux-nvdimm mailing list
> Linux-nvdimm@lists.01.org
> https://lists.01.org/mailman/listinfo/linux-nvdimm
