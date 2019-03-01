Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58B2C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACAA520850
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 13:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbfCANVR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 08:21:17 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52997 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbfCANVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 08:21:16 -0500
X-Originating-IP: 81.250.144.103
Received: from [10.30.1.20] (lneuilly-657-1-5-103.w81-250.abo.wanadoo.fr [81.250.144.103])
        (Authenticated sender: alex@ghiti.fr)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id ABA561C001D;
        Fri,  1 Mar 2019 13:21:06 +0000 (UTC)
Subject: Re: [PATCH v4 4/4] hugetlb: allow to free gigantic pages regardless
 of the configuration
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S . Miller" <davem@davemloft.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
References: <20190228063604.15298-1-alex@ghiti.fr>
 <20190228063604.15298-5-alex@ghiti.fr>
 <9a385cc8-581c-55cf-4a85-10b5c4dd178c@intel.com>
 <31212559-d397-88fb-eaec-60f6417436c8@oracle.com>
 <6c842251-1bed-4d79-bf6d-997006ec72e2@intel.com>
 <6ea4119a-0ecb-511d-3aab-269004245a08@oracle.com>
 <1cfaca88-a219-d057-3ab8-37fb1c1687d6@ghiti.fr>
Message-ID: <f7c94eb5-d496-7e24-d44f-17eaff287012@ghiti.fr>
Date:   Fri, 1 Mar 2019 14:21:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1cfaca88-a219-d057-3ab8-37fb1c1687d6@ghiti.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2019 07:25 AM, Alex Ghiti wrote:
> On 2/28/19 5:26 PM, Mike Kravetz wrote:
>> On 2/28/19 12:23 PM, Dave Hansen wrote:
>>> On 2/28/19 11:50 AM, Mike Kravetz wrote:
>>>> On 2/28/19 11:13 AM, Dave Hansen wrote:
>>>>>> +    if (hstate_is_gigantic(h) && 
>>>>>> !IS_ENABLED(CONFIG_CONTIG_ALLOC)) {
>>>>>> +        spin_lock(&hugetlb_lock);
>>>>>> +        if (count > persistent_huge_pages(h)) {
>>>>>> +            spin_unlock(&hugetlb_lock);
>>>>>> +            return -EINVAL;
>>>>>> +        }
>>>>>> +        goto decrease_pool;
>>>>>> +    }
>>>>> This choice confuses me.  The "Decrease the pool size" code already
>>>>> works and the code just falls through to it after skipping all the
>>>>> "Increase the pool size" code.
>>>>>
>>>>> Why did did you need to add this case so early?  Why not just let it
>>>>> fall through like before?
>>>> I assume you are questioning the goto, right?  You are correct in that
>>>> it is unnecessary and we could just fall through.
>>> Yeah, it just looked odd to me.
>
> (Dave I do not receive your answers, I don't know why).

I collected mistakes here: domain name expired and no mailing list added :)
Really sorry about that, I missed the whole discussion (if any).
Could someone forward it to me (if any) ? Thanks !

> I'd rather avoid useless checks when we already know they won't
> be met and I think that makes the code more understandable.
>
> But that's up to you for the next version.
>
> Thanks
>>>
>>>> However, I wonder if we might want to consider a wacky condition 
>>>> that the
>>>> above check would prevent.  Consider a system/configuration with 5 
>>>> gigantic
>>>> pages allocated at boot time.  Also CONFIG_CONTIG_ALLOC is not 
>>>> enabled, so
>>>> it is not possible to allocate gigantic pages after boot.
>>>>
>>>> Suppose the admin decreased the number of gigantic pages to 3.  
>>>> However, all
>>>> gigantic pages were in use.  So, 2 gigantic pages are now 'surplus'.
>>>> h->nr_huge_pages == 5 and h->surplus_huge_pages == 2, so
>>>> persistent_huge_pages() == 3.
>>>>
>>>> Now suppose the admin wanted to increase the number of gigantic 
>>>> pages to 5.
>>>> The above check would prevent this.  However, we do not need to really
>>>> 'allocate' two gigantic pages.  We can simply convert the surplus 
>>>> pages.
>>>>
>>>> I admit this is a wacky condition.  The ability to 'free' gigantic 
>>>> pages
>>>> at runtime if !CONFIG_CONTIG_ALLOC makes it possible.  I don't 
>>>> necessairly
>>>> think we should consider this.  hugetlbfs code just makes me think of
>>>> wacky things. :)
>>> I think you're saying that the newly-added check is overly-restrictive.
>>>   If we "fell through" like I was suggesting we would get better 
>>> behavior.
>> At first, I did not think it overly restrictive.  But, I believe we can
>> just eliminate that check for gigantic pages.  If 
>> !CONFIG_CONTIG_ALLOC and
>> this is a request to allocate more gigantic pages, 
>> alloc_pool_huge_page()
>> should return NULL.
>>
>> The only potential issue I see is that in the past we have returned 
>> EINVAL
>> if !CONFIG_CONTIG_ALLOC and someone attempted to increase the pool size.
>> Now, we will not increase the pool and will not return an error.  Not 
>> sure
>> if that is an acceptable change in user behavior.
>
> If I may, I think that this is the kind of info the user wants to have 
> and we should
> return an error when it is not possible to allocate runtime huge pages.
> I already noticed that if someone asks for 10 huge pages, and only 5 
> are allocated,
> no error is returned to the user and I found that surprising.
>
>>
>> If we go down this path, then we could remove this change as well:
>
> I agree that in that path, we do not need the following change neither.
>
>>
>>> @@ -2428,7 +2442,9 @@ static ssize_t 
>>> __nr_hugepages_store_common(bool obey_mempolicy,
>>>       } else
>>>           nodes_allowed = &node_states[N_MEMORY];
>>>   -    h->max_huge_pages = set_max_huge_pages(h, count, nodes_allowed);
>>> +    err = set_max_huge_pages(h, count, nodes_allowed);
>>> +    if (err)
>>> +        goto out;
>>>         if (nodes_allowed != &node_states[N_MEMORY])
>>>           NODEMASK_FREE(nodes_allowed);
>> Do note that I beleive there is a bug the above change.  The code after
>> the out label is:
>>
>> out:
>>          NODEMASK_FREE(nodes_allowed);
>>          return err;
>> }
>>
>> With the new goto, we need the same
>> if (nodes_allowed != &node_states[N_MEMORY]) before NODEMASK_FREE().
>>
>> Sorry, I missed this in previous versions.
>
> Oh right, I'm really sorry I missed that, thank you for noticing.
>

