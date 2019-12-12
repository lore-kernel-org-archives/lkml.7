Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD75EC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5D12467A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 05:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLLFwA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 00:52:00 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10721 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbfLLFv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:51:59 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0TkgNfek_1576129906;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TkgNfek_1576129906)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 12 Dec 2019 13:51:47 +0800
Subject: Re: [PATCH] ocfs2: call journal flush to mark journal as empty after
 journal recovery when mount
To:     Changwei Ge <chge@linux.alibaba.com>, Kai Li <li.kai4@h3c.com>,
        mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20191211100338.510-1-li.kai4@h3c.com>
 <76d8166c-afe9-fc63-98b2-5293e3956669@linux.alibaba.com>
 <5bc88eee-21d9-14c2-6544-d4e3baa931cb@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <5510650e-2e5d-2f7c-e1ef-b118389125d5@linux.alibaba.com>
Date:   Thu, 12 Dec 2019 13:51:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <5bc88eee-21d9-14c2-6544-d4e3baa931cb@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/12/12 11:55, Changwei Ge wrote:
> Hi Joseph,
> 
> On 12/11/19 9:17 PM, Joseph Qi wrote:
>>
>>
>> On 19/12/11 18:03, Kai Li wrote:
>>> If journal is dirty when mount, it will be replayed but jbd2 sb
>>> log tail cannot be updated to mark a new start because
>>> journal->j_flag has already been set with JBD2_ABORT first
>>> in journal_init_common. When a new transaction is committed, it
>>> will be recored in block 1 first(journal->j_tail is set to 1 in
>>> journal_reset).
>>>
>>> If emergency restart happens again before journal super block is
>>> updated unfortunately, the new recorded trans will not be replayed
>>> in the next mount.
>>>
>> I think I've finally understood the problem. But I don't think it has
>> been clearly described for reviewing. I strongly suggest you describe
>> the problem in the way of timeline, such as in which step, do what
>> operation, and what is the status, etc.
>>
>>
>>> This exception happens when this lun is used by only one node. If it
>>> is used by multi-nodes, other node will replay its journal and its
>>> journal sb block will be updated after recovery.
>>>
>>> To fix this problem, use jbd2_journal_flush to mark journal as empty as
>>> ocfs2_replay_journal has done.>
>> Sounds reasonable. But IMO, it is really a corner use scenario, using
>> cluster filesystem in single node...
> 
> True, this use case should be rare.
> But considering that fixing this is not complicated and does no harm at least, I am inclining taking this in. We can only merge it to mainline rather than -stable branches. :-)
> 
Okay, let's move it on.

Thanks,
Joseph
