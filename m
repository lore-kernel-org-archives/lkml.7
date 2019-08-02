Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F55DC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFE792080C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 02:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388961AbfHBCHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 22:07:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:28672 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726796AbfHBCHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 22:07:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2019 19:07:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,336,1559545200"; 
   d="scan'208";a="184440078"
Received: from allen-box.sh.intel.com (HELO [10.239.159.136]) ([10.239.159.136])
  by orsmga002.jf.intel.com with ESMTP; 01 Aug 2019 19:07:19 -0700
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, ashok.raj@intel.com,
        jacob.jun.pan@intel.com, kevin.tian@intel.com,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/3] iommu/vt-d: Refactor find_domain() helper
To:     Christoph Hellwig <hch@lst.de>
References: <20190801060156.8564-1-baolu.lu@linux.intel.com>
 <20190801060156.8564-2-baolu.lu@linux.intel.com>
 <20190801061021.GA14955@lst.de>
 <40f3a736-0a96-0491-61ad-0ddf03612d91@linux.intel.com>
 <20190801140913.GD23435@lst.de>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <7c1b26a6-0caa-ae42-4fc6-967901fb9bbc@linux.intel.com>
Date:   Fri, 2 Aug 2019 10:06:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190801140913.GD23435@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/1/19 10:09 PM, Christoph Hellwig wrote:
> On Thu, Aug 01, 2019 at 02:20:07PM +0800, Lu Baolu wrote:
>> Hi Christoph,
>>
>> On 8/1/19 2:10 PM, Christoph Hellwig wrote:
>>> On Thu, Aug 01, 2019 at 02:01:54PM +0800, Lu Baolu wrote:
>>>> +	/* No lock here, assumes no domain exit in normal case */
>>>
>>> s/exit/exists/ ?
>>
>> This comment is just moved from one place to another in this patch.
>>
>> "no domain exit" means "the domain isn't freed". (my understand)
> 
> Maybe we'll get that refconfirmed and can fix up the comment?

Sure.

> 
>>
>>>
>>>> +	info = dev->archdata.iommu;
>>>> +	if (likely(info))
>>>> +		return info->domain;
>>>
>>> But then again the likely would be odd.
>>>
>>
>> Normally there's a domain for a device (default domain or isolation
>> domain for assignment cases).
> 
> Makes sense, I just mean to say that the likely was contrary to my
> understanding of the above comment.
> 

Best regards,
Baolu
