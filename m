Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063B4C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DBE20692
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 16:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FE66yPxs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfLIQch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 11:32:37 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:47540 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbfLIQch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 11:32:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575909157; x=1607445157;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DSkO43vZ6jMSY4v0dhIXeNPsDIsCAb8O7azHytXOI8M=;
  b=FE66yPxs8wlAAcEWjP8pEPIgplHbXGHA3uG7ywV8pfU5qpUUVr2ajMPV
   cW0jkGtPXmP2BWztQRArxnfWbi2ARm4a97TJnhCM6ykcqgU09a0vsnYxm
   5Zf1jEKtmRURnBiPM+THYqYLpHr6MvFxINR8VNO5nhzr2/JIjvLmlrb2B
   E=;
IronPort-SDR: 06bsbpUXVKcSe5TxVXlcwhKaIKxAsDSCVtwp/skcHUnFycwF2rpJ66FCnWxxXAGgD7hsfsbJvF
 pspmjoEcEc5A==
X-IronPort-AV: E=Sophos;i="5.69,296,1571702400"; 
   d="scan'208";a="7701640"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 09 Dec 2019 16:32:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 61353A245F;
        Mon,  9 Dec 2019 16:32:33 +0000 (UTC)
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:32 +0000
Received: from ua9e4f3715fbc5f.ant.amazon.com (10.43.162.171) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 9 Dec 2019 16:32:26 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <axboe@kernel.dk>, <hdegoede@redhat.com>
CC:     <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dwmw@amazon.co.uk>, <benh@amazon.com>, <ronenk@amazon.com>,
        <talel@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <hhhawa@amazon.com>
Subject: [PATCH 0/2] ata: ahci: Add shutdown handler
Date:   Mon, 9 Dec 2019 16:32:07 +0000
Message-ID: <20191209163209.26284-1-hhhawa@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.162.171]
X-ClientProxiedBy: EX13D34UWA002.ant.amazon.com (10.43.160.245) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduced AHCI shutdown handler for AHCI PCIe driver, to
disable host controller DMA and interrupts in order to avoid potentially
corrupting or otherwise interfering with a new kernel being started with
kexec.

Part of this patch move the common part between platform and pcie
drivers to libahci.c.

Hanna Hawa (2):
  ata: libahci: move ahci platform shutdown function to libahci
  ata: ahci: Add shutdown handler

 drivers/ata/ahci.c             |  9 +++++++++
 drivers/ata/ahci.h             |  1 +
 drivers/ata/libahci.c          | 33 +++++++++++++++++++++++++++++++++
 drivers/ata/libahci_platform.c | 20 +-------------------
 4 files changed, 44 insertions(+), 19 deletions(-)

-- 
2.17.1

