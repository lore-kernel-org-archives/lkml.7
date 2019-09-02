Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1258DC3A59B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D714D21744
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 04:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfIBECD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 00:02:03 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:56131 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725681AbfIBECC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 00:02:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=luoben@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Tb3eY5p_1567396912;
Received: from localhost(mailfrom:luoben@linux.alibaba.com fp:SMTPD_---0Tb3eY5p_1567396912)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 Sep 2019 12:01:55 +0800
From:   Ben Luo <luoben@linux.alibaba.com>
To:     tglx@linutronix.de, alex.williamson@redhat.com
Cc:     linux-kernel@vger.kernel.org, tao.ma@linux.alibaba.com,
        gerry@linux.alibaba.com, nanhai.zou@linux.alibaba.com
Subject: [PATCH v6 0/3] genirq/vfio: Introduce irq_update_devid() and optimize VFIO irq ops
Date:   Mon,  2 Sep 2019 12:01:49 +0800
Message-Id: <cover.1567394624.git.luoben@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, VFIO takes a free-then-request-irq way to do interrupt
affinity setting and masking/unmasking for a VM with device passthru
via VFIO. Sometimes it only changes the cookie data of irqaction or even
changes nothing. The free-then-request-irq not only adds more latency,
but also increases the risk of losing interrupt, which may lead to a
VM hang forever in waiting for IO completion

This patchset solved the issue by:
Patch 2 introduces irq_update_devid() to only update dev_id of irqaction
Patch 3 make use of this function and optimize irq operations in VFIO

changes from v5:
 - Patch 3: remove an error log to avoid potential DDoS attacking
 _ Patch 3: fix typo in comment

changes from v4:
 - Patch 3: follow the previous behavior to disable interrupt on error path
 - Patch 3: do irqbypass registration before update or free the interrupt
 - Patch 3: add more comments

changes from v3:
 - Patch 2: rename the new function to irq_update_devid()
 - Patch 2: use disbale_irq() to avoid a twist for threaded interrupt
 - ALL: amend commit messages and code comments

changes from v2:
 - reformat to avoid quoted string split across lines and etc.

changes from v1:
 - add Patch 1 to enhance error recovery etc. in free irq per tglx's comments
 - enhance error recovery code and debugging info in irq_update_devid
 - use __must_check in external referencing of this function
 - use EXPORT_SYMBOL_GPL for irq_update_devid
 - reformat code of patch 3 for better readability

Ben Luo (3):
  genirq: enhance error recovery code in free irq
  genirq: introduce irq_update_devid()
  vfio/pci: make use of irq_update_devid() and optimize irq ops

 drivers/vfio/pci/vfio_pci_intrs.c | 118 ++++++++++++++++++++++++++------------
 include/linux/interrupt.h         |   3 +
 kernel/irq/manage.c               | 105 +++++++++++++++++++++++++++++----
 3 files changed, 177 insertions(+), 49 deletions(-)

-- 
1.8.3.1

