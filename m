Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF96C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BA8D21741
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554368731;
	bh=UfSem3mEsrv95V7lNAwIlwoaz7Ht05Zmnhkeolw+bgQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w58L/MTQxTboQ0TU7mxTmEyzZ7B4CmgGkRfR6o5DonKYC0VtNns+7nX4KmpxaP76U
	 uooPCAt97/LarPzH4DSHF48Teapa0vWTr75+JUn04LUybjrRs3I2d99j4eCqLcfoA2
	 aBwwYJi7bgxzpwuDLmQIKDAy1xPV+YuDEoHFIxog=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731467AbfDDJF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:05:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732129AbfDDJFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:05:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 668352147C;
        Thu,  4 Apr 2019 09:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554368724;
        bh=UfSem3mEsrv95V7lNAwIlwoaz7Ht05Zmnhkeolw+bgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PZJKNnsIQcGhTkzIWuYpkDqzW5OhjappZpAkKBR9HWAsWRZGDGwo3n41bRih7i30Y
         pd8EpWTLOJNUbcJVkdONGrJUSREXaEiIikHis5hjbzSmPDKSTv1QWZt4OEOxU4h9H8
         E3BPoj7m5KamEKwtOTVbBFLdCUDVyzqweNnOU120=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 130/187] iwlwifi: mvm: fix RFH config command with >=10 CPUs
Date:   Thu,  4 Apr 2019 10:47:47 +0200
Message-Id: <20190404084609.332234205@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084603.119654039@linuxfoundation.org>
References: <20190404084603.119654039@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit dbf592f3d14fb7d532cb7c820b1065cf33e02aaa ]

If we have >=10 (logical) CPUs, our command size exceeds the
internal buffer size and the command fails; fix that by using
IWL_HCMD_DFL_NOCOPY for the command that's allocated anyway.

While at it, also fix the leak of cmd, and use struct_size()
to calculate its size.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Fixes: 8edbfaa19835 ("iwlwifi: mvm: configure multi RX queue")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 16c6c7f921a8..8b7d70e3a379 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -132,13 +132,17 @@ static int iwl_send_rss_cfg_cmd(struct iwl_mvm *mvm)
 
 static int iwl_configure_rxq(struct iwl_mvm *mvm)
 {
-	int i, num_queues, size;
+	int i, num_queues, size, ret;
 	struct iwl_rfh_queue_config *cmd;
+	struct iwl_host_cmd hcmd = {
+		.id = WIDE_ID(DATA_PATH_GROUP, RFH_QUEUE_CONFIG_CMD),
+		.dataflags[0] = IWL_HCMD_DFL_NOCOPY,
+	};
 
 	/* Do not configure default queue, it is configured via context info */
 	num_queues = mvm->trans->num_rx_queues - 1;
 
-	size = sizeof(*cmd) + num_queues * sizeof(struct iwl_rfh_queue_data);
+	size = struct_size(cmd, data, num_queues);
 
 	cmd = kzalloc(size, GFP_KERNEL);
 	if (!cmd)
@@ -159,10 +163,14 @@ static int iwl_configure_rxq(struct iwl_mvm *mvm)
 		cmd->data[i].fr_bd_wid = cpu_to_le32(data.fr_bd_wid);
 	}
 
-	return iwl_mvm_send_cmd_pdu(mvm,
-				    WIDE_ID(DATA_PATH_GROUP,
-					    RFH_QUEUE_CONFIG_CMD),
-				    0, size, cmd);
+	hcmd.data[0] = cmd;
+	hcmd.len[0] = size;
+
+	ret = iwl_mvm_send_cmd(mvm, &hcmd);
+
+	kfree(cmd);
+
+	return ret;
 }
 
 static int iwl_mvm_send_dqa_cmd(struct iwl_mvm *mvm)
-- 
2.19.1



