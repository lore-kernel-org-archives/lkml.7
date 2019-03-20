Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 709D0C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C0D218A6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="Kygu0tiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbfCTUZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:25:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37309 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTUZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:25:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id w10so2769456wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MHZP+AxeIuRWFzIxL8Jt/aPfs8sKuTbsmTDggMYL2yk=;
        b=Kygu0tiQqQIYi4heVt4vt6+MwLW21wa0MMbx2BUVCFiw1HnlvxXSGTTJEGR5eSP8eO
         LLVYQsJA/ZN02gR4s65qNGTQItWHirPir+AQYq8/ddv/eGW8+zE0xA03XLKfb4dZ/VEu
         isgIK58CyLbFQtO7Ynxtrp627pUQu0TLxCmbXQNCxogkWBtkSF4fljPu3cNVtLJ4a27R
         wX6cX++dMdyMLLmr04xeRYfLbCRFkxWfS42mAdzg9NdeSfvXPPSv4XwWWLwizEyEDDwQ
         81bm9K6KxdU20Vef5R13+FW5HNbNQD4s6+OW07gpmSFmQgR1H8y/8mDsLfY/MTee4UFV
         /r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MHZP+AxeIuRWFzIxL8Jt/aPfs8sKuTbsmTDggMYL2yk=;
        b=eX8p3hDFQ10YCVHKRh5MAomUgBiQksCIPu52oOZDLFcH43yt8xSvh/BSry63gdn1AY
         7N89y5lT1O6az8NfGPNRKnpu+bnUfFJFdja+8FSEE7R+bRFVbrRDPFaCFpMjcljMwldl
         tnVRrWU4InXv1PZ2/qcyNY4ia/bgRU9DMyH8DiSaf35M3Hyo+LCbhKXYV9jkq0QZdW/9
         n6Ax9dUZOZ/pJwuT24TsmnTgnAy2KT+6QiMpJ6IlRXi9+WB6hcf8VHJQWOdEitl+MFX/
         U7I+dt1XPtTIoO7MnHQfbTB7+OMz6dyMd/NAh5K1Oq7scMsXyN7O4gUWsCEZfsoG97uG
         kJqQ==
X-Gm-Message-State: APjAAAUmdWcn5QfDQnvlfpxKojx5O9Q1NGfC57E95uW1KfusqLl2JadH
        fquN5Gvdt7gvHz37/nDF96jqJgBqgYE=
X-Google-Smtp-Source: APXvYqyvfmdRVOtldNK5ELJlJVd/gOt9R0lWZBiX6aw+IyzDgMnUNLoVwlq6cuMJINVKYJH33vc/Rg==
X-Received: by 2002:adf:e547:: with SMTP id z7mr50505wrm.295.1553113550967;
        Wed, 20 Mar 2019 13:25:50 -0700 (PDT)
Received: from [192.168.1.109] (46.246.177.193.dsl.dyn.forthnet.gr. [46.246.177.193])
        by smtp.gmail.com with ESMTPSA id m6sm5273844wrr.53.2019.03.20.13.25.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:25:50 -0700 (PDT)
Subject: Re: [dm-devel] [PATCH 1/3] list_bl: Add hlist_bl_add_before/behind
 helpers
To:     paulmck@linux.ibm.com
Cc:     Mike Snitzer <snitzer@redhat.com>, hch@infradead.org,
        agk@redhat.com, dm-devel@redhat.com, mpatocka@redhat.com,
        iliastsi@arrikto.com, linux-kernel@vger.kernel.org
