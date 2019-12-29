Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF05AC2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9358206DB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577641314;
	bh=IErqbog8e9JrhvsZt+PSPHx1L69jq2tQASc9WBeYfPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SaKte0crjTeQbwy4YZJI0WRx4R9HHZt0DrRG07WRkGnRR6DgwcRISwmrjhZNPrSNs
	 ieZIeukRrHlJuC/mZL5z9KZzWh9M7bjw5nZHfs+Wd/8tmEwQ0OzoIdFB3A0ckh+/qk
	 OoKSrXKfOekob0aMbXNOEwPpeg0rEOVvW6ozXU/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbfL2Rlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:41:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729978AbfL2Rlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:41:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759F1206A4;
        Sun, 29 Dec 2019 17:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641306;
        bh=IErqbog8e9JrhvsZt+PSPHx1L69jq2tQASc9WBeYfPE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pQaJzMn8Opm9Nzmjvugz0V6GQkLCoOm1Zn0J2G6RwkrOwuzW2pdirGLittaEZGTMa
         TSb3tcohKe4/iOhJNStRVZxPp2YLqvhHWh1A3awo/vcDha5ltvq3b5X/jfm9y83q73
         hq+/rsp6QXgPQMBX3LWSfB2qhegk5XQH1xPPHV+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, John Hurley <john.hurley@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 012/434] nfp: flower: fix stats id allocation
Date:   Sun, 29 Dec 2019 18:21:05 +0100
Message-Id: <20191229172703.069434778@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Hurley <john.hurley@netronome.com>

[ Upstream commit 39f14c00b13c47186739a4cbc7a16e04d7fdbb60 ]

As flower rules are added, they are given a stats ID based on the number
of rules that can be supported in firmware. Only after the initial
allocation of all available IDs does the driver begin to reuse those that
have been released.

The initial allocation of IDs was modified to account for multiple memory
units on the offloaded device. However, this introduced a bug whereby the
counter that controls the IDs could be decremented before the ID was
assigned (where it is further decremented). This means that the stats ID
could be assigned as -1/0xfffffff which is out of range.

Fix this by only decrementing the main counter after the current ID has
been assigned.

Fixes: 467322e2627f ("nfp: flower: support multiple memory units for filter offloads")
Signed-off-by: John Hurley <john.hurley@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/flower/metadata.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/flower/metadata.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/metadata.c
@@ -65,17 +65,17 @@ static int nfp_get_stats_entry(struct nf
 	freed_stats_id = priv->stats_ring_size;
 	/* Check for unallocated entries first. */
 	if (priv->stats_ids.init_unalloc > 0) {
-		if (priv->active_mem_unit == priv->total_mem_units) {
-			priv->stats_ids.init_unalloc--;
-			priv->active_mem_unit = 0;
-		}
-
 		*stats_context_id =
 			FIELD_PREP(NFP_FL_STAT_ID_STAT,
 				   priv->stats_ids.init_unalloc - 1) |
 			FIELD_PREP(NFP_FL_STAT_ID_MU_NUM,
 				   priv->active_mem_unit);
-		priv->active_mem_unit++;
+
+		if (++priv->active_mem_unit == priv->total_mem_units) {
+			priv->stats_ids.init_unalloc--;
+			priv->active_mem_unit = 0;
+		}
+
 		return 0;
 	}
 


