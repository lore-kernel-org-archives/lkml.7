Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E43C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4957721783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142192;
	bh=Nie++jwXeETwcFQqwwHJgPZbDbLErfmYmKOCTZHw8QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wMZQmmP9BtblIcHdQNR0psKldJC3b5FOGEJ7AVq2XSXadBKqLv+8juGHoWBdNxGdp
	 NfhQVBK85g5DYM5CYk1zUGiNEFLbLBNxWXRdXd8mbEYrAdMCpHu5IL5sNxau01Gbrd
	 wKu4jsOmC7d0QhwL/eveWP6AkcoyX/XEYw4Rf8E0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbfKSFnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:37768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730684AbfKSFm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:42:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 072DC21783;
        Tue, 19 Nov 2019 05:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142176;
        bh=Nie++jwXeETwcFQqwwHJgPZbDbLErfmYmKOCTZHw8QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eK+NUhx0JeBjhMAa7PRxcBCcj7/FvTzy8wBP1HtdXOZpWJfD/Cy+JT7OcnlxeRStB
         i35ovO/v3qvbBdG91USHiRiA46QCRMq+ylOhpcLk7gILcAl7YBvOHRM5fqIbJdkRP+
         p03eG2otv3cSK2i4bHN+tEvbAi0Lhh8pYRXtWSa8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilan Peer <ilan.peer@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 398/422] iwlwifi: mvm: Allow TKIP for AP mode
Date:   Tue, 19 Nov 2019 06:19:55 +0100
Message-Id: <20191119051424.925088372@linuxfoundation.org>
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

From: Ilan Peer <ilan.peer@intel.com>

[ Upstream commit 6f3df8c1192c873a6ad9a76328920f6f85af90a8 ]

Support for setting keys for TKIP cipher suite was mistakenly removed
for AP mode. Fix this.

Fixes: 85aeb58cec1a ("iwlwifi: mvm: Enable security on new TX API")
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 18db1ed92d9b0..04ea516bddcc0 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -3133,10 +3133,6 @@ static int __iwl_mvm_set_sta_key(struct iwl_mvm *mvm,
 
 	switch (keyconf->cipher) {
 	case WLAN_CIPHER_SUITE_TKIP:
-		if (vif->type == NL80211_IFTYPE_AP) {
-			ret = -EINVAL;
-			break;
-		}
 		addr = iwl_mvm_get_mac_addr(mvm, vif, sta);
 		/* get phase 1 key from mac80211 */
 		ieee80211_get_key_rx_seq(keyconf, 0, &seq);
-- 
2.20.1



