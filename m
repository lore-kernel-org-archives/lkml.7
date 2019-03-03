Return-Path: <SRS0=GAfv=RG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7FFC43381
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDC620863
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Mar 2019 08:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="GDaQDExm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfCCIuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Mar 2019 03:50:20 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:32654 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Mar 2019 03:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1551603019; x=1583139019;
  h=from:to:subject:date:message-id:mime-version;
  bh=HULVZF1Nd30wsAPzXNiwMKC16XIsSssaDMvSux7F4Jw=;
  b=GDaQDExm5XnbCcwXqzF7JZVRjeI/LosNFgFD+Fc5ZfMqhsMSlqFm1xAj
   GiF63+SGpHFyeK4BgqrOsIJojT3bcJhFMwa+m/Z42vuYX802iqoLuXanB
   qFgHonMbrVca42GDkQG23KFDi14qcyFEYuprcuwQLmbRApm7XFb8SLgBb
   8=;
X-IronPort-AV: E=Sophos;i="5.58,435,1544486400"; 
   d="scan'208";a="791048729"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-17c49630.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Mar 2019 08:50:14 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-17c49630.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x238oBZu086876
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 3 Mar 2019 08:50:11 GMT
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 3 Mar 2019 08:50:10 +0000
Received: from udc4a3e82dbc15a031435.hfa14.amazon.com (10.43.161.217) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 3 Mar 2019 08:50:04 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <edubezval@gmail.com>, <rui.zhang@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>
Subject: [PATCH 0/2] Thermal MMIO Driver
Date:   Sun, 3 Mar 2019 10:49:24 +0200
Message-ID: <1551602966-2334-1-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.161.217]
X-ClientProxiedBy: EX13D24UWA004.ant.amazon.com (10.43.160.233) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces the generic thermal MMIO driver that will use
memory mapped reads to get the temperature.  Any HW/System that
allows temperature reading by a single memory-mapped reading, be it
register or shared memory, is a potential candidate to work with this
driver.

This driver is most suitable for cases such as the following:
- The entire thermal HW setup is done by another SW entity (e.g.
  bootloader) and all that is left is to read the current temperature from
  a register.
- The thermal HW setup is done via an external CPU (e.g. micro-controller)
  and that CPU has is using shared memory that can be memory-mapped to this
  driver.
- The thermal HW setup and reading is done via CPLD, which exports the
  current temperature to the system via a register.
- The thermal HW is working out-of-the-box and only reports temperature via
  a single register access.



Talel Shenhar (2):
  dt-bindings: thermal: thermal_mmio: Add binding documentation
  thermal: Introduce thermal MMIO

 .../devicetree/bindings/thermal/thermal_mmio.txt   | 173 +++++++++++++++++
 drivers/thermal/Kconfig                            |  11 ++
 drivers/thermal/Makefile                           |   3 +
 drivers/thermal/thermal_mmio.c                     | 214 +++++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/thermal_mmio.txt
 create mode 100644 drivers/thermal/thermal_mmio.c

-- 
2.7.4

