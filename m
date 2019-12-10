Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACB0C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F26412464B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 11:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="A0wGIOnq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfLJLeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 06:34:11 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:58954 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfLJLeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 06:34:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1575977651; x=1607513651;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LiFxV5CMEgQkjnYID39q3GkTj66kaKL32UVp4mkfoWE=;
  b=A0wGIOnq0ydzsrWDBRlaFB5NPQR3q2WojLbHqReGvRanBYIZdu4VppPU
   wi3jQ5Zhg8DdJLTlVtISAzSxqvWsMmwhbDkhk354Gz0aTevyrjRu2KNf6
   2dxfz3QaO88sx7WLlkVISIBdN3Cqo+o6qF4XNRR753hLyvKURp7zVqpxU
   c=;
IronPort-SDR: WWOuSsbCzQsAsTwmiQW5IQY5gg45/0r6yBSltupOCgJaPa5P85qzAkkAeK5mgT2E7hELLdE8o4
 scVo+4P4NYOw==
X-IronPort-AV: E=Sophos;i="5.69,299,1571702400"; 
   d="scan'208";a="7827202"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 10 Dec 2019 11:34:09 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 57613A1F2B;
        Tue, 10 Dec 2019 11:34:07 +0000 (UTC)
Received: from EX13D32EUC004.ant.amazon.com (10.43.164.121) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:06 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13D32EUC004.ant.amazon.com (10.43.164.121) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 10 Dec 2019 11:34:05 +0000
Received: from u2f063a87eabd5f.cbg10.amazon.com (10.125.106.135) by
 mail-relay.amazon.com (10.43.62.226) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 10 Dec 2019 11:34:04 +0000
From:   Paul Durrant <pdurrant@amazon.com>
To:     <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>
CC:     Paul Durrant <pdurrant@amazon.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Juergen Gross <jgross@suse.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>
Subject: [PATCH v2 0/4] xen-blkback: support live update
Date:   Tue, 10 Dec 2019 11:33:43 +0000
Message-ID: <20191210113347.3404-1-pdurrant@amazon.com>
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
  xen/interface: re-define FRONT/BACK_RING_ATTACH()
  xen-blkback: support dynamic unbind/bind

 drivers/block/xen-blkback/xenbus.c         | 59 +++++++++++++++-------
 drivers/xen/xenbus/xenbus.h                |  2 -
 drivers/xen/xenbus/xenbus_probe.c          | 35 ++++---------
 drivers/xen/xenbus/xenbus_probe_backend.c  |  1 -
 drivers/xen/xenbus/xenbus_probe_frontend.c | 24 ++++++++-
 include/xen/interface/io/ring.h            | 29 ++++-------
 include/xen/xenbus.h                       |  1 +
 7 files changed, 84 insertions(+), 67 deletions(-)
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Juergen Gross <jgross@suse.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
-- 
2.20.1

