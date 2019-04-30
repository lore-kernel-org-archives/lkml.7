Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A0DC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D1621734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbfD3LiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:38:23 -0400
Received: from foss.arm.com ([217.140.101.70]:45200 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbfD3LiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:38:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C47080D;
        Tue, 30 Apr 2019 04:38:22 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 164F23F5C1;
        Tue, 30 Apr 2019 04:38:20 -0700 (PDT)
Subject: Re: [PATCH 02/26] arm64/iommu: improve mmap bounds checking
To:     Christoph Hellwig <hch@lst.de>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190422175942.18788-1-hch@lst.de>
 <20190422175942.18788-3-hch@lst.de>
 <306b7a19-4eb5-d1d8-5250-40f3ba9bca16@arm.com> <20190429190120.GA5637@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <a96caa67-ac59-9ce8-aabc-2601c9a10203@arm.com>
Date:   Tue, 30 Apr 2019 12:38:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190429190120.GA5637@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2019 20:01, Christoph Hellwig wrote:
> On Mon, Apr 29, 2019 at 01:35:46PM +0100, Robin Murphy wrote:
>> On 22/04/2019 18:59, Christoph Hellwig wrote:
>>> The nr_pages checks should be done for all mmap requests, not just those
>>> using remap_pfn_range.
>>
>> I think it probably makes sense now to just squash this with #22 one way or
>> the other, but if you really really still want to keep it as a separate
>> patch with a misleading commit message then I'm willing to keep my
>> complaints to myself :)
> 
> Well, I split this out in response to your earlier comments, so if you
> prefer it squasheѕ back in I can do that..

AFAICS I only ever suggested splitting the original "fix and refactor" 
commit into the fix (patch #1) and the refactor - I think we've just 
ended up adding more "refactor" on top in the evolution of the series :)

Robin.
