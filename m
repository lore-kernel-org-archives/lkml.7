Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7037C41514
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9547A218F0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nZqEhfFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbfGYSJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 14:09:19 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44871 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfGYSJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 14:09:18 -0400
Received: by mail-vs1-f66.google.com with SMTP id v129so34289416vsb.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQkJfAq6w2vHWXCGY8CJlX7sAf5KrI5hGh5G/DWUbSE=;
        b=nZqEhfFRSm0yhJHGECsERx8km+FW6sLeuBozoNXLRjEwXSQkj/j4YsA+L4+TVOTFy8
         ZMlqrqE8BdCPn5504Lui8tNIIXrqzuoDpXFipkd7MrmCbOJ0EHdsYiBARVFk05UIDxRC
         8dcGpYtkf3xgVrilvgs5mUAIPcS4h6BW0dsqz7woQ3R8UzzN9tylqY9SNtOkMu50tsJp
         MY0920heANbwqrtwpmZofFxHb3Yb4NNcWBMhhETgETdbb7fjjlJH3jAvE3FWUfPniEsO
         EH3oc+RUZL5c63fFpfL48Ex+/Nq7bNPe11l4tZddmkW3aewOmgRpiX2QqRnjJ1eOcpi4
         JnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQkJfAq6w2vHWXCGY8CJlX7sAf5KrI5hGh5G/DWUbSE=;
        b=kENR0wP1Cm51LxEI/hzUd6Au6oD8MYB66NQJpmWapamKucJeUGtqC2fpaj/Zy7JAzW
         A2kob7XJCHN22/cqCwGV0ptUuCAGcEt/qika8qZ/e0MPHifq+2heyWUG/vSGC16djHj3
         VEHSPf0pyT5RlCV7yrL0nA1HRPUAruuM79yXmEEtEvrJIv0YoIMDm6h9kk16oQYt9vAT
         hzneHA/xpdZ+NMkU9gjpk8cQshtT9d6sfr/yrSGIZRFFqExNIog6hOF62CNkgzmWiRJG
         cYhhdZTqPzRn7hujOCdgxZ0AlUipqfvoGYLyXG+MSgAzjKAnYxApI6vPB6Og1aSrMBWW
         b6Gw==
X-Gm-Message-State: APjAAAXD2f79wxjyoju/bg7zfIkKekkEzTh2nMOYEUzqlD/XWx9LZMSO
        5xPNonhadqZthnKuRWHoBl2sEKcHsDmLle0zmjs=
X-Google-Smtp-Source: APXvYqxrHq2+gGn17JuXE8+fJgfmZKHhv5dRuqNmbs504UKMlMZPJgnA5bVtfzJ2LHYPIaZ1PFVLHSc/4HCYmcyyUE4=
X-Received: by 2002:a67:fc19:: with SMTP id o25mr57199329vsq.106.1564078157202;
 Thu, 25 Jul 2019 11:09:17 -0700 (PDT)
MIME-Version: 1.0
References: <CACDBo56EoKca9FJCnbztWZAARdUQs+B=dmCs+UxW27yHNu5pzQ@mail.gmail.com>
 <57f8aa35-d460-9933-a547-fbf578ea42d3@arm.com> <20190716121026.GB2388@lst.de>
In-Reply-To: <20190716121026.GB2388@lst.de>
From:   Pankaj Suryawanshi <pankajssuryawanshi@gmail.com>
Date:   Thu, 25 Jul 2019 23:39:08 +0530
Message-ID: <CACDBo56RWh=kjhEm_eOpzkTuZ+A-VEuCYPnVJW1BYAXrP6LERg@mail.gmail.com>
Subject: Re: cma_remap when using dma_alloc_attr :- DMA_ATTR_NO_KERNEL_MAPPING
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        pankaj.suryawanshi@einfochips.com, minchan@kernel.org,
        minchan.kim@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2019 at 5:40 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Jul 16, 2019 at 01:02:19PM +0100, Robin Murphy wrote:
> >> Lets say 4k video allocation required 300MB cma memory but not required
> >> virtual mapping for all the 300MB, its require only 20MB virtually mapped
> >> at some specific use case/point of video, and unmap virtual mapping after
> >> uses, at that time this functions will be useful, it works like ioremap()
> >> for cma_alloc() using dma apis.
> >
> > Hmm, is there any significant reason that this case couldn't be handled
> > with just get_vm_area() plus dma_mmap_attrs(). I know it's only *intended*
> > for userspace mappings, but since the basic machinery is there...
>
> Because the dma helper really are a black box abstraction.
>
> That being said DMA_ATTR_NO_KERNEL_MAPPING and DMA_ATTR_NON_CONSISTENT
> have been a constant pain in the b**t.  I've been toying with replacing
> them with a dma_alloc_pages or similar abstraction that just returns
> a struct page that is guaranteed to be dma addressable by the passed
> in device.  Then the driver can call dma_map_page / dma_unmap_page /
> dma_sync_* on it at well.  This would replace DMA_ATTR_NON_CONSISTENT
> with a sensible API, and also DMA_ATTR_NO_KERNEL_MAPPING when called
> with PageHighmem, while providing an easy to understand API and
> something that can easily be fed into the various page based APIs
> in the kernel.
>
> That being said until we get arm moved over the common dma direct
> and dma-iommu code, and x86 fully moved over to dma-iommu it just
> seems way too much work to even get it into the various architectures
> that matter, never mind all the fringe IOMMUs.  So for now I've just
> been trying to contain the DMA_ATTR_NON_CONSISTENT and
> DMA_ATTR_NO_KERNEL_MAPPING in fewer places while also killing bogus
> or pointless users of these APIs.


I agree with you Christoph, users want page based api, which is useful
in many scenarios, but
As of now i think we have to move with this type of api which is
useful when dma_alloc (for cma )call with DMA_ATTR_NO_KERNEL_MAPPING,
and mapped again to kernel space, this api is useful mostly for 32-bit
system which has 4GB of limited virtual memory (its very less for
android devices) as we have already dma_mmap_attr() for user space
mapping.
This api is also useful for one who directly want to use cma_alloc()
in their own drivers. For example ion-cma.c.
Please let me know if any recommendation/suggestion/improvement required ?

Regards,
Pankaj
