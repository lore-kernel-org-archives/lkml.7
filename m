Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A1DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFBD206DD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfCAVVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 16:21:32 -0500
Received: from rio.cs.utah.edu ([155.98.64.241]:58537 "EHLO
        mail-svr1.cs.utah.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAVVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 16:21:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail-svr1.cs.utah.edu (Postfix) with ESMTP id 0E1CF650102;
        Fri,  1 Mar 2019 14:21:30 -0700 (MST)
Received: from mail-svr1.cs.utah.edu ([127.0.0.1])
        by localhost (mail-svr1.cs.utah.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bXf882Z9WytB; Fri,  1 Mar 2019 14:21:29 -0700 (MST)
Received: from [192.168.3.5] (dhcp-155-97-238-209.usahousing.utah.edu [155.97.238.209])
        by smtps.cs.utah.edu (Postfix) with ESMTPSA id 11F4F6500F1;
        Fri,  1 Mar 2019 14:21:29 -0700 (MST)
Subject: Re: [PATCH] cxgb4: fix undefined behavior in mem.c
To:     Doug Ledford <dledford@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org
Cc:     Steve Wise <swise@chelsio.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        open list <linux-kernel@vger.kernel.org>, cl@linux.com
References: <1551393519-96595-1-git-send-email-shaobo@cs.utah.edu>
 <1551394596.31902.209.camel@acm.org>
 <abf425b1-19ba-9cf5-8288-87ac0dbf6ac7@cs.utah.edu>
 <1551396788.31902.213.camel@acm.org>
 <a03cc0b7-c508-4937-f2dc-c5f9dbc356ba@cs.utah.edu>
 <d796cd9bea794179136b869218dcad5755380029.camel@redhat.com>
From:   Shaobo He <shaobo@cs.utah.edu>
Message-ID: <73050221-dd7f-169f-a3c0-69e022f13407@cs.utah.edu>
Date:   Fri, 1 Mar 2019 14:21:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <d796cd9bea794179136b869218dcad5755380029.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, why wouldn't they be real bugs? I was simply pointing out the irrational 
conclusion if the C standard is strictly applied to kernel code.

I think the spirit of the C standard is that one shouldn't rely on the 
assumption that the value of a freed pointer does not change, even though in 
practice any compiler developers probably won't bother to implement the logic to 
change the pointer value or optimizations leveraging it even they are allowed 
to. In other words, the original code may be a little bit problematic in the 
spirit of the C standard whereas the patch simply makes it totally valid.

If it can be finally submitted, that would be great. If not, I'm totally fine.

Shaobo
On 2019/3/1 7:26, Doug Ledford wrote:
> On Thu, 2019-02-28 at 16:57 -0700, Shaobo He wrote:
>> Good catch. But if we agree on that memory management functions are those
>> specified by the C standard, would it be OK to ignore so-called use after free
>> or double free bugs for the kernel as C standard does not apply to kfree?
> 
> No, most kernel use-after-free bugs are real bugs.  This one might be
> technically a bug by certain readings of the standard, but it's a non-
> issue.  Real use-after-free bugs don't just look at the value of a local
> stack variable to get the memory's old address (which is what this does,
> and the same could be achieved and be totally in spec by doing this:
> 
>      old_ptr = mhp;
>      kfree(mhp);
>      pr_debug("%p\n", old_ptr);)
> 
> Real use after free things would actually dereference the pointer to
> either read or write from the old memory region.  That leads to data
> corruption or kernel data leaks.  Plus, in this case, the purpose of
> printing the literal value of mhp is simply to provide a unique name for
> tracing purposes.  Since kfree() doesn't alter the local stack variable,
> the name is still present in the local stack variable at the point you
> call pr_debug().
> 
> It could be fixed.  It's not like this patch is wrong.  But I wouldn't
> submit it this late in the -rc cycle, I'd just take it for next.
> 
>> On 2/28/19 4:33 PM, Bart Van Assche wrote:
>>> On Thu, 2019-02-28 at 16:18 -0700, Shaobo He wrote:
>>>> I can't afford a pdf version of the C standard. So I looked at the draft version
>>>> used in the link I put in the commit message. It says (in 6.2.4:2),
>>>>
>>>> ```
>>>> The lifetime of an object is the portion of program execution during which
>>>> storage is guaranteed to be reserved for it. An object exists, has a constant
>>>> address, and retains its last-stored value throughout its lifetime. If an object
>>>> is referred to outside of its lifetime, the behavior is undefined. The value of
>>>> a pointer becomes indeterminate when the object it points to (or just past)
>>>> reaches the end of its lifetime.
>>>> ```
>>>> I couldn't find the definition of lifetime over a dynamically allocated object
>>>> in the draft of C standard. I refer to this link
>>>> (https://en.cppreference.com/w/c/language/lifetime) which suggests that the
>>>> lifetime of an allocated object ends after the deallocation function is called
>>>> upon it.
>>>>
>>>> I think maybe the more problematic issue is that the value of a freed pointer is
>>>> intermediate.
>>>
>>> In another section of the same draft I found the following:
>>>
>>> J.2 Undefined behavior [ ... ] The value of a pointer that refers to space
>>> deallocated by a call to the free or realloc function is used (7.22.3).
>>>
>>> Since the C standard explicitly refers to free() and realloc(), does that
>>> mean that that statement about undefined behavior does not apply to munmap()
>>> (for user space code) nor to kfree() (for kernel code)?
>>>
>>> Bart.
>>>
> 
