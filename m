Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827E5C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 510B5217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TvmM8cZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfCTBSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:18:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8419 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbfCTBSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:18:36 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9194ee0000>; Tue, 19 Mar 2019 18:18:38 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 19 Mar 2019 18:18:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 19 Mar 2019 18:18:36 -0700
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 20 Mar
 2019 01:18:35 +0000
Subject: Re: [PATCH v4 0/1] mm: introduce put_user_page*(), placeholder
 versions
To:     Christopher Lameter <cl@linux.com>
CC:     <john.hubbard@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
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
References: <20190308213633.28978-1-jhubbard@nvidia.com>
 <01000169972802f7-2d72ffed-b3a6-4829-8d50-cd92cda6d267-000000@email.amazonses.com>
 <dc2499a6-4475-bea3-605a-7778ffcf76fc@nvidia.com>
 <0100016998a587a1-c6df93d4-223b-4e66-9d8c-2bb38fae28ac-000000@email.amazonses.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <cd97ec48-1776-20d8-d517-35dca93f7da4@nvidia.com>
Date:   Tue, 19 Mar 2019 18:18:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <0100016998a587a1-c6df93d4-223b-4e66-9d8c-2bb38fae28ac-000000@email.amazonses.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553044718; bh=lUyW74g7qbSUcJU3wmjKXemQqGL0UbX2ngNwCUmFEDw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TvmM8cZ1absETn4/Ryv+cdfBfglm0ueLTDRHMr5jxLlr1/12Pdkv7L5hgchcFQHuo
         hj1IAsDtmSDbTHPWRkdBIsT/CorqahbDPPolGR0vb42oRjhEKGw9nBUKU4uSKNU4NM
         c+BeLdc0BMTF/zxGF1ClIX/XBqfcUOqhew/omFI/2V09SAlysy/n7xxl92mie0cSio
         +eRHVI1wAhW4dzKyrEaFKidH+eBc04oCBh+ROlvh6gAEbH/GZ56FQUBsOnjUmyp54D
         6wVjIAXXT6dd2aKGOuCmq+BB3qOZeN0BGu841WHazAyzgOmEjqPNQEuVk3mTguO+PY
         7IDudyXVBHV/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/19 6:09 PM, Christopher Lameter wrote:
> On Tue, 19 Mar 2019, John Hubbard wrote:
> 
>>>
>>> My concerns do not affect this patchset which just marks the get/put for
>>> the pagecache. The problem was that the description was making claims that
>>> were a bit misleading and seemed to prescribe a solution.
>>>
>>> So lets get this merged. Whatever the solution will be, we will need this
>>> markup.
>>>
>>
>> Sounds good. Do you care to promote that thought into a formal ACK for me? :)
> 
> Reviewed-by: Christoph Lameter <cl@linux.com>
> 

Awesome! I've added that tag and it will show up in the next posting.


thanks,
-- 
John Hubbard
NVIDIA
