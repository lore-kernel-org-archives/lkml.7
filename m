Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAABBC10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A9BC2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 20:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="BFuqPlz2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfC1UyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 16:54:05 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:18847 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727521AbfC1UyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 16:54:04 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d346d0001>; Thu, 28 Mar 2019 13:54:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 13:54:02 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 13:54:02 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 20:54:02 +0000
Subject: Re: [PATCH v2 10/11] mm/hmm: add helpers for driver to safely take
 the mmap_sem v2
To:     <jglisse@redhat.com>, <linux-mm@kvack.org>
CC:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-11-jglisse@redhat.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9df742eb-61ca-3629-a5f4-8ad1244ff840@nvidia.com>
Date:   Thu, 28 Mar 2019 13:54:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325144011.10560-11-jglisse@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553806446; bh=66ATySaHlVECGh1E7+UM9QuEPXamIu3gtSuhG9bf+E8=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=BFuqPlz2E3sxwSyIDD9EWu/eD+fvDokJzqkj9BM3Dd7891jCCptci248hOcEuLhLf
         Ozn4DDhBLtg2swX3xez9IbLAnDq3F0fVZTwvNL4Tvvuhid1Rburr1dU3p30nMktUSS
         e4H3lB4yQQ7tPrT3S1TtKHIiQyzrsFB0KvE6IUzBhJY368xVGl4oNlLpNaj3BhMw9R
         NJkiGuKFLft21ll+xlAYtB5J8L/IrbUX+G5YBVMDf0Yd+BST/uebj9PZSVlarH+s1Y
         SGR8bxM1Fq2m+OZi/SSHg99kBM+UnoXv6F4STZN8cDbq/cDcw2LZpkxo+N+ZXRFjB8
         2iquhi8a6waBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>=20
> The device driver context which holds reference to mirror and thus to
> core hmm struct might outlive the mm against which it was created. To
> avoid every driver to check for that case provide an helper that check
> if mm is still alive and take the mmap_sem in read mode if so. If the
> mm have been destroy (mmu_notifier release call back did happen) then
> we return -EINVAL so that calling code knows that it is trying to do
> something against a mm that is no longer valid.
>=20
> Changes since v1:
>     - removed bunch of useless check (if API is use with bogus argument
>       better to fail loudly so user fix their code)
>=20
> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
> Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/hmm.h | 50 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> index f3b919b04eda..5f9deaeb9d77 100644
> --- a/include/linux/hmm.h
> +++ b/include/linux/hmm.h
> @@ -438,6 +438,50 @@ struct hmm_mirror {
>  int hmm_mirror_register(struct hmm_mirror *mirror, struct mm_struct *mm)=
;
>  void hmm_mirror_unregister(struct hmm_mirror *mirror);
> =20
> +/*
> + * hmm_mirror_mm_down_read() - lock the mmap_sem in read mode
> + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> + * Returns: -EINVAL if the mm is dead, 0 otherwise (lock taken).
> + *
> + * The device driver context which holds reference to mirror and thus to=
 core
> + * hmm struct might outlive the mm against which it was created. To avoi=
d every
> + * driver to check for that case provide an helper that check if mm is s=
till
> + * alive and take the mmap_sem in read mode if so. If the mm have been d=
estroy
> + * (mmu_notifier release call back did happen) then we return -EINVAL so=
 that
> + * calling code knows that it is trying to do something against a mm tha=
t is
> + * no longer valid.
> + */
> +static inline int hmm_mirror_mm_down_read(struct hmm_mirror *mirror)

Hi Jerome,

Let's please not do this. There are at least two problems here:

1. The hmm_mirror_mm_down_read() wrapper around down_read() requires a=20
return value. This is counter to how locking is normally done: callers do
not normally have to check the return value of most locks (other than
trylocks). And sure enough, your own code below doesn't check the return va=
lue.
That is a pretty good illustration of why not to do this.

2. This is a weird place to randomly check for semi-unrelated state, such=20
as "is HMM still alive". By that I mean, if you have to detect a problem
at down_read() time, then the problem could have existed both before and
after the call to this wrapper. So it is providing a false sense of securit=
y,
and it is therefore actually undesirable to add the code.

If you insist on having this wrapper, I think it should have approximately=
=20
this form:

void hmm_mirror_mm_down_read(...)
{
	WARN_ON(...)
	down_read(...)
}=20

> +{
> +	struct mm_struct *mm;
> +
> +	/* Sanity check ... */
> +	if (!mirror || !mirror->hmm)
> +		return -EINVAL;
> +	/*
> +	 * Before trying to take the mmap_sem make sure the mm is still
> +	 * alive as device driver context might outlive the mm lifetime.

Let's find another way, and a better place, to solve this problem.
Ref counting?

> +	 *
> +	 * FIXME: should we also check for mm that outlive its owning
> +	 * task ?
> +	 */
> +	mm =3D READ_ONCE(mirror->hmm->mm);
> +	if (mirror->hmm->dead || !mm)
> +		return -EINVAL;
> +
> +	down_read(&mm->mmap_sem);
> +	return 0;
> +}
> +
> +/*
> + * hmm_mirror_mm_up_read() - unlock the mmap_sem from read mode
> + * @mirror: the HMM mm mirror for which we want to lock the mmap_sem
> + */
> +static inline void hmm_mirror_mm_up_read(struct hmm_mirror *mirror)
> +{
> +	up_read(&mirror->hmm->mm->mmap_sem);
> +}
> +
> =20
>  /*
>   * To snapshot the CPU page table you first have to call hmm_range_regis=
ter()
> @@ -463,7 +507,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror)=
;
>   *          if (ret)
>   *              return ret;
>   *
> - *          down_read(mm->mmap_sem);
> + *          hmm_mirror_mm_down_read(mirror);

See? The normal down_read() code never needs to check a return value, so wh=
en
someone does a "simple" upgrade, it introduces a fatal bug here: if the wra=
pper
returns early, then the caller proceeds without having acquired the mmap_se=
m.

>   *      again:
>   *
>   *          if (!hmm_range_wait_until_valid(&range, TIMEOUT)) {
> @@ -476,13 +520,13 @@ void hmm_mirror_unregister(struct hmm_mirror *mirro=
r);
>   *
>   *          ret =3D hmm_range_snapshot(&range); or hmm_range_fault(&rang=
e);
>   *          if (ret =3D=3D -EAGAIN) {
> - *              down_read(mm->mmap_sem);
> + *              hmm_mirror_mm_down_read(mirror);

Same problem here.


thanks,
--=20
John Hubbard
NVIDIA
