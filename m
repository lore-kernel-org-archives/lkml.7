Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99DE9C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C16B2190B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962495;
	bh=X539h0fWRxw9J8h/sKEh6813gk6mX/7igaUTTezWcPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x44GlmnLIDcn83E66lbON1FFC0Ih+hM8kpiLDAHamGndUlFjH5/XOla0TMNNLOnOb
	 E9dPAkiu3siOE0a0vYsQEznTPEC9T60fW6zG4GoJenhiGSV7Rk0lFV4WWAAjkMD5gp
	 7CVM+35/ZicqLbuo3udxVGHiWzHtbDp/3STIZ/4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfDVTsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:48:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbfDVTsM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C208321917;
        Mon, 22 Apr 2019 19:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962491;
        bh=X539h0fWRxw9J8h/sKEh6813gk6mX/7igaUTTezWcPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gZMTq92DNfhkTC1dqGDD0m2YanZ7B4cwxiu2LgdemmQLgIQnV1czrwNrHfLzjZZCb
         /dcQ+qXu5CND4AOKiyEN/kFUsT4zsaG1zxhPo0/S8uhYgtHEerDep3liyQJjz63KKw
         yoVaeaGXJ2VciqUreec/HLJgr/LtVBxxhaBa9LlA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 19/43] staging: rtlwifi: rtl8822b: fix to avoid potential NULL pointer dereference
Date:   Mon, 22 Apr 2019 15:47:03 -0400
Message-Id: <20190422194727.12495-19-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit d70d70aec9632679dd00dcc1b1e8b2517e2c7da0 ]

skb allocated via dev_alloc_skb can fail and return a NULL pointer.
This patch avoids such a scenario and returns, consistent with other
invocations.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwifi/rtl8822be/fw.c
index acabb2470d55..02ca3157c5a5 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -752,6 +752,8 @@ void rtl8822be_set_fw_rsvdpagepkt(struct ieee80211_hw *hw, bool b_dl_finished)
 		      u1_rsvd_page_loc, 3);
 
 	skb = dev_alloc_skb(totalpacketlen);
+	if (!skb)
+		return;
 	memcpy((u8 *)skb_put(skb, totalpacketlen), &reserved_page_packet,
 	       totalpacketlen);
 
-- 
2.19.1

