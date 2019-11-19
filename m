Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DE7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8C221783
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141676;
	bh=dKdA9fvKDvrzwT6OyXoV13tqy04HRb0LRnMHuVWnVHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cPk2V9VpeS66Kc7Cl+0/mgpup5BYlgfhW91Ad/pumJihqNvKXmoxgowoyJo85Tx8z
	 m41RByNYA5XY+e9mbGhrbIhosHWqUbU5Dy3I08z7/G+5CDYe8dK9kQXGFW7stSv8AD
	 Z/KxsXt7FykKyTE11uALG9dCgOHtvj04VrZDhgMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfKSFef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:34:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729687AbfKSFed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:34:33 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E48E20862;
        Tue, 19 Nov 2019 05:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141672;
        bh=dKdA9fvKDvrzwT6OyXoV13tqy04HRb0LRnMHuVWnVHA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wxBTJWhFpcPjha9gkUcyeFZ5fal9SYt+/7GEe81qcl/8S8R67GirR4yuEsDaOaVQc
         9uTompvZZB7/ATymNEDq+9ceTrtjBefK5bHBnVocXB9SB9W40jtqsgqHCcbdkWgTyp
         VW4wwXwN445TljVIJON41MQIbc3XiSX29rP0buT8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Honghui Zhang <honghui.zhang@mediatek.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 242/422] PCI: mediatek: Fix unchecked return value
Date:   Tue, 19 Nov 2019 06:17:19 +0100
Message-Id: <20191119051414.700418537@linuxfoundation.org>
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

From: Gustavo A. R. Silva <gustavo@embeddedor.com>

[ Upstream commit 17a0a1e5f6c4bd6df17834312ff577c1373d87b8 ]

Check return value of devm_pci_remap_iospace().

Addresses-Coverity-ID: 1471965 ("Unchecked return value")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-mediatek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index c5ff6ca65eab2..0d100f56cb884 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1120,7 +1120,9 @@ static int mtk_pcie_request_resources(struct mtk_pcie *pcie)
 	if (err < 0)
 		return err;
 
-	devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	err = devm_pci_remap_iospace(dev, &pcie->pio, pcie->io.start);
+	if (err)
+		return err;
 
 	return 0;
 }
-- 
2.20.1



