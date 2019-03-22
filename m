Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D6E21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254462;
	bh=tnfkSFnsp86RzNwpFSEIkXFXM0jGj+UGUnA+5PcFYsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rlBWWUxfIDS9rreOw65O1gpIK/s/sejbF/E2xARVO6b/peo0LICUVPSae7urOGUOK
	 RuG3g/XZ9qwa5e7oEUkmn2J/iEXPy6N6Qmb5rMa5Zyfqe94If9NKitwTlU0fz+YXLX
	 PwUlxDLkDMeZf+YxoF18TCFH2Q+6iu1oCBNMkcCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbfCVLeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730199AbfCVLeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09CC22183E;
        Fri, 22 Mar 2019 11:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254457;
        bh=tnfkSFnsp86RzNwpFSEIkXFXM0jGj+UGUnA+5PcFYsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=is8QIlifF41iDfXt+kUCunlB8dOloUZcAZqfTZs1DzdGCPf7AAXNLdIiHLAhD3C+X
         FH4dLMnkUXrkHf0MBTRSlMzn6HNU5sC8iq/ONHdsig8TeCPIKYrqMrEGOf3fiTUJix
         LqSz6CPAQBPBm4aSMYeEG40MNUUSvXmhfRK0xstE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 142/230] vxlan: Fix GRO cells race condition between receive and link delete
Date:   Fri, 22 Mar 2019 12:14:40 +0100
Message-Id: <20190322111246.614628121@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit ad6c9986bcb627c7c22b8f9e9a934becc27df87c ]

If we receive a packet while deleting a VXLAN device, there's a chance
vxlan_rcv() is called at the same time as vxlan_dellink(). This is fine,
except that vxlan_dellink() should never ever touch stuff that's still in
use, such as the GRO cells list.

Otherwise, vxlan_rcv() crashes while queueing packets via
gro_cells_receive().

Move the gro_cells_destroy() to vxlan_uninit(), which runs after the RCU
grace period is elapsed and nothing needs the gro_cells anymore.

This is now done in the same way as commit 8e816df87997 ("geneve: Use GRO
cells infrastructure.") originally implemented for GENEVE.

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: 58ce31cca1ff ("vxlan: GRO support at tunnel layer")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -2322,6 +2322,8 @@ static void vxlan_uninit(struct net_devi
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 
+	gro_cells_destroy(&vxlan->gro_cells);
+
 	vxlan_fdb_delete_default(vxlan);
 
 	free_percpu(dev->tstats);
@@ -3066,7 +3068,6 @@ static void vxlan_dellink(struct net_dev
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 
-	gro_cells_destroy(&vxlan->gro_cells);
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
 }


