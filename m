Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C610C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CBA206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573610909;
	bh=LH61V/qzUmWOj7rI6InJebjBB7kMjoSX9nWyR9/yzfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2sZzuRpBb2EDuyVLVFr/yCK9rW+h32izw+7hTqDnki+M/lH/BAcYPxK39Qk/Bh4Rh
	 cDkmjl/VnxV1gQjVTD6DzLEDD0QrhmghDtMm6iAaElAQ22gg4I5j/yDOZImCMTkulY
	 dIt5cAJNdo7IVMMRR2nb0dPP2FXW4vrkjkaCrA2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbfKMCAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:00:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbfKMB7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:59:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC7222467;
        Wed, 13 Nov 2019 01:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573610392;
        bh=LH61V/qzUmWOj7rI6InJebjBB7kMjoSX9nWyR9/yzfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w4JdBIPtmwJjG+FaXexDGzF4MGcjbM6qqZBJrotcyeFQ6LP2VBQkgRXUGIFLSHn21
         5/JLuvp66nOWpxviEETqK3lQMiUun0dGVnAIFSkF6hbpZCBVQtK3HHtrFHPG3ZBHO3
         8aB1IlBHNredVZntwSUciBVPMBwaRJF5Qtib9z4s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andrew Zaborowski <andrew.zaborowski@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/68] nl80211: Fix a GET_KEY reply attribute
Date:   Tue, 12 Nov 2019 20:58:37 -0500
Message-Id: <20191113015932.12655-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015932.12655-1-sashal@kernel.org>
References: <20191113015932.12655-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Zaborowski <andrew.zaborowski@intel.com>

[ Upstream commit efdfce7270de85a8706d1ea051bef3a7486809ff ]

Use the NL80211_KEY_IDX attribute inside the NL80211_ATTR_KEY in
NL80211_CMD_GET_KEY responses to comply with nl80211_key_policy.
This is unlikely to affect existing userspace.

Signed-off-by: Andrew Zaborowski <andrew.zaborowski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/nl80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 060bc0cc82526..bb19be78aed70 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -3058,7 +3058,7 @@ static void get_key_callback(void *c, struct key_params *params)
 			 params->cipher)))
 		goto nla_put_failure;
 
-	if (nla_put_u8(cookie->msg, NL80211_ATTR_KEY_IDX, cookie->idx))
+	if (nla_put_u8(cookie->msg, NL80211_KEY_IDX, cookie->idx))
 		goto nla_put_failure;
 
 	nla_nest_end(cookie->msg, key);
-- 
2.20.1

