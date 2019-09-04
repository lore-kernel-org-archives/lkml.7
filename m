Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F90C3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60932087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 17:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbfIDR3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 13:29:35 -0400
Received: from ale.deltatee.com ([207.54.116.67]:58972 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729020AbfIDR3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 13:29:35 -0400
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1i5Z64-0008Ty-GK; Wed, 04 Sep 2019 11:29:33 -0600
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Keith Busch <keith.busch@intel.com>
References: <20190831152910.GA29439@localhost.localdomain>
 <33af4d94-9f6d-9baa-01fa-0f75ccee263e@deltatee.com>
 <20190903164620.GA20847@localhost.localdomain>
 <20190904060558.GA10849@lst.de>
 <20190904144426.GB21302@localhost.localdomain>
 <20190904154215.GA20422@lst.de>
 <20190904155445.GD21302@localhost.localdomain>
 <ef3bf93b-cb47-95c5-7d96-f81d9acfdb55@deltatee.com>
 <20190904163557.GF21302@localhost.localdomain>
 <f07e03f1-48f0-591e-fdf6-9499fa4dd9ab@deltatee.com>
 <20190904171445.GG21302@localhost.localdomain>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5a4cf3b0-daa2-30de-63b2-c5b28c5bb7b4@deltatee.com>
Date:   Wed, 4 Sep 2019 11:29:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904171445.GG21302@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: keith.busch@intel.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, martin.petersen@oracle.com, sagi@grimberg.me, hare@suse.com, axboe@fb.com, hch@lst.de, kbusch@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH] nvme-core: Fix subsystem instance mismatches
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019-09-04 11:14 a.m., Keith Busch wrote:
> On Wed, Sep 04, 2019 at 11:01:22AM -0600, Logan Gunthorpe wrote:
>> Oh, yes that's simpler than the struct/kref method and looks like it
>> will accomplish the same thing. I did some brief testing with it and it
>> seems to work for me (though I don't have any subsystems with multiple
>> controllers). If you want to make a patch out of it you can add my
>>
>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> Thanks! I'll make it a proper patch and send shortly.
> 
> For testing multi-controller subsystems, I haven't got proper hardware
> either, so I really like the nvme loop target. Here's a very simple json
> defining a two namespace subsystem backed by two real nvme devices:

Cool right, thanks for the tip, I should have thought of that. I just
did some more loop testing with your patch and it behaves roughly as we
expect. The controller and subsystem IDs never overlap unless they are
created at the same time and it doesn't look like any IDs are ever
leaked. With simple non-CMIC devices the ctrl and subsystem always have
the same instance number.

Logan
