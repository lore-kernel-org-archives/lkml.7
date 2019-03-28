Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F39C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D41F2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 22:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="M5UHoEjg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbfC1Wkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 18:40:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16050 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfC1Wkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 18:40:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d4d690000>; Thu, 28 Mar 2019 15:40:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 15:40:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 15:40:44 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 22:40:42 +0000
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
To:     Jerome Glisse <jglisse@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-8-jglisse@redhat.com>
 <2f790427-ea87-b41e-b386-820ccdb7dd38@nvidia.com>
 <20190328221203.GF13560@redhat.com>
 <555ad864-d1f9-f513-9666-0d3d05dbb85d@nvidia.com>
 <20190328223153.GG13560@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <768f56f5-8019-06df-2c5a-b4187deaac59@nvidia.com>
Date:   Thu, 28 Mar 2019 15:40:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328223153.GG13560@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553812842; bh=OfUK1aEAY6Zsl63UJUEUMpkH+P62LWdbOYog0WT8rz4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=M5UHoEjg/pye8s/V9BWWTr2SPNaB4/v7N0AgemPbujCD1AtnpUEl8SGpHHF2a1mwD
         PrsbQRvTCMc36QgfskTOSOkCLtJGzv7FKtcJLpcJItFg3qXDBug/4g5RVJLyfiDk+M
         d4rN0QGvmDgJ+6UNqgsNavS83Jk4AXgUatCETkGMN9i2aZL0+etcuJ7K2mlW1BbapK
         MUM68sgzd4jVhRop9knpusl2eXTBwVEc1EaGODI/fA4JkqmiYmQZQ+oxWu/R9vCESG
         DOkphyrEySgLcm8pKg1Lr8gNOxyfTQVIYFa3LD1fp+HZ4GoRpN8VRpM/Gxy9XP1QHn
         a6nExVPulspbw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 3:31 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 03:19:06PM -0700, John Hubbard wrote:
>> On 3/28/19 3:12 PM, Jerome Glisse wrote:
>>> On Thu, Mar 28, 2019 at 02:59:50PM -0700, John Hubbard wrote:
>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>>>
>>>>> The HMM mirror API can be use in two fashions. The first one where th=
e HMM
>>>>> user coalesce multiple page faults into one request and set flags per=
 pfns
>>>>> for of those faults. The second one where the HMM user want to pre-fa=
ult a
>>>>> range with specific flags. For the latter one it is a waste to have t=
he user
>>>>> pre-fill the pfn arrays with a default flags value.
>>>>>
>>>>> This patch adds a default flags value allowing user to set them for a=
 range
