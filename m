Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAB4C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56D082178F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 16:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232293;
	bh=+kENHqz85tfOU1sQpqk5u9rRNpgekPEHUeduidqGMmQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=sxeiHnFfJzbfZ4yECvqnAtjWdLIFyySdh4dfkoHe9HqE8KriFBxDfZp2CyQcf/OUj
	 npPaLKP9c76vHjwMG3eNTk0o2y1iKM0iLsCCCJakAvGtk7hXHmuwOtILiF81GxjOAf
	 bfi5BJSPsEfdW1LLy03YjXzXxhj1ZoyHwho0pOnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfKHQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 11:58:12 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:34028 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbfKHQ6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 11:58:11 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iT7aL-0002sR-LW; Fri, 08 Nov 2019 17:58:09 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, lorenzo.pieralisi@arm.com,
        Andrew.Murray@arm.com, yuzenghui@huawei.com,
        Heyi Guo <guoheyi@huawei.com>
Subject: [PATCH v2 00/11] irqchip/gic-v3-its: Cleanup and fixes for Linux 5.5
Date:   Fri,  8 Nov 2019 16:57:54 +0000
Message-Id: <20191108165805.3071-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, guoheyi@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series is a mix of early GICv4.1 cleanups, fixes coming out of
discussions with Zenghui Yu, and a couple of stashed bug fixes that I
recently rediscovered (oops).

Hopefully nothing controvertial here, but please shout if you think
anything looks wrong. I've given it a good shake on my D05, and
everything was fine.

As $SUBJECT says, I plan to take this into 5.5.

Thanks,

	M.

* From v1:
  - Moved the collection map freeing from the irqdomain dtor
    into the device teardown function (noticed by Zenghui)

Marc Zyngier (11):
  irqchip/gic-v3-its: Free collection mapping on device teardown
  irqchip/gic-v3-its: Factor out wait_for_syncr primitive
  irqchip/gic-v3-its: Allow LPI invalidation via the DirectLPI interface
  irqchip/gic-v3-its: Make is_v4 use a TYPER copy
  irqchip/gic-v3-its: Kill its->ite_size and use TYPER copy instead
  irqchip/gic-v3-its: Kill its->device_ids and use TYPER copy instead
  irqchip/gic-v3-its: Add its_vlpi_map helpers
  irqchip/gic-v3-its: Synchronise INV command targetting a VLPI using
    VSYNC
  irqchip/gic-v3-its: Synchronise INT/CLEAR commands targetting a VLPI
    using VSYNC
  irqchip/irq-gic-v3-its: Lock VLPI map array before translating it
  irqchip/gic-v3-its: Make vlpi_lock a spinlock

 drivers/irqchip/irq-gic-v3-its.c   | 289 ++++++++++++++++++++++-------
 include/linux/irqchip/arm-gic-v3.h |   4 +-
 2 files changed, 224 insertions(+), 69 deletions(-)

-- 
2.20.1

