Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44082C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F2921882
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfGCRBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 13:01:45 -0400
Received: from ale.deltatee.com ([207.54.116.67]:36968 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCRBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 13:01:42 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hiidX-0000CZ-9D; Wed, 03 Jul 2019 11:01:42 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hiidV-0005bl-VX; Wed, 03 Jul 2019 11:01:38 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  3 Jul 2019 11:01:34 -0600
Message-Id: <20190703170136.21515-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/2]  Fix use-after-free bug when ports are removed
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

NVME target ports can be removed while there are still active
controllers. Largely this is fine, except some admin commands
can access the req->port (for example, id-ctrl uses the port's
inline date size as part of it's response). This was found
while testing with KASAN.

Two patches follow which disconnect active controllers when the
ports are removed for loop and rdma. I'm not sure if fc has the
same issue and have no way to test this.

Alternatively, we could add reference counting to the struct port,
but I think this is a more involved change and could be done later
after we fix the bug quickly.

Thanks,

Logan

--

Logan Gunthorpe (2):
  nvmet-loop: Fix use-after-free bug when a port is removed
  nvmet-rdma: Fix use-after-free bug when a port is removed

 drivers/nvme/target/loop.c | 11 +++++++++++
 drivers/nvme/target/rdma.c | 16 ++++++++++++++++
 2 files changed, 27 insertions(+)

--
2.20.1