>>>>> without having to pre-fill the pfn array.
>>>>>
>>>>> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>>> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
>>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>>>> ---
>>>>>  include/linux/hmm.h |  7 +++++++
>>>>>  mm/hmm.c            | 12 ++++++++++++
>>>>>  2 files changed, 19 insertions(+)
>>>>>
>>>>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>>>>> index 79671036cb5f..13bc2c72f791 100644
>>>>> --- a/include/linux/hmm.h
>>>>> +++ b/include/linux/hmm.h
>>>>> @@ -165,6 +165,8 @@ enum hmm_pfn_value_e {
>>>>>   * @pfns: array of pfns (big enough for the range)
>>>>>   * @flags: pfn flags to match device driver page table
>>>>>   * @values: pfn value for some special case (none, special, error, .=
..)
>>>>> + * @default_flags: default flags for the range (write, read, ...)
>>>>> + * @pfn_flags_mask: allows to mask pfn flags so that only default_fl=
ags matter
>>>>>   * @pfn_shifts: pfn shift value (should be <=3D PAGE_SHIFT)
>>>>>   * @valid: pfns array did not change since it has been fill by an HM=
M function
>>>>>   */
>>>>> @@ -177,6 +179,8 @@ struct hmm_range {
>>>>>  	uint64_t		*pfns;
>>>>>  	const uint64_t		*flags;
>>>>>  	const uint64_t		*values;
>>>>> +	uint64_t		default_flags;
>>>>> +	uint64_t		pfn_flags_mask;
>>>>>  	uint8_t			pfn_shift;
>>>>>  	bool			valid;
>>>>>  };
>>>>> @@ -521,6 +525,9 @@ static inline int hmm_vma_fault(struct hmm_range =
*range, bool block)
>>>>>  {
>>>>>  	long ret;
>>>>> =20
>>>>> +	range->default_flags =3D 0;
>>>>> +	range->pfn_flags_mask =3D -1UL;
>>>>
>>>> Hi Jerome,
>>>>
>>>> This is nice to have. Let's constrain it a little bit more, though: th=
e pfn_flags_mask
>>>> definitely does not need to be a run time value. And we want some assu=
rance that
>>>> the mask is=20
>>>> 	a) large enough for the flags, and
>>>> 	b) small enough to avoid overrunning the pfns field.
>>>>
>>>> Those are less certain with a run-time struct field, and more obviousl=
y correct with
>>>> something like, approximately:
>>>>
>>>>  	#define PFN_FLAGS_MASK 0xFFFF
>>>>
>>>> or something.
>>>>
>>>> In other words, this is more flexibility than we need--just a touch to=
o much,
>>>> IMHO.
>>>
>>> This mirror the fact that flags are provided as an array and some devic=
es use
>>> the top bits for flags (read, write, ...). So here it is the safe defau=
lt to
>>> set it to -1. If the caller want to leverage this optimization it can o=
verride
>>> the default_flags value.
>>>
>>
>> Optimization? OK, now I'm a bit lost. Maybe this is another place where =
I could
>> use a peek at the calling code. The only flags I've seen so far use the =
bottom
>> 3 bits and that's it.=20
>>
>> Maybe comments here?
>>
>>>>
>>>>> +
>>>>>  	ret =3D hmm_range_register(range, range->vma->vm_mm,
>>>>>  				 range->start, range->end);
>>>>>  	if (ret)
>>>>> diff --git a/mm/hmm.c b/mm/hmm.c
>>>>> index fa9498eeb9b6..4fe88a196d17 100644
>>>>> --- a/mm/hmm.c
>>>>> +++ b/mm/hmm.c
>>>>> @@ -415,6 +415,18 @@ static inline void hmm_pte_need_fault(const stru=
ct hmm_vma_walk *hmm_vma_walk,
>>>>>  	if (!hmm_vma_walk->fault)
>>>>>  		return;
>>>>> =20
>>>>> +	/*
>>>>> +	 * So we not only consider the individual per page request we also
>>>>> +	 * consider the default flags requested for the range. The API can
>>>>> +	 * be use in 2 fashions. The first one where the HMM user coalesce
>>>>> +	 * multiple page fault into one request and set flags per pfns for
>>>>> +	 * of those faults. The second one where the HMM user want to pre-
>>>>> +	 * fault a range with specific flags. For the latter one it is a
>>>>> +	 * waste to have the user pre-fill the pfn arrays with a default
>>>>> +	 * flags value.
>>>>> +	 */
>>>>> +	pfns =3D (pfns & range->pfn_flags_mask) | range->default_flags;
>>>>
>>>> Need to verify that the mask isn't too large or too small.
>>>
>>> I need to check agin but default flag is anded somewhere to limit
>>> the bit to the one we expect.
>>
>> Right, but in general, the *mask* could be wrong. It would be nice to ha=
ve
>> an assert, and/or a comment, or something to verify the mask is proper.
>>
>> Really, a hardcoded mask is simple and correct--unless it *definitely* m=
ust
>> vary for devices of course.
>=20
> Ok so re-read the code and it is correct. The helper for compatibility wi=
th
> old API (so that i do not break nouveau upstream code) initialize those t=
o
> the safe default ie:
>=20
> range->default_flags =3D 0;
> range->pfn_flags_mask =3D -1;
>=20
> Which means that in the above comment we are in the case where it is the
> individual entry within the pfn array that will determine if we fault or
> not.
>=20
> Driver using the new API can either use this safe default or use the
> second case in the above comment and set default_flags to something
> else than 0.
>=20
> Note that those default_flags are not set in the final result they are
> use to determine if we need to do a page fault. For instance if you set
> the write bit in the default flags then the pfns computed above will
> have the write bit set and when we compare with the CPU pte if the CPU
> pte do not have the write bit set then we will fault. What matter is
> that in this case the value within the pfns array is totaly pointless
> ie we do not care what it is, it will not affect the decission ie the
> decision is made by looking at the default flags.
>=20
> Hope this clarify thing. You can look at the ODP patch to see how it
> is use:
>=20
> https://cgit.freedesktop.org/~glisse/linux/commit/?h=3Dhmm-odp-v2&id=3Dee=
bd4f3095290a16ebc03182e2d3ab5dfa7b05ec
>=20

Hi Jerome,

I think you're talking about flags, but I'm talking about the mask. The=20
above link doesn't appear to use the pfn_flags_mask, and the default_flags=
=20
that it uses are still in the same lower 3 bits:

+static uint64_t odp_hmm_flags[HMM_PFN_FLAG_MAX] =3D {
+	ODP_READ_BIT,	/* HMM_PFN_VALID */
+	ODP_WRITE_BIT,	/* HMM_PFN_WRITE */
+	ODP_DEVICE_BIT,	/* HMM_PFN_DEVICE_PRIVATE */
+};

So I still don't see why we need the flexibility of a full 0xFFFFFFFFFFFFFF=
FF
mask, that is *also* runtime changeable.=20

thanks,
--=20
John Hubbard
NVIDIAr
