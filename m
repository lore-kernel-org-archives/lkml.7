Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC87C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3FF2084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 12:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="csIaxlo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfDCMgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 08:36:06 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:3759 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfDCMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 08:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1554294960; x=1585830960;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DvRHBQJQh5aPyQRkoJui/bmQxXtf6YrC3CVrZRN4uh8=;
  b=csIaxlo0wmwtnLZGt+AqieSGIwcQCpBb/Q04AWesoknwzxf5p8JH7P/T
   Z9LXGleI69Nza/v0zPQC6hl6NJxfDF1PM3ALnwVyGsLON8SXWN2YE2ZS6
   4TlfVoervRLB8tuxLPN+tNs/I60yycm3NCq/brWqvfHwIrxGQCKews9Bd
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,304,1549929600"; 
   d="scan'208";a="792315462"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 03 Apr 2019 12:35:49 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x33CZi4I045777
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 3 Apr 2019 12:35:44 GMT
Received: from EX13D18EUA002.ant.amazon.com (10.43.165.184) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:44 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D18EUA002.ant.amazon.com (10.43.165.184) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 3 Apr 2019 12:35:43 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Wed, 3 Apr 2019 12:35:41 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix, from userid 5466572)
        id A312424A25; Wed,  3 Apr 2019 12:35:41 +0000 (UTC)
From:   Maximilian Heyne <mheyne@amazon.de>
CC:     David Woodhouse <dwmw2@infradead.org>, Amit Shah <aams@amazon.de>,
        Maximilian Heyne <mheyne@amazon.de>,
        Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/2] Adding per-controller timeout support to nvme
Date:   Wed, 3 Apr 2019 12:35:04 +0000
Message-ID: <20190403123506.122904-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.5
MIME-Version: 1.0
Content-Type: text/plain
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As different nvme controllers are connect via different fabrics, some require
different timeout settings than others. This series implements per-controller
timeouts in the nvme subsystem which can be set via sysfs.

We have reached out to the NVMe working group to implement per-controller
timeout values. These patches are paving the way for this.

Changes since v1:
- implement the change not only for the pci NVMe driver but also for fc,
  lightnvm, rdma, tcp and loop.
- add an additional check when updating timeouts to not race with controller
  creation or deletion

Maximilian Heyne (2):
  nvme: add per-controller io and admin timeouts
  nvme: add sysfs controls for io and admin timeouts

 drivers/nvme/host/core.c     | 123 +++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/host/fc.c       |   2 +-
 drivers/nvme/host/lightnvm.c |   2 +-
 drivers/nvme/host/nvme.h     |   2 +
 drivers/nvme/host/pci.c      |  13 ++---
 drivers/nvme/host/rdma.c     |   4 +-
 drivers/nvme/host/tcp.c      |   4 +-
 drivers/nvme/target/loop.c   |   4 +-
 8 files changed, 136 insertions(+), 18 deletions(-)

-- 
2.16.5




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrer: Christian Schlaeger, Ralf Herbrich
Ust-ID: DE 289 237 879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B


