Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4000BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:02:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10EFE20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 04:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="eU7vf8X9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfCNECZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 00:02:25 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42485 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfCNECZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 00:02:25 -0400
Received: by mail-ot1-f65.google.com with SMTP id i5so3874201oto.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2019 21:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs7tp1/zBqGtB73b9T3ZkeYLG/1DJ1WgPchIkfxvgMI=;
        b=eU7vf8X9XCVloH4yFRSwPMJOtpSR/fMmFkniq4uHcPXAlIReWXJh0Z+q64meRuGP3M
         skI5X4A5JF/zw1rhA6o7JcFS6QQUIjOyw87HiIPJuTeV3ZFCWkuVzjiunjbGmnKIH8PP
         d0GUJS45X4BfE3LGcOkOgmFPbVoD1RlmOP/s4Iba+KMHCV7RQOG8tt5WRNcYCxFV8yGB
         uQgbxTR+iAgUImDt6CTAyz2+XDvw6vYu7YGLKi1XurFi/KZX9rHUjIia18cI51xDn6FC
         vI2KT31oSMg20EO444p+DGxfHVR1APWOjIF4q0elCkXZ/5bHEVX7dTtHnmLFxCnjmC/E
         9rXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qs7tp1/zBqGtB73b9T3ZkeYLG/1DJ1WgPchIkfxvgMI=;
        b=kXZYs7NwHXGEsFUeMT4shCx4H5WR/XG0bFME9VXTFD8Vyj6ysqtPmU8Yz/D1jHJEuw
         R6eLhfJgWPprKI+4dxkT+LOJqXmUwxpu4yQccRPOVG94tIKX16zFUfov/aIfj4FQ5Gxu
         Q/YsAjbnHNU9FjjefY+AMt2fPdXUfQlSUzTmBPgA9WHZ/VByz+z/rK77CovFLATKB7jR
         pZ6wiX7CIOx4oncuR4bnbJ7mfwKs7tzMUOhMUrSYFuXYkrH6vQAjE23vzyFG1WNbHRiH
         40Zb5mgEk3d+kmkXLMiR2x5qK6KfWap4aWJtVGz8CnIWbvwd5Cd+13May21A7pr3Mexw
         m8Qw==
X-Gm-Message-State: APjAAAULNz8c69y3nciEY1w34BuAk+jI35j0je369rd33suRgk79FF/Z
        M5SotKDmWAL4bhd/EvaFXQ0ekA9yczazhmmz7hVw3KsW
X-Google-Smtp-Source: APXvYqzxaRxDED7CM3oENetDG2md4WXlntPbG0NSGcR0/oaZGUe6x6pBOyPAF61pD1lSSIn/hEMAOHQHBo57G6q1bYU=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr28800858otl.353.1552536143794;
 Wed, 13 Mar 2019 21:02:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190228083522.8189-1-aneesh.kumar@linux.ibm.com>
 <20190228083522.8189-2-aneesh.kumar@linux.ibm.com> <CAOSf1CHjkyX2NTex7dc1AEHXSDcWA_UGYX8NoSyHpb5s_RkwXQ@mail.gmail.com>
 <CAPcyv4jhEvijybSVsy+wmvgqfvyxfePQ3PUqy1hhmVmPtJTyqQ@mail.gmail.com>
 <87k1hc8iqa.fsf@linux.ibm.com> <CAPcyv4ir4irASBQrZD_a6kMkEUt=XPUCuKajF75O7wDCgeG=7Q@mail.gmail.com>
 <871s3aqfup.fsf@linux.ibm.com>
In-Reply-To: <871s3aqfup.fsf@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 13 Mar 2019 21:02:11 -0700
Message-ID: <CAPcyv4i0SahDP=_ZQV3RG_b5pMkjn-9Cjy7OpY2sm1PxLdO8jA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/dax: Don't enable huge dax mapping by default
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
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

On Wed, Mar 13, 2019 at 8:45 PM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
[..]
> >> Now w.r.t to failures, can device-dax do an opportunistic huge page
> >> usage?
> >
> > device-dax explicitly disclaims the ability to do opportunistic mappings.
> >
> >> I haven't looked at the device-dax details fully yet. Do we make the
> >> assumption of the mapping page size as a format w.r.t device-dax? Is that
> >> derived from nd_pfn->align value?
> >
> > Correct.
> >
> >>
> >> Here is what I am working on:
> >> 1) If the platform doesn't support huge page and if the device superblock
> >> indicated that it was created with huge page support, we fail the device
> >> init.
> >
> > Ok.
> >
> >> 2) Now if we are creating a new namespace without huge page support in
> >> the platform, then we force the align details to PAGE_SIZE. In such a
> >> configuration when handling dax fault even with THP enabled during
> >> the build, we should not try to use hugepage. This I think we can
> >> achieve by using TRANSPARENT_HUGEPAEG_DAX_FLAG.
> >
> > How is this dynamic property communicated to the guest?
>
> via device tree on powerpc. We have a device tree node indicating
> supported page sizes.

Ah, ok, yeah let's plumb that straight to the device-dax driver and
leave out the interaction / interpretation of the thp-enabled flags.

>
> >
> >>
> >> Also even if the user decided to not use THP, by
> >> echo "never" > transparent_hugepage/enabled , we should continue to map
> >> dax fault using huge page on platforms that can support huge pages.
> >>
> >> This still doesn't cover the details of a device-dax created with
> >> PAGE_SIZE align later booted with a kernel that can do hugepage dax.How
> >> should we handle that? That makes me think, this should be a VMA flag
> >> which got derived from device config? May be use VM_HUGEPAGE to indicate
> >> if device should use a hugepage mapping or not?
> >
> > device-dax configured with PAGE_SIZE always gets PAGE_SIZE mappings.
>
> Now what will be page size used for mapping vmemmap?

That's up to the architecture's vmemmap_populate() implementation.

> Architectures
> possibly will use PMD_SIZE mapping if supported for vmemmap. Now a
> device-dax with struct page in the device will have pfn reserve area aligned
> to PAGE_SIZE with the above example? We can't map that using
> PMD_SIZE page size?

IIUC, that's a different alignment. Currently that's handled by
padding the reservation area up to a section (128MB on x86) boundary,
but I'm working on patches to allow sub-section sized ranges to be
mapped.

Now, that said, I expect there may be bugs lurking in the
implementation if PAGE_SIZE changes from one boot to the next simply
because I've never tested that.

I think this also indicates that the section padding logic can't be
removed until all arch vmemmap_populate() implementations understand
the sub-section case.
