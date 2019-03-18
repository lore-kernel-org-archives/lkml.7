Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191DCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF9B214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901689;
	bh=PKf/J9o5eX5viLjngfPrixCKEt111pOMnrPtBq2t6Cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OsBY4vepG0iuwsqgC+ywWE6WfQ6RDPfssd9dT0MCjjuyc4ajprFE9GYEDo2ihutcL
	 uu2TkmmkzzAQUMVhtO76IfCN46f2n557SxQMkl14sIFZ3t11sXwpOuseqrVkXLG+Qd
	 AETxX1ZA2uyFvBOZmCahF8YlrafKT9rfgKEsow9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbfCRJer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:34:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:43156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbfCRJeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:34:44 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB2882075C;
        Mon, 18 Mar 2019 09:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901683;
        bh=PKf/J9o5eX5viLjngfPrixCKEt111pOMnrPtBq2t6Cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rwxjdnsYACa1dtW6GMdJ4RKJjbHHG/eO2trNsfKIyQ/0zwCT5gXrcadgdkgkuB3t1
         uOUrwTf9HEeYcpzNkJHD9YxFjQbI9wfemDkuvkWZXHZ1AfSpHv5XHSeNLaVfsTOrSj
         Ghpm5/iK0U8XOf/JWLGpQvwAc55MjwHNrXsg6ISw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/34] vxlan: Fix GRO cells race condition between receive and link delete
Date:   Mon, 18 Mar 2019 10:25:41 +0100
Message-Id: <20190318084147.070998629@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084144.657740413@linuxfoundation.org>
References: <20190318084144.657740413@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2462,6 +2462,8 @@ static void vxlan_uninit(struct net_devi
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 
+	gro_cells_destroy(&vxlan->gro_cells);
+
 	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
 
 	free_percpu(dev->tstats);
@@ -3523,7 +3525,6 @@ static void vxlan_dellink(struct net_dev
 
 	vxlan_flush(vxlan, true);
 
-	gro_cells_destroy(&vxlan->gro_cells);
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
 }


