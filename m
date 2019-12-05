Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD2DC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0D722525
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 14:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Zl9MkcFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbfLEOBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 09:01:48 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26536 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfLEOBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 09:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575554508; x=1607090508;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lGLBuGSdZX/veDcc+uJUEV1pogLhVnVlkgpfMlauIsY=;
  b=Zl9MkcFRW66pROUitBwOLoF1WNyeTtAALEVhzinuHI0peucRe8azZRIS
   HZChvTp7BeNCMs3sg6wp+SkzAK1iVq5GvavtlyZpL9GKd66f7CHvFczlP
   aCQ1wXE05Om/jSHs4IHHySroqO5+Z4VxXuGxpHgvUlPoUTw6JavVKUcut
   g=;
IronPort-SDR: ILqrpCruQ1ZMq7tf0Pdel+6wAAt+g7ejuplQtbOxk50vB0+5Kt8Dppuiz/S5f7dlbSPVzi+eDl
 yhjKWHfPpqrA==
X-IronPort-AV: E=Sophos;i="5.69,281,1571702400"; 
   d="scan'208";a="13183874"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1a-715bee71.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Dec 2019 14:01:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-715bee71.us-east-1.amazon.com (Postfix) with ESMTPS id 12E4EA2A34;
        Thu,  5 Dec 2019 14:01:33 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:32 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 5 Dec 2019 14:01:31 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 5 Dec 2019 14:01:28 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <linux-kernel@vger.kernel.org>, <xen-devel@lists.xenproject.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH 0/4] xen-blkback: support live update
Date:   Thu, 5 Dec 2019 14:01:19 +0000
Message-ID: <20191205140123.3817-1-pdurrant@amazon.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch #1 is clean-up for an apparent mis-feature.

Paul Durrant (4):
  xenbus: move xenbus_dev_shutdown() into frontend code...
  xenbus: limit when state is forced to closed
  xen/interface: don't discard pending work in FRONT/BACK_RING_ATTACH
  xen-blkback: support dynamic unbind/bind

 drivers/block/xen-blkback/xenbus.c         | 12 ++++----
 drivers/xen/xenbus/xenbus.h                |  2 --
 drivers/xen/xenbus/xenbus_probe.c          | 34 ++++++----------------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 ++++++++++++++-
 include/xen/interface/io/ring.h            |  4 +--
 6 files changed, 40 insertions(+), 37 deletions(-)
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.20.1

