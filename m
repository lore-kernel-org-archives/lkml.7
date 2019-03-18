Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F31FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C0842171F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 21:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="KCUGuNY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfCRVab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:30:31 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40275 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCRVaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 17:30:30 -0400
Received: by mail-ot1-f66.google.com with SMTP id x8so15802528otg.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 14:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y8YsUQ1pdHWqexK7sIz4qXDZCsJt+yDdueh4JXEzClU=;
        b=KCUGuNY/mUzIWa+2Uv9mcBG4QykEPnd1Ea57GYtl5VlUucexWFnnu4flLt6LSUwd60
         6fQV+8rsTSWWt1sIWhQhnPdNWb4O7N2dy4+wXIRjpBMJaZBkYm5nCqsTn1Y5iyk3U5gm
         VrUN+mtjYc8zJ9H2L2zqW9n69wy6yCuFQvxBXG99eHShKdq0TFc3tYcO5F8Tk4FKout2
         pzZ5pZm+Wu6pd4AWmFsp5ixT14IC46H4VI+zo5zDZeR2ZkH4jSx8p4dGwK08q9DzlG8M
         ibCuyVusvAvOntZCrjp4LjdhCiaAxtsz3ccecU6A+WRlIR9yKXMdrZQEM7bAddHHegeL
         TJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y8YsUQ1pdHWqexK7sIz4qXDZCsJt+yDdueh4JXEzClU=;
        b=tABuIEoCEuuUReh60hghGQqw3ruzw3ZrCSXmxxvsncLuX1bLdGgFpbkgU+RZEjQmEz
         PY2soVz74/LH042yog509aQXn7wyN+jV1HeqcmECDOb9g+OtqsEWaUQnSJ7/wmcRYb24
         xAKNTu3paK6p5T9LWvygxE4zWKBH7Ckwnu6JhMkhsHxZBou6Y/R7pRuEA5y6JIaPBXik
         HMtjTacjsnxDuPKNuqsEkLDKgaB09tiUfB0fvbstVFmA88JG5zQaz6zAYUgcy4ar3My6
         S3N3HqKl8ViQUAAjRM9fUbcz1GG15rfM9JccG3bdQ3TuRylnsjcB/ogPimUvWunkDtJk
         p0FA==
X-Gm-Message-State: APjAAAWppE+E1YoeCRMdvwEjwis4/HzGUiwzLmmRMgXn/9PX6+0NUOvR
        ldwbsi/sM6B0FAhao8JRdExVZZJ3BgOUXiviGAwmHg==
X-Google-Smtp-Source: APXvYqzzHBucIYBPAfl3DK8iqNNp5zzdiL8B8+aQnNAwxL2xJs13E2tlniVLF5qYCAA0/wbG7h3hTLZTomnpn+1MXD8=
X-Received: by 2002:a9d:2c23:: with SMTP id f32mr8388695otb.353.1552944626498;
 Mon, 18 Mar 2019 14:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190129165428.3931-1-jglisse@redhat.com> <20190129165428.3931-8-jglisse@redhat.com>
 <CAA9_cmcN+8B_tyrxRy5MMr-AybcaDEEWB4J8dstY6h0cmFxi3g@mail.gmail.com> <20190318204134.GD6786@redhat.com>
In-Reply-To: <20190318204134.GD6786@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 18 Mar 2019 14:30:15 -0700
Message-ID: <CAPcyv4he6v5JQMucezZV4J3i+Ea-i7AsaGpCOnc4f-stCrhGag@mail.gmail.com>
Subject: Re: [PATCH 07/10] mm/hmm: add an helper function that fault pages and
 map them to a device
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 1:41 PM Jerome Glisse <jglisse@redhat.com> wrote:
>
> On Mon, Mar 18, 2019 at 01:21:00PM -0700, Dan Williams wrote:
> > On Tue, Jan 29, 2019 at 8:55 AM <jglisse@redhat.com> wrote:
> > >
> > > From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> > >
> > > This is a all in one helper that fault pages in a range and map them =
to
> > > a device so that every single device driver do not have to re-impleme=
nt
> > > this common pattern.
> >
> > Ok, correct me if I am wrong but these seem effectively be the typical
> > "get_user_pages() + dma_map_page()" pattern that non-HMM drivers would
> > follow. Could we just teach get_user_pages() to take an HMM shortcut
> > based on the range?
> >
> > I'm interested in being able to share code across drivers and not have
> > to worry about the HMM special case at the api level.
> >
> > And to be clear this isn't an anti-HMM critique this is a "yes, let's
> > do this, but how about a more fundamental change".
>
> It is a yes and no, HMM have the synchronization with mmu notifier
> which is not common to all device driver ie you have device driver
> that do not synchronize with mmu notifier and use GUP. For instance
> see the range->valid test in below code this is HMM specific and it
> would not apply to GUP user.
>
> Nonetheless i want to remove more HMM code and grow GUP to do some
> of this too so that HMM and non HMM driver can share the common part
> (under GUP). But right now updating GUP is a too big endeavor.

I'm open to that argument, but that statement then seems to indicate
that these apis are indeed temporary. If the end game is common api
between HMM and non-HMM drivers then I think these should at least
come with /* TODO: */ comments about what might change in the future,
and then should be EXPORT_SYMBOL_GPL since they're already planning to
be deprecated. They are a point in time export for a work-in-progress
interface.

> I need
> to make progress on more driver with HMM before thinking of messing
> with GUP code. Making that code HMM only for now will make the GUP
> factorization easier and smaller down the road (should only need to
> update HMM helper and not each individual driver which use HMM).
>
> FYI here is my todo list:
>     - this patchset
>     - HMM ODP
>     - mmu notifier changes for optimization and device range binding
>     - device range binding (amdgpu/nouveau/...)
>     - factor out some nouveau deep inner-layer code to outer-layer for
>       more code sharing
>     - page->mapping endeavor for generic page protection for instance
>       KSM with file back page
>     - grow GUP to remove HMM code and consolidate with GUP code

Sounds workable as a plan.
