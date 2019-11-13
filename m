Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27C8C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F63206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKMClD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:41:03 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57903 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727474AbfKMClD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 21:41:03 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0ThwxWMo_1573612858;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0ThwxWMo_1573612858)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 13 Nov 2019 10:40:59 +0800
Subject: Re: [PATCH v2 6/8] mm/lru: remove rcu_read_lock to fix performance
 regression
To:     Matthew Wilcox <willy@infradead.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org, hughd@google.com,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1573567588-47048-1-git-send-email-alex.shi@linux.alibaba.com>
 <1573567588-47048-7-git-send-email-alex.shi@linux.alibaba.com>
 <20191112143844.GB7934@bombadil.infradead.org>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <a6bb6739-cc00-cf9f-cd69-6016ce93e054@linux.alibaba.com>
Date:   Wed, 13 Nov 2019 10:40:58 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191112143844.GB7934@bombadil.infradead.org>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2019/11/12 ÏÂÎç10:38, Matthew Wilcox Ð´µÀ:
> On Tue, Nov 12, 2019 at 10:06:26PM +0800, Alex Shi wrote:
>> Intel 0day report there are performance regression on this patchset.
>> The detailed info points to rcu_read_lock + PROVE_LOCKING which causes
>> queued_spin_lock_slowpath waiting too long time to get lock.
>> Remove rcu_read_lock is safe here since we had a spinlock hold.
> Argh.  You have not sent these patches in a properly reviewable form!
> I wasted all that time reviewing the earlier patch in this series only to
> find out that you changed it here.  FIX THE PATCH, don't send a fix-patch
> on top of it!
> 

Hi Matthew,

Very sorry for your time! The main reasons I use a separate patch since a, Intel 0day asking me to credit their are founding, and I don't know how to give a clearly/elegant explanation for a non-exist regression in a fixed patch. b, this regression is kindly pretty tricky.  Maybe it's better saying thanks in version change log of cover-letter?

Anyway, Thanks a lot for your review!

Alex
