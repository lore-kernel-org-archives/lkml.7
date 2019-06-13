Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22EC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8D720644
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560442919;
	bh=UYJHN5eL3F/xYsJ1AHNxzRAwdLyzkyjHar/AmDJKRgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UFrzqkmLa8hEfbKttewkZr45JmtBn6WCOzILEGA3mbKUz6Vhi/f6MobL3eXhWawy7
	 eZDTNqGviw+faa+kzUGT8S3tbMK0HEINsaDXdQk0VvIo60bGCI+3+v5vuNWdGAiWLJ
	 izEtBNTUoSxZQLEPHjutPxT3eNQQKwI87MVoV7jw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403908AbfFMQV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 12:21:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731051AbfFMIic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 04:38:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D5AF21473;
        Thu, 13 Jun 2019 08:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560415111;
        bh=UYJHN5eL3F/xYsJ1AHNxzRAwdLyzkyjHar/AmDJKRgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=erwQwCJM+qKtyA0IIprBXsYNmVmM/7Qzjnxz1w8Nva+OGlXbm3lFz7bn8946DdD6J
         rgx824fVP6wfp194+j5M+p8GHgDfCMk9ktgxn1dgJ79sR1Dl+CaMeZYTbYCHgwpKD8
         cchrWXB2pgcIYMbv5WgN828bkS8ioPO2Zx9mLGt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 64/81] PCI: rcar: Fix a potential NULL pointer dereference
Date:   Thu, 13 Jun 2019 10:33:47 +0200
Message-Id: <20190613075653.740223919@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190613075649.074682929@linuxfoundation.org>
References: <20190613075649.074682929@linuxfoundation.org>
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
 drivers/pci/host/pcie-rcar.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/host/pcie-rcar.c b/drivers/pci/host/pcie-rcar.c
index 41edce16a07c..fad57d068db3 100644
--- a/drivers/pci/host/pcie-rcar.c
+++ b/drivers/pci/host/pcie-rcar.c
@@ -888,6 +888,10 @@ static int rcar_pcie_enable_msi(struct rcar_pcie *pcie)
 
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



