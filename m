Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FB8C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2E62085A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 09:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfHLJ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 05:57:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60132 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727485AbfHLJ5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 05:57:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48EC93066FBF;
        Mon, 12 Aug 2019 09:57:19 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 181EC5D6D0;
        Mon, 12 Aug 2019 09:57:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-nvme@lists.infradead.org,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH V2 0/3] genriq/affinity: Make vectors allocation fair
Date:   Mon, 12 Aug 2019 17:57:06 +0800
Message-Id: <20190812095709.25623-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 09:57:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The 1st patch makes __irq_build_affinity_masks() more reliable, such as,
all nodes can be covered in the spread.

The 2nd patch spread vectors on node according to the ratio of this node's
CPU number to number of all remaining CPUs, then vectors assignment can
become more fair. Meantime, the warning report from Jon Derrick can be
fixed.

The 3rd patch enhances one warning check.

Please review & comment!


V2:
	- add patch3
	- start to allocate vectors from node with minimized CPU number,
	  then every node is guaranteed to be allocated at least one vector.
	- avoid cross node spread

Ming Lei (3):
  genirq/affinity: Improve __irq_build_affinity_masks()
  genirq/affinity: Spread vectors on node according to nr_cpu ratio
  genirq/affinity: Enhance warning check

 kernel/irq/affinity.c | 140 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 121 insertions(+), 19 deletions(-)

Cc: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org,
Cc: Jon Derrick <jonathan.derrick@intel.com>
-- 
2.20.1

