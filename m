Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D27C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CF42067B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 16:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfJIQSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 12:18:18 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35238 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731688AbfJIQSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 12:18:18 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1iIEfE-0007Md-Fx; Wed, 09 Oct 2019 10:18:13 -0600
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Joerg Roedel <joro@8bytes.org>, Kit Chow <kchow@gigaio.com>
References: <20191008221837.13067-1-logang@deltatee.com>
 <20191008221837.13067-2-logang@deltatee.com>
 <20191009065750.GA17832@infradead.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c5f6750f-b415-3562-9abe-0937bae94f75@deltatee.com>
Date:   Wed, 9 Oct 2019 10:17:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191009065750.GA17832@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: kchow@gigaio.com, joro@8bytes.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, hch@infradead.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/3] iommu/amd: Implement dma_[un]map_resource()
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-10-09 12:57 a.m., Christoph Hellwig wrote:
> On Tue, Oct 08, 2019 at 04:18:35PM -0600, Logan Gunthorpe wrote:
>> From: Kit Chow <kchow@gigaio.com>
>>
>> Currently the Intel IOMMU uses the default dma_[un]map_resource()
> 
> s/Intel/AMD/ ?

Oops, yes, my mistake.

>> +static dma_addr_t map_resource(struct device *dev, phys_addr_t paddr,
>> +		size_t size, enum dma_data_direction dir, unsigned long attrs)
>> +{
>> +	struct protection_domain *domain;
>> +	struct dma_ops_domain *dma_dom;
>> +
>> +	domain = get_domain(dev);
>> +	if (PTR_ERR(domain) == -EINVAL)
>> +		return (dma_addr_t)paddr;
> 
> I thought that case can't happen anymore?
> 
> Also note that Joerg just applied the patch to convert the AMD iommu
> driver to use the dma-iommu ops.  Can you test that series and check
> it does the right thing for your use case?  From looking at the code
> I think it should.

Yes, looking at the new code, it looks like this patch will not be
needed. So we can drop it. We'll test it to make sure.

I believe the other two patches in this series are still needed though.

Thanks,

Logan


