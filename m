Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CA2C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4DDB2070D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142320;
	bh=9RA4TuuQcZr3YOkh4LRb+xp103gSX/7xhqLQhTOjjAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JSLtFN+L1uxtFFj5diGmTxw8s+tUFeH5NCVCr1+LjniMNEiIoLruMB5waYjfyLT2p
	 A4iW3EUh/aS8qOh40U4AyaUPnKgfeUREmbUeWzd1qd5O0n+WYeSxOIOrsIKIet1Wsl
	 GunX0FgqWK3fqw6hFHeGhYq4ldq2bQhFzK6Mg9FA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfDARFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbfDARFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2867621925;
        Mon,  1 Apr 2019 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138309;
        bh=9RA4TuuQcZr3YOkh4LRb+xp103gSX/7xhqLQhTOjjAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NZAF+dcShhYpCXdfDWiqPTXwGnknXt2Gs7tJwIawOmA1EIBDuSCe1qSjMNTOn1EO6
         Yj+E/tNn5b2TRus9UA0CzMoO6qpLydYgkOCaUomzdf98CfQAJTW/2wTEtwrohIf8yZ
         bcjW7KjAQOsABYECU/VHsXJjVhbtGHxpEhSpak1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Suanming.Mou" <mousuanming@huawei.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 028/146] vxlan: Dont call gro_cells_destroy() before device is unregistered
Date:   Mon,  1 Apr 2019 19:00:40 +0200
Message-Id: <20190401170050.901957393@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4184,10 +4184,8 @@ static void vxlan_destroy_tunnels(struct
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


