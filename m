Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0195EC3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F9422CF8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfICSNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 14:13:50 -0400
Received: from ale.deltatee.com ([207.54.116.67]:35214 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727069AbfICSNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 14:13:50 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i5DJ1-0005Zx-O9; Tue, 03 Sep 2019 12:13:28 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     Keith Busch <keith.busch@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20190831000139.7662-1-logang@deltatee.com>
 <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d71107d2-c133-9f51-c271-688516641703@deltatee.com>
Date:   Tue, 3 Sep 2019 12:13:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190903164620.GA20847@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: martin.petersen@oracle.com, hare@suse.com, axboe@fb.com, sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, keith.busch@intel.com, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-09-03 10:46 a.m., Keith Busch wrote:
> On Tue, Sep 03, 2019 at 10:08:01AM -0600, Logan Gunthorpe wrote:
>> On 2019-08-31 9:29 a.m., Keith Busch wrote:
>>> On Fri, Aug 30, 2019 at 06:01:39PM -0600, Logan Gunthorpe wrote:
>>>> To fix this, assign the subsystem's instance based on the instance
>>>> number of the controller's instance that first created it. There should
>>>> always be fewer subsystems than controllers so the should not be a need
>>>> to create extra subsystems that overlap existing controllers.
>>>
>>> The subsystem's lifetime is not tied to the controller's. When the
>>> controller is removed and releases its instance, the next controller
>>> to take that available instance will create naming collisions with the
>>> subsystem still using it.
>>>
>>
>> Hmm, yes, ok.
>>
>> So perhaps we can just make the subsystem prefer the ctrl's instance
>> when allocating the ID? Then at least, in the common case, the
>> controller numbers will match the subsystem numbers. Only when there's
>> random hot-plugs would the numbers get out of sync.
> 
> I really don't know about a patch that works only on static
> configurations. Connects and disconnects do happen on live systems,
> so the numerals will inevitably get out of sync.

Well this depends on how big a problem we think the number mismatch is.
Right now it's pretty annoying because numbers aren't matching for
non-CMIC controllers in simple setups on boot. I think having a small
patch that makes it more consistent for the static would be worth it and
if CMIC controllers with significant hot-plug events have mismatches
that seems more understandable to me.

> Could we possibly make /dev/nvmeX be a subsystem handle without causing
> trouble for anyone? This would essentially be the same thing as today
> for non-CMIC controllers with a device-per-controller and only affects
> the CMIC ones.

Well then we'd have to be able to do everything that's possible with a
controller via the subsystem and it would have to multiplex all admin
commands for CMIC ones, etc to a sensible controller. This might make
sense in the long term but it sounds like a larger project than I have
time to take on.

Logan
