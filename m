Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35976C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0570C218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253665;
	bh=HF4fP++xF/Ho9cc3sFsCcOeY6eeeukjDI7rehcOPeG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eOLBSSavr9BL5YhoHkGMz+LB9CpTqKsWcEVHAHTKZ8rkTz0u4f5BPMBwb2UzOcvIJ
	 +rk/jQolJjiK+P7GOTvK+BShOnJaIuWBuOVjf8KwD1uTECqwaPxi2GCcqJK5vzW9Wq
	 WP7l+MOtlEi5wbzbouY1nqNl786BBwEwzvLDw+X8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728518AbfCVLVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:47456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728504AbfCVLVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:21:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A35621917;
        Fri, 22 Mar 2019 11:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253661;
        bh=HF4fP++xF/Ho9cc3sFsCcOeY6eeeukjDI7rehcOPeG4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5zDXP45RTLHSRBGuVuE7ACuEMZh6/QGZ8/eXLIOgQtTOD7wNeAT+FGVAXHs37yvQ
         m9j6pisAXBT+vKG9UbvSqnowHnAn/TDVtm5CMfnLADR0e6Quhr++2Ujf3hBk9p8nYm
         RTlC5LDog3Tqmz1GHz5xA3yChJGoWXYI44UUugsI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Copeland <bobcopeland@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 033/134] mac80211: fix miscounting of ttl-dropped frames
Date:   Fri, 22 Mar 2019 12:14:06 +0100
Message-Id: <20190322111212.146969334@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit a0dc02039a2ee54fb4ae400e0b755ed30e73e58c ]

In ieee80211_rx_h_mesh_fwding, we increment the 'dropped_frames_ttl'
counter when we decrement the ttl to zero.  For unicast frames
destined for other hosts, we stop processing the frame at that point.

For multicast frames, we do not rebroadcast it in this case, but we
do pass the frame up the stack to process it on this STA.  That
doesn't match the usual definition of "dropped," so don't count
those as such.

With this change, something like `ping6 -i0.2 ff02::1%mesh0` from a
peer in a ttl=1 network no longer increments the counter rapidly.

Signed-off-by: Bob Copeland <bobcopeland@fb.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ea3b139875218..ccb822aa62258 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2179,7 +2179,9 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
 	skb_set_queue_mapping(skb, q);
 
 	if (!--mesh_hdr->ttl) {
-		IEEE80211_IFSTA_MESH_CTR_INC(ifmsh, dropped_frames_ttl);
+		if (!is_multicast_ether_addr(hdr->addr1))
+			IEEE80211_IFSTA_MESH_CTR_INC(ifmsh,
+						     dropped_frames_ttl);
 		goto out;
 	}
 
-- 
2.19.1



