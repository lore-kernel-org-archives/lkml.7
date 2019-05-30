Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42C5C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F043252EA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191656;
	bh=9XcAquDnq3A8qk+QB5ZE/rDQDS1uopKAjm8S9gv+JfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XgJQ2hOGfNcQBpobGvk73VXUsmirrgdWZ7sutzuYyAcZXIIavoL+NLwWqXZ45O2rr
	 +LyVWEQyNoyPEBcESVg1M6dkSL3nLqKPdz6f76QzFuLpV4/75zb7xntmUBFJHyYfK3
	 ja0tUM29GQzHYFkNczBbofye3WUmrJUztNZ5ws2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389008AbfE3Erf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:47:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:51140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbfE3DL3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:29 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EDD6244A6;
        Thu, 30 May 2019 03:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185888;
        bh=9XcAquDnq3A8qk+QB5ZE/rDQDS1uopKAjm8S9gv+JfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiGTy+PcV1/UHRDp1XoPSfxtRHTH9nVPg6GAceGuhWOZhW4NC7dynZk3B51FkJ84w
         aF2d1w6FEO9sMClqaNQvufESS9nA/Dcwz1t9HXhEVoWyRNNosnTgcCwODp4nh1CCJp
         9mjfkrdAzMXfabCoxuzWFXA2njldUOwsej1Ev8Ng=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 248/405] mwifiex: Fix mem leak in mwifiex_tm_cmd
Date:   Wed, 29 May 2019 20:04:06 -0700
Message-Id: <20190530030553.542230260@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 003b686ace820ce2d635a83f10f2d7f9c147dabc ]

'hostcmd' is alloced by kzalloc, should be freed before
leaving from the error handling cases, otherwise it will
cause mem leak.

Fixes: 3935ccc14d2c ("mwifiex: add cfg80211 testmode support")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cfg80211.c b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
index c46f0a54a0c76..e582d9b3e50c2 100644
--- a/drivers/net/wireless/marvell/mwifiex/cfg80211.c
+++ b/drivers/net/wireless/marvell/mwifiex/cfg80211.c
@@ -4082,16 +4082,20 @@ static int mwifiex_tm_cmd(struct wiphy *wiphy, struct wireless_dev *wdev,
 
 		if (mwifiex_send_cmd(priv, 0, 0, 0, hostcmd, true)) {
 			dev_err(priv->adapter->dev, "Failed to process hostcmd\n");
+			kfree(hostcmd);
 			return -EFAULT;
 		}
 
 		/* process hostcmd response*/
 		skb = cfg80211_testmode_alloc_reply_skb(wiphy, hostcmd->len);
-		if (!skb)
+		if (!skb) {
+			kfree(hostcmd);
 			return -ENOMEM;
+		}
 		err = nla_put(skb, MWIFIEX_TM_ATTR_DATA,
 			      hostcmd->len, hostcmd->cmd);
 		if (err) {
+			kfree(hostcmd);
 			kfree_skb(skb);
 			return -EMSGSIZE;
 		}
-- 
2.20.1



