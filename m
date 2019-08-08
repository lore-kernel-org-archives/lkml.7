Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B526C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD6621743
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="fR5j9wfS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404542AbfHHTUK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:20:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18643 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404178AbfHHTUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:20:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4c75f30000>; Thu, 08 Aug 2019 12:20:19 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 12:20:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 08 Aug 2019 12:20:09 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 8 Aug
 2019 19:20:08 +0000
Subject: Re: [PATCH 1/3] mm/mlock.c: convert put_page() to put_user_page*()
To:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Black <daniel@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20190805222019.28592-1-jhubbard@nvidia.com>
 <20190805222019.28592-2-jhubbard@nvidia.com>
 <20190807110147.GT11812@dhcp22.suse.cz>
 <01b5ed91-a8f7-6b36-a068-31870c05aad6@nvidia.com>
 <20190808062155.GF11812@dhcp22.suse.cz>
 <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <306128f9-8cc6-761b-9b05-578edf6cce56@nvidia.com>
Date:   Thu, 8 Aug 2019 12:20:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <875dca95-b037-d0c7-38bc-4b4c4deea2c7@suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565292019; bh=gyjAPj2n6Df+meBITnObLks8CStskxi0utl7evTCTTw=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=fR5j9wfSfwQnIbtxsXQwVx4m3yEG1GHbyByYyV5gBzEBx59m1WUifbcholhHCK1Wo
         yqui8gxSIgvO77jrIShOyraDGi8GvTWgxnIzH9c7B1A2X+bMRJbWsF1PRMy/yqnhfu
         nVLVHLIhW6NC78g+Pyp30UxKkteVz1hv6VkK3OjkudSDJPyBjdwXgHxeBp+f5b3edQ
         ucC1fmBED476OuRsEuz+3ClDMQXqRciY6Ae22F230ne/YZWk4EgL+Skzzl5hlJvrho
         7gV35HBjUQDHyt05Ls6FypCgMmDbJcqXz9Saz9CMNTsAWHln8fS3RvG8Q2UTphHb3Y
         pKMkidlRP1ZQw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/19 4:09 AM, Vlastimil Babka wrote:
> On 8/8/19 8:21 AM, Michal Hocko wrote:
>> On Wed 07-08-19 16:32:08, John Hubbard wrote:
>>> On 8/7/19 4:01 AM, Michal Hocko wrote:
>>>> On Mon 05-08-19 15:20:17, john.hubbard@gmail.com wrote:
>>>>> From: John Hubbard <jhubbard@nvidia.com>
>>> Actually, I think follow_page_mask() gets all the pages, right? And the
>>> get_page() in __munlock_pagevec_fill() is there to allow a pagevec_release() 
>>> later.
>>
>> Maybe I am misreading the code (looking at Linus tree) but munlock_vma_pages_range
>> calls follow_page for the start address and then if not THP tries to
>> fill up the pagevec with few more pages (up to end), do the shortcut
>> via manual pte walk as an optimization and use generic get_page there.
> 

Yes, I see it finally, thanks. :)  

> That's true. However, I'm not sure munlocking is where the
> put_user_page() machinery is intended to be used anyway? These are
> short-term pins for struct page manipulation, not e.g. dirtying of page
> contents. Reading commit fc1d8e7cca2d I don't think this case falls
> within the reasoning there. Perhaps not all GUP users should be
> converted to the planned separate GUP tracking, and instead we should
> have a GUP/follow_page_mask() variant that keeps using get_page/put_page?
>  

Interesting. So far, the approach has been to get all the gup callers to
release via put_user_page(), but if we add in Jan's and Ira's vaddr_pin_pages()
wrapper, then maybe we could leave some sites unconverted.

However, in order to do so, we would have to change things so that we have
one set of APIs (gup) that do *not* increment a pin count, and another set
(vaddr_pin_pages) that do. 

Is that where we want to go...?

I have a tracking patch that only deals with gup/pup. I could post as an RFC,
but I think it might just muddy the waters at this point, anyway it's this one:

    
https://github.com/johnhubbard/linux/commit/a0fb73ce0a39c74f0d1fb6bd9d866f660f762eae


thanks,
-- 
John Hubbard
NVIDIA 
