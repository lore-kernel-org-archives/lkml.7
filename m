Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE046C43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84DCE208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142127;
	bh=WpEQZ96HSyMvJyMLElFdXV/w39V1EhtGl8Y9d68T/ME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jPnLYsnbPgiiEN3W3cM4XH/AkMtIJkJIf76l7twWP5JsL2Jhg4N8dqbOOkMDiOPHl
	 8p5aa8mG0x0qB1H19XPNbOZKAcbtgYFQEioyfvCVjO8hvfETCaQz24SxYfHtBNx9nE
	 Kp8co6pyEG8B7iJQCchJWznT09L810vd3v5l5wLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730602AbfKSFmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:42:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728932AbfKSFmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:42:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B1E0208C3;
        Tue, 19 Nov 2019 05:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142123;
        bh=WpEQZ96HSyMvJyMLElFdXV/w39V1EhtGl8Y9d68T/ME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RCqy/ximoocHMY7P1mgNNvdEyc2H267orq2PVH9yAdoGD5Vfslyi+WbGXIzM+S7c4
         efTWDyk/raPqqGhMOlZjqycggCIv8kXLJlTRNl7Rjp5zD4PE5FGM8/JVyjaMWYquRQ
         gqawAA2jpQr/BpR0wXifqK8/bZyFxJQy+Aca3FTg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 394/422] iwlwifi: api: annotate compressed BA notif array sizes
Date:   Tue, 19 Nov 2019 06:19:51 +0100
Message-Id: <20191119051424.660464776@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 6f68cc367ab6578a33cca21b6056804165621f00 ]

Annotate the compressed BA notification array sizes and
make both of them 0-length since the length of 1 is just
confusing - it may be different than that and the offset
to the second one needs to be calculated in the C code
anyhow.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/fw/api/tx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
index 514b86123d3d3..80853f6cbd6d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/tx.h
@@ -747,9 +747,9 @@ enum iwl_mvm_ba_resp_flags {
  * @tfd_cnt: number of TFD-Q elements
  * @ra_tid_cnt: number of RATID-Q elements
  * @tfd: array of TFD queue status updates. See &iwl_mvm_compressed_ba_tfd
- *	for details.
+ *	for details. Length in @tfd_cnt.
  * @ra_tid: array of RA-TID queue status updates. For debug purposes only. See
- *	&iwl_mvm_compressed_ba_ratid for more details.
+ *	&iwl_mvm_compressed_ba_ratid for more details. Length in @ra_tid_cnt.
  */
 struct iwl_mvm_compressed_ba_notif {
 	__le32 flags;
@@ -766,7 +766,7 @@ struct iwl_mvm_compressed_ba_notif {
 	__le32 tx_rate;
 	__le16 tfd_cnt;
 	__le16 ra_tid_cnt;
-	struct iwl_mvm_compressed_ba_tfd tfd[1];
+	struct iwl_mvm_compressed_ba_tfd tfd[0];
 	struct iwl_mvm_compressed_ba_ratid ra_tid[0];
 } __packed; /* COMPRESSED_BA_RES_API_S_VER_4 */
 
-- 
2.20.1



