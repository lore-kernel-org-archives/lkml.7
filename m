Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6FBC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E587520823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551687809;
	bh=lWzv4KIiuO4JjQkk6CCDbC3KTRS6lfxJE/izDEKUkVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1eZgl1/ebwCTLYJNHqYBWzXP2hdk0PkhP7uQulRLRqjyGnFlraih+6EfqG6sbyfsg
	 tKs+noEHOr5OpFbhjN0EAkX3WonQu60MuDR8BCi9AZqWh1bzBle9XaHLyFhO9Lkzdz
	 VENslNFporMOgUkxd1cjgGLdNBK/aXnt/AQyNkus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfCDIX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:23:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:39354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbfCDIXZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:23:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F9A20823;
        Mon,  4 Mar 2019 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551687804;
        bh=lWzv4KIiuO4JjQkk6CCDbC3KTRS6lfxJE/izDEKUkVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yuRI3sGYiYcvQpv2xr3jGXd+u2BmEUplrSr8W4iA/+DWZtmIT+48jUEtt21H+S0w4
         fdDvdqJ/82ZYHu+5PCvsPx5kUPiZh5UoZLcts7L+oscp5S790XzGo+pqlwcX7ZCGJd
         yDIqO7mYMokhlW4jcwW6kgSir3Lf8wfeaI3keelY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mathieu Malaterre <malat@debian.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 25/32] mac80211: Add attribute aligned(2) to struct action
Date:   Mon,  4 Mar 2019 09:22:13 +0100
Message-Id: <20190304081604.135644789@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081602.307094059@linuxfoundation.org>
References: <20190304081602.307094059@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 7c53eb5d87bc21464da4268c3c0c47457b6d9c9b ]

During refactor in commit 9e478066eae4 ("mac80211: fix MU-MIMO
follow-MAC mode") a new struct 'action' was declared with packed
attribute as:

  struct {
          struct ieee80211_hdr_3addr hdr;
          u8 category;
          u8 action_code;
  } __packed action;

But since struct 'ieee80211_hdr_3addr' is declared with an aligned
keyword as:

  struct ieee80211_hdr {
  	__le16 frame_control;
  	__le16 duration_id;
  	u8 addr1[ETH_ALEN];
  	u8 addr2[ETH_ALEN];
  	u8 addr3[ETH_ALEN];
  	__le16 seq_ctrl;
  	u8 addr4[ETH_ALEN];
  } __packed __aligned(2);

Solve the ambiguity of placing aligned structure in a packed one by
adding the aligned(2) attribute to struct 'action'.

This removes the following warning (W=1):

  net/mac80211/rx.c:234:2: warning: alignment 1 of 'struct <anonymous>' is less than 2 [-Wpacked-not-aligned]

Cc: Johannes Berg <johannes.berg@intel.com>
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 7013b37637556..23f6c8baae951 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -217,7 +217,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_hdr_3addr hdr;
 		u8 category;
 		u8 action_code;
-	} __packed action;
+	} __packed __aligned(2) action;
 
 	if (!sdata)
 		return;
-- 
2.19.1



