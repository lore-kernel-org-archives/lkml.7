Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7659BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484E12075B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfB1XSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:18:42 -0500
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:35756 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1XSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:18:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 2BB106500C0;
        Thu, 28 Feb 2019 16:18:41 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
        by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NKWgAgrdid1s; Thu, 28 Feb 2019 16:18:40 -0700 (MST)
Received: from [155.98.67.65] (kalnik.cs.utah.edu [155.98.67.65])
        by smtps.cs.utah.edu (Postfix) with ESMTPSA id 8153A6500BF;
        Thu, 28 Feb 2019 16:18:40 -0700 (MST)
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
 <1551394596.31902.209.camel@acm.org>
From:   Shaobo He <shaobo@cs.utah.edu>
Message-ID: <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
Date:   Thu, 28 Feb 2019 16:18:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1551394596.31902.209.camel@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can't afford a pdf version of the C standard. So I looked at the draft version 
used in the link I put in the commit message. It says (in 6.2.4:2),

```
The lifetime of an object is the portion of program execution during which 
storage is guaranteed to be reserved for it. An object exists, has a constant 
address, and retains its last-stored value throughout its lifetime. If an object 
is referred to outside of its lifetime, the behavior is undefined. The value of 
a pointer becomes indeterminate when the object it points to (or just past) 
reaches the end of its lifetime.
```
I couldn't find the definition of lifetime over a dynamically allocated object 
in the draft of C standard. I refer to this link 
(https://en.cppreference.com/w/c/language/lifetime) which suggests that the 
lifetime of an allocated object ends after the deallocation function is called 
upon it.

I think maybe the more problematic issue is that the value of a freed pointer is 
intermediate.

Shaobo
On 2/28/19 3:56 PM, Bart Van Assche wrote:
> On Thu, 2019-02-28 at 15:38 -0700, Shaobo He wrote:
>> In function `c4iw_dealloc_mw`, variable mhp's value is printed after
>> freed, which triggers undefined behavior according to this post:
>> https://trust-in-soft.com/dangling-pointer-indeterminate/.
>>
>> This commit fixes it by swapping the order of `kfree` and `pr_debug`.
>>
>> Signed-off-by: Shaobo He <shaobo@cs.utah.edu>
>> ---
>>   drivers/infiniband/hw/cxgb4/mem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/cxgb4/mem.c b/drivers/infiniband/hw/cxgb4/mem.c
>> index 7b76e6f..bb8e0bc 100644
>> --- a/drivers/infiniband/hw/cxgb4/mem.c
>> +++ b/drivers/infiniband/hw/cxgb4/mem.c
>> @@ -684,8 +684,8 @@ int c4iw_dealloc_mw(struct ib_mw *mw)
>>   			  mhp->wr_waitp);
>>   	kfree_skb(mhp->dereg_skb);
>>   	c4iw_put_wr_wait(mhp->wr_waitp);
>> -	kfree(mhp);
>>   	pr_debug("ib_mw %p mmid 0x%x ptr %p\n", mw, mmid, mhp);
>> +	kfree(mhp);
>>   	return 0;
>>   }
> 
> Please quote the relevant paragraphs from the C standard. All I have found
> about free() in ISO/IEC 9899:2017 is the following:
> 
> Description
> The free function causes the space pointed to by ptr to be deallocated, that
> is, made available for further allocation. If ptr is a null pointer, no
> action occurs. Otherwise, if the argument does not match a pointer earlier
> returned by a memory management function, or if the space has been
> deallocated by a call to free or realloc, the behavior is undefined.
> 
> That is not sufficient to claim that the above code triggers undefined
> behavior.
> 
> Bart.
> 
