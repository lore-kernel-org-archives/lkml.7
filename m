Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC5BC41514
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC7320C01
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 14:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565103450;
	bh=qv9VLYI4YXiz7Xg5UU3MBCYuuX9SV3fmurXwzWkX9Vw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=nt3Dvnlco9ZCvPomKa92u8tyYySq0Zxg95nwfnrGvye3aY93DHvxDpTe+3LclqbaS
	 +nupsOC72Z6jw5Gc3xt+HUjA0hdSq7Mce7FlB3OEH+mWYIdo6hPAoVQ/8vKgxE7zzw
	 63UJ+eombphmDCaAxo9v74TuJHt4lS+wTzVSL94g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733145AbfHFO53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 10:57:29 -0400
Received: from foss.arm.com ([217.140.110.172]:34660 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732976AbfHFO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 10:57:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2B6EC344;
        Tue,  6 Aug 2019 07:57:28 -0700 (PDT)
Received: from filthy-habits.cambridge.arm.com (filthy-habits.cambridge.arm.com [10.1.197.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B05F93F706;
        Tue,  6 Aug 2019 07:57:26 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linusw@kernel.org>, Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] irqdomain/debugfs: Fix uses of irq_domain_alloc_fwnode
Date:   Tue,  6 Aug 2019 15:57:08 +0100
Message-Id: <20190806145716.125421-1-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently noticed that all irq_domain_alloc_fwnode were passing a VA
to it, which is unfortunate as this is designed to appear in debugfs
(and we don't like to leak VAs). Disaster was avoided thanks to our
____ptrval____ friend, but it remains that the whole thing is pretty
useless if you have more than a single domain (they all have the same
name and creation fails).

In order to sort it out, change all users of irq_domain_alloc_fwnode
to pass the PA of the irqchip the domain will be associated with. One
notable exception is the HyperV PCI controller driver which has no PA
to associate with. This is solved by using a named fwnode instead,
using the device GUID.

Finally, irq_domain_alloc_fwnode() is changed to pa a pionter to a PA,
which can be safely advertised in debugfs.

Marc Zyngier (8):
  irqchip/gic-v3: Register the distributor's PA instead of its VA in
    fwnode
  irqchip/gic-v3-its: Register the ITS' PA instead of its VA in fwnode
  irqchip/gic: Register the distributor's PA instead of its VA in fwnode
  irqchip/gic-v2m: Register the frame's PA instead of its VA in fwnode
  irqchip/ixp4xx: Register the base PA instead of its VA in fwnode
  gpio/ixp4xx: Register the base PA instead of its VA in fwnode
  PCI: hv: Allocate a named fwnode instead of an address-based one
  irqdomain/debugfs: Use PAs to generate fwnode names

 drivers/gpio/gpio-ixp4xx.c          |  2 +-
 drivers/irqchip/irq-gic-v2m.c       |  2 +-
 drivers/irqchip/irq-gic-v3-its.c    |  2 +-
 drivers/irqchip/irq-gic-v3.c        |  2 +-
 drivers/irqchip/irq-gic.c           |  2 +-
 drivers/irqchip/irq-ixp4xx.c        |  2 +-
 drivers/pci/controller/pci-hyperv.c | 10 +++++++++-
 include/linux/irqdomain.h           |  6 +++---
 kernel/irq/irqdomain.c              |  9 +++++----
 9 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.20.1

