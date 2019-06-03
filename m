Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC773C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1EF6207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mVkn8qHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfFCTsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 15:48:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8114 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfFCTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 15:48:03 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf579710000>; Mon, 03 Jun 2019 12:48:01 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 03 Jun 2019 12:48:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 03 Jun 2019 12:48:02 -0700
Received: from [10.26.11.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 3 Jun
 2019 19:47:59 +0000
Subject: Re: [PATCH 07/26] iommu/dma: move the arm64 wrappers to common code
To:     Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>
CC:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-8-hch@lst.de>
 <06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <acb46c7f-0855-de30-485f-a6242968f947@nvidia.com>
Date:   Mon, 3 Jun 2019 20:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <06b331f0-7df7-a6cd-954c-789f89a0836d@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559591281; bh=RMxapgyeEuOTQ8bInOu5Fbjyth09Qz8mwr+ogzgFnH8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mVkn8qHn4oghIo8cKZJkJcmq0wsglM5sp4kJ+xEF9zxvkcO3EetQgf2WDxh88dKjl
         WU1kgDYR/RidtsSNfnah+urlkR+Aos1fbomRJh6Mppj0JQQvyIivYS5V6fRQJohR0L
         3BANrGnTtJhH+HsC14T2ZHd6w6ZJtQMfzzOPCu3UOfCCJvUHBxlBeVRcxyTcmiFwqk
         JUR6R9NsmkaIo7NwILxJWuVb0kwVn28ZNBRL28dX8Tmsmorji8+p9XEtvX/entSiKW
         QlKhjgG5mx2vvbBDIHNrTzsMbbV5vRMD3GixETL4yf3Ev9Z+ZL6g8+QFpf4nVKcf9X
         S9Y166LHlYo4Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/04/2019 13:56, Robin Murphy wrote:
> On 22/04/2019 18:59, Christoph Hellwig wrote:
>> There is nothing really arm64 specific in the iommu_dma_ops
>> implementation, so move it to dma-iommu.c and keep a lot of symbols
>> self-contained.=C2=A0 Note the implementation does depend on the
>> DMA_DIRECT_REMAP infrastructure for now, so we'll have to make the
>> DMA_IOMMU support depend on it, but this will be relaxed soon.
>=20
> Nothing looks objectionable, and boot testing with this much of the
> series merged has my coherent and non-coherent IOMMU-backed devices
> appearing to still work OK, so:
>=20
> Acked-by: Robin Murphy <robin.murphy@arm.com>

Since next-20190529 one of our tests for MMC has started failing, where
the symptom is that the data written to the MMC does not match the
source. Bisecting this is pointing to this commit. Unfortunately, I am
not able to cleanly revert this on top of -next, but wanted to report
this if case you have any ideas.

Cheers
Jon

--=20
nvpublic
