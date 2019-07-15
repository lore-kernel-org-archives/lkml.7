Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23BAC7618A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DACB20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 03:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729070AbfGODre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 23:47:34 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:45755 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726916AbfGODre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 23:47:34 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TWuAKbH_1563162430;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TWuAKbH_1563162430)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 15 Jul 2019 11:47:13 +0800
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
To:     Matthew Wilcox <willy@infradead.org>
Cc:     mhocko@suse.com, dvyukov@google.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190713212548.GZ32320@bombadil.infradead.org>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <4b4eb1f9-440c-f4cd-942c-2c11b566c4c0@linux.alibaba.com>
Date:   Sun, 14 Jul 2019 20:47:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190713212548.GZ32320@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/13/19 2:25 PM, Matthew Wilcox wrote:
> On Sat, Jul 13, 2019 at 04:49:04AM +0800, Yang Shi wrote:
>> When running ltp's oom test with kmemleak enabled, the below warning was
>> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
>> passed in:
> There are lots of places where kmemleak will call kmalloc with
> __GFP_NOFAIL and ~__GFP_DIRECT_RECLAIM (including the XArray code, which
> is how I know about it).  It needs to be fixed to allow its internal
> allocations to fail and return failure of the original allocation as
> a consequence.

Do you mean kmemleak internal allocation? It would fail even though 
__GFP_NOFAIL is passed in if GFP_NOWAIT is specified. Currently buddy 
allocator will not retry if the allocation is non-blockable.


