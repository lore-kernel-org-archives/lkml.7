Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C9C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E04520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918826;
	bh=CFP61ogKUaFlMEANdTpgbEgjc/Z+NZmy6sxfd+TvkqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c2A986Ur9C9KiOmaFF5q0OJPh5snydBlkPPABk1ZpiPPyq669F19iIysWyIaTs4Yb
	 IkAmnrP34SmrYxEnTvgubBFifg+9GCKWHt5jnej67kD7u8u7/cDKc+riSEgvANYwxq
	 D4Br2+KKSj0+SCr/g573Zb0DkMmMMJj7CeyqaudU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbfEOLNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:49480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730013AbfEOLNm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:13:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5C12084E;
        Wed, 15 May 2019 11:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918821;
        bh=CFP61ogKUaFlMEANdTpgbEgjc/Z+NZmy6sxfd+TvkqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyDuUxsnf9MBjLA9fOJmpZJXhN752t3Fa1b6LJf4BagGG3jhyWLSYkeT9qMnGYSvr
         0YmfolmVMZdLqbORBxyywnXsOZN+Oi/05q4mdAznbiD73rA2ceA+fOL8NAYrhWFXyQ
         0EJ8shtWX28UPJx1a9cS3Y3xzVifyC3awIU/S+Qw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 13/51] mac80211: fix unaligned access in mesh table hash function
Date:   Wed, 15 May 2019 12:55:48 +0200
Message-Id: <20190515090621.557590829@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 40586e3fc400c00c11151804dcdc93f8c831c808 ]

The pointer to the last four bytes of the address is not guaranteed to be
aligned, so we need to use __get_unaligned_cpu32 here

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mesh_pathtbl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 197753ad50b4e..8c17d498df301 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -23,7 +23,7 @@ static void mesh_path_free_rcu(struct mesh_table *tbl, struct mesh_path *mpath);
 static u32 mesh_table_hash(const void *addr, u32 len, u32 seed)
 {
 	/* Use last four bytes of hw addr as hash index */
-	return jhash_1word(*(u32 *)(addr+2), seed);
+	return jhash_1word(__get_unaligned_cpu32((u8 *)addr + 2), seed);
 }
 
 static const struct rhashtable_params mesh_rht_params = {
-- 
2.20.1



