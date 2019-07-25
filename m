Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F9AC76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D90E22BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="DhAx15tD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbfGYRx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:53:59 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8008 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729911AbfGYRxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:53:55 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d39ecb00000>; Thu, 25 Jul 2019 10:53:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 25 Jul 2019 10:53:54 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 25 Jul 2019 10:53:54 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 25 Jul
 2019 17:53:54 +0000
Subject: Re: [PATCH] mm/hmm: replace hmm_update with mmu_notifier_range
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Ben Skeggs <bskeggs@redhat.com>
References: <20190723210506.25127-1-rcampbell@nvidia.com>
 <20190725011424.GA377@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <e101947a-da37-2a9f-c673-fe0a54965e18@nvidia.com>
Date:   Thu, 25 Jul 2019 10:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190725011424.GA377@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1564077232; bh=C/3jo0jsE8wFgw2iplq9k3+bvhgHMroF2GYfUpuZsE0=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=DhAx15tDao86fNlJyG41mGVLdRS4/AWdLS624zZoNmWkk3D7BjMR5xCzjLZBoVLLx
         afryURRZB/swcEevPYzWOT4IVLi5ZgHxsDCQxxQZNU6w1WG01nZ+jnybjiYlec0vWp
         K6uyYQSPu7IuTdfmgboDdwx9/ORVCRuDPSJ/c/qeHQ3cU5SCDV+AE/nkHy+jt4ovLk
         pQSLsmpMP9fnSGq/ZjIzvO2xYXfrRtfQD5SL0e1xKeJ9tGrj4h282I5a4ENoccpPue
         GlSEJMxOnjXGYBZawJUxgLm5FITum1dRyJQiJGTyd/6mJ251nH2dme/+hCCQk3hiuA
         UmXZ1fHXQ2LkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/24/19 6:14 PM, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2019 at 02:05:06PM -0700, Ralph Campbell wrote:
>> The hmm_mirror_ops callback function sync_cpu_device_pagetables() passes
>> a struct hmm_update which is a simplified version of struct
>> mmu_notifier_range. This is unnecessary so replace hmm_update with
>> mmu_notifier_range directly.
>>
>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
>> Cc: Jason Gunthorpe <jgg@mellanox.com>
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Ben Skeggs <bskeggs@redhat.com>
>>
>> This is based on 5.3.0-rc1 plus Christoph Hellwig's 6 patches
>> ("hmm_range_fault related fixes and legacy API removal v2").
>> Jason, I believe this is the patch you were requesting.
>=20
> Doesn't this need revision to include amgpu?
>=20
> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:         .sync_cpu_device_pagetabl=
es =3D amdgpu_mn_sync_pagetables_gfx,
> drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c:         .sync_cpu_device_pagetabl=
es =3D amdgpu_mn_sync_pagetables_hsa,
>=20
> Thanks,
> Jason
>=20

Yes. I have added this to v2 which I'll send out with Christoph's 2=20
patches and the hmm_range.vma removal patch you suggested.
