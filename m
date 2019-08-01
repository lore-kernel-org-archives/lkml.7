Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5389C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9F5220838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 21:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbfHAVKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 17:10:17 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:55553 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726888AbfHAVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 17:10:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0TYQEJnk_1564693809;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TYQEJnk_1564693809)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 02 Aug 2019 05:10:14 +0800
Subject: Re: [BUG]: mm/vmscan.c: shrink_slab does not work correctly with
 memcg disabled via commandline
To:     Jan Hadrava <had@kam.mff.cuni.cz>, Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        wizards@kam.mff.cuni.cz, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190801134250.scbfnjewahbt5zui@kam.mff.cuni.cz>
 <20190801140610.GM11627@dhcp22.suse.cz>
 <20190801155434.2dftso2wuggfuv7a@kam.mff.cuni.cz>
 <20190801163213.GO11627@dhcp22.suse.cz>
 <20190801174631.ulnlx3pi2g2rznzk@kam.mff.cuni.cz>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <8db8ec82-5a66-a221-09f3-66d0b8b9a75f@linux.alibaba.com>
Date:   Thu, 1 Aug 2019 14:10:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20190801174631.ulnlx3pi2g2rznzk@kam.mff.cuni.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/1/19 10:46 AM, Jan Hadrava wrote:
> On Thu, Aug 01, 2019 at 06:32:13PM +0200, Michal Hocko wrote:
>> On Thu 01-08-19 17:54:34, Jan Hadrava wrote:
>>> Just to be sure, i run my tests and patch proposed in the original thread
>>> solves my issue in all four affected stable releases:
>> Cc Andrew.
> Are you sure? I can't see any change in e-mail headers.

Cc'ed Andrew.

>
>> I assume we can assume your Tested-by tag?
> Well, these test only checked, that bug is present without the patch
> and disappears after applying it. Anyway: I am ok with it.

Thanks for testing it. I think you ran into the similar pre-mature OOM 
issue as what Shakeel reported.

Andrew,

The patch has been in -mm tree 
(mm-vmscan-check-if-mem-cgroup-is-disabled-or-not-before-calling-memcg-slab-shrinker.patch), 
it seems we'd better to get this fix in the upcoming 5.3-rc so that it 
could get into stable release soon.

>
>

