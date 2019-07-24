Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D59EC76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312DD218F0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfGXTML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:12:11 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46312 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfGXTML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:12:11 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hqMgJ-0000Ev-5G; Wed, 24 Jul 2019 13:12:07 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190718225132.5865-1-logang@deltatee.com>
 <20190718225132.5865-2-logang@deltatee.com>
 <c52f80b1-e154-b11f-a868-e3209e4ccb2d@grimberg.me>
 <6deea9e7-ff3c-e115-b2f2-8914df0b6da7@deltatee.com>
 <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <021b5195-9a09-4cc2-064f-940ada9cf764@deltatee.com>
Date:   Wed, 24 Jul 2019 13:12:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <dd287560-2cb3-28ab-c22d-fe9f3682c609@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: hch@lst.de, axboe@fb.com, kbusch@kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 2/2] nvme-core: Fix deadlock when deleting the ctrl while
 scanning
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Sorry for the delay.

I tested your patch and it does work. Do you want me to send your change
as a full patch? Can I add your signed-off-by?

On 2019-07-18 6:50 p.m., Sagi Grimberg wrote:
>> I didn't think the scan_lock was that contested or that
>> nvme_change_ctrl_state() was really called that often...
> 
> it shouldn't be, but I think it makes the flow more convoluted
> as we serialize by flushing the scan_work right after...

I would argue that the check for state in nvme_scan_work() without a
lock is racy and confusing. There's nothing to prevent the state from
changing immediately after the check.

> The design principal is met as we do get the I/O failing,
> but its just that with mpath we simply queue the I/O again
> because the head->list happens to not be empty.
> Perhaps taking care of that check is cleaner.

Yes, I feel your patch is a good solution on it's own merits.
> Thanks. Do you have a firm reproducer for it?

Yes. If you connect to and then immediately disconnect from a target (at
least with nvme-loop) you will reliably trigger this bug -- or one of
the others I've sent patches for.

>>>> +    mutex_lock(&ctrl->scan_lock);
>>>> +
>>>>        if (ctrl->state != NVME_CTRL_LIVE)
>>>>            return;
>>>
>>> unlock
>>
>> If we unlock here and relock below, we'd have to recheck the ctrl->state
>> to avoid any races. If you don't want to call nvme_identify_ctrl with
>> the lock held, then it would probably be better to move the state check
>> below it.
> 
> Meant before the return statement.

Ah, right, my mistake.

Logan
