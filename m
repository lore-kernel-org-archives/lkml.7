Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C65CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2842086D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 17:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfJWRCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 13:02:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45255 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbfJWRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 13:02:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07487;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Tg.HetG_1571850128;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tg.HetG_1571850128)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 24 Oct 2019 01:02:10 +0800
Subject: Re: [PATCH] mm: thp: handle page cache THP correctly in
 PageTransCompoundMap
To:     Hugh Dickins <hughd@google.com>
Cc:     aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        gavin.dg@linux.alibaba.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1571769577-89735-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1910221454060.2077@eggly.anvils>
 <4ea5d015-19cb-d5d9-42f7-d1319d8de7c4@linux.alibaba.com>
 <alpine.LSU.2.11.1910221802270.2748@eggly.anvils>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <b4e320b7-d152-779a-8456-263e711f69b6@linux.alibaba.com>
Date:   Wed, 23 Oct 2019 10:02:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.1910221802270.2748@eggly.anvils>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/19 6:31 PM, Hugh Dickins wrote:
> On Tue, 22 Oct 2019, Yang Shi wrote:
>> On 10/22/19 3:27 PM, Hugh Dickins wrote:
>>> I completely agree that the current PageTransCompoundMap() is wrong.
>>>
>>> A fix for that is one of many patches I've not yet got to upstreaming.
>>> Comparing yours and mine, I'm worried by your use of PageDoubleMap(),
>>> because really that's a flag for anon THP, and not properly supported
>>> on shmem (or now I suppose file) THP - I forget the details, is it
>>> that it sometimes gets set, but never cleared?  Generally, we just
>>> don't refer to PageDoubleMap() on shmem THPs (but there may be
>>> exceptions: sorting out the THP mapcount maze, and eliminating
>>> PageDoubleMap(), is one of my long-held ambitions, not yet reached).
>>>
>>> Here's the patch I've been carrying, but it's from earlier, so I
>>> should warn that I've done no more than build-testing it on 5.4,
>>> and I'm too far away from these issues at the moment to be able to
>>> make a good judgement or argue for it - I hope you and others can
>>> decide which patch is the better.  I should also add that we're
>>> barely using PageTransCompoundMap() at all: at best it can only
>>> give a heuristic guess as to whether the page is pmd-mapped in
>>> any particular case, and we preferred to take forward the KVM
>>> patches we posted back in April 2016, plumbing hva down to where
>>> it's needed - though of course those are somewhat different now.
>> Thanks for catching this. I was definitely thinking about using
>> compount_mapcount instead of DoubleMap flag when I was working the patch. I
>> just simply thought it would change less file by using DoubleMap flag but I
>> didn't notice it was kind of unbalanced for file THP.
>>
>> With the unbalanced DoubleMap flag, it sounds better to use
>> compound_mapcount.
> Yes: no doubt PageDoubleMap could be fixed on shmem+file, but I have no
> interest in doing that, because it's just unnecessary overhead for them.
> (They have their own overhead, of subpage mapcounting for pmd: which is
> something to eliminate and unify with anon when I get around to it.)

It might be worth fixing the unbalance since mlock depends on this flag 
too. There should be a little bit overhead when handling PTE rmap remove 
since we have to iterate every subpage to check if _mapcount is same 
with compound_mapcount or not in order to clear DoubleMap flag. It is 
easy to handle this when the last PMD map is gone.

>
>> Thanks for sharing your patch, I'm going to rework v2 by using
>> compound_mapcount. Do you mind I might steal your patch?
> Please do! One less for me to worry about, thanks.
>
>> I'm supposed we'd better fix this bug regardless of whether you would like to
>> move forward your KVM patches.
> Absolutely. There remain a few other uses of PageTransCompoundMap
> anyway, and I really wanted this outright mm fix to go in before
> re-submitting AndresLC's KVM patch (I'll ask a KVM-savvy colleague
> to take that over, Cc'ing you, once the mm end is correct).

Thanks.

>
> Hugh

