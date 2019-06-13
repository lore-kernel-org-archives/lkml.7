Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C44FC46477
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A46208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442432;
	bh=Kw+HJr+R42y6/vvn4jURGVl/5vkrzlwKS9vwDuY+uEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wKjqSWIcskLi3OkcJROOdN4opRDWGbd4/ltPwYyGdyx4FaZGpUCnvugopfwDdCzGH
	 +YfKLxLVlBwfZuL4UJhzbKnWCWNvi7zwO/yHp+JBme2LzG9fwhSrBi+nsSoHwx5TKh
	 yaa5maiZOkL+Pmrl4cekMkCmzK0NdRGZFvQg7zVQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391745AbfFMQNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:13:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:59816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731202AbfFMImj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:42:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9038C215EA;
        Thu, 13 Jun 2019 08:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415358;
        bh=Kw+HJr+R42y6/vvn4jURGVl/5vkrzlwKS9vwDuY+uEk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tBCXVh63ZIz8N+WCZGCpcyiY2UdPwwIPZxiGRG48jCV25kMA9z15QF+7aJl+zXYWV
         TkKPC6ZqbtV/GbsSOHZ0DNjnUST/+hD50yx9O4AE9S+mhj5kuqVKbA+p6zYkTz3iUG
         ggAXQXQZDof6nIXsuPAlseiFH802WDYCgUKRSWqE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/118] PCI: rcar: Fix a potential NULL pointer dereference
Date:   Thu, 13 Jun 2019 10:33:54 +0200
Message-Id: <20190613075649.511604563@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075643.642092651@linuxfoundation.org>
References: <20190613075643.642092651@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit f0d14edd2ba43b995bef4dd5da5ffe0ae19321a1 ]

In case __get_free_pages() fails and returns NULL, fix the return
value to -ENOMEM and release resources to avoid dereferencing a
NULL pointer.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Ulrich Hecht <uli+renesas@fpond.eu>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-rcar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/pcie-rcar.c b/drivers/pci/controller/pcie-rcar.c
index 6a4e435bd35f..765c39911c0c 100644
--- a/drivers/pci/controller/pcie-rcar.c
+++ b/drivers/pci/controller/pcie-rcar.c
@@ -931,6 +931,10 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
 	/* setup MSI data target */
 	msi->pages = __get_free_pages(GFP_KERNEL, 0);
+	if (!msi->pages) {
+		err = -ENOMEM;
+		goto err;
+	}
 	base = virt_to_phys((void *)msi->pages);
 
 	rcar_pci_write_reg(pcie, base | MSIFE, PCIEMSIALR);
-- 
2.20.1



