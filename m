Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2096C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D6021019
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 11:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arrikto-com.20150623.gappssmtp.com header.i=@arrikto-com.20150623.gappssmtp.com header.b="FGSy8fKz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbfCQLwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 07:52:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52399 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbfCQLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 07:52:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id f65so10356181wma.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arrikto-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z2lB40SNrOspKziih6vTzr5FCyPGifgTvJPdnmwKWME=;
        b=FGSy8fKzb8PfNubumoaE8TAaRZwRTz2/ask+kHWpcz+h3ioiSeenMHW+j1xi/GyyEY
         Ha3buWZJhjN/jtZQ4BfaH8GXkQLuvIjxtFJ8RRsHNiEGSb+DHtnYk5mVfrs1tb4wETbW
         X/Nj1GDwobWVax3JzScw4fXqUH1VRfpDAak3vo/qfHiKgFy5tRh0F/7+5LyRvlrLcOPe
         XsmtjrtIoSyPOzIaUX7x0zuN4YigNiEwc74sMlsq9Hren60FF+kBqP6WfwOOL8Xm9Whv
         TxtcMTbj4nq+atbtJtMhJd1bDRK81f7zfbzanGWIdWq/qclhb35E5lG1DXZDfK87K3n4
         Elsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z2lB40SNrOspKziih6vTzr5FCyPGifgTvJPdnmwKWME=;
        b=jSsdfGDKY6xW6pDJGWu54MGtl9PQinLOw3QxyOmuXfrlOJSbAhFOU7ACF2HAp7ZxO3
         ZINXyCRhBHmVAz2fhdDFkWPv2DEc77Grj9ViNzW+E+LwiNIwtoidQUqr+IOZ9Hpo/tPZ
         MfYTV8v2rKgo5SRzIEyrF5Jv4vL5skPUGsImDId3NOoQA+9IUDnK8hEe4/7IGPDA6Gdu
         JY4aa8SC37S0n6sXm6dA/F4HtddjSb0Fq7TW5pweRMHXDLWwuGjDyoYsrVineCMZbkWr
         iuDFzMxSHNMVbDwjKTMZOboGOP+Lal5svw8wuG3t2qEdUh/CVJ3g3/WabZWZyAAKGPpC
         4VOA==
X-Gm-Message-State: APjAAAXHiPQgjxXlOuqwhnOrsYS8KQbZUz5s/GhSDuYMe+Gyza9NJiO6
        5Dd/f5kkZcWjLsBlN7xaWy91GFCKXAc=
X-Google-Smtp-Source: APXvYqxDqkxwX1/veEWnYcEwEJt7Zo1BqIg7dA3UbfK8oufKQvr5nKeOgiDEBz6SJweYgqa1EbJ63g==
X-Received: by 2002:a7b:c382:: with SMTP id s2mr7563616wmj.56.1552823572237;
        Sun, 17 Mar 2019 04:52:52 -0700 (PDT)
