Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B152C4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BBB2133F
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 17:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570383010;
	bh=E69jPBhERz8zrUisDraYKLSEfmvI3riaLDoldYjcMW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0eG/TLy/G6C1O8ILQGR/lZ2hbyUzxpjd2lLGtXu2BnjUaiGsZHcSCLsYfT2cpGgzh
	 EN4zjYmH9pyCcmIGWKrZ5+0tlW+rC0k1w2/RS33Y0x9QOkEar9q6oxoirWyuuMvvxU
	 9ccStwqhbJauSJVFihXWBK71CEjLHb4SrrrEKChY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbfJFRaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 13:30:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728107AbfJFRaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:30:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ECA12133F;
        Sun,  6 Oct 2019 17:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570383005;
        bh=E69jPBhERz8zrUisDraYKLSEfmvI3riaLDoldYjcMW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RsvaOvX85p9em7FGk31fw1z6reYQqHU4tceptSw27OZOcjrTiTXpOLcjLYGNfrrJ9
         amoEpS12itJ/XRVGL71DjoY28IaDbEhT1zXaqRfrQMuKpFKzsgYjE82gDlqESOTZFS
         PzxAQoTLXByMQyPH9iJShtfAO4PKwKyuqGsA9avk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 052/106] PCI: tegra: Fix OF node reference leak
Date:   Sun,  6 Oct 2019 19:20:58 +0200
Message-Id: <20191006171145.260544189@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191006171124.641144086@linuxfoundation.org>
References: <20191006171124.641144086@linuxfoundation.org>
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
 drivers/pci/controller/pci-tegra.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
index f4f53d092e005..976eaa9a9f266 100644
--- a/drivers/pci/controller/pci-tegra.c
+++ b/drivers/pci/controller/pci-tegra.c
@@ -1975,14 +1975,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -1991,12 +1992,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -2010,13 +2012,15 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
@@ -2043,6 +2047,10 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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



