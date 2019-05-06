Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 908F3C04AAD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A381205ED
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557155074;
	bh=J6O7YHknQMMh9GgrHKVn3dZ6xeVMLPiS7n/F1IMKFHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=czPJl2CEZPQd7y4iP1Xx1tT5gBmvH569op+KhIqMR02VRja0uAwVDSknRnIpcMARl
	 GTOGaBuVhhtpsP5E0XzQjGjuspX7KCH59p6vw8s+Tt9l/iBjpZGWoGJGg66dyzDvah
	 cCWhqfKPPu1eq4ZeiSh7w15EtxbIafPFtnKOqKyw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfEFOjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbfEFOjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:39:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64B9A21479;
        Mon,  6 May 2019 14:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153550;
        bh=J6O7YHknQMMh9GgrHKVn3dZ6xeVMLPiS7n/F1IMKFHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cq2tJRIJg4f1p3CWgVrUTw3Jb9UQ0sMhUNv5f0AXc3PrXI/uL226pVaz1h2aRffEy
         rF7XExxyTgpj0HrGwRgZssHxiNi752WN/p1JJiTqw8/e0A3boFVSKjW6Pi5idifbwP
         hUkPX8MVuGQoAu39KLtAAuSl0sXQPmrUdKMzRpug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 4.19 01/99] iwlwifi: fix driver operation for 5350
Date:   Mon,  6 May 2019 16:31:34 +0200
Message-Id: <20190506143054.025064509@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 5c9adef9789148d382d7d1307c3d6bfaf51d143d upstream.

We introduced a bug that prevented this old device from
working. The driver would simply not be able to complete
the INIT flow while spewing this warning:

 CSR addresses aren't configured
 WARNING: CPU: 0 PID: 819 at drivers/net/wireless/intel/iwlwifi/pcie/drv.c:917
 iwl_pci_probe+0x160/0x1e0 [iwlwifi]

Cc: stable@vger.kernel.org # v4.18+
Fixes: a8cbb46f831d ("iwlwifi: allow different csr flags for different device families")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Fixes: c8f1b51e506d ("iwlwifi: allow different csr flags for different device families")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
+++ b/drivers/net/wireless/intel/iwlwifi/cfg/5000.c
@@ -1,7 +1,7 @@
 /******************************************************************************
  *
  * Copyright(c) 2007 - 2014 Intel Corporation. All rights reserved.
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms of version 2 of the GNU General Public License as
@@ -140,6 +140,7 @@ const struct iwl_cfg iwl5350_agn_cfg = {
 	.ht_params = &iwl5000_ht_params,
 	.led_mode = IWL_LED_BLINK,
 	.internal_wimax_coex = true,
+	.csr = &iwl_csr_v1,
 };
 
 #define IWL_DEVICE_5150						\


