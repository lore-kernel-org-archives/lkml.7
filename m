Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CBBC10F00
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E164E20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="igHAK3Ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728640AbfCFSeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:34:18 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:5873 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfCFSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:34:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8012a90000>; Wed, 06 Mar 2019 10:34:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 06 Mar 2019 10:34:16 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 06 Mar 2019 10:34:16 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 18:34:15 +0000
Subject: Re: [PATCH] mm/hmm: fix unused variable warnings
To:     Arnd Bergmann <arnd@arndb.de>
CC:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190304200026.1140281-1-arnd@arndb.de>
 <bf509a99-604b-10a4-e71b-f4f8e61f00b3@nvidia.com>
 <CAK8P3a2no2gjWXTcgg_g1DJ9B-j8LfyaeOn+Ji18bWS5mQNZUA@mail.gmail.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <745a2366-23e2-0718-92f4-ccadad5ccf8a@nvidia.com>
Date:   Wed, 6 Mar 2019 10:34:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2no2gjWXTcgg_g1DJ9B-j8LfyaeOn+Ji18bWS5mQNZUA@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551897257; bh=yC7ehc6njw1E3SuHOt+SsTnUaysDvj7ZQ5vFInDjvDQ=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=igHAK3LsZcVHxtB6N8VhpFMw/EuNTWHI744htYl3XE15CeIT1Ug4Ed+/Dc9MJCZLv
         hC+wQSLEhsAEkb8W5zDLnHQO+iGSFNmMuzGIgULYUI9ibHBTGLoqYm+OBMZ3E+h9oo
         zoKMC9Zdgivw0tsfs9sRSmtDZaKs/0rSgNua/BYdjA8RIsjZWgP+Fki/nHmbV6VjXR
         NkoSKjdToyTTJg4g+wgzKPM3mIit+UF6w+84QOtvm6yNElnTnfC3eG1/OZKxMwfH/l
         +FgjOY2bIZUIaaJ3JCs7csQTtHiwXNlN1eS7+Z+0RHFOBpoNap5AmysaLZR8LjFmms
         EBB0miT/Cd8fA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/19 2:19 AM, Arnd Bergmann wrote:
> On Wed, Mar 6, 2019 at 12:51 AM John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> With some Kconfig local hacks that removed all HUGE* support, while leav=
ing
>> HMM enabled, I was able to reproduce your results, and also to verify th=
e
>> fix. It also makes sense from reading it.
>=20
> Thanks for the confirmation.
>=20
>> Also, I ran into one more warning as well:
>>
>> mm/hmm.c: In function =E2=80=98hmm_vma_walk_pud=E2=80=99:
>> mm/hmm.c:764:25: warning: unused variable =E2=80=98vma=E2=80=99 [-Wunuse=
d-variable]
>>   struct vm_area_struct *vma =3D walk->vma;
>>                          ^~~
>>
>> ...which can be fixed like this:
>>
>> diff --git a/mm/hmm.c b/mm/hmm.c
>> index c4beb1628cad..c1cbe82d12b5 100644
>> --- a/mm/hmm.c
>> +++ b/mm/hmm.c
>> @@ -761,7 +761,6 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>>  {
>>         struct hmm_vma_walk *hmm_vma_walk =3D walk->private;
>>         struct hmm_range *range =3D hmm_vma_walk->range;
>> -       struct vm_area_struct *vma =3D walk->vma;
>>         unsigned long addr =3D start, next;
>>         pmd_t *pmdp;
>>         pud_t pud;
>> @@ -807,7 +806,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
>>                 return 0;
>>         }
>>
>> -       split_huge_pud(vma, pudp, addr);
>> +       split_huge_pud(walk->vma, pudp, addr);
>>         if (pud_none(*pudp))
>>                 goto again;
>>
>> ...so maybe you'd like to fold that into your patch?
>=20
> I also ran into this one last night during further randconfig testing,
> and came up with the same patch that you showed here. I'll
> send this one to Andrew and add a Reported-by line for you,
> since he already merged the first patch.
>=20
> I'll leave it up to Andrew to fold the fixes into one, or into the origin=
al
> patches if he thinks that makes sense.
>=20
>      Arnd
>=20

Sounds good!

thanks,
--=20
John Hubbard
NVIDIA
