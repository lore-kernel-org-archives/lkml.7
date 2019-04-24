Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1ECC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92070218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556116453;
	bh=UmPRuZUOXkApAPBDtN5lVFzj99dOhP+6iVKI9fw6Vjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tqAW39VuP5AtAdPoD40GH2f9tTENzDr41ThLtsgYsy7qRRKml6oNcRTkeHOehu2vY
	 nIAYvlosMiUZiom0a8RUicce07TNeJ9LKH3h6kq1JRoBqT3i0IuLyIVjrSZnA3S2Qv
	 XAiu8Y11/Tln/zI/LjnjfCaebL3/xjcqllJouhSE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfDXOeM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 10:34:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730836AbfDXOeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 10:34:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31A542089F;
        Wed, 24 Apr 2019 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556116448;
        bh=UmPRuZUOXkApAPBDtN5lVFzj99dOhP+6iVKI9fw6Vjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYsvbWvToyPv5y7lIjqzcrpSGcNwud0pKT6Nk5YEONdm5Tgaib3xMGQRNcvVg9yrs
         1ZGgrINJOmkZlo5qtQIC4qKG4d2JjNGNKft87mYTTfsedIaTHaO9YWkR5oUjhCHv2Z
         u5Psv5XX13ngVxOs7/oG66/sXRbsta9KxlTOVRe0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 11/66] batman-adv: fix warning in function batadv_v_elp_get_throughput
Date:   Wed, 24 Apr 2019 10:32:45 -0400
Message-Id: <20190424143341.27665-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190424143341.27665-1-sashal@kernel.org>
References: <20190424143341.27665-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit ca8c3b922e7032aff6cc3fd05548f4df1f3df90e ]

When CONFIG_CFG80211 isn't enabled the compiler correcly warns about
'sinfo.pertid' may be unused. It can also happen for other error
conditions that it not warn about.

net/batman-adv/bat_v_elp.c: In function ‘batadv_v_elp_get_throughput.isra.0’:
include/net/cfg80211.h:6370:13: warning: ‘sinfo.pertid’ may be used
 uninitialized in this function [-Wmaybe-uninitialized]
  kfree(sinfo->pertid);
        ~~~~~^~~~~~~~

Rework so that we only release '&sinfo' if cfg80211_get_station returns
zero.

Fixes: 7d652669b61d ("batman-adv: release station info tidstats")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 net/batman-adv/bat_v_elp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/bat_v_elp.c b/net/batman-adv/bat_v_elp.c
index ef0dec20c7d8..5da183b2f4c9 100644
--- a/net/batman-adv/bat_v_elp.c
+++ b/net/batman-adv/bat_v_elp.c
@@ -104,8 +104,10 @@ static u32 batadv_v_elp_get_throughput(struct batadv_hardif_neigh_node *neigh)
 
 		ret = cfg80211_get_station(real_netdev, neigh->addr, &sinfo);
 
-		/* free the TID stats immediately */
-		cfg80211_sinfo_release_content(&sinfo);
+		if (!ret) {
+			/* free the TID stats immediately */
+			cfg80211_sinfo_release_content(&sinfo);
+		}
 
 		dev_put(real_netdev);
 		if (ret == -ENOENT) {
-- 
2.19.1

