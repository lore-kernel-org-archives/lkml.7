Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDA8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5448921855
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 17:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfCNRB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 13:01:26 -0400
Received: from mx0.arrikto.com ([212.71.252.59]:34328 "EHLO mx0.arrikto.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfCNRB0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 13:01:26 -0400
Received: from troi.prod.arr (mail.arr [10.99.0.5])
        by mx0.arrikto.com (Postfix) with ESMTP id 3CF50182004;
        Thu, 14 Mar 2019 19:01:24 +0200 (EET)
Received: from [10.89.50.3] (nivel.vpn.arr [10.89.50.3])
        by troi.prod.arr (Postfix) with ESMTPSA id B4EB260;
        Thu, 14 Mar 2019 19:01:23 +0200 (EET)
Subject: Re: [dm-devel] [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind
 helpers
To:     paulmck@linux.ibm.com
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-kernel@vger.kernel.org,
        iliastsi@arrikto.com, hch@infradead.org, dm-devel@redhat.com,
        mpatocka@redhat.com, agk@redhat.com
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com> <20190313234853.GA7797@linux.ibm.com>
 <20190314003027.GE4202@redhat.com>
 <f70ea4c9-658d-5770-be7f-a1a97bb67643@arrikto.com>
 <20190314140750.GB4102@linux.ibm.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <86a26792-03ad-0dc4-737e-8fd5a3a79fa8@arrikto.com>
Date:   Thu, 14 Mar 2019 19:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314140750.GB4102@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 4:07 PM, Paul E. McKenney wrote:
> On Thu, Mar 14, 2019 at 03:28:23PM +0200, Nikos Tsironis wrote:
>> On 3/14/19 2:30 AM, Mike Snitzer wrote:
>>> On Wed, Mar 13 2019 at  7:48pm -0400,
>>> Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>>>
>> Hi Paul,
>>
>> Thanks a lot for your feedback!
> 
> NP, and apologies for the delay.
> 
>>>> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
>>>>> On Thu, Dec 20 2018 at  1:06pm -0500,
>>>>> Nikos Tsironis <ntsironis@arrikto.com> wrote:
>>>>>
>>>>>> Add hlist_bl_add_before/behind helpers to add an element before/after an
>>>>>> existing element in a bl_list.
>>>>>>
>>>>>> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
>>>>>> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
>>>>>> ---
>>>>>>  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
>>>>>>  1 file changed, 27 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>>>>>> index 3fc2cc57ba1b..2fd918e5fd48 100644
>>>>>> --- a/include/linux/list_bl.h
>>>>>> +++ b/include/linux/list_bl.h
>>>>>> @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>>>>>>  	hlist_bl_set_first(h, n);
>>>>>>  }
>>>>>>  
>>>>>> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>>>>>> +				       struct hlist_bl_node *next)
>>>>>> +{
>>>>>> +	struct hlist_bl_node **pprev = next->pprev;
>>>>>> +
>>>>>> +	n->pprev = pprev;
>>>>>> +	n->next = next;
>>>>>> +	next->pprev = &n->next;
>>>>>> +
>>>>>> +	/* pprev may be `first`, so be careful not to lose the lock bit */
>>>>>> +	WRITE_ONCE(*pprev,
>>>>>> +		   (struct hlist_bl_node *)
>>>>>> +			((unsigned long)n |
>>>>>> +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
>>>>
>>>> A nit, but use of uintptr_t shrinks things a bit:
>>>>
>>>> +		   (struct hlist_bl_node *)
>>>> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
>>>>
>>>> I am not too concerned about this, though.
>>>
>>> I'm fine with folding in your suggestion.
>>
>> Indeed, this looks better.
>>
>>>> The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
>>>> the corresponding READ_ONCE()) correct?
>>>
>>> Correct.
>>
>> Yes that's correct.
>>
>>>>>> +}
>>>>>> +
>>>>>> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
>>>>>> +				       struct hlist_bl_node *prev)
>>>>>> +{
>>>>>> +	n->next = prev->next;
>>>>>> +	n->pprev = &prev->next;
>>>>>> +	WRITE_ONCE(prev->next, n);
>>>>
>>>> I don't see what this WRITE_ONCE() is interacting with.  The traversals
>>>> use plain C-language reads, and hlist_bl_empty() can't get here.  All
>>>> uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
>>>> the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
>>>> (Perhaps it should be removed?  Or is there some anticipated use?)
>>
>> I am using hlist_bl_for_each_entry_safe() in this proposed patch for
>> dm-snapshot: https://patchwork.kernel.org/patch/10835709/
> 
> Probably should keep it, then.  ;-)
> 
>>>>
>>>> I don't believe that the WRITE_ONCE() is needed.  What am I missing?
>>>>
>>>> Other than that, looks good.
>>>>
>>>> 							Thanx, Paul
>>>>
>>>
>>> I'd imagine it was just born out of symmetry with hlist_bl_add_before()
>>> and/or caution.  But let's see what Nikos has to say.
>>
>> I also don't believe that this WRITE_SAME() is needed. But, looking at
>> hlist_add_behind() in include/linux/list.h, which, if I am not missing
>> something, is used in the same way as hlist_bl_add_behind(), it also
>> uses WRITE_ONCE() to update prev->next:
>>
>> static inline void hlist_add_behind(struct hlist_node *n,
>> 				    struct hlist_node *prev)
>> {
>> 	n->next = prev->next;
>> 	WRITE_ONCE(prev->next, n);
>> 	n->pprev = &prev->next;
>>
>> 	if (n->next)
>> 		n->next->pprev  = &n->next;
>> }
>>
>> Could it be the case that the WRITE_ONCE() in hlist_add_behind() is also
>> not needed? This WRITE_ONCE() was introduced by commit 1c97be677f72b3
>> ("list: Use WRITE_ONCE() when adding to lists and hlists").
> 
> Looks like I have no one to blame but myself!
> 
> Would you like to remove that as part of your patch series?

Yes, Of course. I will add an extra patch removing the WRITE_ONCE() from
hlist_add_behind().

Thanks,
Nikos

> 
>> But, since I am not an expert in lockless programming, I opted to be on
>> the safe side and followed the example of hlist_add_behind().
>>
>> That said, I will follow up with a new version of the patch removing the
>> WRITE_ONCE() and using uintptr_t instead of unsigned long.
> 
> Sounds good!
> 
> 							Thanx, Paul
> 
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://www.redhat.com/mailman/listinfo/dm-devel
> 
