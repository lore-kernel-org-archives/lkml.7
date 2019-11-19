Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2617CC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB35521783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574142083;
	bh=xscJ7EClHwitBaxZMa5jBEldDG3fG8cJaiC13LZuq10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfAF5bA0zWvedbwWrLZ6dAEC8fgJtfgf2SNYiSj+aLHXmvFQSbIcH0HyerhOSwHGr
	 VUX6qAw3ZgiNaWCiP5iWbnm2dJKlvUfoky3kGrX4nbmj2Flb+5whQJI7c/8OMExr6T
	 /CPPWDcT8nhjxYB+U4U6YxXerf080uGQZYd6I0WI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfKSFlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:41:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729946AbfKSFlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:41:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6285821783;
        Tue, 19 Nov 2019 05:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574142076;
        bh=xscJ7EClHwitBaxZMa5jBEldDG3fG8cJaiC13LZuq10=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XuL6+aSW1++/cMN4rn0S8rVfX9G77aay8qLXKGcnWdqqzh9tv/KMN73zjHxaZuUl8
         +41qiEzIBd/L49IUvQIx/77B4VLJqC160fhKWi+TmSOYFwmLrUIhADMm0c6RVu7jeG
         uu2m5ICPoU4bc8hk9LDQwYWWFWzgW1phjuiF+4x4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 380/422] RDMA: Fix dependencies for rdma_user_mmap_io
Date:   Tue, 19 Nov 2019 06:19:37 +0100
Message-Id: <20191119051423.687303372@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 46bdf777685677c1cc6b3da9220aace9da690731 ]

The mlx4 driver produces a link error when it is configured
as built-in while CONFIG_INFINIBAND_USER_ACCESS is set to =m:

drivers/infiniband/hw/mlx4/main.o: In function `mlx4_ib_mmap':
main.c:(.text+0x1af4): undefined reference to `rdma_user_mmap_io'

The same function is called from mlx5, which already has a
dependency to ensure we can call it, and from hns, which
appears to suffer from the same problem.

This adds the same dependency that mlx5 uses to the other two.

Fixes: 6745d356ab39 ("RDMA/hns: Use rdma_user_mmap_io")
Fixes: c282da4109e4 ("RDMA/mlx4: Use rdma_user_mmap_io")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/Kconfig  | 1 +
 drivers/infiniband/hw/mlx4/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
index fddb5fdf92de8..21c2100b2ea98 100644
--- a/drivers/infiniband/hw/hns/Kconfig
+++ b/drivers/infiniband/hw/hns/Kconfig
@@ -1,6 +1,7 @@
 config INFINIBAND_HNS
 	tristate "HNS RoCE Driver"
 	depends on NET_VENDOR_HISILICON
+	depends on INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 	depends on ARM64 || (COMPILE_TEST && 64BIT)
 	---help---
 	  This is a RoCE/RDMA driver for the Hisilicon RoCE engine. The engine
diff --git a/drivers/infiniband/hw/mlx4/Kconfig b/drivers/infiniband/hw/mlx4/Kconfig
index db4aa13ebae0c..d1de3285fd885 100644
--- a/drivers/infiniband/hw/mlx4/Kconfig
+++ b/drivers/infiniband/hw/mlx4/Kconfig
@@ -1,6 +1,7 @@
 config MLX4_INFINIBAND
 	tristate "Mellanox ConnectX HCA support"
 	depends on NETDEVICES && ETHERNET && PCI && INET
+	depends on INFINIBAND_USER_ACCESS || !INFINIBAND_USER_ACCESS
 	depends on MAY_USE_DEVLINK
 	select NET_VENDOR_MELLANOX
 	select MLX4_CORE
-- 
2.20.1



