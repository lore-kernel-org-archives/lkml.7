Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977F8C3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618CA2086C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 02:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Vrg1MvRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfHPCHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 22:07:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54365 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfHPCHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 22:07:19 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so2799231wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 19:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4t96VrJO/aS/379GpZWL86SzmnziIJmi9L5o4u6HMF4=;
        b=Vrg1MvRSi8MEcTXWax28fm0Y94Y7L5w+dEhHm7nUDN1z0jmBLy24d5m6CjB6CtBncW
         cwSehAxMSaXQkSvTDrT0bkZx8wgxMt450myd8vIxr61UpKOG7hJ78gwa36Qs8GCcxGn5
         /Cm2jQFdyB3LcbgB8kSa/5IqQ3L8KM3Z23Wf1UCneAopPqfQ6YaXBiLK2h9kb2eEmal4
         cA3i9k9b55mm6naet6z3jF7eiquU/CxjIcGGUMhyO4dHR6qDzP4egWjhYqlbfOpvT5QZ
         uBNQt0gRL27bLoYVNBFSiVCtMB8/v2XNg5+xD8ZUy9gYPozeLXlnUsComPwI+KJ2H6LD
         B0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4t96VrJO/aS/379GpZWL86SzmnziIJmi9L5o4u6HMF4=;
        b=RyKmJC/p4w/laBKqqrxrmIgoGw9Ebz59AGXEEFTmRCsdskgUeSyleGmiDZkKgUYU6n
         HEpRhnSTipqKFOYMBkcRNPHPH0/YpCzVE6zCpacklcyqyTrbzrApkdm8dvIN0Q0mhmnd
         ctisRAFAGJ/sJq421h3Xsteg0L5XwvAn+vBvw9NlrfjW/MMoxCIn0NARIAXxXjOEV3s+
         y+9cq01ndxRLDqEAt6As8IDR1rDd43WYNdSL+P7ZJ3SJOLnkAlsBj4qb8a98sjGO9vOD
         9dyDNK2EVe80GPD8aEaXD6N56roXRcPKP67Cp8Vx95vqVc0Of2bVl5JTkVKRuIk8Iax8
         WIWA==
X-Gm-Message-State: APjAAAVrLipF+vkoZQ/zh6Teu5cOL7EUFYtu4nGo6msJo7DtM+35dvon
        tcXkYbS/PDO1hq5/BWQPqNNbfS9DxweCKghkgdieDQ==
X-Google-Smtp-Source: APXvYqzaPRbihIfvjiZQdpb4iYG/ZGbwtATyK9eaeJCOhTmwwtc9szneogjAecpmFOj7nVFCAbo0J7G18lcSWjtbQSU=
X-Received: by 2002:a1c:2dcf:: with SMTP id t198mr4510657wmt.147.1565921237851;
 Thu, 15 Aug 2019 19:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190109203911.7887-1-logang@deltatee.com> <c4298fdd-6fd6-fa7f-73f7-5ff016788e49@deltatee.com>
 <CAEbi=3cn4+7zk2DU1iRa45CDwTsJYfkAV8jXHf-S7Jz63eYy-A@mail.gmail.com>
 <CAEbi=3eZcgWevpX9VO9ohgxVDFVprk_t52Xbs3-TdtZ+js3NVA@mail.gmail.com>
 <0926a261-520e-4c40-f926-ddd40bb8ce44@deltatee.com> <CAEbi=3ebNM-t_vA4OA7KCvQUF08o6VmL1j=kMojVnYsYsN_fBw@mail.gmail.com>
 <e2603558-7b2c-2e5f-e28c-f01782dc4e66@deltatee.com> <CAEbi=3d7_xefYaVXEnMJW49Bzdbbmc2+UOwXWrCiBo7YkTAihg@mail.gmail.com>
 <96156909-1453-d487-ff66-a041d67c74d6@deltatee.com> <CAEbi=3dC86dhGdwdarS_x+6-5=WPydUBKjo613qRZxKLDAqU_g@mail.gmail.com>
 <5506c875-9387-acc9-a7fe-5b7c10036c40@deltatee.com> <alpine.DEB.2.21.9999.1908130921170.30024@viisi.sifive.com>
 <e1f78a33-18bb-bd6e-eede-e5e86758a4d0@deltatee.com> <CAEbi=3f+JDywuHYspfYKuC8z2wm8inRenBz+3DYbKK3ixFjU_g@mail.gmail.com>
 <8b7b6285-dd85-5895-8653-be1f6f08cca8@deltatee.com> <CAHCEeh+us9N5_AMAJp41Ob9R9PD=JfWLcUrU+gU54xf8NKddJw@mail.gmail.com>
 <315f8a06-72f8-9ee8-4a3c-aa9e66b472fd@deltatee.com>
In-Reply-To: <315f8a06-72f8-9ee8-4a3c-aa9e66b472fd@deltatee.com>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Fri, 16 Aug 2019 10:07:05 +0800
Message-ID: <CAHCEehLvw7vnhUaFUE69+mAgw5H8aeLh9c7+Qcg_HaKwwFpOqw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] RISC-V: Implement sparsemem
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Waterman <andrew@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Bates <sbates@raithlin.com>,
        Olof Johansson <olof@lixom.net>,
        linux-riscv@lists.infradead.org,
        Michael Clark <michaeljclark@mac.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:20 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2019-08-15 3:31 a.m., Greentime Hu wrote:
> > Hi Logan,
> >
> > On Thu, Aug 15, 2019 at 6:21 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >> Hey,
> >>
> >> On 2019-08-14 7:35 a.m., Greentime Hu wrote:
> >>> How about this fix? Not sure if it is good for everyone.
> >>
> >> I applied your fix to the patch and it seems ok. But it doesn't seem to
> >> work on a recent version of the kernel. Have you got it working on v5.3?
> >> It seems the following patch breaks things:
> >>
> >> 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> >>
> >> I don't really have time right now to debug this any further.
> >>
> >
> > I just tried v5.3-rc4 and it failed. I try to debug this case.
> > I found it failed might be because of an unmapped virtual address is used
> > in memblocks_present() -> memblock_alloc ().
> >
> > In this commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two
> > stages"), it finishes all the VA/PA mapping after setup_vm_final() is
> > called.
> > So we have to call memblocks_present() and sparse_init() right after
> > setup_vm_final().
> >
> > Here is my patch and I tested with memory-with-hole.
> > It can boot normally in Unleashed board after applying this patch.
>
> Great, thanks! I'll roll this into my patch and send v5 out when I have
> a moment. Can I add your Signed-off-by for the bits you've contributed
> to give you credit for your work?

Sure. Please use my Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
