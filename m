Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A3C43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32EF420896
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391155AbfFKOiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:38:10 -0400
Received: from foss.arm.com ([217.140.110.172]:34570 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387486AbfFKOiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:38:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35FBD337;
        Tue, 11 Jun 2019 07:38:09 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C1583F557;
        Tue, 11 Jun 2019 07:38:07 -0700 (PDT)
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-2-jean-philippe.brucker@arm.com>
 <20190611052626.20bed59a@jacob-builder>
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <95292b47-4cf4-5fd9-b096-1cb016e2264f@arm.com>
Date:   Tue, 11 Jun 2019 15:37:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611052626.20bed59a@jacob-builder>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 13:26, Jacob Pan wrote:
>> +/**
>> + * ioasid_set_data - Set private data for an allocated ioasid
>> + * @ioasid: the ID to set data
>> + * @data:   the private data
>> + *
>> + * For IOASID that is already allocated, private data can be set
>> + * via this API. Future lookup can be done via ioasid_find.
>> + */
>> +int ioasid_set_data(ioasid_t ioasid, void *data)
>> +{
>> +	struct ioasid_data *ioasid_data;
>> +	int ret = 0;
>> +
>> +	xa_lock(&ioasid_xa);
> Just wondering if this is necessary, since xa_load is under
> rcu_read_lock and we are not changing anything internal to xa. For
> custom allocator I still need to have the mutex against allocator
> removal.

I think we do need this because of a possible race with ioasid_free():

         CPU1                      CPU2
  ioasid_free(ioasid)     ioasid_set_data(ioasid, foo)
                            data = xa_load(...)
    xa_erase(...)
    kfree_rcu(data)           (no RCU lock held)
    ...free(data)
                            data->private = foo;

The issue is theoretical at the moment because no users do this, but I'd
be more comfortable taking the xa_lock, which prevents a concurrent
xa_erase()+free(). (I commented on your v3 but you might have missed it)

>> +	ioasid_data = xa_load(&ioasid_xa, ioasid);
>> +	if (ioasid_data)
>> +		rcu_assign_pointer(ioasid_data->private, data);
> it is good to publish and have barrier here. But I just wonder even for
> weakly ordered machine, this pointer update is quite far away from its
> data update.

I don't know, it could be right before calling ioasid_set_data():

	mydata = kzalloc(sizeof(*mydata));
	mydata->ops = &my_ops;			(1)
	ioasid_set_data(ioasid, mydata);
		... /* no write barrier here */
		data->private = mydata;		(2)

And then another thread calls ioasid_find():

	mydata = ioasid_find(ioasid);
	if (mydata)
		mydata->ops->do_something();

On a weakly ordered machine, this thread could observe the pointer
assignment (2) before the ops assignment (1), and dereference NULL.
Using rcu_assign_pointer() should fix that

Thanks,
Jean
