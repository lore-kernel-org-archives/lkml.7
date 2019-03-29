Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB91C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DD622183E
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 02:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TCCYngfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfC2CLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 22:11:19 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:5984 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727434AbfC2CLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 22:11:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9d7ec40001>; Thu, 28 Mar 2019 19:11:16 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 28 Mar 2019 19:11:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 28 Mar 2019 19:11:17 -0700
Received: from [10.110.48.28] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 29 Mar
 2019 02:11:17 +0000
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
 <fcb7be01-38c1-ed1f-70a0-d03dc9260473@nvidia.com>
 <20190328165708.GH31324@iweiny-DESK2.sc.intel.com>
 <20190329010059.GB16680@redhat.com>
 <55dd8607-c91b-12ab-e6d7-adfe6d9cb5e2@nvidia.com>
 <20190329015003.GE16680@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cc587c80-34ea-8d08-533d-0dc0c2fb079f@nvidia.com>
Date:   Thu, 28 Mar 2019 19:11:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190329015003.GE16680@redhat.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553825476; bh=kNXxnRe3M1ijRkP4yynTmx6uLTiKcabSICyOQfMgSMw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TCCYngfrlCQTvKv1rhpyIVK3LxaWz+hW7XDu8Fzz9E/d18QO1CqEZSqLswtry/e+k
         UrOnp6rld7LJCk+y6FB6xYN1orUNpKBjpF7gxkWh15FE/QSc2Ls6HIK6gOG6T8QHhH
         zVDoPrYKUbDfwd3pbHLSCYLtDOdb/ZMVJNIiiEzgooV072BV415VSMJ+gPjf/MAyxX
         FjKg1oym70nUDnOGY/vhLbTP1dhy6HTBWdb5F738n1Hud5sL50J7LDGCz2NfcCGsPR
         vwOrkHl/E8o01yxW4w9XdyfDc8dtAZM08lyhbdMr9jwsV97Ot8Dp0Fp0ZlEuZFD7w9
         vkAvK9PA2IttA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 6:50 PM, Jerome Glisse wrote:
[...]
>>>
>>> The hmm_put() is just releasing the reference on the hmm struct.
>>>
>>> Here i feel i am getting contradicting requirement from different people.
>>> I don't think there is a way to please everyone here.
>>>
>>
>> That's not a true conflict: you're comparing your actual implementation
>> to Ira's request, rather than comparing my request to Ira's request.
>>
>> I think there's a way forward. Ira and I are actually both asking for the
>> same thing:
>>
>> a) clear, concise get/put routines
>>
>> b) avoiding odd side effects in functions that have one name, but do
>> additional surprising things.
> 
> Please show me code because i do not see any other way to do it then
> how i did.
> 

Sure, I'll take a run at it. I've driven you crazy enough with the naming 
today, it's time to back it up with actual code. :)

I hope this is not one of those "we must also change Nouveau in N+M steps" 
situations, though. I'm starting to despair about reviewing code that
basically can't be changed...

thanks,
-- 
John Hubbard
NVIDIA
