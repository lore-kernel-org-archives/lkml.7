Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518B1C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187A216F4
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 09:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfHTJRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 05:17:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42230 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTJRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 05:17:04 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id BD8848EC234F8254D4D4;
        Tue, 20 Aug 2019 17:17:02 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.207) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 20 Aug
 2019 17:16:59 +0800
Subject: Re: [PATCH] f2fs: fix to avoid data corruption by forbidding SSR
 overwrite
To:     Jaegeuk Kim <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>
References: <20190816030334.81035-1-yuchao0@huawei.com>
 <3349ceea-85ac-173a-81a4-1188ce3804ca@huawei.com>
 <20190820010000.GA45681@jaegeuk-macbookpro.roam.corp.google.com>
From:   Chao Yu <yuchao0@huawei.com>
Message-ID: <74d1d451-e2a7-dc0f-a218-a05cd4cdcfa8@huawei.com>
Date:   Tue, 20 Aug 2019 17:16:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190820010000.GA45681@jaegeuk-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/8/20 9:00, Jaegeuk Kim wrote:
> On 08/19, Chao Yu wrote:
>> On 2019/8/16 11:03, Chao Yu wrote:
>>> There is one case can cause data corruption.
>>>
>>> - write 4k to fileA
>>> - fsync fileA, 4k data is writebacked to lbaA
>>> - write 4k to fileA
>>> - kworker flushs 4k to lbaB; dnode contain lbaB didn't be persisted yet
>>> - write 4k to fileB
>>> - kworker flush 4k to lbaA due to SSR
>>> - SPOR -> dnode with lbaA will be recovered, however lbaA contains fileB's
>>> data
>>>
>>> One solution is tracking all fsynced file's block history, and disallow
>>> SSR overwrite on newly invalidated block on that file.
>>>
>>> However, during recovery, no matter the dnode is flushed or fsynced, all
>>> previous dnodes until last fsynced one in node chain can be recovered,
>>> that means we need to record all block change in flushed dnode, which
>>> will cause heavy cost, so let's just use simple fix by forbidding SSR
>>> overwrite directly.
>>>
>>
>> Jaegeuk,
>>
>> Please help to add below missed tag to keep this patch being merged in stable
>> kernel.
>>
>> Fixes: 5b6c6be2d878 ("f2fs: use SSR for warm node as well")
> 
> Done.

Thanks! :)

Thanks,
