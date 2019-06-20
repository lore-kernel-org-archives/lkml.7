Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D6EC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8195A2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054916;
	bh=nUY6ILTxX+DakTlISDVeWnorLgfPe9zH17lpV8hhCvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2eef1FvY5TcGlvyv4YCCKPUHZeSRMtR8xGEVkF8ImKIGuQFip2Mn41v6QXLL9v9F0
	 AxlZvXyspDhCk3lEBOt6z6Ju56MV1CglXdHYTwCGk0hHru0iq2qgMu50Y7w8zfHoUo
	 KAFaMKmYSVqZ4Yar+LmjbmI7fUGLvsvEUjfKKro4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfFTSVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:21:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728607AbfFTSLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:11:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFE02089C;
        Thu, 20 Jun 2019 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054301;
        bh=nUY6ILTxX+DakTlISDVeWnorLgfPe9zH17lpV8hhCvs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SkEckStZBLv2r4ZjmjxHWhPJI6Z8Hdo37/DhsjzK5JqvyJxUiOEXdK4CZNMqRLcJQ
         qiOULDK1Pdg6+IWnC3w4L9vkI7wIC6PyraX66RWhca8mXtKchKRJy77r5g+bqq2NpG
         /14FJf2pcTWK4x53mZw/REcKmYph0OR5i0qTTcNM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yuri Chipchev <yuric@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 16/61] net: mvpp2: prs: Use the correct helpers when removing all VID filters
Date:   Thu, 20 Jun 2019 19:57:11 +0200
Message-Id: <20190620174339.937895518@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit 6b7a3430c163455cf8a514d636bda52b04654972 ]

When removing all VID filters, the mvpp2_prs_vid_entry_remove would be
called with the TCAM id incorrectly used as a VID, causing the wrong
TCAM entries to be invalidated.

Fix this by directly invalidating entries in the VID range.

Fixes: 56beda3db602 ("net: mvpp2: Add hardware offloading for VLAN filtering")
Suggested-by: Yuri Chipchev <yuric@marvell.com>
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_prs.c
@@ -2025,8 +2025,10 @@ void mvpp2_prs_vid_remove_all(struct mvp
 
 	for (tid = MVPP2_PRS_VID_PORT_FIRST(port->id);
 	     tid <= MVPP2_PRS_VID_PORT_LAST(port->id); tid++) {
-		if (priv->prs_shadow[tid].valid)
-			mvpp2_prs_vid_entry_remove(port, tid);
+		if (priv->prs_shadow[tid].valid) {
+			mvpp2_prs_hw_inv(priv, tid);
+			priv->prs_shadow[tid].valid = false;
+		}
 	}
 }
 


