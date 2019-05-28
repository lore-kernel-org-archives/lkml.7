Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD75EC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A95C420717
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 11:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfE1LvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 07:51:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42764 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726844AbfE1LvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 07:51:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37A12C072269;
        Tue, 28 May 2019 11:51:21 +0000 (UTC)
Received: from [10.36.116.67] (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 402E65D6A9;
        Tue, 28 May 2019 11:51:14 +0000 (UTC)
Subject: Re: [PATCH v4 3/8] iommu/vt-d: Duplicate iommu_resv_region objects
 per device list
To:     Joerg Roedel <joro@8bytes.org>
Cc:     eric.auger.pro@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dwmw2@infradead.org,
        lorenzo.pieralisi@arm.com, robin.murphy@arm.com,
        will.deacon@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com,
        alex.williamson@redhat.com, shameerali.kolothum.thodi@huawei.com
References: <20190527085541.5294-1-eric.auger@redhat.com>
 <20190527085541.5294-4-eric.auger@redhat.com>
 <20190527152303.GD12745@8bytes.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <26e14927-0ec5-2472-54a2-4498a2145c19@redhat.com>
Date:   Tue, 28 May 2019 13:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190527152303.GD12745@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 28 May 2019 11:51:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 5/27/19 5:23 PM, Joerg Roedel wrote:
> On Mon, May 27, 2019 at 10:55:36AM +0200, Eric Auger wrote:
>> -			list_add_tail(&rmrr->resv->list, head);
>> +			length = rmrr->end_address - rmrr->base_address + 1;
>> +			resv = iommu_alloc_resv_region(rmrr->base_address,
>> +						       length, prot,
>> +						       IOMMU_RESV_DIRECT,
>> +						       GFP_ATOMIC);
>> +			if (!resv)
>> +				break;
>> +
>> +			list_add_tail(&resv->list, head);
> 
> Okay, so this happens in a rcu_read_locked section and must be atomic,
> but I don't like this extra parameter to iommu_alloc_resv_region().
> 
> How about replacing the rcu-lock with the dmar_global_lock, which
> protects against changes to the global rmrr list? This will make this
> loop preemptible and taking the global lock is okay because this
> function is in no way performance relevant.

After studying in more details the for_each_active_dev_scope macro and
rcu_dereference_check it looks OK to me. I respinned accordingly.

Thanks

Eric
> 
> Regards,
> 
> 	Joerg
> 
