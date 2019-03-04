Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1E5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6466C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688313;
	bh=M3Zp06f+NNaun/b0HLm3ZtBxGYq+cWZd7t6mwF5viKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sLOeo291BM19SZzpIGPcZwhdw+A1j+2EykJmodiS8+wtvexmH+mHRYUVGN4bckggX
	 p1Iyz7FWYTj0l7YlB85Zstm/bfrpHIDPsGVUMFIU29AoOuBJPLdsfSR1sOjNRD16aN
	 uWWZQq3isx60cdLH7RwODe19nWHohQPSDgiBocmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727477AbfCDIbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:34380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfCDIbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:31:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52266208E4;
        Mon,  4 Mar 2019 08:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688307;
        bh=M3Zp06f+NNaun/b0HLm3ZtBxGYq+cWZd7t6mwF5viKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itwbSvZcFsINyvqVdoYaw609ocf5DIq+jiZZO1//HpsaFJYDsJEl9RJe3mlZQePR+
         6VVWq/eKvzTpMp/iV68hDFdQodkiewUGyrqlpqUNyz+mzgp6HLneiCIYrG8yb8RDk+
         AbQV8vV+iAGeJiyddlLh2j+qayDOOEVZN1qTHZBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Mathieu Malaterre <malat@debian.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 60/78] mac80211: Add attribute aligned(2) to struct action
Date:   Mon,  4 Mar 2019 09:22:43 +0100
Message-Id: <20190304081628.236183451@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index d7a05a9944421..e946ee4f335bd 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -221,7 +221,7 @@ static void ieee80211_handle_mu_mimo_mon(struct ieee80211_sub_if_data *sdata,
 		struct ieee80211_hdr_3addr hdr;
 		u8 category;
 		u8 action_code;
-	} __packed action;
+	} __packed __aligned(2) action;
 
 	if (!sdata)
 		return;
-- 
2.19.1



