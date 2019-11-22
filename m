Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D008FC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92AF02068E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402913;
	bh=Blf/Jr/CgoOus8tGQdPdkyE7gdy3r35yHYj1VNTpXjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Hc8vgkPBJC9qfQBF5UoGzX60gJcG3zRbkuAfDtG6npBLfFb5xFd0xspwQiILm3YmV
	 c7REx4tLiaudJzw7XuzpnXvGMfbm3ModH7369ucMFG0JrnIrkpTWMcRVBPdPN0arUd
	 jiy5Nd9LN+8NgDsYt8ht8WuSyQP6F/TjU4ZAsIIY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbfKVGIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:08:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:39970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfKVGBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:01:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1F22070B;
        Fri, 22 Nov 2019 06:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574402502;
        bh=Blf/Jr/CgoOus8tGQdPdkyE7gdy3r35yHYj1VNTpXjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HmphHVUMTTDWvr4OzDineQYKHhmDe3j3hRfHG13pCb6LYkJfPrXB5Aat85axLsS/Q
         Dh9sLqAcixkybNfnPwK6gkE+xJPLN3O8MJ7YRQmrdC29VnDw0L79nQJp9jQXKu/mq9
         Ch1dntUdxoib/CBM+QBGyjdzs88b+uMxNMXhHCGs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>, Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 12/91] mwifiex: fix potential NULL dereference and use after free
Date:   Fri, 22 Nov 2019 01:00:10 -0500
Message-Id: <20191122060129.4239-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122060129.4239-1-sashal@kernel.org>
References: <20191122060129.4239-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 1dcd9429212b98bea87fc6ec92fb50bf5953eb47 ]

There are two defects: (1) passing a NULL bss to
mwifiex_save_hidden_ssid_channels will result in NULL dereference,
(2) using bss after dropping the reference to it via cfg80211_put_bss.
To fix them, the patch moves the buggy code to the branch that bss is
not NULL and puts it before cfg80211_put_bss.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/scan.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 7e96b6a37946a..828c6f5eb83c8 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -1890,15 +1890,17 @@ mwifiex_parse_single_response_buf(struct mwifiex_private *priv, u8 **bss_info,
 					    ETH_ALEN))
 					mwifiex_update_curr_bss_params(priv,
 								       bss);
-				cfg80211_put_bss(priv->wdev.wiphy, bss);
-			}
 
-			if ((chan->flags & IEEE80211_CHAN_RADAR) ||
-			    (chan->flags & IEEE80211_CHAN_NO_IR)) {
-				mwifiex_dbg(adapter, INFO,
-					    "radar or passive channel %d\n",
-					    channel);
-				mwifiex_save_hidden_ssid_channels(priv, bss);
+				if ((chan->flags & IEEE80211_CHAN_RADAR) ||
+				    (chan->flags & IEEE80211_CHAN_NO_IR)) {
+					mwifiex_dbg(adapter, INFO,
+						    "radar or passive channel %d\n",
+						    channel);
+					mwifiex_save_hidden_ssid_channels(priv,
+									  bss);
+				}
+
+				cfg80211_put_bss(priv->wdev.wiphy, bss);
 			}
 		}
 	} else {
-- 
2.20.1

