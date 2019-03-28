Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110FDC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:25:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18F82184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:25:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UZI18uN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbfC1WZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:25:41 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:15473 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727906AbfC1WZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:25:41 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d49e20002>; Thu, 28 Mar 2019 15:25:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 15:25:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 28 Mar 2019 15:25:40 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 22:25:40 +0000
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-11-jglisse@redhat.com>
 <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
 <20190328213047.GB13560@redhat.com>
 <a16efd42-3e2b-1b72-c205-0c2659de2750@nvidia.com>
 <20190328220824.GE13560@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
Date:   Thu, 28 Mar 2019 15:25:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328220824.GE13560@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553811938; bh=tmWuerb4oqQAkXRnvtt8BJOgEyPuSCQS0SzrfMmcP4A=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UZI18uN8FzlrqInNtTFT5AGFZiqb1Pc73eHhprR5NNhrgtl6h4qkQN80QPNG1lG0n
         PVnwjztlHOxwP/AVoOZD+l6nd5oK5Jui8up9gYG0u5eXOSS7mhDTeDjBH2gu8ELBOc
         jLr28l+wi6mUlYgSwGfSfaDUq2qnW6OZ8NY+ahefZcCkZJJYFa9ddmv1Yi7KkApOMq
         1aUvQmcqW9tyMa980vhvthyc+j/XzYJgFcjmr4LT/au2qYq1Suqs58WtYBll2gU1tn
         1vynV9j+mB1KLLVp3lDdQ1Qn+LNzNiUQzqInrEruSu6A3vOawyWTOwtJdkFC4Tm7Ps
         BmYLOA4nLehgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 3:08 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 02:41:02PM -0700, John Hubbard wrote:
>> On 3/28/19 2:30 PM, Jerome Glisse wrote:
>>> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
[...]
>>
>>>>
>>>> If you insist on having this wrapper, I think it should have approxima=
tely=20
>>>> this form:
>>>>
>>>> void hmm_mirror_mm_down_read(...)
>>>> {
>>>> 	WARN_ON(...)
>>>> 	down_read(...)
>>>> }=20
>>>
>>> I do insist as it is useful and use by both RDMA and nouveau and the
>>> above would kill the intent. The intent is do not try to take the lock
>>> if the process is dying.
>>
>> Could you provide me a link to those examples so I can take a peek? I
>> am still convinced that this whole thing is a race condition at best.
>=20
> The race is fine and ok see:
>=20
> https://cgit.freedesktop.org/~glisse/linux/commit/?h=3Dhmm-odp-v2&id=3Dee=
bd4f3095290a16ebc03182e2d3ab5dfa7b05ec
>=20
> which has been posted and i think i provided a link in the cover
> letter to that post. The same patch exist for nouveau i need to
> cleanup that tree and push it.

Thanks for that link, and I apologize for not keeping up with that
other review thread.

Looking it over, hmm_mirror_mm_down_read() is only used in one place.
So, what you really want there is not a down_read() wrapper, but rather,
something like

	hmm_sanity_check()

, that ib_umem_odp_map_dma_pages() calls.


>=20
>>>
>>>
>>>>
>>>>> +{
>>>>> +	struct mm_struct *mm;
>>>>> +
>>>>> +	/* Sanity check ... */
>>>>> +	if (!mirror || !mirror->hmm)
>>>>> +		return -EINVAL;
>>>>> +	/*
>>>>> +	 * Before trying to take the mmap_sem make sure the mm is still
>>>>> +	 * alive as device driver context might outlive the mm lifetime.
>>>>
>>>> Let's find another way, and a better place, to solve this problem.
>>>> Ref counting?
>>>
>>> This has nothing to do with refcount or use after free or anthing
>>> like that. It is just about checking wether we are about to do
>>> something pointless. If the process is dying then it is pointless
>>> to try to take the lock and it is pointless for the device driver
>>> to trigger handle_mm_fault().
>>
>> Well, what happens if you let such pointless code run anyway?=20
>> Does everything still work? If yes, then we don't need this change.
>> If no, then we need a race-free version of this change.
>=20
> Yes everything work, nothing bad can happen from a race, it will just
> do useless work which never hurt anyone.
>=20

OK, so let's either drop this patch, or if merge windows won't allow that,
then *eventually* drop this patch. And instead, put in a hmm_sanity_check()
that does the same checks.


thanks,
--=20
John Hubbard
NVIDIA