Received: from [192.168.1.109] (46.246.177.193.dsl.dyn.forthnet.gr. [46.246.177.193])
        by smtp.gmail.com with ESMTPSA id e5sm8469809wrh.71.2019.03.17.04.52.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 04:52:51 -0700 (PDT)
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
From:   Nikos Tsironis <ntsironis@arrikto.com>
Message-ID: <ad704078-1a28-5726-c428-7be19dbe2466@arrikto.com>
Date:   Sun, 17 Mar 2019 13:52:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190314150306.GA22051@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/19 5:03 PM, Paul E. McKenney wrote:
> On Thu, Mar 14, 2019 at 07:07:50AM -0700, Paul E. McKenney wrote:
>> On Thu, Mar 14, 2019 at 03:28:23PM +0200, Nikos Tsironis wrote:
>>> On 3/14/19 2:30 AM, Mike Snitzer wrote:
>>>> On Wed, Mar 13 2019 at  7:48pm -0400,
>>>> Paul E. McKenney <paulmck@linux.ibm.com> wrote:
>>>>
>>> Hi Paul,
>>>
>>> Thanks a lot for your feedback!
>>
>> NP, and apologies for the delay.
>>
>>>>> On Thu, Feb 28, 2019 at 04:32:02PM -0500, Mike Snitzer wrote:
>>>>>> On Thu, Dec 20 2018 at  1:06pm -0500,
>>>>>> Nikos Tsironis <ntsironis@arrikto.com> wrote:
>>>>>>
>>>>>>> Add hlist_bl_add_before/behind helpers to add an element before/after an
>>>>>>> existing element in a bl_list.
>>>>>>>
>>>>>>> Signed-off-by: Nikos Tsironis <ntsironis@arrikto.com>
>>>>>>> Signed-off-by: Ilias Tsitsimpis <iliastsi@arrikto.com>
>>>>>>> ---
>>>>>>>  include/linux/list_bl.h | 27 +++++++++++++++++++++++++++
>>>>>>>  1 file changed, 27 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>>>>>>> index 3fc2cc57ba1b..2fd918e5fd48 100644
>>>>>>> --- a/include/linux/list_bl.h
>>>>>>> +++ b/include/linux/list_bl.h
>>>>>>> @@ -86,6 +86,33 @@ static inline void hlist_bl_add_head(struct hlist_bl_node *n,
>>>>>>>  	hlist_bl_set_first(h, n);
>>>>>>>  }
>>>>>>>  
>>>>>>> +static inline void hlist_bl_add_before(struct hlist_bl_node *n,
>>>>>>> +				       struct hlist_bl_node *next)
>>>>>>> +{
>>>>>>> +	struct hlist_bl_node **pprev = next->pprev;
>>>>>>> +
>>>>>>> +	n->pprev = pprev;
>>>>>>> +	n->next = next;
>>>>>>> +	next->pprev = &n->next;
>>>>>>> +
>>>>>>> +	/* pprev may be `first`, so be careful not to lose the lock bit */
>>>>>>> +	WRITE_ONCE(*pprev,
>>>>>>> +		   (struct hlist_bl_node *)
>>>>>>> +			((unsigned long)n |
>>>>>>> +			 ((unsigned long)*pprev & LIST_BL_LOCKMASK)));
>>>>>
>>>>> A nit, but use of uintptr_t shrinks things a bit:
>>>>>
>>>>> +		   (struct hlist_bl_node *)
>>>>> +			((uintptr_t)n | ((uintptr_t)*pprev & LIST_BL_LOCKMASK)));
>>>>>
>>>>> I am not too concerned about this, though.
>>>>
>>>> I'm fine with folding in your suggestion.
>>>
>>> Indeed, this looks better.
>>>
>>>>> The WRITE_ONCE() is to handle races with hlist_bl_empty() (which does contain
>>>>> the corresponding READ_ONCE()) correct?
>>>>
>>>> Correct.
>>>
>>> Yes that's correct.
>>>
>>>>>>> +}
>>>>>>> +
>>>>>>> +static inline void hlist_bl_add_behind(struct hlist_bl_node *n,
>>>>>>> +				       struct hlist_bl_node *prev)
>>>>>>> +{
>>>>>>> +	n->next = prev->next;
>>>>>>> +	n->pprev = &prev->next;
>>>>>>> +	WRITE_ONCE(prev->next, n);
>>>>>
>>>>> I don't see what this WRITE_ONCE() is interacting with.  The traversals
>>>>> use plain C-language reads, and hlist_bl_empty() can't get here.  All
>>>>> uses of hlist_bl_for_each_entry() invoke hlist_bl_lock() before starting
>>>>> the traversal, and hlist_bl_for_each_entry_safe() looks to be unused.
>>>>> (Perhaps it should be removed?  Or is there some anticipated use?)
>>>
>>> I am using hlist_bl_for_each_entry_safe() in this proposed patch for
>>> dm-snapshot: https://patchwork.kernel.org/patch/10835709/
>>
>> Probably should keep it, then.  ;-)
>>
>>>>>
>>>>> I don't believe that the WRITE_ONCE() is needed.  What am I missing?
>>>>>
>>>>> Other than that, looks good.
>>>>>
>>>>> 							Thanx, Paul
>>>>>
>>>>
>>>> I'd imagine it was just born out of symmetry with hlist_bl_add_before()
>>>> and/or caution.  But let's see what Nikos has to say.
>>>
>>> I also don't believe that this WRITE_SAME() is needed. But, looking at
>>> hlist_add_behind() in include/linux/list.h, which, if I am not missing
>>> something, is used in the same way as hlist_bl_add_behind(), it also
>>> uses WRITE_ONCE() to update prev->next:
>>>
>>> static inline void hlist_add_behind(struct hlist_node *n,
>>> 				    struct hlist_node *prev)
>>> {
>>> 	n->next = prev->next;
>>> 	WRITE_ONCE(prev->next, n);
>>> 	n->pprev = &prev->next;
>>>
>>> 	if (n->next)
>>> 		n->next->pprev  = &n->next;
>>> }
>>>
>>> Could it be the case that the WRITE_ONCE() in hlist_add_behind() is also
>>> not needed? This WRITE_ONCE() was introduced by commit 1c97be677f72b3
>>> ("list: Use WRITE_ONCE() when adding to lists and hlists").
>>
>> Looks like I have no one to blame but myself!
>>
>> Would you like to remove that as part of your patch series?
>>
>>> But, since I am not an expert in lockless programming, I opted to be on
>>> the safe side and followed the example of hlist_add_behind().
>>>
>>> That said, I will follow up with a new version of the patch removing the
>>> WRITE_ONCE() and using uintptr_t instead of unsigned long.
>>
>> Sounds good!
> 
> Oh, and of course intptr_t is one character shorter than uintptr_t, and
> looks to work just as well in this context.  ;-)
> 
> 							Thanx, Paul
> 


Hi Paul,

Sorry for the late reply.

intptr_t seems to be defined only in a header file under arch/mips, so I
will stick to uintptr_t.

Thanks,
Nikos
