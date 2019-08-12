Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B808BC31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7203420663
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 19:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="AejkOoxo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfHLTme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 15:42:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8775 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLTmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 15:42:33 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d51c1340002>; Mon, 12 Aug 2019 12:42:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 12:42:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 12 Aug 2019 12:42:33 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 19:42:30 +0000
Subject: Re: [PATCH] nouveau/hmm: map pages after migration
To:     Christoph Hellwig <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <nouveau@lists.freedesktop.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>
References: <20190807150214.3629-1-rcampbell@nvidia.com>
 <20190808070701.GC29382@lst.de>
 <0b96a8d8-86b5-3ce0-db95-669963c1f8a7@nvidia.com>
 <20190810111308.GB26349@lst.de>
From:   Ralph Campbell <rcampbell@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1a84e6b6-31e6-6955-509f-9883f4a7a322@nvidia.com>
Date:   Mon, 12 Aug 2019 12:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190810111308.GB26349@lst.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565638964; bh=OU8IJv/lYjVdyGsKoyblYg4ib4y7MVh+DIjHamncxq8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=AejkOoxomaGMhLpZ3pIIkspkKl7sO550hrdwKO5/NA8faapWC8ktyg1xgZmGlUyIT
         E8+aD/Eyq4DXtfObw2wb1IDfF5rGaB9SY6L/edDp+qrtiD/VZn2zqviiDYtoL2w5RT
         G2oreIveRctBxGW5KoLgroNOd1BXtk46jBCX4G5NkjDRbfvrDjsc6GOcIcGt2oLG0z
         UngAn/Ys1zlFjY6Xwh+/SSpg1UNR5ybYE1cK2qp/6NKJvinEEPJHRCwvguTZlofaqS
         Pfo7VmGAYM9odOp4MO2GNNvVxTKI+kTKn1BcDsQmcysGiShtWpFpnDFVSIWPomC38i
         YRYBbJfX49njg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/10/19 4:13 AM, Christoph Hellwig wrote:
> On something vaguely related to this patch:
> 
> You use the NVIF_VMM_PFNMAP_V0_V* defines from nvif/if000c.h, which are
> a little odd as we only ever set these bits, but they also don't seem
> to appear to be in values that are directly fed to the hardware.
> 
> On the other hand mmu/vmm.h defines a set of NVIF_VMM_PFNMAP_V0_*

Yes, I see NVKM_VMM_PFN_*

> constants with similar names and identical values, and those are used
> in mmu/vmmgp100.c and what appears to finally do the low-level dma
> mapping and talking to the hardware.  Are these two sets of constants
> supposed to be the same?  Are the actual hardware values or just a
> driver internal interface?

It looks a bit odd to me too.
I don't really know the structure/history of nouveau.
Perhaps Ben Skeggs can shed more light on your question.
