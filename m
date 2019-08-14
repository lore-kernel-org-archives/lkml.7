Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F58C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03B722084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565802902;
	bh=la4iSv3YeUpXSyUkxOHZhCwwypU2UNbLwGV1nwUKWpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QjfIitebAusQ/ljqXskP8ShmKQwBDrjQDhelS2gJivws04tHZ6EndHvrxUqZukDiC
	 fGdVg1F6HVBxD9HjqvSWpFd2lI/7CYUxPOeide9bAz0wHCbvNLOL4m/GzuNnSsbivM
	 SBO6Extl2F+S4e/rKntE0BK+Pt588Gg6GqFPK3RI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731167AbfHNRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730713AbfHNRO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:14:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8679E2063F;
        Wed, 14 Aug 2019 17:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565802897;
        bh=la4iSv3YeUpXSyUkxOHZhCwwypU2UNbLwGV1nwUKWpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fvipxmGrVMmbtk/qncG2knNPUcTaoKMIcT9VGKWEVGNfTXIYKgl1qXmebTWBeO1jf
         xonpES4erqwYzyWb2sXodTxkMOi4qlEX6nzr3hZ9fE4dl//0RuuVbSsC5In5a9FWQU
         VaG3Ennrucj75zLfAhrOfCnKWfn/vmtpaikU2ZEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Luca Coelho <luciano.coelho@intel.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 68/69] iwlwifi: mvm: dont send GEO_TX_POWER_LIMIT on version < 41
Date:   Wed, 14 Aug 2019 19:02:06 +0200
Message-Id: <20190814165750.532697491@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190814165744.822314328@linuxfoundation.org>
References: <20190814165744.822314328@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

commit 39bd984c203e86f3109b49c2a2e20677c4d3ab65 upstream.

Firmware versions before 41 don't support the GEO_TX_POWER_LIMIT
command, and sending it to the firmware will cause a firmware crash.
We allow this via debugfs, so we need to return an error value in case
it's not supported.

This had already been fixed during init, when we send the command if
the ACPI WGDS table is present.  Fix it also for the other,
userspace-triggered case.

Cc: stable@vger.kernel.org
Fixes: 7fe90e0e3d60 ("iwlwifi: mvm: refactor geo init")
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -912,6 +912,17 @@ int iwl_mvm_sar_select_profile(struct iw
 	return iwl_mvm_send_cmd_pdu(mvm, REDUCE_TX_POWER_CMD, 0, len, &cmd);
 }
 
+static bool iwl_mvm_sar_geo_support(struct iwl_mvm *mvm)
+{
+	/*
+	 * The GEO_TX_POWER_LIMIT command is not supported on earlier
+	 * firmware versions.  Unfortunately, we don't have a TLV API
+	 * flag to rely on, so rely on the major version which is in
+	 * the first byte of ucode_ver.
+	 */
+	return IWL_UCODE_SERIAL(mvm->fw->ucode_ver) >= 41;
+}
+
 int iwl_mvm_get_sar_geo_profile(struct iwl_mvm *mvm)
 {
 	struct iwl_geo_tx_power_profiles_resp *resp;
@@ -927,6 +938,9 @@ int iwl_mvm_get_sar_geo_profile(struct i
 		.data = { &geo_cmd },
 	};
 
+	if (!iwl_mvm_sar_geo_support(mvm))
+		return -EOPNOTSUPP;
+
 	ret = iwl_mvm_send_cmd(mvm, &cmd);
 	if (ret) {
 		IWL_ERR(mvm, "Failed to get geographic profile info %d\n", ret);
@@ -952,13 +966,7 @@ static int iwl_mvm_sar_geo_init(struct i
 	int ret, i, j;
 	u16 cmd_wide_id =  WIDE_ID(PHY_OPS_GROUP, GEO_TX_POWER_LIMIT);
 
-	/*
-	 * This command is not supported on earlier firmware versions.
-	 * Unfortunately, we don't have a TLV API flag to rely on, so
-	 * rely on the major version which is in the first byte of
-	 * ucode_ver.
-	 */
-	if (IWL_UCODE_SERIAL(mvm->fw->ucode_ver) < 41)
+	if (!iwl_mvm_sar_geo_support(mvm))
 		return 0;
 
 	ret = iwl_mvm_sar_get_wgds_table(mvm);


