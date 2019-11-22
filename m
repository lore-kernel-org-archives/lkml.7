Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBA5C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ED922071F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574419215;
	bh=lZXxMuWIybLFtXGs8v1ZWRWHg9eTWJ+Zb4KyQrFSfR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcgpKEAdgtDoImVDAosJtUE7sRK37COmzZ+T5uuqzRfCEOtXVO+Rr1PqBSswuOP/V
	 CO77PiabUcIU/9fu17jvusFcXOnTO95UV+7hYk2/kdjODr03HiLmKHbmem3w+NXdic
	 QE668XNxs8/3ziqUuK5kqlNUXHXEaHx5TEIB2PoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbfKVKkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbfKVKkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:40:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2CE62075B;
        Fri, 22 Nov 2019 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574419203;
        bh=lZXxMuWIybLFtXGs8v1ZWRWHg9eTWJ+Zb4KyQrFSfR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i/CiCn+Qz2PTm9nUT9w6VBzQogCAoqgberlFv+8b6ZrMoJzg2TYCMu0InP3oP06cr
         kNpgsVzhsrkTRnuQi6AAW66rqGzfW+LKZfwSeepJuCjaXu0fpY80JU6UL2cadEHetT
         U4gre8Jdx1lLap+bQglOdX521G9srkpnXLJA4GIw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sara Sharon <sara.sharon@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 033/222] iwlwifi: mvm: avoid sending too many BARs
Date:   Fri, 22 Nov 2019 11:26:13 +0100
Message-Id: <20191122100843.751274099@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100830.874290814@linuxfoundation.org>
References: <20191122100830.874290814@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sara Sharon <sara.sharon@intel.com>

[ Upstream commit 1a19c139be18ed4d6d681049cc48586fae070120 ]

When we receive TX response, we may release a few packets
due to a hole that was closed in the transmission window.

However, if that frame failed, we will mark all the released
frames as failed and will send multiple BARs.

This affects statistics badly, and cause unnecessary frames
transmission.

Instead, mark all the following packets as success, with the
desired result of sending a bar for the failed frame only.

Signed-off-by: Sara Sharon <sara.sharon@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 1aa74b87599ff..63dcea640d076 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1303,6 +1303,14 @@ static void iwl_mvm_rx_tx_cmd_single(struct iwl_mvm *mvm,
 			break;
 		}
 
+		/*
+		 * If we are freeing multiple frames, mark all the frames
+		 * but the first one as acked, since they were acknowledged
+		 * before
+		 * */
+		if (skb_freed > 1)
+			info->flags |= IEEE80211_TX_STAT_ACK;
+
 		iwl_mvm_tx_status_check_trigger(mvm, status);
 
 		info->status.rates[0].count = tx_resp->failure_frame + 1;
-- 
2.20.1



