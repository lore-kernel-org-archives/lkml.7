Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B96C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C1EC2084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 10:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfDIKXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 06:23:20 -0400
Received: from verein.lst.de ([213.95.11.211]:49451 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfDIKXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 06:23:20 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1180668B02; Tue,  9 Apr 2019 12:23:08 +0200 (CEST)
Date:   Tue, 9 Apr 2019 12:23:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme: add sysfs controls for io and admin
 timeouts
Message-ID: <20190409102307.GA7741@lst.de>
References: <20190403123506.122904-1-mheyne@amazon.de> <20190403123506.122904-3-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403123506.122904-3-mheyne@amazon.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I really don't think the iteration over all queues of a tagset
makes a whole lot of sense.  We really need to replace the per-queue
limit with a per-tagset one (or at least add the per-tagset one)
and then allow tweaking that in the block layer instead of writing
this boiler plate code.
