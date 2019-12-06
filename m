Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C76C2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DE5A20706
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 14:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfLFOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 09:38:50 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:49558 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726259AbfLFOiu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 09:38:50 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0D3A35B5EF5F41BE22E2;
        Fri,  6 Dec 2019 22:38:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 22:38:34 +0800
From:   John Garry <john.garry@huawei.com>
To:     <tglx@linutronix.de>
CC:     <chenxiang66@hisilicon.com>, <bigeasy@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <maz@kernel.org>, <hare@suse.com>,
        <ming.lei@redhat.com>, <hch@lst.de>, <axboe@kernel.dk>,
        <bvanassche@acm.org>, <peterz@infradead.org>, <mingo@redhat.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH RFC 0/1] Threaded handler uses irq affinity for when the interrupt is managed
Date:   Fri, 6 Dec 2019 22:35:03 +0800
Message-ID: <1575642904-58295-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As mentioned in [0], we are experiencing a scenario where data throughput
can be limited by the fact a CPU can be fully consumed in handling the
hard and threaded interrupt parts for a managed interrupt, while it can
help throughput by allowing another CPU to handle the threaded part. That
same link also includes some CPU load figures further in the discussion
for the same change in the patch here.

As some more background, in cbf8699996a6 ("genirq: Let irq thread follow
the effective hard irq affinity"), the change was made to enforce that the
threaded and hard parts should be kept on the same CPU, on the basis we
should not allow the threaded part stray from the CPU of the hard handler.

As in [0], again, Thomas said that it could be optional on whether we
allow the full irq affinity mask to be used. What that option is based on,
I am not sure.

Ming Lei said it would be sensible to do it when the interrupt is managed,
so that is the basis of this change.

Aside this this, it is worth noting that there has been another discussion
on CPU lockup from relentless handling of hard interrupts [2]. Using
threaded interrupts was discussed but seemingly rejected due to too much
context switching hitting performance. And so it seems that the conclusion
in that discussion was to use IRQ polling, but I have seen no recent
update.

[0] https://lore.kernel.org/lkml/e0e9478e-62a5-ca24-3b12-58f7d056383e@huawei.com/
[1] https://lore.kernel.org/lkml/CACVXFVPCiTU0mtXKS0fyMccPXN6hAdZNHv6y-f8-tz=FE=BV=g@mail.gmail.com/

John Garry (1):
  genirq: Make threaded handler use irq affinity for managed interrupt

 kernel/irq/manage.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.1

