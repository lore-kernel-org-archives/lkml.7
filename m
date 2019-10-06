Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51ADDC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7A02067B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 18:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570384925;
	bh=+z1/bSBIpzw/6DQYOinfkUhl+ECxEW75rghM58TcE+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PxEMg9GV4oYHiGU7A3dNPtgGLFfBLqvV39+MNcGRcvCAcULwKWrphK96Qu/YxKD1t
	 g3l+TJlR+NUhdoRoXgHX1+1HG2nzqFCDJ/hjQfSF51yc7TjGXbfQ/LEUro7Cni7k4I
	 jMFToMKjlmU09+mzhs+h4hnoe7Y9xZmFMxEMFYaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbfJFR0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:26:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:51250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbfJFR0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:26:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E29482077B;
        Sun,  6 Oct 2019 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570382770;
        bh=+z1/bSBIpzw/6DQYOinfkUhl+ECxEW75rghM58TcE+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cL23YV52RnYf/Pwg2jVFafUxpmtdqmwoMFfsgRAjt9JF+Zx2yLWe/6OOTk5RGlYla
         ClRC8WvZwWXBA9h8EU8d5RCfs1KE5XVNsQjSf9ZaW2kXpfK8wsnE3JBhqdPWU7o24P
         E1kzcpz9v44d1XSBCMEUR5+iy5CJ+OYapsl4xkGo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 32/68] PCI: tegra: Fix OF node reference leak
Date:   Sun,  6 Oct 2019 19:21:08 +0200
Message-Id: <20191006171122.472129602@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171108.150129403@linuxfoundation.org>
References: <20191006171108.150129403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nishka Dasgupta <nishkadg.linux@gmail.com>

[ Upstream commit 9e38e690ace3e7a22a81fc02652fc101efb340cf ]

Each iteration of for_each_child_of_node() executes of_node_put() on the
previous node, but in some return paths in the middle of the loop
of_node_put() is missing thus causing a reference leak.

Hence stash these mid-loop return values in a variable 'err' and add a
new label err_node_put which executes of_node_put() on the previous node
and returns 'err' on failure.

Change mid-loop return statements to point to jump to this label to
fix the reference leak.

Issue found with Coccinelle.

Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
[lorenzo.pieralisi@arm.com: rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/host/pci-tegra.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
index 1987fec1f126f..8efd086c57c96 100644
--- a/drivers/pci/host/pci-tegra.c
+++ b/drivers/pci/host/pci-tegra.c
@@ -1910,14 +1910,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		err = of_pci_get_devfn(port);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			return err;
+			goto err_node_put;
 		}
 
 		index = PCI_SLOT(err);
 
 		if (index < 1 || index > soc->num_ports) {
 			dev_err(dev, "invalid port number: %d\n", index);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_node_put;
 		}
 
 		index--;
@@ -1926,12 +1927,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		if (err < 0) {
 			dev_err(dev, "failed to parse # of lanes: %d\n",
 				err);
-			return err;
+			goto err_node_put;
 		}
 
 		if (value > 16) {
 			dev_err(dev, "invalid # of lanes: %u\n", value);
-			return -EINVAL;
+			err = -EINVAL;
+			goto err_node_put;
 		}
 
 		lanes |= value << (index << 3);
@@ -1945,13 +1947,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		lane += value;
 
 		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
-		if (!rp)
-			return -ENOMEM;
+		if (!rp) {
+			err = -ENOMEM;
+			goto err_node_put;
+		}
 
 		err = of_address_to_resource(port, 0, &rp->regs);
 		if (err < 0) {
 			dev_err(dev, "failed to parse address: %d\n", err);
-			return err;
+			goto err_node_put;
 		}
 
 		INIT_LIST_HEAD(&rp->list);
@@ -1978,6 +1982,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
 		return err;
 
 	return 0;
+
+err_node_put:
+	of_node_put(port);
+	return err;
 }
 
 /*
-- 
2.20.1



