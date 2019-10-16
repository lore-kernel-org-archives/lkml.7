Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E154ECE59D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B0202067D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388939AbfJPARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 20:17:22 -0400
Received: from mga12.intel.com ([192.55.52.136]:50706 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388379AbfJPARV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 20:17:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Oct 2019 17:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,301,1566889200"; 
   d="scan'208";a="189517714"
Received: from ipsg-l-lixuzha.sh.intel.com ([10.239.153.12])
  by orsmga008.jf.intel.com with ESMTP; 15 Oct 2019 17:17:19 -0700
From:   Zhang Lixu <lixu.zhang@intel.com>
To:     jikos@kernel.org, linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com,
        benjamin.tissoires@redhat.com, Zhang Lixu <lixu.zhang@intel.com>
Subject: [PATCH] hid: intel-ish-hid: fix wrong error handling in ishtp_cl_alloc_tx_ring()
Date:   Wed, 16 Oct 2019 08:15:59 +0800
Message-Id: <20191016001559.27947-1-lixu.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating tx ring buffers failed, should free tx buffers, not rx buffers.

Signed-off-by: Zhang Lixu <lixu.zhang@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/hid/intel-ish-hid/ishtp/client-buffers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
index 1b0a0cc605e7..513d7a4a1b8a 100644
--- a/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
+++ b/drivers/hid/intel-ish-hid/ishtp/client-buffers.c
@@ -84,7 +84,7 @@ int ishtp_cl_alloc_tx_ring(struct ishtp_cl *cl)
 	return	0;
 out:
 	dev_err(&cl->device->dev, "error in allocating Tx pool\n");
-	ishtp_cl_free_rx_ring(cl);
+	ishtp_cl_free_tx_ring(cl);
 	return	-ENOMEM;
 }
 
-- 
2.17.1

