Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3DFC73C66
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBE720844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 01:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bdqZj66S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfGJBY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jul 2019 21:24:58 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:8784 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbfGJBY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jul 2019 21:24:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d253e6e0002>; Tue, 09 Jul 2019 18:25:02 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 09 Jul 2019 18:24:57 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 09 Jul 2019 18:24:57 -0700
Received: from rcampbell-dev.nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Jul
 2019 01:24:57 +0000
Subject: Re: [PATCH] mm/hmm: Fix bad subpage pointer in try_to_unmap_one
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190709223556.28908-1-rcampbell@nvidia.com>
 <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
X-Nvconfidentiality: public
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <05fffcad-cf5e-8f0c-f0c7-6ffbd2b10c2e@nvidia.com>
Date:   Tue, 9 Jul 2019 18:24:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190709172823.9413bb2333363f7e33a471a0@linux-foundation.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1562721902; bh=7k/lgMwyAOSzNGQqdDXXYMv79vityN/pwh1Ws1jVVNs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bdqZj66SSKe/Sej2HEmOBrXJF+zC/5PRqfyUvCr6pR8GfmbS1yp5prYZc/+vQeU11
         +2fuVzrvi2SZd/aDuTcIlMzu7sf7T1kK4E0C9ThIPyJt+GyxmtMYTfrYTI3WUyBQ7S
         +6sp5Z11zhxQ54RUOpuTxIXG6ddnyycB9I+s4NZYlGqbISCfwy+xe0qyJxnibrjLOa
         IbXVXKq0PzfXx2np9JUzGj7empCUXNl/cmmb0f5RZttV/ZFDmwMrWJxt9sqKUQHICq
         gWBtYR07FoHZy1mtc1BmG0WrxibQgD7Hf0aSBCLARpAs6lPNveVsx3oBmKuAzxtJtT
         U9fy2s4k1Gd+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/19 5:28 PM, Andrew Morton wrote:
> On Tue, 9 Jul 2019 15:35:56 -0700 Ralph Campbell <rcampbell@nvidia.com> wrote:
> 
>> When migrating a ZONE device private page from device memory to system
>> memory, the subpage pointer is initialized from a swap pte which computes
>> an invalid page pointer. A kernel panic results such as:
>>
>> BUG: unable to handle page fault for address: ffffea1fffffffc8
>>
>> Initialize subpage correctly before calling page_remove_rmap().
> 
> I think this is
> 
> Fixes:  a5430dda8a3a1c ("mm/migrate: support un-addressable ZONE_DEVICE page in migration")
> Cc: stable
> 
> yes?
> 

Yes. Can you add this or should I send a v2?
