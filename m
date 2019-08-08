Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16730C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DF0214C6
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565291743;
	bh=dQ6PS1WCEpBzXhZD5UEH0K4K783IqUu+5OPXTthOhBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vVIOxsKmYbTi/3pVGXpzjytGkxzHy9gJQX7k9NEMP39oHkZ2gXKxFdxMqXbZfLx1A
	 1+JEqwIHYNYROT7X1j0+86MJz40r0uhgi9cq2i3x5+VSn7Lst9jdpZGamw2EIjdfBw
	 ZMlAKdFzRSrQjN4ROp2tUnQVcCz6gy+qhSeNbQns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404496AbfHHTGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404475AbfHHTGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:06:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1083E214C6;
        Thu,  8 Aug 2019 19:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565291197;
        bh=dQ6PS1WCEpBzXhZD5UEH0K4K783IqUu+5OPXTthOhBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc0l8xSVHmIeW/ilxiDtOrbn/hHN/j//va8J4GvDMOvjFBTy2swsxTGkUQnZtZcE0
         tC+DiKaf4KX+8j1X0yMUItpslCaZxZkiBTGtJG3fhJ+k3xv785mQ0rLMS3DwkW4BeT
         u8219dxC/RRlGNTDuNahZ0/pHUfnxr/Ehs+8lBfo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 5.2 23/56] net/mlx5: Use reversed order when unregister devices
Date:   Thu,  8 Aug 2019 21:04:49 +0200
Message-Id: <20190808190453.823001128@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808190452.867062037@linuxfoundation.org>
References: <20190808190452.867062037@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit 08aa5e7da6bce1a1963f63cf32c2e7ad434ad578 ]

When lag is active, which is controlled by the bonded mlx5e netdev, mlx5
interface unregestering must happen in the reverse order where rdma is
unregistered (unloaded) first, to guarantee all references to the lag
context in hardware is removed, then remove mlx5e netdev interface which
will cleanup the lag context from hardware.

Without this fix during destroy of LAG interface, we observed following
errors:
 * mlx5_cmd_check:752:(pid 12556): DESTROY_LAG(0x843) op_mod(0x0) failed,
   status bad parameter(0x3), syndrome (0xe4ac33)
 * mlx5_cmd_check:752:(pid 12556): DESTROY_LAG(0x843) op_mod(0x0) failed,
   status bad parameter(0x3), syndrome (0xa5aee8).

Fixes: a31208b1e11d ("net/mlx5_core: New init and exit flow for mlx5_core")
Reviewed-by: Parav Pandit <parav@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/dev.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/dev.c
@@ -213,7 +213,7 @@ void mlx5_unregister_device(struct mlx5_
 	struct mlx5_interface *intf;
 
 	mutex_lock(&mlx5_intf_mutex);
-	list_for_each_entry(intf, &intf_list, list)
+	list_for_each_entry_reverse(intf, &intf_list, list)
 		mlx5_remove_device(intf, priv);
 	list_del(&priv->dev_list);
 	mutex_unlock(&mlx5_intf_mutex);


