Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95C2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F9D2213F2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 13:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553260015;
	bh=n+VKxsLRS/NPzthK/pGX5cXJqSNm25pqky8PiZdkduQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DLuXQUfs5FGw29048vF4F9U7bMAKi0Azpitl/L/bCGnuwDU/0BYrBHjAKNkGoC5wk
	 cN069k5PNteSXT3dZ1gSJWGcQBfrDy/5qIJFqreOPNOXjpd15GXPzDc0MCKS22B00J
	 n173aEq+p+58UhNAezHtH/JAmp/HESvhycryDqtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730787AbfCVLhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbfCVLg7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:36:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEFEE21934;
        Fri, 22 Mar 2019 11:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254618;
        bh=n+VKxsLRS/NPzthK/pGX5cXJqSNm25pqky8PiZdkduQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ijd1rdbKxSuABmVozST/rxMb7OczmqRpxh4VuCD8Hqxe6TZoH1NHrl4JQ0KyrRlyD
         YZUjZLhwXGWEjZRxeAQeBCAZ1oSWAxZeLtn3JBiRs6as5Ng/DlTZcWl5Hju8AMWFv+
         1ne7aekEx5sXBq2qVGWTuGAxOVjq+BeoRzpTWWcQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 175/230] net: set static variable an initial value in atl2_probe()
Date:   Fri, 22 Mar 2019 12:15:13 +0100
Message-Id: <20190322111249.022025739@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4593403fa516a5a4cffe6883c5062d60932cbfbe ]

cards_found is a static variable, but when it enters atl2_probe(),
cards_found is set to zero, the value is not consistent with last probe,
so next behavior is not our expect.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atlx/atl2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl2.c b/drivers/net/ethernet/atheros/atlx/atl2.c
index 2ff465848b65..097a0bf592ab 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1338,13 +1338,11 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	struct net_device *netdev;
 	struct atl2_adapter *adapter;
-	static int cards_found;
+	static int cards_found = 0;
 	unsigned long mmio_start;
 	int mmio_len;
 	int err;
 
-	cards_found = 0;
-
 	err = pci_enable_device(pdev);
 	if (err)
 		return err;
-- 
2.19.1



