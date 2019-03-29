Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8ACC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 349C3218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 01:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="XsyhN1AS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfC2Ba2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 21:30:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11344 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbfC2Ba2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 21:30:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d75370000>; Thu, 28 Mar 2019 18:30:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 18:30:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 18:30:27 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 01:30:27 +0000
Subject: Re: [PATCH v2 07/11] mm/hmm: add default fault flags to avoid the
 need to pre-fill pfns arrays.
To:     Jerome Glisse <jglisse@redhat.com>, Ira Weiny <ira.weiny@intel.com>
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
 <d2008b88-962f-b7b4-8351-9e1df95ea2cc@nvidia.com>
 <20190328164231.GF31324@iweiny-DESK2.sc.intel.com>
 <20190329011727.GC16680@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <f053e75e-25b5-d95a-bb3c-73411ba49e3e@nvidia.com>
Date:   Thu, 28 Mar 2019 18:30:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190329011727.GC16680@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553823031; bh=6CXtjATayMacxoWaowYhZ6ypW2hRAvedqZ7XljR3NP0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=XsyhN1ASj7Mh0dDwxw0mXugftAbLLQTdnDmNNouB6FlcjokJuiLocsVpdmB9T5dRX
         gFx9TMvi/rO2wQxXKYSR8WOjn2ecwn5VPScbRdlKs2x5NsBv7OfY0TahE7GONGQbfy
         TTdcfBqRqMi+lJFwenppTHbUAaOtBheAuOKSPSRC1lXbiIldfu8TVUFrKHRif+Fc0K
         Xh74rfxCYL7J5SAWbmORiJ+84PE0+BkROLxMfI/pGxBriWk9wZyVnUhOSZAIz5xA6I
         SL9NXQReFHiluHxyoqW5SlqBlYT+nkX6PHfMKQGmElYqgvnS4eyVM1Q+mmv4TyhU6J
         WrI1cKMY+F4dg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:17 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 09:42:31AM -0700, Ira Weiny wrote:
>> On Thu, Mar 28, 2019 at 04:28:47PM -0700, John Hubbard wrote:
>>> On 3/28/19 4:21 PM, Jerome Glisse wrote:
>>>> On Thu, Mar 28, 2019 at 03:40:42PM -0700, John Hubbard wrote:
>>>>> On 3/28/19 3:31 PM, Jerome Glisse wrote:
>>>>>> On Thu, Mar 28, 2019 at 03:19:06PM -0700, John Hubbard wrote:
>>>>>>> On 3/28/19 3:12 PM, Jerome Glisse wrote:
>>>>>>>> On Thu, Mar 28, 2019 at 02:59:50PM -0700, John Hubbard wrote:
>>>>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>>>>>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>> [...]
>> Indeed I did not realize there is an hmm "pfn" until I saw this function=
:
>>
>> /*
>>  * hmm_pfn_from_pfn() - create a valid HMM pfn value from pfn
>>  * @range: range use to encode HMM pfn value
>>  * @pfn: pfn value for which to create the HMM pfn
>>  * Returns: valid HMM pfn for the pfn
>>  */
>> static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
>>                                         unsigned long pfn)
>>
>> So should this patch contain some sort of helper like this... maybe?
>>
>> I'm assuming the "hmm_pfn" being returned above is the device pfn being
>> discussed here?
>>
>> I'm also thinking calling it pfn is confusing.  I'm not advocating a new=
 type
>> but calling the "device pfn's" "hmm_pfn" or "device_pfn" seems like it w=
ould
>> have shortened the discussion here.
>>
>=20
> That helper is also use today by nouveau so changing that name is not tha=
t
> easy it does require the multi-release dance. So i am not sure how much
> value there is in a name change.
>=20

Once the dust settles, I would expect that a name change for this could go
via Andrew's tree, right? It seems incredible to claim that we've built som=
ething
that effectively does not allow any minor changes!

I do think it's worth some *minor* trouble to improve the name, assuming th=
at we
can do it in a simple patch, rather than some huge maintainer-level effort.

This field name not a large thing, but the cumulative effect of having a nu=
mber of
naming glitches within HMM is significant. The size and complexity of HMM h=
as
always made it hard to attract code reviewers, so let's improve what we can=
, to
counteract that.

thanks,
--=20
John Hubbard
NVIDIA

