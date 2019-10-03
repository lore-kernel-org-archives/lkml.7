Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF75C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C924F215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570121347;
	bh=I3kLEQRO6N51vK01+5h+Rvc7se9w/7wBISFxOD8uRAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FrXh+ztc5flSPUe5aVRZcap5KGHlj6vvcp/E8sMQlY9SsgVeN8QdM5yXL6JDcPekK
	 S/aVAnZnmoQvCOuAqSpAEd4t6rW7+az57oIua7DCYloH9SEVyCidvSIp7MZnP6t4Qa
	 7gUZ62jzZFjkqPoltPOk1NJ1IGab/F02+79pcapI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405230AbfJCQtH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 12:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405798AbfJCQtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 12:49:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4D92070B;
        Thu,  3 Oct 2019 16:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570121343;
        bh=I3kLEQRO6N51vK01+5h+Rvc7se9w/7wBISFxOD8uRAA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUW4sKOewD9QjIhl35bCY6fMDPnWT/ogA8I3zqzeJjDP2E6AiYjv6tlvJ0XFsFD9m
         5akLuvxpni2xsI3SisGeIJkNrkGx4n1XCWfLqdT6hv0/NTLJUbHmrJOTGlFQ73Evsw
         GuevUglz7MPoFqRrGvs467TP58pF+qAp+iItwu78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Danit Goldberg <danitg@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5.3 243/344] IB/mlx5: Free mpi in mp_slave mode
Date:   Thu,  3 Oct 2019 17:53:28 +0200
Message-Id: <20191003154604.377975004@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191003154540.062170222@linuxfoundation.org>
References: <20191003154540.062170222@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

commit 5d44adebbb7e785939df3db36ac360f5e8b73e44 upstream.

ib_add_slave_port() allocates a multiport struct but never frees it.
Don't leak memory, free the allocated mpi struct during driver unload.

Cc: <stable@vger.kernel.org>
Fixes: 32f69e4be269 ("{net, IB}/mlx5: Manage port association for multiport RoCE")
Link: https://lore.kernel.org/r/20190916064818.19823-3-leon@kernel.org
Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/hw/mlx5/main.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6959,6 +6959,7 @@ static void mlx5_ib_remove(struct mlx5_c
 			mlx5_ib_unbind_slave_port(mpi->ibdev, mpi);
 		list_del(&mpi->list);
 		mutex_unlock(&mlx5_ib_multiport_mutex);
+		kfree(mpi);
 		return;
 	}
 


