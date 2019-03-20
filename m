Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38652C10F03
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098D920854
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 01:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfCTBGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 21:06:44 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:51620 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727106AbfCTBGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 21:06:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TNA0mks_1553043988;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TNA0mks_1553043988)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 20 Mar 2019 09:06:30 +0800
Subject: Re: [PATCH] mm: mempolicy: make mbind() return -EIO when
 MPOL_MF_STRICT is specified
To:     David Rientjes <rientjes@google.com>
Cc:     chrubis@suse.cz, vbabka@suse.cz, kirill@shutemov.name,
        osalvador@suse.de, akpm@linux-foundation.org,
        stable@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1553020556-38583-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.DEB.2.21.1903191748090.18028@chino.kir.corp.google.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <5ef2a902-7abb-a0a9-f478-dcccbb393893@linux.alibaba.com>
Date:   Tue, 19 Mar 2019 18:06:26 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1903191748090.18028@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/19 5:49 PM, David Rientjes wrote:
> On Wed, 20 Mar 2019, Yang Shi wrote:
>
>> When MPOL_MF_STRICT was specified and an existing page was already
>> on a node that does not follow the policy, mbind() should return -EIO.
>> But commit 6f4576e3687b ("mempolicy: apply page table walker on
>> queue_pages_range()") broke the rule.
>>
>> And, commit c8633798497c ("mm: mempolicy: mbind and migrate_pages
>> support thp migration") didn't return the correct value for THP mbind()
>> too.
>>
>> If MPOL_MF_STRICT is set, ignore vma_migratable() to make sure it reaches
>> queue_pages_to_pte_range() or queue_pages_pmd() to check if an existing
>> page was already on a node that does not follow the policy.  And,
>> non-migratable vma may be used, return -EIO too if MPOL_MF_MOVE or
>> MPOL_MF_MOVE_ALL was specified.
>>
>> Tested with https://github.com/metan-ucw/ltp/blob/master/testcases/kernel/syscalls/mbind/mbind02.c
>>
>> Fixes: 6f4576e3687b ("mempolicy: apply page table walker on queue_pages_range()")
>> Reported-by: Cyril Hrubis <chrubis@suse.cz>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: stable@vger.kernel.org
>> Suggested-by: Kirill A. Shutemov <kirill@shutemov.name>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: David Rientjes <rientjes@google.com>
>
> Thanks.  I think this needs stable for 4.0+, can you confirm?

Thanks. Yes, this needs stable for 4.0+.

Yang


