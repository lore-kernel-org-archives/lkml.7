Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BBC28EB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DE9208E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 21:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YMIH7Umh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbfFFVIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 17:08:17 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19743 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbfFFVIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 17:08:17 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cf980b00000>; Thu, 06 Jun 2019 14:08:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Jun 2019 14:08:15 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Jun 2019 14:08:15 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Jun
 2019 21:08:15 +0000
Subject: Re: [PATCH 4/5] mm/hmm: hmm_vma_fault() doesn't always call
 hmm_range_unregister()
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Philip Yang <Philip.Yang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, John Hubbard <jhubbard@nvidia.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
References: <20190506232942.12623-1-rcampbell@nvidia.com>
 <20190506232942.12623-5-rcampbell@nvidia.com>
 <20190606145018.GA3658@ziepe.ca>
 <45c7f8ae-36b2-60cc-7d1d-d13ddd402d4b@nvidia.com>
 <20190606195404.GJ17373@ziepe.ca>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <716383df-9985-03b4-bd0c-93de87bffa90@nvidia.com>
Date:   Thu, 6 Jun 2019 14:08:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190606195404.GJ17373@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1559855280; bh=Y4XntF7b7G4DQ81sR0y/Jn2xedJWjLJRstkFUo/OuT8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=YMIH7Umhi4BIMhgVQhYRmUeQw1+kXYUpAhobvb7PiW1Vf+rDjc0Hn9H3i5vjlY58R
         Ki+k06AVcac5VD5x4cnYgL6j4SSyhmQqpp7FmMoBYSBdHn1utQ8MWkrdRYI4L5qWf2
         CsX6cpb+rH3mzDRwHkEPm8MqtFvTDP3V7TjDq54dSuVRPQ0YIRMIGmAioXkwEnMSKY
         TYHX1WxoxUPWQx1T/Xog6YC/Y4acWP0UuaeT68p1n3EFgjEIl9gREBcBvj4dI6wj0L
         5WNge292oaRHVcYfEP9Jl1UAbp69ACRJKuVUQfYbkY5SV99iyL9EXbwtFHPWupfdnO
         KQ25V6EZu+cJg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/6/19 12:54 PM, Jason Gunthorpe wrote:
> On Thu, Jun 06, 2019 at 12:44:36PM -0700, Ralph Campbell wrote:
>>
>> On 6/6/19 7:50 AM, Jason Gunthorpe wrote:
>>> On Mon, May 06, 2019 at 04:29:41PM -0700, rcampbell@nvidia.com wrote:
>>>> From: Ralph Campbell <rcampbell@nvidia.com>
>>>>
>>>> The helper function hmm_vma_fault() calls hmm_range_register() but is
>>>> missing a call to hmm_range_unregister() in one of the error paths.
>>>> This leads to a reference count leak and ultimately a memory leak on
>>>> struct hmm.
>>>>
>>>> Always call hmm_range_unregister() if hmm_range_register() succeeded.
>>>>
>>>> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
>>>> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>>> Cc: Balbir Singh <bsingharora@gmail.com>
>>>> Cc: Dan Carpenter <dan.carpenter@oracle.com>
>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>    include/linux/hmm.h | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>>>> index 35a429621e1e..fa0671d67269 100644
>>>> +++ b/include/linux/hmm.h
>>>> @@ -559,6 +559,7 @@ static inline int hmm_vma_fault(struct hmm_range *=
range, bool block)
>>>>    		return (int)ret;
>>>>    	if (!hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT))=
 {
>>>> +		hmm_range_unregister(range);
>>>>    		/*
>>>>    		 * The mmap_sem was taken by driver we release it here and
>>>>    		 * returns -EAGAIN which correspond to mmap_sem have been
>>>> @@ -570,13 +571,13 @@ static inline int hmm_vma_fault(struct hmm_range=
 *range, bool block)
>>>>    	ret =3D hmm_range_fault(range, block);
>>>>    	if (ret <=3D 0) {
>>>> +		hmm_range_unregister(range);
>>>
>>> While this seems to be a clear improvement, it seems there is still a
>>> bug in nouveau_svm.c around here as I see it calls hmm_vma_fault() but
>>> never calls hmm_range_unregister() for its on stack range - and
>>> hmm_vma_fault() still returns with the range registered.
>>>
>>> As hmm_vma_fault() is only used by nouveau and is marked as
>>> deprecated, I think we need to fix nouveau, either by dropping
>>> hmm_range_fault(), or by adding the missing unregister to nouveau in
>>> this patch.
>>
>> I will send a patch for nouveau to use hmm_range_register() and
>> hmm_range_fault() and do some testing with OpenCL.
>=20
> wow, thanks, I'd like to also really like to send such a thing through
> hmm.git - do you know who the nouveau maintainers are so we can
> collaborate on patch planning this?

Ben Skeggs <bskeggs@redhat.com> is the maintainer and
nouveau@lists.freedesktop.org is the mailing list for changes.
I'll be sure to CC them for the patch.

>> I can also send a separate patch to then remove hmm_vma_fault()
>> but I guess that should be after AMD's changes.
>=20
> Let us wait to hear back from AMD how they can consume hmm.git - I'd
> very much like to get everything done in one kernel cycle!
>=20
> Regards,
> Jason
>=20
