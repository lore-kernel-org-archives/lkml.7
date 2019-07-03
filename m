Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F2DC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D948218BE
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbfGCSNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:13:23 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39872 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCSNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:13:23 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hijks-0001bI-IX; Wed, 03 Jul 2019 12:13:19 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703170136.21515-1-logang@deltatee.com>
 <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>
Date:   Wed, 3 Jul 2019 12:13:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, hch@lst.de, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, sagi@grimberg.me
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 0/2] Fix use-after-free bug when ports are removed
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-07-03 11:33 a.m., Sagi Grimberg wrote:
>> NVME target ports can be removed while there are still active
>> controllers. Largely this is fine, except some admin commands
>> can access the req->port (for example, id-ctrl uses the port's
>> inline date size as part of it's response). This was found
>> while testing with KASAN.
>>
>> Two patches follow which disconnect active controllers when the
>> ports are removed for loop and rdma. I'm not sure if fc has the
>> same issue and have no way to test this.
>>
>> Alternatively, we could add reference counting to the struct port,
>> but I think this is a more involved change and could be done later
>> after we fix the bug quickly.
> 
> I don't think that when removing a port the expectation is that
> all associated controllers remain intact (although they can, which
> was why we did not remove them), so I think its fine to change that
> if it causes issues.
> 
> Can we handle this in the core instead (also so we'd be consistent
> across transports)?

Yes, that would be much better if we can sort out some other issues below...

> How about this untested patch instead?

I've found a couple of problems with the patch:

1) port->subsystems will always be empty before nvmet_disable_port() is
called. We'd have to restructure things a little perhaps so that when a
subsystem is removed from a port, all the active controllers for that
subsys/port combo would be removed.

2) loop needs to call flush_workqueue(nvme_delete_wq) somewhere,
otherwise there's a small window after the port disappears while
commands can still be submitted. We can actually still hit the bug with
a tight loop.

Maybe there's other cleanup that could be done to solve this: it does
seem like all three transports need to keep their own lists of open
controllers and loops through them to delete them. In theory, that could
be made common so there's common code to manage the list per transport
which would remove some boiler plate code. If we want to go this route
though, I'd suggest using my patches as is for now and doing the cleanup
in the next cycle.

Logan
