Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BB4C10F0D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E2C20828
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 20:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="kdfzspIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfCRUMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 16:12:50 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16699 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCRUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 16:12:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c8ffbb10000>; Mon, 18 Mar 2019 13:12:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 18 Mar 2019 13:12:47 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 18 Mar 2019 13:12:47 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Mar
 2019 20:12:47 +0000
Subject: Re: [PATCH v3 0/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Jan Kara <jack@suse.cz>, Christopher Lameter <cl@linux.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Ira Weiny <ira.weiny@intel.com>, <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190306235455.26348-1-jhubbard@nvidia.com>
 <010001695b4631cd-f4b8fcbf-a760-4267-afce-fb7969e3ff87-000000@email.amazonses.com>
 <20190310224742.GK26298@dastard>
 <01000169705aecf0-76f2b83d-ac18-4872-9421-b4b6efe19fc7-000000@email.amazonses.com>
 <20190312103932.GD1119@iweiny-DESK2.sc.intel.com>
 <20190312221113.GF23020@dastard> <20190313160319.GA15134@infradead.org>
 <010001697880bfdc-4503d0dd-03cd-4c91-84a0-c18af1eab145-000000@email.amazonses.com>
 <20190314090635.GC16658@quack2.suse.cz>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <445e6907-2fd7-1eeb-21f6-e7fa00d00346@nvidia.com>
Date:   Mon, 18 Mar 2019 13:12:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314090635.GC16658@quack2.suse.cz>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552939953; bh=iGAUPJJ+Q3A71Lvl21ZNq7fTQp4p5vmBmHlE40N1XP8=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=kdfzspIOMbdNIz/V4toshBZcPvyHARFKk/GxlRerAg4U8EZ/Ck8XeretMa1qlqxB0
         9hZQUw49H3B9nr7wc2DTPBpQAUNUHqbohF9c+u2HwqGb03mHntxjVXlbGNMhfFCnRy
         DsYWC9Zdw6hEDsL2CE+KKjS/tRnEK5BHek4C5Fa4Jn+xCPuLMVITBYdYHrH8816lTu
         0B7MjwmiMhbz55bziJkKiVlZv67ghCPmoRSPELgtuaTW7jB1u1gGqGlWrp1K1jcnuF
         VSsRGR/kES8782fEmJVBtPp3K8M134jW7KuT49l0PsUITEAJAFukDIHbL8Pm890V+K
         TRspMJldCevUg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 2:06 AM, Jan Kara wrote:
> On Wed 13-03-19 19:21:37, Christopher Lameter wrote:
>> On Wed, 13 Mar 2019, Christoph Hellwig wrote:
>>
>>> On Wed, Mar 13, 2019 at 09:11:13AM +1100, Dave Chinner wrote:
>>>> On Tue, Mar 12, 2019 at 03:39:33AM -0700, Ira Weiny wrote:
>>>>> IMHO I don't think that the copy_file_range() is going to carry us through the
>>>>> next wave of user performance requirements.  RDMA, while the first, is not the
>>>>> only technology which is looking to have direct access to files.  XDP is
>>>>> another.[1]
>>>>
>>>> Sure, all I doing here was demonstrating that people have been
>>>> trying to get local direct access to file mappings to DMA directly
>>>> into them for a long time. Direct Io games like these are now
>>>> largely unnecessary because we now have much better APIs to do
>>>> zero-copy data transfer between files (which can do hardware offload
>>>> if it is available!).
>>>
>>> And that is just the file to file case.  There are tons of other
>>> users of get_user_pages, including various drivers that do large
>>> amounts of I/O like video capture.  For them it makes tons of sense
>>> to transfer directly to/from a mmap()ed file.
>>
>> That is very similar to the RDMA case and DAX etc. We need to have a way
>> to tell a filesystem that this is going to happen and that things need to
>> be setup for this to work properly.
> 
> The way to tell filesystem what's happening is exactly what we are working
> on with these patches...
> 
>> But if that has not been done then I think its proper to fail a long term
>> pin operation on page cache pages. Meaning the regular filesystems
>> maintain control of whats happening with their pages.
> 
> And as I mentioned in my other email, we cannot just fail the pin for
> pagecache pages as that would regress existing applications.
> 
> 								Honza
> 

Christopher L,

Are you OK with this approach now? If so, I'd like to collect any additional
ACKs people are willing to provide, and ask Andrew to consider this first 
patch for 5.2, so we can get started.

thanks,
-- 
John Hubbard
NVIDIA
