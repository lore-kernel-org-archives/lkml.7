Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A1BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10AB20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tNZ4iHzr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729202AbfDDKRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:17:22 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6768 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbfDDKRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:17:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554373040; x=1585909040;
  h=from:to:subject:date:message-id:mime-version;
  bh=I4CCV6KLI97RKKOs9+G0QaWvIxWlVqRP7fbiAEF/Xhw=;
  b=tNZ4iHzrGRAkfjaCBtSObMYrZTB9c7uBFuhfhnqaLbPPrSgr9ECHFjPK
   BsUDDPRG3I80sUNMolgDQsSysWrCOz1t179HMfkdUwVdvKedhXgLn6hvZ
   09r+ajhfqNZZDRh3zCQJdx1HdrVUAA6Co0+S+3fxzMScHmoy/+UUKItzr
   E=;
X-IronPort-AV: E=Sophos;i="5.60,308,1549929600"; 
   d="scan'208";a="725984684"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 Apr 2019 10:17:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x34AHEgp057459
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 4 Apr 2019 10:17:15 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:14 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 4 Apr 2019 10:17:08 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <rui.zhang@intel.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/2] Amazon's Annapurna Labs Thermal Sensor Driver
Date:   Thu, 4 Apr 2019 13:16:54 +0300
Message-ID: <1554373016-1442-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D25UWC003.ant.amazon.com (10.43.162.129) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Thermal Sensor
based on a new simple MMIO thermal driver. This driver is intended to be
used by other devices as well, which require just a simple MMIO access to
read temperature. 

Changes since v1:
==================
- removed the "thermal_mmio" compatible string. With v2 version, only
  specific hardware can bound
- add initialization function that is mapped based on the specific binding
  string
- removed thermal_mmio_readl and thermal_readw, but kept mmio reads in
  callback function. Left only thermal_mmio_reab which is used by
  al-thermal
- removed divider, bias, width which are not needed for al-thermal.



Talel Shenhar (2):
  dt-bindings: thermal: al-thermal: Add binding documentation
  thermal: Introduce Amazon's Annapurna Labs Thermal Driver

 .../bindings/thermal/amazon,al-thermal.txt         |  33 ++++++
 MAINTAINERS                                        |   6 +
 drivers/thermal/Kconfig                            |  10 ++
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/thermal_mmio.c                     | 129 +++++++++++++++++++++
 5 files changed, 179 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/amazon,al-thermal.txt
 create mode 100644 drivers/thermal/thermal_mmio.c

-- 
2.7.4

