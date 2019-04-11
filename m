Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4DDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A924E20818
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BFe4Euni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbfDKKXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 06:23:11 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:32476 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfDKKXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 06:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554978190; x=1586514190;
  h=from:to:subject:date:message-id:mime-version;
  bh=ZdwRQPKamKRhDq4hZZRT4OqvNsRINrDHac1Ji29q3kM=;
  b=BFe4EunidO+S6/DoqdcbX2wQwsfhRZkBifVzTKn3AVVtGsoZoWK2nmuY
   bJkWWgIcBhhsLYVKtjaebo4b8y6cowr7xQ8Ns+YKKwoGMlEjE/mwoVSyQ
   ZJQbjbacotZLyIFrq/Wac91JBHbSf3SH4ouI2OtElhbRVA+jh4/pVtNo7
   g=;
X-IronPort-AV: E=Sophos;i="5.60,337,1549929600"; 
   d="scan'208";a="727378066"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 11 Apr 2019 10:23:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3BAN6k2067872
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 11 Apr 2019 10:23:06 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Apr 2019 10:23:05 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.160.69) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 11 Apr 2019 10:22:58 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <talel@amazon.com>, <robh@kernel.org>, <edubezval@gmail.com>,
        <dwmw@amazon.co.uk>, <jonnyc@amazon.com>, <rui.zhang@intel.com>,
        <hhhawa@amazon.com>, <ronenk@amazon.com>, <hanochu@amazon.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/2] Amazon's Annapurna Labs Thermal Sensor Driver
Date:   Thu, 11 Apr 2019 13:22:46 +0300
Message-ID: <1554978168-17369-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13D15UWB001.ant.amazon.com (10.43.161.254) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Amazon's Annapurna Labs Thermal Sensor
based on a new simple MMIO thermal driver. This driver is intended to be
used by other devices as well, which require just a simple MMIO access to
read temperature. 

Changes since v2:
=================
- dt-binding: changed node name from "thermal_z0" to "thermal-z0"
- dt-binding: changed node name from thermalz0_crit to "critical"

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

