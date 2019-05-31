Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E67C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A63E263C9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 04:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cUnuTd7r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbfEaEef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 00:34:35 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:41121 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfEaEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 00:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559277274; x=1590813274;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rWZylmxt/NNWlYGvQ7wVH1y8Psn+3RZud7pA+S3VO8U=;
  b=cUnuTd7rjQ7+xzB9DK40kIj0Z/x9mfXliZFC2Zjov/uFqkhcMIgK2+2f
   lXRN4dpt8k4F8ahBI4VGvOIjzLWJpQFBKRu9glWEthWpAAGvxRr1lqUWi
   jU+7q2wXEgxF9FjmZAJg5Kzf2gsX6xhX+c9IvA7YbA7y3I/DCJUKT2AbU
   Y=;
X-IronPort-AV: E=Sophos;i="5.60,533,1549929600"; 
   d="scan'208";a="802758359"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-a70de69e.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 31 May 2019 04:34:32 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-a70de69e.us-east-1.amazon.com (Postfix) with ESMTPS id BC12DA22FB;
        Fri, 31 May 2019 04:34:28 +0000 (UTC)
Received: from EX13D05UWB002.ant.amazon.com (10.43.161.50) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 04:34:28 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13D05UWB002.ant.amazon.com (10.43.161.50) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 31 May 2019 04:34:27 +0000
Received: from localhost (10.85.16.145) by mail-relay.amazon.com
 (10.43.160.118) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Fri, 31 May 2019 04:34:27 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Haiyue Wang <haiyue.wang@linux.intel.com>,
        <jarkko.nikula@linux.intel.com>, <andriy.shevchenko@intel.com>,
        <brendanhiggins@google.com>, Eduardo Valentin <eduval@amazon.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] introduce i2c-slave-mqueue
Date:   Thu, 30 May 2019 21:33:44 -0700
Message-ID: <20190531043347.4196-1-eduval@amazon.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wolfram,

I am sending you the i2c-slave-mqueue driver.
Apparently Haiyue had to move on to another project and
does not have cycles to continue with the comments on this
driver after some time waiting for feedback,
that is essentially why I took over.

Here is a small changelog from V5 to V6:
- Added DT support for probing via Device Tree
- Docummented DT bindings
- Documented sysfs ABI
- Small fixes on wording and Kconfig entries.

Haiyue's V5: https://lkml.org/lkml/2018/4/23/835

BR,

Eduardo Valentin (2):
  dt-bindings: i2c: document bindings for i2c-slave-mqueue
  Documentation: ABI: Add i2c-slave-mqueue sysfs documentation

Haiyue Wang (1):
  i2c: slave-mqueue: add a slave backend to receive and queue messages

 .../sysfs-bus-i2c-devices-slave-mqueue        |  10 +
 .../bindings/i2c/i2c-slave-mqueue.txt         |  34 +++
 Documentation/i2c/slave-mqueue-backend.rst    | 124 ++++++++++
 MAINTAINERS                                   |   8 +
 drivers/i2c/Kconfig                           |  25 +++
 drivers/i2c/Makefile                          |   1 +
 drivers/i2c/i2c-slave-mqueue.c                | 211 ++++++++++++++++++
 7 files changed, 413 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-slave-mqueue
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-slave-mqueue.txt
 create mode 100644 Documentation/i2c/slave-mqueue-backend.rst
 create mode 100644 drivers/i2c/i2c-slave-mqueue.c

-- 
2.21.0

