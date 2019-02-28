Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD402C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899612087E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 23:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbfB1X5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 18:57:08 -0500
Received: from mail-svr1.cs.utah.edu ([155.98.64.241]:36815 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfB1X5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 18:57:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 3F13E6500BF;
        Thu, 28 Feb 2019 16:57:07 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
        by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8qXCwX2cOliC; Thu, 28 Feb 2019 16:57:06 -0700 (MST)
Received: from [155.98.67.65] (kalnik.cs.utah.edu [155.98.67.65])
        by smtps.cs.utah.edu (Postfix) with ESMTPSA id B6E1C6500B9;
        Thu, 28 Feb 2019 16:57:06 -0700 (MST)
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
To:     Bart Van Assche <bvanassche@acm.org>, linux-rdma@vger.kernel.org
Cc:     Steve Wise <swise@chelsio.com>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
 <1551394596.31902.209.camel@acm.org>
 <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
 <1551396788.31902.213.camel@acm.org>
From:   Shaobo He <shaobo@cs.utah.edu>
Message-ID: <a03cc0b7-c508-4937-f2dc-c5f9dbc356ba@cs.utah.edu>
Date:   Thu, 28 Feb 2019 16:57:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.2
MIME-Version: 1.0
In-Reply-To: <1551396788.31902.213.camel@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch. But if we agree on that memory management functions are those 
specified by the C standard, would it be OK to ignore so-called use after free 
or double free bugs for the kernel as C standard does not apply to kfree?

On 2/28/19 4:33 PM, Bart Van Assche wrote:
> On Thu, 2019-02-28 at 16:18 -0700, Shaobo He wrote:
>> I can't afford a pdf version of the C standard. So I looked at the draft version
>> used in the link I put in the commit message. It says (in 6.2.4:2),
>>
>> ```
>> The lifetime of an object is the portion of program execution during which
>> storage is guaranteed to be reserved for it. An object exists, has a constant
>> address, and retains its last-stored value throughout its lifetime. If an object
>> is referred to outside of its lifetime, the behavior is undefined. The value of
>> a pointer becomes indeterminate when the object it points to (or just past)
>> reaches the end of its lifetime.
>> ```
>> I couldn't find the definition of lifetime over a dynamically allocated object
>> in the draft of C standard. I refer to this link
>> (https://en.cppreference.com/w/c/language/lifetime) which suggests that the
>> lifetime of an allocated object ends after the deallocation function is called
>> upon it.
>>
>> I think maybe the more problematic issue is that the value of a freed pointer is
>> intermediate.
> 
> In another section of the same draft I found the following:
> 
> J.2 Undefined behavior [ ... ] The value of a pointer that refers to space
> deallocated by a call to the free or realloc function is used (7.22.3).
> 
> Since the C standard explicitly refers to free() and realloc(), does that
> mean that that statement about undefined behavior does not apply to munmap()
> (for user space code) nor to kfree() (for kernel code)?
> 
> Bart.
> 
