Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F09C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284B52075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142372;
	bh=kbSPGq080Nn0FUfGmRqHlogt7rWfHK73COfGgh2PqDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=apeniK63LRQH+eMWrnjcIhp6kZE3PTANrWMI9lKbno8kByXPVEgVYCOyGl3j2ieYg
	 TdRgtyAKhnkeJxQXC0zy/LQb89kNAmTATNCPdIXTkEEKXItvPlpv5xtweuHPOnYDx9
	 11nViU7DO2gtGp3JbGzCkXtmBu1xCiMwCSfAWNHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbfKSFqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:46:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbfKSFp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:45:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D016C2075E;
        Tue, 19 Nov 2019 05:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142358;
        bh=kbSPGq080Nn0FUfGmRqHlogt7rWfHK73COfGgh2PqDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dCoewIKDaBWxfDeQJ3T2wtzf27ZKd2Ww4Dy24ECxMkB42UqhJCtuyRq197Lf4JosB
         ULTgHH29WTXH0JV6dzsX0TGsHUC3jephSCrP1W+HGKzBfPhGwQQtqcWnxWOJW6O6WL
         gRnHCa4gzBeA2zuHtgP5toDo0mOmAmj0pwEFX/5E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 055/239] iwlwifi: dont WARN on trying to dump dead firmware
Date:   Tue, 19 Nov 2019 06:17:35 +0100
Message-Id: <20191119051308.365808462@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051255.850204959@linuxfoundation.org>
References: <20191119051255.850204959@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 84f260251ed8153e84c64eb2c5278ab18d3ddef6 ]

There's no point in warning here, the user will just get an
error back to the debugfs file write, and warning just makes
it seem like there's an internal consistency problem when in
reality the user just happened to hit this at a bad time.
Remove the warning.

Fixes: f45f979dc208 ("iwlwifi: mvm: disable dbg data collect when fw isn't alive")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
index 8390104172410..e72c0b825420c 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/dbg.c
@@ -954,7 +954,7 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	 * If the loading of the FW completed successfully, the next step is to
 	 * get the SMEM config data. Thus, if fwrt->smem_cfg.num_lmacs is non
 	 * zero, the FW was already loaded successully. If the state is "NO_FW"
-	 * in such a case - WARN and exit, since FW may be dead. Otherwise, we
+	 * in such a case - exit, since FW may be dead. Otherwise, we
 	 * can try to collect the data, since FW might just not be fully
 	 * loaded (no "ALIVE" yet), and the debug data is accessible.
 	 *
@@ -962,9 +962,8 @@ int iwl_fw_dbg_collect_desc(struct iwl_fw_runtime *fwrt,
 	 *	config. In such a case, due to HW access problems, we might
 	 *	collect garbage.
 	 */
-	if (WARN((fwrt->trans->state == IWL_TRANS_NO_FW) &&
-		 fwrt->smem_cfg.num_lmacs,
-		 "Can't collect dbg data when FW isn't alive\n"))
+	if (fwrt->trans->state == IWL_TRANS_NO_FW &&
+	    fwrt->smem_cfg.num_lmacs)
 		return -EIO;
 
 	if (test_and_set_bit(IWL_FWRT_STATUS_DUMPING, &fwrt->status))
-- 
2.20.1



