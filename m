Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64313C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AD5A208CA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 11:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406413AbfFLLae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 07:30:34 -0400
Received: from foss.arm.com ([217.140.110.172]:50970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727352AbfFLLae (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 07:30:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F9C428;
        Wed, 12 Jun 2019 04:30:33 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C93383F246;
        Wed, 12 Jun 2019 04:32:14 -0700 (PDT)
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Will Deacon <Will.Deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-2-jean-philippe.brucker@arm.com>
 <20190611052626.20bed59a@jacob-builder>
 <95292b47-4cf4-5fd9-b096-1cb016e2264f@arm.com>
 <20190611101052.35af46df@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <f68f4ccb-1422-4f93-dc9c-2bcdf61c9ed4@arm.com>
Date:   Wed, 12 Jun 2019 12:30:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611101052.35af46df@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 18:10, Jacob Pan wrote:
>> The issue is theoretical at the moment because no users do this, but
>> I'd be more comfortable taking the xa_lock, which prevents a
>> concurrent xa_erase()+free(). (I commented on your v3 but you might
>> have missed it)
>>
> Did you reply to my v3? I did not see it. I only saw your comments about
> v3 in your commit message.

My fault, I sneaked the comments in a random reply three levels down the
thread:
https://lore.kernel.org/linux-iommu/836caf0d-699e-33ba-5303-b1c9c949c9ca@arm.com/

(Great, linux-iommu is indexed by lore! I won't have to Cc lkml anymore)

>>>> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
>>>> +	if (ioasid_data)
>>>> +		rcu_assign_pointer(ioasid_data->private, data);  
>>> it is good to publish and have barrier here. But I just wonder even
>>> for weakly ordered machine, this pointer update is quite far away
>>> from its data update.  
>>
>> I don't know, it could be right before calling ioasid_set_data():
>>
>> 	mydata = kzalloc(sizeof(*mydata));
>> 	mydata->ops = &my_ops;			(1)
>> 	ioasid_set_data(ioasid, mydata);
>> 		... /* no write barrier here */
>> 		data->private = mydata;		(2)
>>
>> And then another thread calls ioasid_find():
>>
>> 	mydata = ioasid_find(ioasid);
>> 	if (mydata)
>> 		mydata->ops->do_something();
>>
>> On a weakly ordered machine, this thread could observe the pointer
>> assignment (2) before the ops assignment (1), and dereference NULL.
>> Using rcu_assign_pointer() should fix that
>>
> I agree it is better to have the barrier. Just thought there is already
> a rcu_read_lock() in xa_load() in between. rcu_read_lock() may have
> barrier in some case but better not count on it. 

Yes, and even if rcu_read_lock() provided a barrier I don't think it
would be sufficient, because acquire semantics don't guarantee that
prior writes appear to happen before the barrier, only the other way
round. A lock operation with release semantics, for example
spin_unlock(), should work.

Thanks,
Jean

> No issues here. I will
> integrate this in the next version.
> 
>> Thanks,
>> Jean
> 
> [Jacob Pan]
> 

