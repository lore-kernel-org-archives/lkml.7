Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26EEC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FD82196E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138814;
	bh=vENPIQeql5/qRoFrdYhqghzLrqSl1eO4CVpALkEp8kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XBu6xQ9t5o8ZBcy9yJB/btim1GRrWtvs0h/LVMGJnF5mLj6NHiS9mEFlk0LVakbAF
	 toxQe51K8U3db5NZ6qAWFFkqWsHJx+RFfiXx9ZVcuvhX86MC4XNt8PsofxbJE/0oDC
	 mdee/zcMsCPr5WKMiMQlNsahcI0wxO0Kf670t1Bg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfDARNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730559AbfDARNa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:13:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B911521924;
        Mon,  1 Apr 2019 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138810;
        bh=vENPIQeql5/qRoFrdYhqghzLrqSl1eO4CVpALkEp8kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNmRN5TY3fi+eaVCW94p/lOx7XzkBZU8wUXuBBBVSOj8vwxmIpwDnCoEhAdMjEssu
         z17vj6kQe8VQ9BZI7ePKzEXLdK1p42icLCJR2mVc8vi7yPgsWPYG9xP3XaHGB1UMuU
         PnmKmRujR1E+F+CWU0ZAfaVUZdydgc5vBK6reGLI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Suanming.Mou" <mousuanming@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 027/134] vxlan: Dont call gro_cells_destroy() before device is unregistered
Date:   Mon,  1 Apr 2019 19:01:03 +0200
Message-Id: <20190401170047.066601027@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170044.243719205@linuxfoundation.org>
References: <20190401170044.243719205@linuxfoundation.org>
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

From: Zhiqiang Liu <liuzhiqiang26@huawei.com>

[ Upstream commit cc4807bb609230d8959fd732b0bf3bd4c2de8eac ]

Commit ad6c9986bcb62 ("vxlan: Fix GRO cells race condition between
receive and link delete") fixed a race condition for the typical case a vxlan
device is dismantled from the current netns. But if a netns is dismantled,
vxlan_destroy_tunnels() is called to schedule a unregister_netdevice_queue()
of all the vxlan tunnels that are related to this netns.

In vxlan_destroy_tunnels(), gro_cells_destroy() is called and finished before
unregister_netdevice_queue(). This means that the gro_cells_destroy() call is
done too soon, for the same reasons explained in above commit.

So we need to fully respect the RCU rules, and thus must remove the
gro_cells_destroy() call or risk use after-free.

Fixes: 58ce31cca1ff ("vxlan: GRO support at tunnel layer")
Signed-off-by: Suanming.Mou <mousuanming@huawei.com>
Suggested-by: Eric Dumazet <eric.dumazet@gmail.com>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/vxlan.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -3798,10 +3798,8 @@ static void vxlan_destroy_tunnels(struct
 		/* If vxlan->dev is in the same netns, it has already been added
 		 * to the list by the previous loop.
 		 */
-		if (!net_eq(dev_net(vxlan->dev), net)) {
-			gro_cells_destroy(&vxlan->gro_cells);
+		if (!net_eq(dev_net(vxlan->dev), net))
 			unregister_netdevice_queue(vxlan->dev, head);
-		}
 	}
 
 	for (h = 0; h < PORT_HASH_SIZE; ++h)


