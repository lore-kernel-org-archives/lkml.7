Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3009CC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE1E217D7
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428499;
	bh=BSZPvpOMtHf9X+S8zBNMYSxLNZ1dYPWKShwaiIJ/B50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a7B28J0rxjIW1DWWNQQsBsdD7KnYfFq4K+chClbhyQ4597/PoW6ACZwP26sR8N3Ki
	 CWb94h/8PYOwDro/sDYVFWVsbPlNU/AtOFDwC5g+oCWBhjT8EZDx6IMwdJy7bwzHjh
	 V+aJj4QyuqpnIzCnEGYBku/hZrBFAZx/Y46/LyU0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387685AbfG2T2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:28:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbfG2T2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:28:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4E621773;
        Mon, 29 Jul 2019 19:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428491;
        bh=BSZPvpOMtHf9X+S8zBNMYSxLNZ1dYPWKShwaiIJ/B50=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JDYpuB5mHzPOIBzFliGI2g7FGkYgpYmNH/HcP5d+MGdZ2kezEiByDpMgPlYRBAA/D
         RV0YFxVyTUPDQ08vP0LNQdBXJQO8cQ271qJWcycgoUtOhYEj41UHfyRvpykitzExo1
         oEUyNHk6LOvJNHjfQhj5uYHjdmWop/jtXEgHhaj8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 092/293] iwlwifi: mvm: Drop large non sta frames
Date:   Mon, 29 Jul 2019 21:19:43 +0200
Message-Id: <20190729190831.657269062@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ac70499ee97231a418dc1a4d6c9dc102e8f64631 ]

In some buggy scenarios we could possible attempt to transmit frames larger
than maximum MSDU size. Since our devices don't know how to handle this,
it may result in asserts, hangs etc.
This can happen, for example, when we receive a large multicast frame
and try to transmit it back to the air in AP mode.
Since in a legal scenario this should never happen, drop such frames and
warn about it.

Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 62a6e293cf12..f0f2be432d20 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -621,6 +621,9 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 
 	memcpy(&info, skb->cb, sizeof(info));
 
+	if (WARN_ON_ONCE(skb->len > IEEE80211_MAX_DATA_LEN + hdrlen))
+		return -1;
+
 	if (WARN_ON_ONCE(info.flags & IEEE80211_TX_CTL_AMPDU))
 		return -1;
 
-- 
2.20.1



