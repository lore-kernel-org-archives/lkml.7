Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF6C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0051B2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552902194;
	bh=O3yJCF0MKkbWFiJt+pEr92/wp61dMXLpXg3MexuNoDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o8Y8yk0e8VZShF5VX/tnlDgOAgk9arv4MfYsQN5XJd3NHMIJSb4OVm+HAbPf1ytgf
	 XxBc86CezBeaL1Ovkf3zqxMOBVI8G+ZCNSy52uY2DvE0bwkmK9hsKDBFRexw7ZNTgw
	 +7xN405e27kO5pHhqgokh5jJAM8zcePsIHMaPciQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbfCRJcL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:32:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728676AbfCRJcG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:32:06 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9183214D8;
        Mon, 18 Mar 2019 09:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901525;
        bh=O3yJCF0MKkbWFiJt+pEr92/wp61dMXLpXg3MexuNoDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5IOA7y9+VQj/0o8zfqOmO/3eQ1XdtfTZDYk5PQ5A3MT3/nNadcYNZY8FSBrdPzNP
         WgATFAGC2wnam+ksvN2dyi0JbWJ+ADnTDNJc6QE+o1OOL8YhbmRw8l9R9rhgnOBDMs
         CphptYB8hgGf1FOFsaeyHbySlqqmYEIPmcag6/xM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 20/52] vxlan: Fix GRO cells race condition between receive and link delete
Date:   Mon, 18 Mar 2019 10:25:17 +0100
Message-Id: <20190318084015.950944030@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318084013.532280682@linuxfoundation.org>
References: <20190318084013.532280682@linuxfoundation.org>
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
@@ -2460,6 +2460,8 @@ static void vxlan_uninit(struct net_devi
 {
 	struct vxlan_dev *vxlan = netdev_priv(dev);
 
+	gro_cells_destroy(&vxlan->gro_cells);
+
 	vxlan_fdb_delete_default(vxlan, vxlan->cfg.vni);
 
 	free_percpu(dev->tstats);
@@ -3526,7 +3528,6 @@ static void vxlan_dellink(struct net_dev
 
 	vxlan_flush(vxlan, true);
 
-	gro_cells_destroy(&vxlan->gro_cells);
 	list_del(&vxlan->next);
 	unregister_netdevice_queue(dev, head);
 }


