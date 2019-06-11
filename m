Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA7CC43218
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D272145D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 14:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390359AbfFKOfu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 10:35:50 -0400
Received: from foss.arm.com ([217.140.110.172]:34402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388292AbfFKOfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 10:35:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6932D337;
        Tue, 11 Jun 2019 07:35:49 -0700 (PDT)
Received: from [10.1.196.129] (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28CF33F557;
        Tue, 11 Jun 2019 07:35:48 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: Re: [PATCH 1/8] iommu: Add I/O ASID allocator
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     mark.rutland@arm.com, devicetree@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, robh+dt@kernel.org,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>
References: <20190610184714.6786-1-jean-philippe.brucker@arm.com>
 <20190610184714.6786-2-jean-philippe.brucker@arm.com>
 <20190611103625.00001399@huawei.com>
Message-ID: <62d1f310-0cba-4d55-0f16-68bba3c64927@arm.com>
Date:   Tue, 11 Jun 2019 15:35:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611103625.00001399@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/06/2019 10:36, Jonathan Cameron wrote:
>> +/**
>> + * ioasid_alloc - Allocate an IOASID
>> + * @set: the IOASID set
>> + * @min: the minimum ID (inclusive)
>> + * @max: the maximum ID (inclusive)
>> + * @private: data private to the caller
>> + *
>> + * Allocate an ID between @min and @max. The @private pointer is stored
>> + * internally and can be retrieved with ioasid_find().
>> + *
>> + * Return: the allocated ID on success, or %INVALID_IOASID on failure.
>> + */
>> +ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min, ioasid_t max,
>> +		      void *private)
>> +{
>> +	u32 id = INVALID_IOASID;
>> +	struct ioasid_data *data;
>> +
>> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
>> +	if (!data)
>> +		return INVALID_IOASID;
>> +
>> +	data->set = set;
>> +	data->private = private;
>> +
>> +	if (xa_alloc(&ioasid_xa, &id, data, XA_LIMIT(min, max), GFP_KERNEL)) {
>> +		pr_err("Failed to alloc ioasid from %d to %d\n", min, max);
>> +		goto exit_free;
>> +	}
>> +	data->id = id;
>> +
>> +exit_free:
> 
> This error flow is perhaps a little more confusing than it needs to be?
> 
> My assumption (perhaps wrong) is that we only have an id == INVALID_IOASID
> if the xa_alloc fails, and that we will always have such an id value if
> it does (I'm not totally sure this second element is true in __xa_alloc).
> 
> If I'm missing something perhaps a comment on how else we'd get here.

Yes we can simplify this:

		return id;
	exit_free:
		kfree(data)
		return INVALID_IOASID;
	}

The XA API doesn't say that @id passed to xa_alloc() won't be modified
in case of error. It's true in the current implementation, but won't
necessarily stay that way. On the other hand I think it's safe to expect
@id to always be set when xa_alloc() succeeds.

>> +/**
>> + * ioasid_find - Find IOASID data
>> + * @set: the IOASID set
>> + * @ioasid: the IOASID to find
>> + * @getter: function to call on the found object
>> + *
>> + * The optional getter function allows to take a reference to the found object
>> + * under the rcu lock. The function can also check if the object is still valid:
>> + * if @getter returns false, then the object is invalid and NULL is returned.
>> + *
>> + * If the IOASID has been allocated for this set, return the private pointer
>> + * passed to ioasid_alloc. Private data can be NULL if not set. Return an error
>> + * if the IOASID is not found or does not belong to the set.
> 
> Perhaps should make it clear that @set can be null.

Indeed. But I'm not sure allowing @set to be NULL is such a good idea,
because the data type associated to an ioasid depends on its set. For
example SVA will put an mm_struct in there, and auxiliary domains use
some structure private to the IOMMU domain.

Jacob, could me make @set mandatory, or do you see a use for a global
search? If @set is NULL, then callers can check if the return pointer is
NULL, but will run into trouble if they try to dereference it.

> 
>> + */
>> +void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>> +		  bool (*getter)(void *))
>> +{
>> +	void *priv = NULL;
> 
> Set in all paths, so does need to be set here.

Right

Thanks,
Jean
