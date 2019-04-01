Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C9CC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 296902087F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 10:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbfDAKKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 06:10:45 -0400
Received: from foss.arm.com ([217.140.101.70]:59896 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbfDAKKp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 06:10:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE09D15AD;
        Mon,  1 Apr 2019 03:10:44 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 652433F557;
        Mon,  1 Apr 2019 03:10:43 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH v2 1/1] iommu: Bind process address spaces to devices
To:     Joerg Roedel <joro@8bytes.org>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        ashok.raj@intel.com, zhangfei.gao@foxmail.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        christian.koenig@amd.com
References: <20190320150258.3240-1-jean-philippe.brucker@arm.com>
 <20190320150258.3240-2-jean-philippe.brucker@arm.com>
 <20190325144241.GC25350@8bytes.org>
Message-ID: <31f7cee6-730c-7ca1-5107-358b8aa8f7b9@arm.com>
Date:   Mon, 1 Apr 2019 11:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190325144241.GC25350@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 25/03/2019 14:44, Joerg Roedel wrote:
> Hey Jean-Philippe,
> 
> thanks for the patch, I think we are on the finish line with this
> interface. Just one small question below.
> 
> On Wed, Mar 20, 2019 at 03:02:58PM +0000, Jean-Philippe Brucker wrote:
>> +int iommu_sva_set_ops(struct iommu_sva *handle,
>> +		      const struct iommu_sva_ops *sva_ops)
>> +{
>> +	const struct iommu_ops *ops = handle->dev->bus->iommu_ops;
>> +
>> +	if (!ops || !ops->sva_set_ops)
>> +		return -ENODEV;
>> +
>> +	return ops->sva_set_ops(handle, sva_ops);
>> +}
> 
> What is the purpose of the sva_set_ops call-back in iommu-ops? Is the
> IOMMU driver supposed to do some extra setup work with the provided ops?
> Otherwise we can just store the pointer in 'struct iommu_sva' without
> calling into the iommu driver.

Right that would be simpler. I added the sva_set_ops callback so that
IOMMU driver can use the same lock in unbind() and sva_set_ops(). But I
think it's safe to assume that device drivers don't call unbind() before
setting the ops.

Thanks,
Jean
