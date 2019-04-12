Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB325C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1EDF20675
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfDLMYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 08:24:16 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:59782 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbfDLMYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 08:24:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC349374;
        Fri, 12 Apr 2019 05:24:14 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C54E3F718;
        Fri, 12 Apr 2019 05:24:13 -0700 (PDT)
Subject: Re: [PATCH v3 1/1] iommu: Bind process address spaces to devices
To:     Joerg Roedel <joro@8bytes.org>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>,
        "kevin.tian@intel.com" <kevin.tian@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
References: <20190410151516.47754-1-jean-philippe.brucker@arm.com>
 <20190410151516.47754-2-jean-philippe.brucker@arm.com>
 <20190411152803.GB29810@8bytes.org>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <aa213d61-2351-73f4-629c-08a18320fbec@arm.com>
Date:   Fri, 12 Apr 2019 13:23:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190411152803.GB29810@8bytes.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2019 16:28, Joerg Roedel wrote:
> On Wed, Apr 10, 2019 at 04:15:16PM +0100, Jean-Philippe Brucker wrote:
>>  drivers/iommu/iommu.c | 104 ++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/iommu.h |  70 ++++++++++++++++++++++++++++
>>  2 files changed, 174 insertions(+)
> 
> Applied to the api-features branch for now, thanks Jean-Philippe!
> 
> 'for now' because I have a question below.
> 
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ed6738c358ca..87fe1cddd817 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -51,10 +51,13 @@ struct device;
>>  struct iommu_domain;
>>  struct notifier_block;
>>  struct iommu_fault_event;
>> +struct iommu_sva;
> 
> The iommu_fault_event doesn't yet exist in my tree, is this patch based
> on something else I need besided Lu Baolus work? I got quite some
> conflicts while applying the patch because of this.

Ugh, sorry about this, I forgot to rebase onto master. The only required
patch is Lu Baolu's "iommu: Add APIs for multiple domains per device".
The iommu_fault_event is introduced by Jacob's fault reporting work, but
is independent from this patch.

There also is a small conflict with the SMMUv3 ATS work, which I'm
hoping to get in v5.2 as well (but will probably require more work).
I'll send next version of ATS applied on top of this patch.

I pushed a cleaner version to git://linux-arm.org/linux-jpb.git sva/api
(with the below mistake fixed as well) and can resend if necessary.

Thanks,
Jean

> 
>> + * @sva_set_ops: Set ops for a SVA handle
> 
> I also removed this line.
> 
> Regards,
> 
>         Joerg

