Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57C1C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD862184E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 21:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hsLB4gq0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbfC1VlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 17:41:05 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:6712 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbfC1VlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 17:41:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d3f680002>; Thu, 28 Mar 2019 14:40:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 14:41:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 14:41:02 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 21:41:02 +0000
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
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <a16efd42-3e2b-1b72-c205-0c2659de2750@nvidia.com>
Date:   Thu, 28 Mar 2019 14:41:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328213047.GB13560@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553809256; bh=i0yznMUZ3/E1QrRkk2+BDp44MTpSzcLV2/NZJ7ipR8Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hsLB4gq0cl32Xmjnr15hA+tqHT/Wm6mRjsQHjiYXOxb3EDWzhHb2doD30UpNQybfY
         mB4tQoX1AXWvQ5HPFUJRIchUWzThGP7EGYyFQMfgbFXZEsMPPzHYNNUuAEruEYAATZ
         Lx1tSjutTd930HwXjaKfkA6+RaQCjKkoNR/W+VNmHKa9OZN7vjgBCelyu04RN+TuE2
         CH/WaP2gqDl6BJg18YbrQZDC/VCdKl64fJ+TEtVyDmK9eMd40yueJ92m8BK46Mtm7i
         1bvhyC5cS2dd7jFW5U7miBWcM+ZuAHGV2IIHcxw8nAdImfwI3AWyKyVWMdGYKUhyf9
         rKvF/tjoIl6NA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 2:30 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>
>>> The device driver context which holds reference to mirror and thus to
>>> core hmm struct might outlive the mm against which it was created. To
>>> avoid every driver to check for that case provide an helper that check
>>> if mm is still alive and take the mmap_sem in read mode if so. If the
>>> mm have been destroy (mmu_notifier release call back did happen) then
>>> we return -EINVAL so that calling code knows that it is trying to do
>>> something against a mm that is no longer valid.
>>>
>>> Changes since v1:
>>>     - removed bunch of useless check (if API is use with bogus argument
>>>       better to fail loudly so user fix their code)
>>>
>>> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: John Hubbard <jhubbard@nvidia.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>  include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 47 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
>>> index f3b919b04eda..5f9deaeb9d77 100644
>>> --- a/include/linux/hmm.h
>>> +++ b/include/linux/hmm.h
>>> @@ -438,6 +438,50 @@ struct hmm_mirror {
>>>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *m=
m);
>>>  void hmm_mirror_unregister(struct hmm_mirror *mirror);
>>> =20
>>> +/*
>>> + * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
>>> + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
>>> + * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
>>> + *
>>> + * The device driver context which holds reference to mirror and thus =
to core
>>> + * hmm struct might outlive the mm against which it was created. To av=
oid every
>>> + * driver to check for that case provide an helper that check if mm is=
 still
>>> + * alive and take the mmap_sem in read mode if so. If the mm have been=
 destroy
>>> + * (mmu_notifier release call back did happen) then we return -EINVAL =
so that
>>> + * calling code knows that it is trying to do something against a mm t=
hat is
>>> + * no longer valid.
>>> + */
>>> +static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)
>>
>> Hi Jerome,
>>
>> Let's please not do this. There are at least two problems here:
>>
>> 1. The hmm_mirror_mm_down_read() wrapper around down_read() requires a=20
>> return value. This is counter to how locking is normally done: callers d=
o
>> not normally have to check the return value of most locks (other than
>> trylocks). And sure enough, your own code below doesn't check the return=
 value.
>> That is a pretty good illustration of why not to do this.
>=20
> Please read the function description this is not about checking lock
> return value it is about checking wether we are racing with process
> destruction and avoid trying to take lock in such cases so that driver
> do abort as quickly as possible when a process is being kill.
>=20
>>
>> 2. This is a weird place to randomly check for semi-unrelated state, suc=
h=20
>> as "is HMM still alive". By that I mean, if you have to detect a problem
>> at down_read() time, then the problem could have existed both before and
>> after the call to this wrapper. So it is providing a false sense of secu=
rity,
>> and it is therefore actually undesirable to add the code.
>=20
> It is not, this function is use in device page fault handler which will
> happens asynchronously from CPU event or process lifetime when a process
> is killed or is dying we do want to avoid useless page fault work and
> we do want to avoid blocking the page fault queue of the device. This
> function reports to the caller that the process is dying and that it
> should just abort the page fault and do whatever other device specific
> thing that needs to happen.
>=20

But it's inherently racy, to check for a condition outside of any lock, so =
again,
it's a false sense of security.

>>
>> If you insist on having this wrapper, I think it should have approximate=
ly=20
>> this form:
>>
>> void hmm_mirror_mm_down_read(...)
>> {
>> 	WARN_ON(...)
>> 	down_read(...)
>> }=20
>=20
> I do insist as it is useful and use by both RDMA and nouveau and the
> above would kill the intent. The intent is do not try to take the lock
> if the process is dying.

Could you provide me a link to those examples so I can take a peek? I
am still convinced that this whole thing is a race condition at best.

>=20
>=20
>>
>>> +{
>>> +	struct mm_struct *mm;
>>> +
>>> +	/* Sanity check ... */
>>> +	if (!mirror || !mirror->hmm)
>>> +		return -EINVAL;
>>> +	/*
>>> +	 * Before trying to take the mmap_sem make sure the mm is still
>>> +	 * alive as device driver context might outlive the mm lifetime.
>>
>> Let's find another way, and a better place, to solve this problem.
>> Ref counting?
>=20
> This has nothing to do with refcount or use after free or anthing
> like that. It is just about checking wether we are about to do
> something pointless. If the process is dying then it is pointless
> to try to take the lock and it is pointless for the device driver
> to trigger handle_mm_fault().

Well, what happens if you let such pointless code run anyway?=20
Does everything still work? If yes, then we don't need this change.
If no, then we need a race-free version of this change.

thanks,
--=20
John Hubbard
NVIDIA
