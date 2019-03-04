Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 278FAC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED4D620823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551689053;
	bh=0kadD9u4Miyy6YekS7ljSYKh74Yn/YUuRxryIF4JH0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PkwJ8IL1OzWGXatuXY0/47IhV+3Kc1HtoqJFntg+UeMfxI0K2dvN8zMkcxWT/TLG3
	 IAkT3+GDvlSx75ZLUkOG9a2/jWOvJViSIJozSE54qJLXU2AKC9AONzWLs65vfyLGxz
	 BB5OVHl/VfX6yUrwjSIHehAaNz+kh5PdZZvGVWO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfCDIoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:44:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfCDI3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:29:13 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 594EB20823;
        Mon,  4 Mar 2019 08:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688152;
        bh=0kadD9u4Miyy6YekS7ljSYKh74Yn/YUuRxryIF4JH0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TtBFizQCNtqcSDT1YMyTXIzKfvBnDWI26ggePnrbDRY2n1PuVvmzzCGY36xWAYisN
         PyqznOD8hP9xjYXn2zMIX9UrYmcowGXjFAKZGiXZu7EE0bl/IPTosmfP1ipYK0fnXC
         yEoVVEFgVpC1Ikfd6/or82YDSqXsQBR0sz3vSnFE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bob Copeland <bobcopeland@fb.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 34/78] mac80211: fix miscounting of ttl-dropped frames
Date:   Mon,  4 Mar 2019 09:22:17 +0100
Message-Id: <20190304081627.029774175@linuxfoundation.org>
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
index 828348b2a504d..d7a05a9944421 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -2678,7 +2678,9 @@ ieee80211_rx_h_mesh_fwding(struct ieee80211_rx_data *rx)
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



