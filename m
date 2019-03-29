Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99719C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 679C121871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 00:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Q0KbVjt4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfC2Aj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 20:39:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15097 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728547AbfC2Aj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 20:39:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d69380000>; Thu, 28 Mar 2019 17:39:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 17:39:27 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 17:39:27 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 00:39:26 +0000
Subject: Re: [PATCH v2 02/11] mm/hmm: use reference counting for HMM struct v2
To:     Jerome Glisse <jglisse@redhat.com>
CC:     Ira Weiny <ira.weiny@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
References: <20190325144011.10560-1-jglisse@redhat.com>
 <20190325144011.10560-3-jglisse@redhat.com>
 <20190328110719.GA31324@iweiny-DESK2.sc.intel.com>
 <20190328191122.GA5740@redhat.com>
 <c8fd897f-b9d3-a77b-9898-78e20221ba44@nvidia.com>
 <20190328212145.GA13560@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
Date:   Thu, 28 Mar 2019 17:39:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328212145.GA13560@redhat.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553819960; bh=tD7OqDvEuxyFdGL//3cLnWvjKrhcIjz2aOlgPkqRx0M=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Q0KbVjt4rsznaiVDmvDr6VuTjjWZ2rlv20UdubVR77Kk269lggejhWVS3cKh7MYkY
         w9593VJNWmESvoEmlkOW846WaJIbzc6nUiJMLCzFkZb7GGGhQ7SGaDH2SsaebT7TNu
         /LRNYJXErEJG+9i26NOGwgXAKU9h54GkWxEIdwAtiG3dMRVYjwLtrfjVy/hCCHKS6m
         MWm6e+PEQx5rt+xGQzNBueRM6zrDM1MnYEp8fHDA4uoYvMTPww2Lgdk7TykKEp/Q36
         385PMGmrePqwnlUTkvmAJjZF1+3tUhXtfanKcV5TzHTYLAvslJjSuaAhkk4O7yjm/H
         GHjFIj7XgIAoA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 2:21 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 01:43:13PM -0700, John Hubbard wrote:
>> On 3/28/19 12:11 PM, Jerome Glisse wrote:
>>> On Thu, Mar 28, 2019 at 04:07:20AM -0700, Ira Weiny wrote:
>>>> On Mon, Mar 25, 2019 at 10:40:02AM -0400, Jerome Glisse wrote:
>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
[...]
>>>>> @@ -67,14 +78,9 @@ struct hmm {
>>>>>   */
>>>>>  static struct hmm *hmm_register(struct mm_struct *mm)
>>>>>  {
>>>>> -	struct hmm *hmm =3D READ_ONCE(mm->hmm);
>>>>> +	struct hmm *hmm =3D mm_get_hmm(mm);
>>>>
>>>> FWIW: having hmm_register =3D=3D "hmm get" is a bit confusing...
>>>
>>> The thing is that you want only one hmm struct per process and thus
>>> if there is already one and it is not being destroy then you want to
>>> reuse it.
>>>
>>> Also this is all internal to HMM code and so it should not confuse
>>> anyone.
>>>
>>
>> Well, it has repeatedly come up, and I'd claim that it is quite=20
>> counter-intuitive. So if there is an easy way to make this internal=20
>> HMM code clearer or better named, I would really love that to happen.
>>
>> And we shouldn't ever dismiss feedback based on "this is just internal
>> xxx subsystem code, no need for it to be as clear as other parts of the
>> kernel", right?
>=20
> Yes but i have not seen any better alternative that present code. If
> there is please submit patch.
>=20

Ira, do you have any patch you're working on, or a more detailed suggestion=
 there?
If not, then I might (later, as it's not urgent) propose a small cleanup pa=
tch=20
I had in mind for the hmm_register code. But I don't want to duplicate effo=
rt=20
if you're already thinking about it.


thanks,
--=20
John Hubbard
NVIDIA


