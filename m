Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8590EC3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAC520674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 08:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfHYIC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 04:02:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35952 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfHYIC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 04:02:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 91FDB3083362;
        Sun, 25 Aug 2019 08:02:26 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81A4910016EB;
        Sun, 25 Aug 2019 08:02:18 +0000 (UTC)
Date:   Sun, 25 Aug 2019 16:02:13 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: Re: [PATCH V6 0/2] genriq/affinity: Make vectors allocation fair
Message-ID: <20190825080212.GA17265@ming.t460p>
References: <20190819124937.9948-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190819124937.9948-1-ming.lei@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Sun, 25 Aug 2019 08:02:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 19, 2019 at 08:49:35PM +0800, Ming Lei wrote:
> Hi Thomas,
> 
> The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
> all nodes can be covered in the spread.
> 
> The 2nd patch spread vectors on node according to the ratio of this node's
> CPU number to number of all remaining CPUs, then vectors assignment can
> become more fair. Meantime, the warning report from Jon Derrick can be
> fixed.
> 
> Please consider it for V5.4.
> 
> V6:
> 	- fix build waring reported by zero day, and extra change is only
> 	done on irq_build_affinity_masks()
> 
> V5:
> 	- remove patch 1 of V4, which is wrong
> 	- handle vector wrapping because the 'start vector' may begin
> 	  anywhere, especially for the 2nd stage spread
> 	- add more comment on the vector allocation algorithm
> 	- cleanup code a bit
> 	- run more tests to verify the change, which always get the
> 	expected result. Covers lots of num_queues, numa topo, CPU
> 	unpresent setting.
> 
> V4:
> 	- provide proof why number of allocated vectors for each node is <= CPU
> 	  count of this node
> 
> V3:
> 	- re-order the patchset
> 	- add helper of irq_spread_vectors_on_node()
> 	- handle vector spread correctly in case that numvecs is > ncpus
> 	- return -ENOMEM to API's caller
> 
> V2:
> 	- add patch3
> 	- start to allocate vectors from node with minimized CPU number,
> 	  then every node is guaranteed to be allocated at least one vector.
> 	- avoid cross node spread
> 
> 
> 
> Ming Lei (2):
>   genirq/affinity: Improve __irq_build_affinity_masks()
>   genirq/affinity: Spread vectors on node according to nr_cpu ratio
> 
>  kernel/irq/affinity.c | 231 ++++++++++++++++++++++++++++++++++++------
>  1 file changed, 201 insertions(+), 30 deletions(-)
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: linux-nvme@lists.infradead.org,
> Cc: Jon Derrick <jonathan.derrick@intel.com>
> -- 
> 2.20.1
> 

Hi Thomas,

Gentle ping on the two patches.


Thanks, 
Ming
