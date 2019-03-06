Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9002EC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5009820675
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="C+hB89nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfCFBeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:34:20 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3225 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbfCFBeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:34:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7f23930000>; Tue, 05 Mar 2019 17:34:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 17:34:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Mar 2019 17:34:19 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 01:34:19 +0000
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling
 paths
To:     Jason Gunthorpe <jgg@ziepe.ca>,
        Artemy Kovalyov <artemyko@mellanox.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <332021c5-ab72-d54f-85c8-b2b12b76daed@nvidia.com>
 <903383a6-f2c9-4a69-83c0-9be9c052d4be@mellanox.com>
 <20190306013213.GA1662@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <74f196a1-bd27-2e94-2f9f-0cf657eb0c91@nvidia.com>
Date:   Tue, 5 Mar 2019 17:34:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306013213.GA1662@ziepe.ca>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551836051; bh=fq/HESMUJWBf059BBX+oMOGMTSzOEnBoqdF74U+vpJk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=C+hB89nQ9YW70yt0RWj8v+uzy9zwNRFfBdGoCq7bd89OCRZkNw7c4RhFusE6Eoltj
         GMpXbfU90OsiqipDUOeIwFOG//icBckExIXFjgaJQV68QYU75RxdRib4z+1gyhSazm
         ZPMee18ECaDRb0nJOW3B0/zNeIQd1g/12GdjipSQqjvw9xkt0Iu7IDdS1/7/ADtstZ
         I/xJY/9Brn2KaYiqgSwJjXqEQYXLmJm8schB+66rZ/fwG5dwbr9X1xQcM98PuqrjrN
         gbcMIHwSIVuXQZk1C0OVOSpsJTH39foJVdaIH30XHQAeda5UUBgCZVpn5w99lYBJ6X
         HxvibPZcbpf9Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:32 PM, Jason Gunthorpe wrote:
> On Wed, Mar 06, 2019 at 03:02:36AM +0200, Artemy Kovalyov wrote:
>>
>>
>> On 04/03/2019 00:37, John Hubbard wrote:
>>> On 3/3/19 1:52 AM, Artemy Kovalyov wrote:
>>>>
>>>>
>>>> On 02/03/2019 21:44, Ira Weiny wrote:
>>>>>
>>>>> On Sat, Mar 02, 2019 at 12:24:35PM -0800, john.hubbard@gmail.com wrote:
>>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>>>>>
>>>>>> ...
>>>
>>> OK, thanks for explaining! Artemy, while you're here, any thoughts about the
>>> release_pages, and the change of the starting point, from the other part of the
>>> patch:
>>>
>>> @@ -684,9 +677,11 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp,
>>> u64 user_virt,
>>> 	mutex_unlock(&umem_odp->umem_mutex);
>>>
>>>    		if (ret < 0) {
>>> -			/* Release left over pages when handling errors. */
>>> -			for (++j; j < npages; ++j)
>> release_pages() is an optimized batch put_page() so it's ok.
>> but! release starting from page next to one cause failure in
>> ib_umem_odp_map_dma_single_page() is correct because failure flow of this
>> functions already called put_page().
>> So release_pages(&local_page_list[j+1], npages - j-1) would be correct.
> 
> Someone send a fixup patch please...
> 
> Jason

Yeah, I'm on it. Just need to double-check that this is the case. But Jason,
you're confirming it already, so that helps too.

Patch coming shortly.

thanks,
-- 
John Hubbard
NVIDIA
