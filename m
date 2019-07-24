Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0C4C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F146C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563999216;
	bh=oMhK2svDNQZluWMPovVKARVEW6yfUn3Wpof1lc/Qgvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O1debaAJxPbLwNmutCvOEUjTQs+BuvvKV9/pRHA7iC/ZtzZrWfxtQ6SARZsaPa1E0
	 nZT9p38lBWfAzCClFPaft+vAOv8QrdnSgr6EcL0sJihE8QUviBDg8NjfKlUwN84QiV
	 CytsDmuyyySP9mC/Dnib7ch2o4ztJsTHPSE0LTS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404580AbfGXT4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391831AbfGXT4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:56:15 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1376C205C9;
        Wed, 24 Jul 2019 19:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563998174;
        bh=oMhK2svDNQZluWMPovVKARVEW6yfUn3Wpof1lc/Qgvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vkvOGZQH0Bviy9Z0a2lbo+xfs9D8IBuy8w7bIAP3bbGFd/JvlIuRSY1GRLLlhZNib
         Ro2tONa1Z0op2ctzYwgOiRFXwXmD+a8CWGmuktkX7c02zt7E/vSIjT2r9r2fwYub3w
         ozH+wuXrrBd7Wqgktezx3cmZ9W9curVoaIL1GcUw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 5.1 272/371] iwlwifi: dont WARN when calling iwl_get_shared_mem_conf with RF-Kill
Date:   Wed, 24 Jul 2019 21:20:24 +0200
Message-Id: <20190724191744.800167597@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191724.382593077@linuxfoundation.org>
References: <20190724191724.382593077@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

commit 0d53cfd0cca3c729a089c39eef0e7d8ae7662974 upstream.

iwl_mvm_send_cmd returns 0 when the command won't be sent
because RF-Kill is asserted. Do the same when we call
iwl_get_shared_mem_conf since it is not sent through
iwl_mvm_send_cmd but directly calls the transport layer.

Cc: stable@vger.kernel.org
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/fw/smem.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -8,7 +8,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of version 2 of the GNU General Public License as
@@ -31,7 +31,7 @@
  * Copyright(c) 2012 - 2014 Intel Corporation. All rights reserved.
  * Copyright(c) 2013 - 2015 Intel Mobile Communications GmbH
  * Copyright(c) 2016 - 2017 Intel Deutschland GmbH
- * Copyright(c) 2018 Intel Corporation
+ * Copyright(c) 2018 - 2019 Intel Corporation
  * All rights reserved.
  *
  * Redistribution and use in source and binary forms, with or without
@@ -134,6 +134,7 @@ void iwl_get_shared_mem_conf(struct iwl_
 		.len = { 0, },
 	};
 	struct iwl_rx_packet *pkt;
+	int ret;
 
 	if (fw_has_capa(&fwrt->fw->ucode_capa,
 			IWL_UCODE_TLV_CAPA_EXTEND_SHARED_MEM_CFG))
@@ -141,8 +142,13 @@ void iwl_get_shared_mem_conf(struct iwl_
 	else
 		cmd.id = SHARED_MEM_CFG;
 
-	if (WARN_ON(iwl_trans_send_cmd(fwrt->trans, &cmd)))
+	ret = iwl_trans_send_cmd(fwrt->trans, &cmd);
+
+	if (ret) {
+		WARN(ret != -ERFKILL,
+		     "Could not send the SMEM command: %d\n", ret);
 		return;
+	}
 
 	pkt = cmd.resp_pkt;
 	if (fwrt->trans->cfg->device_family >= IWL_DEVICE_FAMILY_22000)


