Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F87C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E856721882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 19:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfGCTYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 15:24:38 -0400
Received: from ale.deltatee.com ([207.54.116.67]:40980 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCTYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 15:24:38 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hikrp-0002Qw-SO; Wed, 03 Jul 2019 13:24:34 -0600
To:     Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Stephen Bates <sbates@raithlin.com>
References: <20190703170136.21515-1-logang@deltatee.com>
 <e88bed6b-c487-e224-1434-ba9912495a33@grimberg.me>
 <c072210c-1f44-2803-4781-15ff6f72a07a@deltatee.com>
 <e7f0ae6e-9a72-0640-12d3-1683f9950a13@grimberg.me>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <6344ac00-0102-5cc8-a565-58a715657345@deltatee.com>
Date:   Wed, 3 Jul 2019 13:24:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <e7f0ae6e-9a72-0640-12d3-1683f9950a13@grimberg.me>
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



On 2019-07-03 1:20 p.m., Sagi Grimberg wrote:
> 
>>> Can we handle this in the core instead (also so we'd be consistent
>>> across transports)?
>>
>> Yes, that would be much better if we can sort out some other issues
>> below...
>>
>>> How about this untested patch instead?
>>
>> I've found a couple of problems with the patch:
>>
>> 1) port->subsystems will always be empty before nvmet_disable_port() is
>> called. We'd have to restructure things a little perhaps so that when a
>> subsystem is removed from a port, all the active controllers for that
>> subsys/port combo would be removed.
> 
> Yes, that is better.

Ok, if you like this solution I'll try and come up with a patch like
that. It *may* not be too intrusive compared to the cleanup I suggested
below.

>> 2) loop needs to call flush_workqueue(nvme_delete_wq) somewhere,
>> otherwise there's a small window after the port disappears while
>> commands can still be submitted. We can actually still hit the bug with
>> a tight loop.
> 
> We could simply flush the workqueue in nvme_loop_delete_ctrl for
> each controller?
> 
> Might be an overkill though, and its risking circular locking in case
> we are going via the fatal error path (work context flushing a different
> workqueue always annoys lockdep even when its perfectly safe)
> 
>> Maybe there's other cleanup that could be done to solve this: it does
>> seem like all three transports need to keep their own lists of open
>> controllers and loops through them to delete them. In theory, that could
>> be made common so there's common code to manage the list per transport
>> which would remove some boiler plate code. If we want to go this route
>> though, I'd suggest using my patches as is for now and doing the cleanup
>> in the next cycle.
> 
> Then please fix tcp as well.

Ok, I'll try to send either a destroy controller on subsystem-removal
patch or I'll resend these with TCP included sometime today or tomorrow.

Thanks,

Logan
