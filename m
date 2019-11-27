Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF45C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D849206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 17:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfK0RJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 12:09:47 -0500
Received: from foss.arm.com ([217.140.110.172]:50416 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbfK0RJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 12:09:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FDB30E;
        Wed, 27 Nov 2019 09:09:46 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 019323F6C4;
        Wed, 27 Nov 2019 09:09:44 -0800 (PST)
Subject: Re: [PATCH 2/2] iommu: dma: Use of_iommu_get_resv_regions()
To:     Thierry Reding <thierry.reding@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190829111407.17191-1-thierry.reding@gmail.com>
 <20190829111407.17191-3-thierry.reding@gmail.com>
 <1caeaaa0-c5aa-b630-6d42-055b26764f40@arm.com> <20190902145245.GC1445@ulmo>
 <20190917175950.wrwiqnh5bp62uy3c@willie-the-truck>
 <20191126172910.GA2669319@ulmo> <20191127141631.GA280099@ulmo>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <864d5afb-72b4-a3ef-9c93-3a8ad4864c56@arm.com>
Date:   Wed, 27 Nov 2019 17:09:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191127141631.GA280099@ulmo>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2019 2:16 pm, Thierry Reding wrote:
[...]
> Nevermind that, I figured out that I was missingthe initialization of
> some of the S2CR variables. I've got something that I think is working
> now, though I don't know yet how to go about cleaning up the initial
> mapping and "recycling" it.
> 
> I'll clean things up a bit, run some more tests and post a new patch
> that can serve as a basis for discussion.

I'm a little puzzled by the smmu->identity domain - disregarding the 
fact that it's not actually used by the given diff ;) - if isolation is 
the reason for not simply using a bypass S2CR for the window between 
reset and the relevant .add_device call where the default domain proper 
comes in[1], then surely exposing the union of memory regions to the 
union of all associated devices isn't all that desirable either.

Either way, I'll give you the pre-emptive warning that this is the SMMU 
in the way of my EFI framebuffer ;)

...
arm-smmu 7fb20000.iommu: 	1 context banks (1 stage-2 only)
...

Robin.

[1] the fact that it currently depends on probe order whether getting 
that .add_device call requires a driver probing for the device is an 
error as discussed elsewhere, and will get fixed separately, I promise.
