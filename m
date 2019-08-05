Return-Path: <SRS0=v0Gj=WB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0E0C32751
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E55C920651
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Aug 2019 13:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565011690;
	bh=WpezVymSj/ZV62kDHi1BueDKYGV80SbgQzs2YmGL4sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GC2NEThGB99bxa0S5kN6+bJBB+a39aZc7yjGeVcz7h8gQPef5IMOnajzXNHBvCOzI
	 agLnOezim9ARDhx2nWlUEiXhrSVSNqBdfBg5CnIzVVl2c4VpjN/de91tPrkfqPNuvG
	 vDD9fKyPv0MGyZYltqxvcIHYTM+1hyULXsYlmi0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbfHEN2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Aug 2019 09:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:60632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730891AbfHENXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 09:23:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB78F20651;
        Mon,  5 Aug 2019 13:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565011432;
        bh=WpezVymSj/ZV62kDHi1BueDKYGV80SbgQzs2YmGL4sc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uxNbZKIgORFiii1VLgR9tTdRwS7UhK2eLVF459i0eA6f2oT9irI3qcoSyYQ9XGQ2d
         lWBr6EWe8hXcJdtw6XhAIy+epWVvhSoCRjvOUFsL6tnypZMPNfS+VVJjq5PQxTQDYe
         LiXgLkDXY0QMrKJi8ZWgSdmKh4rqkGufhssxo3YU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andreas Koop <andreas.koop@zf.com>,
        ShihPo Hung <shihpo.hung@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.2 086/131] mmc: mmc_spi: Enable stable writes
Date:   Mon,  5 Aug 2019 15:02:53 +0200
Message-Id: <20190805124957.722761571@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190805124951.453337465@linuxfoundation.org>
References: <20190805124951.453337465@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andreas Koop <andreas.koop@zf.com>

commit 3a6ffb3c8c3274a39dc8f2514526e645c5d21753 upstream.

While using the mmc_spi driver occasionally errors like this popped up:

mmcblk0: error -84 transferring data end_request: I/O error, dev mmcblk0, sector 581756

I looked on the Internet for occurrences of the same problem and came
across a helpful post [1]. It includes source code to reproduce the bug.
There is also an analysis about the cause. During transmission data in the
supplied buffer is being modified. Thus the previously calculated checksum
is not correct anymore.

After some digging I found out that device drivers are supposed to report
they need stable writes. To fix this I set the appropriate flag at queue
initialization if CRC checksumming is enabled for that SPI host.

[1]
https://groups.google.com/forum/#!msg/sim1/gLlzWeXGFr8/KevXinUXfc8J

Signed-off-by: Andreas Koop <andreas.koop@zf.com>
[shihpo: Rebase on top of v5.3-rc1]
Signed-off-by: ShihPo Hung <shihpo.hung@sifive.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
CC: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/core/queue.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -10,6 +10,7 @@
 #include <linux/kthread.h>
 #include <linux/scatterlist.h>
 #include <linux/dma-mapping.h>
+#include <linux/backing-dev.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -430,6 +431,10 @@ int mmc_init_queue(struct mmc_queue *mq,
 		goto free_tag_set;
 	}
 
+	if (mmc_host_is_spi(host) && host->use_spi_crc)
+		mq->queue->backing_dev_info->capabilities |=
+			BDI_CAP_STABLE_WRITES;
+
 	mq->queue->queuedata = mq;
 	blk_queue_rq_timeout(mq->queue, 60 * HZ);
 


