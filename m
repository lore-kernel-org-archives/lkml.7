Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D7BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDE052070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 08:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfHLIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 04:52:20 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48127 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbfHLIwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 04:52:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04391;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TZGPiR-_1565599926;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0TZGPiR-_1565599926)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 12 Aug 2019 16:52:14 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com,
        linux-kernel@vger.kernel.org
Cc:     tao.ma@linux.alibaba.com, gerry@linux.alibaba.com,
        nanhai.zou@linux.alibaba.com, linyunsheng@huawei.com
Subject: [PATCH v2 0/3] introduce update_irq_devid and optimize VFIO irq ops
Date:   Mon, 12 Aug 2019 16:52:03 +0800
Message-Id: <cover.1565594108.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1565263723.git.luoben@linux.alibaba.com>
References: <cover.1565263723.git.luoben@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO takes a lot of free-then-request-irq actions whenever
a VM (with device passthru via VFIO) sets irq affinity or mask/unmask
irq. Those actions only change the cookie data of irqaction or even
change nothing. The free-then-request-irq not only add more latency,
but also increases the risk of losing interrupt, this may lead to a
VM hung forever in waiting IO completion

This patchset solved this issue by:
Patch 2 introduces update_irq_devid to only update dev_id of irqaction
Patch 3 make use of update_irq_devid and optimize irq operations in VFIO

changes from v1:
 - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
 - enhance error recovery code and debugging info in update_irq_devid
 - use __must_check in external referencing of update_irq_devid
 - use EXPORT_SYMBOL_GPL for update_irq_devid
 - reformat code of patch 3 for better readability

Ben Luo (3):
  genirq: enhance error recovery code in free irq
  genirq: introduce update_irq_devid()
  vfio_pci: make use of update_irq_devid and optimize irq ops

 drivers/vfio/pci/vfio_pci_intrs.c |  99 +++++++++++++++++++++-------------
 include/linux/interrupt.h         |   3 ++
 kernel/irq/manage.c               | 111 +++++++++++++++++++++++++++++++++-----
 3 files changed, 163 insertions(+), 50 deletions(-)

-- 
1.8.3.1

