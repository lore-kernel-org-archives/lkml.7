Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB5C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3696A2075B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 20:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="lce5inAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfCEUKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 15:10:05 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1718 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726559AbfCEUKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 15:10:04 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7ed79b0001>; Tue, 05 Mar 2019 12:10:03 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 12:10:04 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 05 Mar 2019 12:10:04 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 Mar
 2019 20:10:03 +0000
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling
 paths
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Artemy Kovalyov <artemyko@mellanox.com>,
        "john.hubbard@gmail.com" <john.hubbard@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
References: <20190302032726.11769-2-jhubbard@nvidia.com>
 <20190302202435.31889-1-jhubbard@nvidia.com>
 <20190302194402.GA24732@iweiny-DESK2.sc.intel.com>
 <2404c962-8f6d-1f6d-0055-eb82864ca7fc@mellanox.com>
 <20190303165550.GB27123@iweiny-DESK2.sc.intel.com>
 <bef8680b-acc5-9f13-f49e-8f36f1939387@nvidia.com>
 <20190304201338.GA28731@iweiny-DESK2.sc.intel.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <9502d777-73e1-f96f-120d-acc1f31045ae@nvidia.com>
Date:   Tue, 5 Mar 2019 12:10:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190304201338.GA28731@iweiny-DESK2.sc.intel.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551816603; bh=nFm92H0F0foev1f/IZP1befItBmU4OpaeUP7oINCO1c=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lce5inAwqd2AW64oEefNbUeVk4kKbL7wNLqPT2AyKiDspWK8bgalRoKahUSdq23ma
         1lAf+Ll8ipe6pkApZLtol2TNcVoGkWVKX6c3KFar0vxUn2z1s7JlFtdH/aE5Vi80Kn
         Z3UQnMOqPIkyFs6vR88OtS4FCnUzwQxhIRfiG2HZSSzJUq2n1WNjcsYWPHT+qlrdm0
         yR5uao9zObAzIcVTBibXwodKbWFuvP9di72kverwQKzBoROP8u4YUuguQvzx26WYpn
         2QsMMicMCoDJhiMIhl9BMsux3tIGPY0aMUHIGgfzrsNXxgeUGAz9M/pFXF/RyWXBer
         Gst1xAnYdNfHw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/19 12:13 PM, Ira Weiny wrote:
[snip]
>> And this reminds me that I have a problem to solve nearby: get_user_pages
>> on huge pages increments the page->_refcount *for each tail page* as well.
>> That's a minor problem for my put_user_page() 
>> patchset, because my approach so far assumed that I could just change us
>> over to:
>>
>> get_user_page(): increments page->_refcount by a large amount (1024)
>>
>> put_user_page(): decrements page->_refcount by a large amount (1024)
>>
>> ...and just stop doing the odd (to me) technique of incrementing once for
>> each tail page. I cannot see any reason why that's actually required, as
>> opposed to just "raise the page->_refcount enough to avoid losing the head
>> page too soon".
> 
> What about splitting a huge page?
> 
> From Documention/vm/transhuge.rst
> 
> <quoute>
> split_huge_page internally has to distribute the refcounts in the head
> page to the tail pages before clearing all PG_head/tail bits from the page
> structures. It can be done easily for refcounts taken by page table
> entries. But we don't have enough information on how to distribute any
> additional pins (i.e. from get_user_pages). split_huge_page() fails any
> requests to split pinned huge page: it expects page count to be equal to
> sum of mapcount of all sub-pages plus one (split_huge_page caller must
> have reference for head page).
> </quote>
> 

heh, so in the end, split_huge_page just needs enough information to say
"no" for gup pages. So as long as page->_refcount avoids one particular
value, the code keeps working. :)


> FWIW, I'm not sure why it needs to "store" the reference in the head page for
> this.  I don't see any check to make sure the ref has been "stored" but I'm not
> really familiar with the compound page code yet.
> 
> Ira
> 

Thanks for peeking at this, I'll look deeper too.

thanks,
-- 
John Hubbard
NVIDIA
