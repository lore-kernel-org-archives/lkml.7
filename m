Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2E7C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94B702171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 20:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Xs91eNvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732532AbfHOUrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 16:47:25 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35732 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728728AbfHOUrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 16:47:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id g17so6874194otl.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 13:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iGCSUcgObYGVRCAzYsit2AWDPyDTFFk4jtMiYAkxFvg=;
        b=Xs91eNvCSOxAfiys1ppgNPaq0ALSevQ/T2i3xlUF6I+d0oNYGWm/kcLiWw3+Xl4qnf
         JmRKMGDSydou9/I7nXt437o0JX4dmiF7jPGXc+pjZbnEFC2zEZTdc2kHWzkAn3V1gSAl
         Hu9FCTmyAtKxs8tWdI2G6Y/dh0Bvh+WzLoLzAyJ2QnYpWxC6zKV9cpe1sVsIEPWKNT7E
         iVYV5R/+pyflylvOahsY4t5XbCQibs6REFPZ0SdxGqNvL9GniE7dpOmgRXMxzo5dWcEd
         ZEmrJY5OG1t7TpFlJrOJdClXDU4QGKNZ3i/T4vOTVaMLxf8C2MQbB2F1vE0fQMBNsoGm
         GEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iGCSUcgObYGVRCAzYsit2AWDPyDTFFk4jtMiYAkxFvg=;
        b=Bn9V7h6YWdxt0NhFpDPRJoHU2EP1zXJuYONhC3Q9/9ZE1nfEZJiXj3MtRvpS7G35po
         Y6Qvo+M7rrUcLTteHk1hlhkaNgywM375uMVo8YjdztS2XtubDXALNPfUWf46C1oXk2RM
         naKzLwUtLKEW4fSUsjskyY7fDzjcm0m2IukVen5cI1uh38LhdwoyuHHyzgreIliKR/eR
         Ovz0xccwPxhUfKQhuPYHC5cdVvWfYWYhqc2vPHQ6CzSS8I8hBTOm85RipNP2bnFd+Ldj
         vmIFxtWdRBRbwiOIGpX/Flaj17n4DQL2+LdN5QoDvZPuceiwXEKjz+A98OYTvPfeaX4l
         LGFg==
X-Gm-Message-State: APjAAAX4BQMfP8LIgLWM2x3+hoxXmJZJts4+KgVjGXDHEzsc8i+xO4br
        ImnPCUpqy6N7HKhQmWfJJmubx7V+vxVCD0KvoPhwjg==
X-Google-Smtp-Source: APXvYqxd1d1qB7OEUrQO74IOC/HKBdhosqv4dkigmxMbJWq9zPu2Tf40r+CLgutNYrcVuSBFfg5oXWWZglhJSMHeq3k=
X-Received: by 2002:a05:6830:458:: with SMTP id d24mr4706447otc.126.1565902044326;
 Thu, 15 Aug 2019 13:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190808065933.GA29382@lst.de> <CAPcyv4hMUzw8vyXFRPe2pdwef0npbMm9tx9wiZ9MWkHGhH1V6w@mail.gmail.com>
 <20190814073854.GA27249@lst.de> <20190814132746.GE13756@mellanox.com>
 <CAPcyv4g8usp8prJ+1bMtyV1xuedp5FKErBp-N8+KzR=rJ-v0QQ@mail.gmail.com>
 <20190815180325.GA4920@redhat.com> <CAPcyv4g4hzcEA=TPYVTiqpbtOoS30ahogRUttCvQAvXQbQjfnw@mail.gmail.com>
 <20190815194339.GC9253@redhat.com> <CAPcyv4jid8_=-8hBpn_Qm=c4S8BapL9B9RGT7e9uu303yH=Yqw@mail.gmail.com>
 <20190815203306.GB25517@redhat.com> <20190815204128.GI22970@mellanox.com>
In-Reply-To: <20190815204128.GI22970@mellanox.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 15 Aug 2019 13:47:12 -0700
Message-ID: <CAPcyv4j_Mxbw+T+yXTMdkrMoS_uxg+TXXgTM_EPBJ8XfXKxytA@mail.gmail.com>
Subject: Re: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Jerome Glisse <jglisse@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 1:41 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> On Thu, Aug 15, 2019 at 04:33:06PM -0400, Jerome Glisse wrote:
>
> > So nor HMM nor driver should dereference the struct page (i do not
> > think any iommu driver would either),
>
> Er, they do technically deref the struct page:
>
> nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
>                          struct hmm_range *range)
>                 struct page *page;
>                 page = hmm_pfn_to_page(range, range->pfns[i]);
>                 if (!nouveau_dmem_page(drm, page)) {
>
>
> nouveau_dmem_page(struct nouveau_drm *drm, struct page *page)
> {
>         return is_device_private_page(page) && drm->dmem == page_to_dmem(page)
>
>
> Which does touch 'page->pgmap'
>
> Is this OK without having a get_dev_pagemap() ?
>
> Noting that the collision-retry scheme doesn't protect anything here
> as we can have a concurrent invalidation while doing the above deref.

As long take_driver_page_table_lock() in Jerome's flow can replace
percpu_ref_tryget_live() on the pagemap reference. It seems
nouveau_dmem_convert_pfn() happens after:

                        mutex_lock(&svmm->mutex);
                        if (!nouveau_range_done(&range)) {

...so I would expect that to be functionally equivalent to validating
the reference count.
