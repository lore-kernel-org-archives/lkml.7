Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0275C76195
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDFC2080A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 16:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731438AbfGOQ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 12:58:25 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:51743 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729533AbfGOQ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 12:58:24 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TX.M-FQ_1563209898;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TX.M-FQ_1563209898)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 16 Jul 2019 00:58:20 +0800
Subject: Re: [PATCH] mm: page_alloc: document kmemleak's non-blockable
 __GFP_NOFAIL case
To:     Qian Cai <cai@lca.pw>, Catalin Marinas <catalin.marinas@gmail.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1562964544-59519-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190715131732.GX29483@dhcp22.suse.cz>
 <F89E7123-C21C-41AA-8084-1DB4C832D7BD@gmail.com>
 <1563203882.4610.1.camel@lca.pw>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <82cbc350-c2a8-e653-208a-a533771fe653@linux.alibaba.com>
Date:   Mon, 15 Jul 2019 09:58:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1563203882.4610.1.camel@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/19 8:18 AM, Qian Cai wrote:
> On Mon, 2019-07-15 at 10:01 -0500, Catalin Marinas wrote:
>> On 15 Jul 2019, at 08:17, Michal Hocko <mhocko@kernel.org> wrote:
>>> On Sat 13-07-19 04:49:04, Yang Shi wrote:
>>>> When running ltp's oom test with kmemleak enabled, the below warning was
>>>> triggerred since kernel detects __GFP_NOFAIL & ~__GFP_DIRECT_RECLAIM is
>>>> passed in:
>>> kmemleak is broken and this is a long term issue. I thought that
>>> Catalin had something to address this.
>> What needs to be done in the short term is revert commit
>> d9570ee3bd1d4f20ce63485f5ef05663866fe6c0. Longer term the solution is to embed
>> kmemleak metadata into the slab so that we don’t have the situation where the
>> primary slab allocation success but the kmemleak metadata fails.
>>
>> I’m on holiday for one more week with just a phone to reply from but feel free
>> to revert the above commit. I’ll follow up with a better solution.
> Well, the reverting will only make the situation worst for the kmemleak under
> memory pressure. In the meantime, if someone wants to push for the mempool

I think this is expected by reverting that commit since kmemleak 
metadata could fail. But, it could fail too even though that commit is 
not reverted if the context is non-blockable.

> solution with tunable pool sizes along with the reverting, that could be an
> improvement.
>
> https://lore.kernel.org/linux-mm/20190328145917.GC10283@arrakis.emea.arm.com/

