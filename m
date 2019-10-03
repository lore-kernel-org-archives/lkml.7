Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FA0C4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B272070B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="g763e/B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbfJCLtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:49:50 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:44345 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfJCLtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1570103388; x=1601639388;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=QLZXac2aKdPQN+qy4ncbu1UgsJ89NCj4anql7kIwAq8=;
  b=g763e/B3o3sQlymTin5Sx/W264Pr9vLiWst+PriT+sBwo2a57qxO+NSP
   gsTEcvprUwaeksp2980ALWFDRMhEwBMsXecQELXCMd2ouzbxBqZJIavkl
   aDL+eFht/Jgiv9Sh5h10BnxylKEd+qA00I8Xz3ZK3Ja1AHdbJAwrBQ/zE
   4=;
X-IronPort-AV: E=Sophos;i="5.67,251,1566864000"; 
   d="scan'208";a="425564051"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 03 Oct 2019 11:49:47 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-2c665b5d.us-east-1.amazon.com (Postfix) with ESMTPS id 30825A218B;
        Thu,  3 Oct 2019 11:49:43 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:49:43 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.161.223) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 3 Oct 2019 11:49:34 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>, <bp@alien8.de>,
        <mchehab@kernel.org>, <james.morse@arm.com>, <talel@amazon.com>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <paulmck@linux.ibm.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <jonnyc@amazon.com>,
        <hanochu@amazon.com>, <amirkl@amazon.com>, <barakw@amazon.com>
Subject: [PATCH v3 0/2] Amazon's Annapurna Labs Memory Controller EDAC
Date:   Thu, 3 Oct 2019 14:49:21 +0300
Message-ID: <1570103363-21486-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.223]
X-ClientProxiedBy: EX13D10UWB003.ant.amazon.com (10.43.161.106) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Memory
Controller EDAC driver.

Changes since v2:
=================
- added missing includes
- aggregated variables to same line
- removed ranks read
- added spinlock to mc reporting
- made irq handler clearer
- freed irq before freeing device memory
- changed Kconfig to tristate
- added COMPILE_TEST to Kconfig
- converted dt binding to new scheme
- used devm_platform_ioremap_resource instead of get&ioremap

Changes since v1:
=================
- updated dt binding node name and added Rob Reviewed-By
- removed auto selecting of this driver


Talel Shenhar (2):
  dt-bindings: edac: al-mc-edac: Amazon's Annapurna Labs Memory
    Controller EDAC
  EDAC: al-mc-edac: Introduce Amazon's Annapurna Labs Memory Controller
    EDAC

 .../bindings/edac/amazon,al-mc-edac.yaml           |  40 +++
 MAINTAINERS                                        |   7 +
 drivers/edac/Kconfig                               |   7 +
 drivers/edac/Makefile                              |   1 +
 drivers/edac/al_mc_edac.c                          | 358 +++++++++++++++++++++
 5 files changed, 413 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/edac/amazon,al-mc-edac.yaml
 create mode 100644 drivers/edac/al_mc_edac.c

-- 
2.7.4

