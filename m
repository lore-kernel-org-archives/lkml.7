Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73743C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F71C2245C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFR05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:26:57 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:45553 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbfLFR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:26:57 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0Tk8dtRm_1575653168;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0Tk8dtRm_1575653168)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 Dec 2019 01:26:17 +0800
Subject: Re: [PATCH] move_pages.2: not return ENOENT if the page are already
 on the target nodes
To:     John Hubbard <jhubbard@nvidia.com>, mtk.manpages@gmail.com,
        cl@linux.com, mhocko@suse.com, cai@lca.pw,
        akpm@linux-foundation.org
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1575596090-115377-1-git-send-email-yang.shi@linux.alibaba.com>
 <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <95170ea5-5b62-9168-fcd9-93b43330a1b4@linux.alibaba.com>
Date:   Fri, 6 Dec 2019 09:26:05 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0dc96e40-5f2b-a2fe-6e5f-b6f3d5e9ebde@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 12:25 AM, John Hubbard wrote:
> On 12/5/19 5:34 PM, Yang Shi wrote:
>> Since commit e78bbfa82624 ("mm: stop returning -ENOENT
>> from sys_move_pages() if nothing got migrated"), move_pages doesn't
>> return -ENOENT anymore if the pages are already on the target nodes, but
>> this change is never reflected in manpage.
>>
>> Cc: Michael Kerrisk <mtk.manpages@gmail.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: John Hubbard <jhubbard@nvidia.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Qian Cai <cai@lca.pw>
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> ---
>>   man2/move_pages.2 | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/man2/move_pages.2 b/man2/move_pages.2
>> index 2d96468..2a2f3cd 100644
>> --- a/man2/move_pages.2
>> +++ b/man2/move_pages.2
>> @@ -192,9 +192,8 @@ was specified or an attempt was made to migrate 
>> pages of a kernel thread.
>>   One of the target nodes is not online.
>>   .TP
>>   .B ENOENT
>> -No pages were found that require moving.
>> -All pages are either already
>> -on the target node, not present, had an invalid address or could not be
>> +No pages were found.
>> +All pages are either not present, had an invalid address or could 
>> not be
>>   moved because they were mapped by multiple processes.
>>   .TP
>>   .B EPERM
>>
>
> whoa, hold on. If I'm reading through the various error paths 
> correctly, then this
> code is *never* going to return ENOENT for the whole function. It can 
> fill in that
> value per-page, in the status array, but that's all. Did I get that 
> right?

Nice catch. Yes, you are right.

>
> If so, we need to redo this part of the man page.

Yes.

>
>
> thanks,

