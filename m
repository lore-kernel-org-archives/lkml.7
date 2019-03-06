Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DBD20663
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="i9027WbB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbfCFCEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:04:41 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:1775 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728774AbfCFCEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:04:37 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7f2ab30000>; Tue, 05 Mar 2019 18:04:35 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 18:04:36 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Mar 2019 18:04:36 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 02:04:35 +0000
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling
 paths
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Artemy Kovalyov <artemyko@mellanox.com>,
        Ira Weiny <ira.weiny@intel.com>,
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
 <74f196a1-bd27-2e94-2f9f-0cf657eb0c91@nvidia.com>
 <be6303c6-d8d2-483a-5271-b6707c21178e@nvidia.com>
 <20190306015123.GB1662@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <1f922d79-0057-ed80-305c-01768dd40cad@nvidia.com>
Date:   Tue, 5 Mar 2019 18:04:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190306015123.GB1662@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551837875; bh=rp+EqwcLxAs6h2sIfzKgeVXiunRhEMOEhWjqu8NVtN8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=i9027WbBk1QDJvGlMPz43I4bjPtR+8kQ3Qe8qTjCZhgoEfMYxXWIuFdRaEuKiC8gy
         h3ERXxuT+FuM5Ttk2RGejBBXVtURrvVQ8Kn8i3kLDdw1C5yXfKewVvTQn5EDyYEqGm
         B1bg6oiZh85z6ZCVoiJwrnIB5qxQfI2wRE7PCLywl5Zuuq/4VjDB13Z54PFZy79d+V
         4AeIIeQl/KdkZvoIdwc3/RRtOESyovJReuhajO4x7ocAuZG6YkPR1oABb8oVrQJBsY
         zXzSsRKW2u/6OBYh5cg1kk9ZIpo9Hy9EjwufJl9zCU4aMfv8y9iVe8ty2BqsEoYVjI
         y93TEEXRXUl+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:51 PM, Jason Gunthorpe wrote:
> On Tue, Mar 05, 2019 at 05:37:18PM -0800, John Hubbard wrote:
>> On 3/5/19 5:34 PM, John Hubbard wrote:
>> [snip]
>>>>> So release_pages(&local_page_list[j+1], npages - j-1) would be correct.
>>>>
>>>> Someone send a fixup patch please...
>>>>
>>>> Jason
>>>
>>> Yeah, I'm on it. Just need to double-check that this is the case. But Jason,
>>> you're confirming it already, so that helps too.
> 
> I didn't look, just assuming Artemy is right since he knows this
> code..
> 

OK. And I've confirmed it, too.

>>> Patch coming shortly.
>>>
>>
>> Jason, btw, do you prefer a patch that fixes the previous one, or a new 
>> patch that stands alone? (I'm not sure how this tree is maintained, exactly.)
> 
> It has past the point when I should apply a fixup, rdma is general has
> about an approximately 1 day period after the 'thanks applied' message
> where rebase is possible
> 
> Otherwise the tree is strictly no rebase
> 
> Jason
> 

Got it, patch is posted now.

thanks,
-- 
John Hubbard
NVIDIA
