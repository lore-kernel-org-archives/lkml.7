Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288BFC48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F32A7217F9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561595469;
	bh=hfofzkUcH0VTTJYIQDvXderaZwVE2BnV09M1bS/FYS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U0DEj/H/16OMfbYQYXWr2CM823Lh2AdqosihVEnxS9v0hfwNLZ4nXFdgi/C4ZHOoP
	 CT0XMMtMMps4kHRBpPS80Ky4+gV/6xhsaTXN04XhujVQ0xRo1QV76kD3STkuEGKByr
	 vsRyzMNTDx6Px8RMSlis/uj0XMNBlkQJhC52xzkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfF0AbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 20:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:34330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbfF0AbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 20:31:05 -0400
Received: from sasha-vm.mshome.net (unknown [107.242.116.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7B5E217D9;
        Thu, 27 Jun 2019 00:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561595464;
        bh=hfofzkUcH0VTTJYIQDvXderaZwVE2BnV09M1bS/FYS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gozPo01/wCrvdsuKd+X/WmTVUjM5/rzCJxAg96WdfvJ3nLclRV1ASgx9vbYo1da6h
         1iIpGcXvkPIGVRdVVslD/ROuQ2A6K7k433dm91uwi60T00pVT+eKaGTFbZXDJHjazt
         e8wK9+sbTJeSWB4aCCY5eUKBA7gb59DcZhXay3KI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Shashidhar Lakkavalli <slakkavalli@datto.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.1 13/95] mac80211: fix rate reporting inside cfg80211_calculate_bitrate_he()
Date:   Wed, 26 Jun 2019 20:28:58 -0400
Message-Id: <20190627003021.19867-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627003021.19867-1-sashal@kernel.org>
References: <20190627003021.19867-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Crispin <john@phrozen.org>

[ Upstream commit 25d16d124a5e249e947c0487678b61dcff25cf8b ]

The reported rate is not scaled down correctly. After applying this patch,
the function will behave just like the v/ht equivalents.

Signed-off-by: Shashidhar Lakkavalli <slakkavalli@datto.com>
Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 75899b62bdc9..5a03f38788e7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1237,7 +1237,7 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	if (rate->he_dcm)
 		result /= 2;
 
-	return result;
+	return result / 10000;
 }
 
 u32 cfg80211_calculate_bitrate(struct rate_info *rate)
-- 
2.20.1

