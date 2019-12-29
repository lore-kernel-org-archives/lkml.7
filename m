Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DDCC2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BE320718
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642701;
	bh=LE9cdr8eK35EQnzMPDAGO/gXk9BabTnFaFTDvZSMwoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hIZICbW85ECXOj1En+lT0Qy56I2IR5Kt2exq/q9HP7IAeZq4jApbKJO7xRNTXhFWf
	 zrQ0JmwMQjWVpRzOdbI/blo3NYkN/uSv1xO79fyna4F4BuaAv1c1I9ME4tnIElzhki
	 rv7hB9k2DQJSzIji59pbFo4+PxBqoTjVwqPWMivo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfL2SE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 13:04:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:37320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732137AbfL2Rvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:51:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A21208C4;
        Sun, 29 Dec 2019 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641902;
        bh=LE9cdr8eK35EQnzMPDAGO/gXk9BabTnFaFTDvZSMwoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q83Xjd2TYW0nIhxzxWJWsMpVZDOjpFZvPcikWHT2rIZenZFZsbU+sWz4SmTILk1TD
         /lfcEOeHtLuWG/FVQpZLChahx32Fuzpiv7DL/+G0Y+gbqJj1JLajemnOVM83+yLUUk
         9PDJAdxEKT5Y+lkRx3TdakfUzH/AtZVXGMKG7euI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 259/434] xen/gntdev: Use select for DMA_SHARED_BUFFER
Date:   Sun, 29 Dec 2019 18:25:12 +0100
Message-Id: <20191229172719.139077677@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit fa6614d8ef13c63aac52ad7c07c5e69ce4aba3dd ]

DMA_SHARED_BUFFER can not be enabled by the user (it represents a library
set in the kernel). The kconfig convention is to use select for such
symbols so they are turned on implicitly when the user enables a kconfig
that needs them.

Otherwise the XEN_GNTDEV_DMABUF kconfig is overly difficult to enable.

Fixes: 932d6562179e ("xen/gntdev: Add initial support for dma-buf UAPI")
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: xen-devel@lists.xenproject.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/xen/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 79cc75096f42..a50dadd01093 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -141,7 +141,8 @@ config XEN_GNTDEV
 
 config XEN_GNTDEV_DMABUF
 	bool "Add support for dma-buf grant access device driver extension"
-	depends on XEN_GNTDEV && XEN_GRANT_DMA_ALLOC && DMA_SHARED_BUFFER
+	depends on XEN_GNTDEV && XEN_GRANT_DMA_ALLOC
+	select DMA_SHARED_BUFFER
 	help
 	  Allows userspace processes and kernel modules to use Xen backed
 	  dma-buf implementation. With this extension grant references to
-- 
2.20.1



