Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8746C32751
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85B2120B7C
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 11:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfHJLNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 07:13:13 -0400
Received: from verein.lst.de ([213.95.11.211]:33898 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfHJLNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 07:13:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2801368BFE; Sat, 10 Aug 2019 13:13:09 +0200 (CEST)
Date:   Sat, 10 Aug 2019 13:13:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
Subject: Re: [PATCH] nouveau/hmm: map pages after migration
Message-ID: <20190810111308.GB26349@lst.de>
References: <20190807150214.3629-1-rcampbell@nvidia.com> <20190808070701.GC29382@lst.de> <0b96a8d8-86b5-3ce0-db95-669963c1f8a7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b96a8d8-86b5-3ce0-db95-669963c1f8a7@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 02:29:34PM -0700, Ralph Campbell wrote:
>>>   {
>>>   	struct nouveau_fence *fence;
>>>   	unsigned long addr = args->start, nr_dma = 0, i;
>>>     	for (i = 0; addr < args->end; i++) {
>>>   		args->dst[i] = nouveau_dmem_migrate_copy_one(drm, args->vma,
>>> -				addr, args->src[i], &dma_addrs[nr_dma]);
>>> +				args->src[i], &dma_addrs[nr_dma], &pfns[i]);
>>
>> Nit: I find the &pfns[i] way to pass the argument a little weird to read.
>> Why not "pfns + i"?
>
> OK, will do in v2.
> Should I convert to "dma_addrs + nr_dma" too?

I'll fix it up for v3 of the migrate_vma series.  This is a leftover
from passing an args structure.

On something vaguely related to this patch:

You use the NVIF_VMM_PFNMAP_V0_V* defines from nvif/if000c.h, which are
a little odd as we only ever set these bits, but they also don't seem
to appear to be in values that are directly fed to the hardware.

On the other hand mmu/vmm.h defines a set of NVIF_VMM_PFNMAP_V0_*
constants with similar names and identical values, and those are used
in mmu/vmmgp100.c and what appears to finally do the low-level dma
mapping and talking to the hardware.  Are these two sets of constants
supposed to be the same?  Are the actual hardware values or just a
driver internal interface?
