Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91DC5B578
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4AD8218A0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 23:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfGCXDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 19:03:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:44162 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfGCXDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 19:03:40 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hioHq-0005uR-Bd; Wed, 03 Jul 2019 17:03:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1hioHp-0005yB-10; Wed, 03 Jul 2019 17:03:37 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed,  3 Jul 2019 17:03:02 -0600
Message-Id: <20190703230304.22905-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 0/2] Fix use-after-free bug when ports are removed
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

This is the second attempt at fixing this.

Per Sagi's feedback on the first attempt, I've found an approach
that disconnects active controllers when the subsys is removed from
the port (Patch 1). Patch 2 fixes a race that still exists in the
loop transport which requires us to flush the nvme_delete_wq before
freeing the port to prevent the use-after-free bug.

Logan

--

NVME target ports can be removed while there are still active
controllers. Largely this is fine, except some admin commands
can access the req->port (for example, id-ctrl uses the port's
inline date size as part of it's response). This was found
while testing with KASAN.

--

Logan Gunthorpe (2):
  nvmet: Fix use-after-free bug when a port is removed
  nvmet-loop: Flush nvme_delete_wq when removing the port

 drivers/nvme/target/configfs.c |  1 +
 drivers/nvme/target/core.c     | 12 ++++++++++++
 drivers/nvme/target/loop.c     |  8 ++++++++
 drivers/nvme/target/nvmet.h    |  3 +++
 4 files changed, 24 insertions(+)

--
2.20.1
