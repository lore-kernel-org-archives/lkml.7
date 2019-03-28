Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47895C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128392075E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QIBBpSa/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfC1X2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:28:51 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11866 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728472AbfC1X2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:28:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d58aa0000>; Thu, 28 Mar 2019 16:28:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 16:28:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 16:28:48 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 23:28:48 +0000
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
 <768f56f5-8019-06df-2c5a-b4187deaac59@nvidia.com>
 <20190328232125.GJ13560@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
Date:   Thu, 28 Mar 2019 16:28:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328232125.GJ13560@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553815722; bh=aerzQFuHUaWHNBU0Ye3GXuNAqGnCivYkdN0hPFwBFaQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=QIBBpSa/0/+y1QUBtjk0WMrKjg0++8/QnMIUZMUo6mQIDaJ6smESM5I5ch/C4bcKH
         4qBcxVfdS8voLks1eLkyS8TcNyeFqhXmOP1FgKahwVVm8larMAMA6RH02wWOfyVq9J
         lb9wsrBLo3l3112rq4ho3BpwR4pUvb4Jf1cywmBJUUwnTvqU/bwEJVygR/6U2sUTaW
         M0hlATT/xTlyMZCNWPLSbJFE94GlabPa4Deblhci3btR4/nXfUHfwwTFbsjxLmEMQr
         B2dtneO+A6FhGaLbya++9CWXoFGtV+63pZc7WbHQwl1qD2Rcu3HEduPOexvheT0mPI
         4NORuQZ4Ogu0g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 4:21 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 03:40:42PM -0700, John Hubbard wrote:
>> On 3/28/19 3:31 PM, Jerome Glisse wrote:
>>> On Thu, Mar 28, 2019 at 03:19:06PM -0700, John Hubbard wrote:
>>>> On 3/28/19 3:12 PM, Jerome Glisse wrote:
>>>>> On Thu, Mar 28, 2019 at 02:59:50PM -0700, John Hubbard wrote:
>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
[...]
>> Hi Jerome,
>>
>> I think you're talking about flags, but I'm talking about the mask. The=
=20
>> above link doesn't appear to use the pfn_flags_mask, and the default_fla=
gs=20
>> that it uses are still in the same lower 3 bits:
>>
>> +static uint64_t odp_hmm_flags[HMM_PFN_FLAG_MAX] =3D {
>> +	ODP_READ_BIT,	/* HMM_PFN_VALID */
>> +	ODP_WRITE_BIT,	/* HMM_PFN_WRITE */
>> +	ODP_DEVICE_BIT,	/* HMM_PFN_DEVICE_PRIVATE */
>> +};
>>
>> So I still don't see why we need the flexibility of a full 0xFFFFFFFFFFF=
FFFFF
>> mask, that is *also* runtime changeable.=20
>=20
> So the pfn array is using a device driver specific format and we have
> no idea nor do we need to know where the valid, write, ... bit are in
> that format. Those bits can be in the top 60 bits like 63, 62, 61, ...
> we do not care. They are device with bit at the top and for those you
> need a mask that allows you to mask out those bits or not depending on
> what the user want to do.
>=20
> The mask here is against an _unknown_ (from HMM POV) format. So we can
> not presume where the bits will be and thus we can not presume what a
> proper mask is.
>=20
> So that's why a full unsigned long mask is use here.
>=20
> Maybe an example will help let say the device flag are:
>     VALID (1 << 63)
>     WRITE (1 << 62)
>=20
> Now let say that device wants to fault with at least read a range
> it does set:
>     range->default_flags =3D (1 << 63)
>     range->pfn_flags_mask =3D 0;
>=20
> This will fill fault all page in the range with at least read
> permission.
>=20
> Now let say it wants to do the same except for one page in the range
> for which its want to have write. Now driver set:
>     range->default_flags =3D (1 << 63);
>     range->pfn_flags_mask =3D (1 << 62);
>     range->pfns[index_of_write] =3D (1 << 62);
>=20
> With this HMM will fault in all page with at least read (ie valid)
> and for the address: range->start + index_of_write << PAGE_SHIFT it
> will fault with write permission ie if the CPU pte does not have
> write permission set then handle_mm_fault() will be call asking for
> write permission.
>=20
>=20
> Note that in the above HMM will populate the pfns array with write
> permission for any entry that have write permission within the CPU
> pte ie the default_flags and pfn_flags_mask is only the minimun
> requirement but HMM always returns all the flag that are set in the
> CPU pte.
>=20
>=20
> Now let say you are an "old" driver like nouveau upstream, then it
> means that you are setting each individual entry within range->pfns
> with the exact flags you want for each address hence here what you
> want is:
>     range->default_flags =3D 0;
>     range->pfn_flags_mask =3D -1UL;
>=20
> So that what we do is (for each entry):
>     (range->pfns[index] & range->pfn_flags_mask) | range->default_flags
> and we end up with the flags that were set by the driver for each of
> the individual range->pfns entries.
>=20
>=20
> Does this help ?
>=20

Yes, the key point for me was that this is an entirely device driver specif=
ic
format. OK. But then we have HMM setting it. So a comment to the effect tha=
t
this is device-specific might be nice, but I'll leave that up to you whethe=
r
it is useful.

Either way, you can add:

	Reviewed-by: John Hubbard <jhubbard@nvidia.com>

thanks,
--=20
John Hubbard
NVIDIA