References: <20181220180651.4879-1-ntsironis@arrikto.com>
 <20181220180651.4879-2-ntsironis@arrikto.com>
 <20190228213201.GB23527@redhat.com> <20190313234853.GA7797@linux.ibm.com>
 <20190314003027.GE4202@redhat.com>
 <f70ea4c9-658d-5770-be7f-a1a97bb67643@arrikto.com>
 <20190314140750.GB4102@linux.ibm.com> <20190314150306.GA22051@linux.ibm.com>
 <ad704078-1a28-5726-c428-7be19dbe2466@arrikto.com>
 <20190318171640.GM4102@linux.ibm.com>
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <f5d715d6-7300-eccb-a67a-fc3a41b537db@arrikto.com>
Date:   Wed, 20 Mar 2019 22:25:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190318171640.GM4102@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/18/19 7:16 PM, Paul E. McKenney wrote:
> On Sun, Mar 17, 2019 at 01:52:50PM +0200, Nikos Tsironis wrote:
>> On 3/14/19 5:03 PM, Paul E. McKenney wrote:
>>> On Thu, Mar 14, 2019 at 07:07:50AM -0700, Paul E. McKenney wrote:
>>>> On Thu, Mar 14, 2019 at 03:28:23PM +0200, Nikos Tsironis wrote:
>>>>> On 3/14/19 2:30 AM, Mike Snitzer wrote:
>>>>>> On Wed, Mar 13 2019 at  7:48pm -0400,
>>>>>> Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>>>>>>
>>>>> Hi Paul,
>>>>>
>>>>> Thanks a lot for your feedback!
>>>>
>>>> NP, and apologies for the delay.
>>>>
>>>>>>> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
>>>>>>>> On Thu, Dec 20 2018 at  1:06pm -0500,
>>>>>>>> Nikos Tsironis <ntsironis@arrikto.com> wrote:
>>>>>>>>
>>>>>>>>> Add hlist_bl_add_before/behind helpers to add an element before/after an
>>>>>>>>> existing element in a bl_list.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
>>>>>>>>> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
>>>>>>>>> ---
>>>>>>>>>  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
>>>>>>>>>  1 file changed, 27 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>>>>>>>>> index 3fc2cc57ba1b..2fd918e5fd48 100644
>>>>>>>>> --- a/include/linux/list_bl.h
>>>>>>>>> +++ b/include/linux/list_bl.h
>>>>>>>>> @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>>>>>>>>>  	hlist_bl_set_first(h, n);
>>>>>>>>>  }
>>>>>>>>>  
>>>>>>>>> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>>>>>>>>> +				       struct hlist_bl_node *next)
>>>>>>>>> +{
>>>>>>>>> +	struct hlist_bl_node **pprev = next->pprev;
>>>>>>>>> +
>>>>>>>>> +	n->pprev = pprev;
>>>>>>>>> +	n->next = next;
>>>>>>>>> +	next->pprev = &n->next;
>>>>>>>>> +
>>>>>>>>> +	/* pprev may be `first`, so be careful not to lose the lock bit */
>>>>>>>>> +	WRITE_ONCE(*pprev,
>>>>>>>>> +		   (struct hlist_bl_node *)
>>>>>>>>> +			((unsigned long)n |
>>>>>>>>> +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
>>>>>>>
>>>>>>> A nit, but use of uintptr_t shrinks things a bit:
>>>>>>>
>>>>>>> +		   (struct hlist_bl_node *)
>>>>>>> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
>>>>>>>
>>>>>>> I am not too concerned about this, though.
>>>>>>
>>>>>> I'm fine with folding in your suggestion.
>>>>>
>>>>> Indeed, this looks better.
>>>>>
>>>>>>> The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
>>>>>>> the corresponding READ_ONCE()) correct?
>>>>>>
>>>>>> Correct.
>>>>>
>>>>> Yes that's correct.
>>>>>
>>>>>>>>> +}
>>>>>>>>> +
>>>>>>>>> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
>>>>>>>>> +				       struct hlist_bl_node *prev)
>>>>>>>>> +{
>>>>>>>>> +	n->next = prev->next;
>>>>>>>>> +	n->pprev = &prev->next;
>>>>>>>>> +	WRITE_ONCE(prev->next, n);
>>>>>>>
>>>>>>> I don't see what this WRITE_ONCE() is interacting with.  The traversals
>>>>>>> use plain C-language reads, and hlist_bl_empty() can't get here.  All
>>>>>>> uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
>>>>>>> the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
>>>>>>> (Perhaps it should be removed?  Or is there some anticipated use?)
>>>>>
>>>>> I am using hlist_bl_for_each_entry_safe() in this proposed patch for
>>>>> dm-snapshot: https://patchwork.kernel.org/patch/10835709/
>>>>
>>>> Probably should keep it, then.  ;-)
>>>>
>>>>>>>
>>>>>>> I don't believe that the WRITE_ONCE() is needed.  What am I missing?
>>>>>>>
>>>>>>> Other than that, looks good.
>>>>>>>
>>>>>>> 							Thanx, Paul
>>>>>>>
>>>>>>
>>>>>> I'd imagine it was just born out of symmetry with hlist_bl_add_before()
>>>>>> and/or caution.  But let's see what Nikos has to say.
>>>>>
>>>>> I also don't believe that this WRITE_SAME() is needed. But, looking at
>>>>> hlist_add_behind() in include/linux/list.h, which, if I am not missing
>>>>> something, is used in the same way as hlist_bl_add_behind(), it also
>>>>> uses WRITE_ONCE() to update prev->next:
>>>>>
>>>>> static inline void hlist_add_behind(struct hlist_node *n,
>>>>> 				    struct hlist_node *prev)
>>>>> {
>>>>> 	n->next = prev->next;
>>>>> 	WRITE_ONCE(prev->next, n);
>>>>> 	n->pprev = &prev->next;
>>>>>
>>>>> 	if (n->next)
>>>>> 		n->next->pprev  = &n->next;
>>>>> }
>>>>>
>>>>> Could it be the case that the WRITE_ONCE() in hlist_add_behind() is also
>>>>> not needed? This WRITE_ONCE() was introduced by commit 1c97be677f72b3
>>>>> ("list: Use WRITE_ONCE() when adding to lists and hlists").
>>>>
>>>> Looks like I have no one to blame but myself!
>>>>
>>>> Would you like to remove that as part of your patch series?
>>>>
>>>>> But, since I am not an expert in lockless programming, I opted to be on
>>>>> the safe side and followed the example of hlist_add_behind().
>>>>>
>>>>> That said, I will follow up with a new version of the patch removing the
>>>>> WRITE_ONCE() and using uintptr_t instead of unsigned long.
>>>>
>>>> Sounds good!
>>>
>>> Oh, and of course intptr_t is one character shorter than uintptr_t, and
>>> looks to work just as well in this context.  ;-)
>>>
>>> 							Thanx, Paul
>>>
>>
>>
>> Hi Paul,
>>
>> Sorry for the late reply.
>>
>> intptr_t seems to be defined only in a header file under arch/mips, so I
>> will stick to uintptr_t.
> 
> Ah, apologies for the misdirection!  Hmmm...  Maybe intptr_t should be
> added alongside uintptr_t?  Saving a character is saving a character.  ;-)
> 
> 							Thanx, Paul
> 

I will follow up with an unrelated patch to add intptr_t to
include/linux/types.h, so that it is available in subsequent patches
throughout the kernel.

Nikos
