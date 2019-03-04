Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE896C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B626520836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688706;
	bh=h5fb5tliEYxgXh/WjjtcJvvucnn0fCj5K7YgO34HPgk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2eyd1YulRmEah5B5eap18CWM0YaAoebx7T8uFWWzEeP74gLp8TtimmkRXuCR9N75u
	 pKEehXzvs5EPUHpA9GlJF6XoU6LNmwhoT4iIj7+FjsMdvtldjcHuqsH3rJP7dFDpMT
	 QmcGLP88XjLlgI1QLU+2Ufhe5F5cZsZj6eZyR2/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfCDIez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728352AbfCDIew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:34:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE04520823;
        Mon,  4 Mar 2019 08:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688491;
        bh=h5fb5tliEYxgXh/WjjtcJvvucnn0fCj5K7YgO34HPgk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FddleHwUHEJNG8SF7hskqmEpljHB0apNz6sqy6aWJdtaj4acuM3iG7kV/ISYWv95j
         euCONYkVa6R+/NIz6egbpjeTt6+TMBywZMxd3wMa59MfwQYOsUqwi2e4enpbMlLVzx
         6UZYwE8eISOGxue5QR3nYNpzqmd9JL7XhBA33wg4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mathieu Malaterre <malat@debian.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 62/88] mac80211: Add attribute aligned(2) to struct action
Date:   Mon,  4 Mar 2019 09:22:45 +0100
Message-Id: <20190304081633.004408556@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index 2ee3f09eced1c..cc9be69af44cb 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -231,7 +231,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_hdr_3addr hdr;
 		u8 category;
 		u8 action_code;
-	} __packed action;
+	} __packed __aligned(2) action;
 
 	if (!sdata)
 		return;
-- 
2.19.1



