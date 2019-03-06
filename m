Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57592C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284212075B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 01:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SIPQduyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfCFBhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 20:37:20 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3391 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbfCFBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 20:37:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7f24470000>; Tue, 05 Mar 2019 17:37:11 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Mar 2019 17:37:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Mar 2019 17:37:19 -0800
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 6 Mar
 2019 01:37:19 +0000
Subject: Re: [PATCH v2] RDMA/umem: minor bug fix and cleanup in error handling
 paths
From:   John Hubbard <jhubbard@nvidia.com>
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
 <74f196a1-bd27-2e94-2f9f-0cf657eb0c91@nvidia.com>
Message-ID: <be6303c6-d8d2-483a-5271-b6707c21178e@nvidia.com>
Date:   Tue, 5 Mar 2019 17:37:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <74f196a1-bd27-2e94-2f9f-0cf657eb0c91@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551836231; bh=6G8GEDfxvsgo3WrgfYipOKCdt+hHrNFO1Dj0Plwre1c=;
        h=X-PGP-Universal:Subject:From:To:CC:References:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SIPQduyblHaTorJ/IxfQwnvaVrKpUl86in8rp1GvHjeawW6d/PlJADuzgrfnghvLg
         MCXDaK+fT3LTD4dfvHQj5Zp58z5l062wGLsZcBQ+RNqujk7pOx+L57REJhXq12dIYJ
         NluAX4zHKHfZfYbr1WwyEmfNPiPgESRb7WcLrEYPCVioLUyxSqUsLguTfeAAGrPJTe
         2Ks4Afx352OHuL9+u1LAYI78zfhnJrTowstYdLqxHfXO2MUK7m4pBkg5RSclhw/Smg
         BP/I/YB/Lh/P9eylMPG5H3ayxZOtHAtZ5bYkbzryZQ6uFZhjE8QYblJ3xWUJadLFdc
         sPfem+gunPxoQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/19 5:34 PM, John Hubbard wrote:
[snip]
>>> So release_pages(&local_page_list[j+1], npages - j-1) would be correct.
>>
>> Someone send a fixup patch please...
>>
>> Jason
> 
> Yeah, I'm on it. Just need to double-check that this is the case. But Jason,
> you're confirming it already, so that helps too.
> 
> Patch coming shortly.
> 

Jason, btw, do you prefer a patch that fixes the previous one, or a new 
patch that stands alone? (I'm not sure how this tree is maintained, exactly.)

thanks,
-- 
John Hubbard
NVIDIA
