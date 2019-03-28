Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53067C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EB0B21850
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 23:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kNMJMs9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfC1XUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 19:20:39 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6479 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfC1XUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 19:20:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d56c90000>; Thu, 28 Mar 2019 16:20:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 16:20:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 16:20:38 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 28 Mar
 2019 23:20:38 +0000
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
 <068db0a8-fade-8ed1-3b9d-c29c27797301@nvidia.com>
 <20190328224032.GH13560@redhat.com>
 <0b698b36-da17-434b-b8e7-4a91ac6c9d82@nvidia.com>
 <20190328230543.GI13560@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9e414b8c-0f98-a2f7-4f46-d335c015fc1b@nvidia.com>
Date:   Thu, 28 Mar 2019 16:20:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190328230543.GI13560@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553815241; bh=cwvfXAmYS2xpbe/FjvzNojKYMDG/S4Ny/qLUa3K9/HA=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kNMJMs9C+TM1nNFTqcCV7IrVAkqxMYU++6lQG9ATbs5dJW3bohUET58V2LGYBJ3AS
         BJOR3Wxcqu+O47jZVuo4jxeNgexPD12CKcgQqGkcjnMg7a14DNYwvxMfNWRsSBQLEg
         PmVuCr8J6jmZ9N9JV6HxPfnhkC4PZ0lRQyjpXcUJ94q9EVm/ibBxc6wIgOfAefZI5U
         ALdxLZSvIEDDguQNaUCnjr01WMaGnRhvhwa+gudD1FXzyCnmBQ83NvG4D7CG5Blw03
         fRfwFvygK2kgIdrvJZK3kRGV9HlIEiUvIRIqJV8go1+5AoYHs0j3fwtpwlXsSukM1Z
         wd9dFJcLPiWiA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 4:05 PM, Jerome Glisse wrote:
> On Thu, Mar 28, 2019 at 03:43:33PM -0700, John Hubbard wrote:
>> On 3/28/19 3:40 PM, Jerome Glisse wrote:
>>> On Thu, Mar 28, 2019 at 03:25:39PM -0700, John Hubbard wrote:
>>>> On 3/28/19 3:08 PM, Jerome Glisse wrote:
>>>>> On Thu, Mar 28, 2019 at 02:41:02PM -0700, John Hubbard wrote:
>>>>>> On 3/28/19 2:30 PM, Jerome Glisse wrote:
>>>>>>> On Thu, Mar 28, 2019 at 01:54:01PM -0700, John Hubbard wrote:
>>>>>>>> On 3/25/19 7:40 AM, jglisse@redhat.com wrote:
>>>>>>>>> From: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>>>> [...]
>>>> OK, so let's either drop this patch, or if merge windows won't allow t=
hat,
>>>> then *eventually* drop this patch. And instead, put in a hmm_sanity_ch=
eck()
>>>> that does the same checks.
>>>
>>> RDMA depends on this, so does the nouveau patchset that convert to new =
API.
>>> So i do not see reason to drop this. They are user for this they are po=
sted
>>> and i hope i explained properly the benefit.
>>>
>>> It is a common pattern. Yes it only save couple lines of code but down =
the
>>> road i will also help for people working on the mmap_sem patchset.
>>>
>>
>> It *adds* a couple of lines that are misleading, because they look like =
they
>> make things safer, but they don't actually do so.
>=20
> It is not about safety, sorry if it confused you but there is nothing abo=
ut
> safety here, i can add a big fat comment that explains that there is no s=
afety
> here. The intention is to allow the page fault handler that potential hav=
e
> hundred of page fault queue up to abort as soon as it sees that it is poi=
ntless
> to keep faulting on a dying process.
>=20
> Again if we race it is _fine_ nothing bad will happen, we are just doing =
use-
> less work that gonna be thrown on the floor and we are just slowing down =
the
> process tear down.
>=20

In addition to a comment, how about naming this thing to indicate the above=
=20
intention?  I have a really hard time with this odd down_read() wrapper, wh=
ich
allows code to proceed without really getting a lock. It's just too wrong-l=
ooking.
If it were instead named:

	hmm_is_exiting()

and had a comment about why racy is OK, then I'd be a lot happier. :)


thanks,
--=20
John Hubbard
NVIDIA
