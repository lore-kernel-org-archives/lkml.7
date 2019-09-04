Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07227C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B1720820
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 16:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbfIDQH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 12:07:27 -0400
Received: from ale.deltatee.com ([207.54.116.67]:57316 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728878AbfIDQHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 12:07:20 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i5XoS-0006yr-3P; Wed, 04 Sep 2019 10:07:17 -0600
To:     Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
Date:   Wed, 4 Sep 2019 10:07:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904155445.GD21302@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, martin.petersen@oracle.com, sagi@grimberg.me, hare@suse.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-09-04 9:54 a.m., Keith Busch wrote:
> On Wed, Sep 04, 2019 at 05:42:15PM +0200, Christoph Hellwig wrote:
>> On Wed, Sep 04, 2019 at 08:44:27AM -0600, Keith Busch wrote:
>>> Let me step through an example:
>>>
>>>   Ctrl A gets instance 0.
>>>
>>>   Its subsystem gets the same instance, and takes ref count on it:
>>>   all namespaces in this subsystem will use '0'.
>>>
>>>   Ctrl B gets instance 1, and it's in the same subsystem as Ctrl A so
>>>   no new subsytem is allocated.
>>>
>>>   Ctrl A is disconnected, dropping its ref on instance 0, but the
>>>   subsystem still has its refcount, making it unavailable.
>>>
>>>   Ctrl A is reconnected, and allocates instance 2 because 0 is still in
>>>   use.
>>>
>>> Now all the namespaces in this subsystem are prefixed with nvme0, but no
>>> controller exists with the same prefix. We still have inevitable naming
>>> mismatch, right?
>>
>> I think th major confusion was that we can use the same handle for
>> and unrelated subsystem vs controller, and that would avoid it.
>>
>> I don't see how we can avoid the controller is entirely different
>> from namespace problem ever.


Yes, I agree, we can't solve the mismatch problem in the general case:
with sequences of hot plug events there will always be a case that
mismatches. I just think we can do better in the simple common default case.


> Can we just ensure there is never a matching controller then? This
> patch will accomplish that and simpler than wrapping the instance in a
> refcount'ed object:
> 
> http://lists.infradead.org/pipermail/linux-nvme/2019-May/024142.html

I don't really like that idea. It reduces the confusion caused by
mismatching numbers, but causes the controller to never match the
namespace, which is also confusing but in a different way.

I like the nvme_instance idea. It's not going to be perfect but it has
some nice properties: the subsystem will try to match the controller's
instance whenever possible, but in cases where it doesn't, the instance
number of the subsystem will never be the same as an existing controller.

I'll see if I can work up a quick patch set and see what people think.

Logan
