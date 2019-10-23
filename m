Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F411CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9C72084C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 16:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436564AbfJWQgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 12:36:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48550 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733188AbfJWQgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 12:36:00 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc4-0006Vr-8G; Wed, 23 Oct 2019 10:35:59 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iNJc2-00016T-Fw; Wed, 23 Oct 2019 10:35:54 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 23 Oct 2019 10:35:38 -0600
Message-Id: <20191023163545.4193-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 0/7] Remove data_len field from the nvmet_req struct
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset is a cleanup in preparation for the passthru patchset.
The aim is to remove the data_len field in the nvmet_req struct and
instead just check the length is appropriate inside the execute
handlers. This is more appropriate for passthru which may have
commands with unknown lengths (like Vendor Specific Commands).
It's also in improvement seeing it can often be confusing when
it's best to use the data_len field over the transfer_len field.
The first two patches in this series remove some questionable uses
of the data_len field in nvmt-tcp

Most of this patchset was extracted from a draft patch from
Christoph[1].

The series is based on v5.4-rc4 and a git branch is available here:

https://github.com/sbates130272/linux-p2pmem/branches nvmet_data_len

Logan

[1] https://lore.kernel.org/linux-block/20191010110425.GA28372@lst.de/

--

Logan Gunthorpe (7):
  nvmet-tcp: Don't check data_len in nvmet_tcp_map_data()
  nvmet-tcp: Don't set the request's data_len
  nvmet: Introduce common execute function for get_log_page and identify
  nvmet: Cleanup discovery execute handlers
  nvmet: Introduce nvmet_dsm_len() helper
  nvmet: Remove the data_len field from the nvmet_req struct
  nvmet: Open code nvmet_req_execute()

 drivers/nvme/target/admin-cmd.c   | 128 +++++++++++++++++-------------
 drivers/nvme/target/core.c        |  12 +--
 drivers/nvme/target/discovery.c   |  62 +++++++--------
 drivers/nvme/target/fabrics-cmd.c |  15 +++-
 drivers/nvme/target/fc.c          |   4 +-
 drivers/nvme/target/io-cmd-bdev.c |  19 +++--
 drivers/nvme/target/io-cmd-file.c |  20 +++--
 drivers/nvme/target/loop.c        |   2 +-
 drivers/nvme/target/nvmet.h       |  10 ++-
 drivers/nvme/target/rdma.c        |   4 +-
 drivers/nvme/target/tcp.c         |  14 ++--
 11 files changed, 167 insertions(+), 123 deletions(-)

--
2.20.1
