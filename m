Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 150F3C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DA922314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003482;
	bh=BLy635XSDMjIwwCgJN1nQvdDhCKHwCkK84/xj2G/bII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wCI7vCB2D0oKC+ZxikbO530y5MANn+saI2bx/eVUjHbQOTHvY5sk1Zy8tEu7wImWf
	 9OZK9Ru0LEOHoSStnMR0ODWbph38eJMV9OPmzzGVvg4geeg31JPpPvxWb3gH2qHdTP
	 kdJglUA1j1SNj9OhkqAimGazOYk9MfXbBEeEBN0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgABWR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:17:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:60838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727791AbgABWRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4753921582;
        Thu,  2 Jan 2020 22:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003473;
        bh=BLy635XSDMjIwwCgJN1nQvdDhCKHwCkK84/xj2G/bII=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0eIb4Qb5A8jCdrEbfBe2YIpsBJo7JgLHNTOYMbmAGT0eA8dTOvoRlVKkgh9TVtZc
         Nwk9EomDUznPZDnfHfSGU5g31f4Yl1wtaJDUwVSloljM4Wg01Nu/eburRFsngImJ3k
         zUxSXsexCf1Z+Z1Bvkab0PNAxXwF/exp28X9DxeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladyslav Tarasiuk <vladyslavt@mellanox.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 149/191] net/mlxfw: Fix out-of-memory error in mfa2 flash burning
Date:   Thu,  2 Jan 2020 23:07:11 +0100
Message-Id: <20200102215845.457450510@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladyslav Tarasiuk <vladyslavt@mellanox.com>

[ Upstream commit a5bcd72e054aabb93ddc51ed8cde36a5bfc50271 ]

The burning process requires to perform internal allocations of large
chunks of memory. This memory doesn't need to be contiguous and can be
safely allocated by vzalloc() instead of kzalloc(). This patch changes
such allocation to avoid possible out-of-memory failure.

Fixes: 410ed13cae39 ("Add the mlxfw module for Mellanox firmware flash process")
Signed-off-by: Vladyslav Tarasiuk <vladyslavt@mellanox.com>
Reviewed-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Tested-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c
+++ b/drivers/net/ethernet/mellanox/mlxfw/mlxfw_mfa2.c
@@ -6,6 +6,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netlink.h>
+#include <linux/vmalloc.h>
 #include <linux/xz.h>
 #include "mlxfw_mfa2.h"
 #include "mlxfw_mfa2_file.h"
@@ -548,7 +549,7 @@ mlxfw_mfa2_file_component_get(const stru
 	comp_size = be32_to_cpu(comp->size);
 	comp_buf_size = comp_size + mlxfw_mfa2_comp_magic_len;
 
-	comp_data = kmalloc(sizeof(*comp_data) + comp_buf_size, GFP_KERNEL);
+	comp_data = vzalloc(sizeof(*comp_data) + comp_buf_size);
 	if (!comp_data)
 		return ERR_PTR(-ENOMEM);
 	comp_data->comp.data_size = comp_size;
@@ -570,7 +571,7 @@ mlxfw_mfa2_file_component_get(const stru
 	comp_data->comp.data = comp_data->buff + mlxfw_mfa2_comp_magic_len;
 	return &comp_data->comp;
 err_out:
-	kfree(comp_data);
+	vfree(comp_data);
 	return ERR_PTR(err);
 }
 
@@ -579,7 +580,7 @@ void mlxfw_mfa2_file_component_put(struc
 	const struct mlxfw_mfa2_comp_data *comp_data;
 
 	comp_data = container_of(comp, struct mlxfw_mfa2_comp_data, comp);
-	kfree(comp_data);
+	vfree(comp_data);
 }
 
 void mlxfw_mfa2_file_fini(struct mlxfw_mfa2_file *mfa2_file)


