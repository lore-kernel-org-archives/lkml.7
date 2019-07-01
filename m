Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7533AC06511
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5501221479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 18:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+mTkh6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfGASHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 14:07:36 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:38723 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfGASHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 14:07:36 -0400
Received: by mail-vk1-f194.google.com with SMTP id f68so2894598vkf.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 11:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lWONYKiUC+xNG+v0x99Ltv7YhSq18V7iywQoniSnrLY=;
        b=B+mTkh6VPC/HVnQ/2aPY6tcq2AbxaF1Ieqvp+5l4ijk9/nrIuBAJwhSsYqD/Lkik4W
         x+k4pLd8gMGKtMhht3Fll8Z+BbzMOMLQb/FqBjxPYlLYt2xkivfIRECPwxqWvzkYSwms
         q78SVjZsa2BdoiPBS9C0KhLfSN7Sh4cMPnid6WAwR0eh962wv/tCSUypcmIQJbluwuBd
         pqNgcsOw/e/yvw1i7IGN1XsbMx3m2art1A/7FZf8nLPSrCuoPP/PtgwZ2stipavisg9I
         t2MwBx7coZG+aEcR35I2h4h1t/ZprqqwTewkKoYWgFEBsg6qwTAj0pnUZtGPsqbMR/tb
         PXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lWONYKiUC+xNG+v0x99Ltv7YhSq18V7iywQoniSnrLY=;
        b=sYxoS37YEMtcSRPMC8I61/TQgla/JcVOil6tsPlfl2LRFdxrV5S2fSxNj0v6ovC6TV
         WNYnIFG9k7PIPE4F8mDsH+S92f1Utybwj68xn1iDnVLD4LraUCX3/uSOSOopYi9H30R9
         3qCBLWoniwwDrVIcWn/33zmhwrgi/7VlPyVTfd+X4ZyFsqqLuGbzRsbXNLbbDSQVcdUh
         UnKwm/D7NAFvwikwVc+9q3xo+VikwrsDkdNV4ty8F4tWbzPNOu1uMkznDsP+vHKYxdkX
         ZbK53r0aPnplureSyRnX19i89nfAe6uQfxsNgRnOE6FJ6BU4vTwBApEzCmx74e+n2mA1
         wsSg==
X-Gm-Message-State: APjAAAV74KTBWw4gfx+1DyXtghVrITSp2kIDNtrvbOOX7qnGbm/nVLBQ
        jNizp5Ru+OgU+0tYktIntEH6HkCbjqhdq4s0EKU=
X-Google-Smtp-Source: APXvYqwRJwKQv7q3x+bK0rhEHYsq3B5RUxQ/uPaJ6fmEtHv4AFhRjDw9aFEkw+axhgsNwnA0UOwULvb0Zrsqeu6li5Q=
X-Received: by 2002:a1f:2896:: with SMTP id o144mr3222112vko.73.1562004455408;
 Mon, 01 Jul 2019 11:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo564RoWpi8y2pOxoddnn0s3f3sA-fmNxpiXuxebV5TFBJA@mail.gmail.com>
 <CACDBo55GfomD4yAJ1qaOvdm8EQaD-28=etsRHb39goh+5VAeqw@mail.gmail.com>
 <20190626175131.GA17250@infradead.org> <CACDBo56fNVxVyNEGtKM+2R0X7DyZrrHMQr6Yw4NwJ6USjD5Png@mail.gmail.com>
 <c9fe4253-5698-a226-c643-32a21df8520a@arm.com> <CACDBo57CcYQmNrsTdMbax27nbLyeMQu4kfKZOzNczNcnde9g3Q@mail.gmail.com>
 <0725b9aa-0523-daef-b4ff-7e2dd910cf3c@arm.com>
In-Reply-To: <0725b9aa-0523-daef-b4ff-7e2dd910cf3c@arm.com>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Mon, 1 Jul 2019 23:37:24 +0530
Message-ID: <CACDBo56taTYwSvzH9ZPbTzPM6gMzknki94QsAoo+oNkyCLkTMA@mail.gmail.com>
Subject: Re: DMA-API attr - DMA_ATTR_NO_KERNEL_MAPPING
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 1, 2019 at 11:24 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 01/07/2019 18:47, Pankaj Suryawanshi wrote:
> >> If you want a kernel mapping, *don't* explicitly request not to have a
> >> kernel mapping in the first place. It's that simple.
> >>
> >
> > Do you mean do not use dma-api ? because if i used dma-api it will give you
> > mapped virtual address.
> > or i have to use directly cma_alloc() in my driver. // if i used this
> > approach i need to reserved more vmalloc area.
>
> No, I mean just call dma_alloc_attrs() normally *without* adding the
> DMA_ATTR_NO_KERNEL_MAPPING flag. That flag means "I never ever want to
> make CPU accesses to this buffer from the kernel" - that is clearly not
> the case for your code, so it is utterly nonsensical to still pass the
> flag but try to hack around it later.


Actually my use case is that i want virtual mapping only when i will
play video as my vpu/gpu driver is design like that.
and  i am using 32-bit so virtual memory is splitted as 3G/1G so dont
have enough memory for all the time to mapped with kernel space.

Lets say i am allocating 400MB for driver but i want only 30MB for
virtual mapping (not everytime) that is the case.
>
>
> Robin.
