Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F147421934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256106;
	bh=ncLaRMFvOnvVUW/n0d+lNRDuFYEkWdIgSln00mtGu44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bfX465Jy+IgkTPIm/yq02gF5MmSZxbar6g9vHWjCfjN4o1a3TihTmHT1cVXJsAg/b
	 TekwArfLCTpnW7CzNVIQq6OsrYigGuUSDiHP7AtSCRWDluUL/4l8/yhkXwE+Q3FF8N
	 Abw1zaoEUkQxDM8cPDpMEjP9mypEzG+Su6NmWhE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388254AbfCVMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:01:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387921AbfCVMBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:01:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08020204FD;
        Fri, 22 Mar 2019 12:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256102;
        bh=ncLaRMFvOnvVUW/n0d+lNRDuFYEkWdIgSln00mtGu44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zu56+3nTZVc2x2A4rKfKe1AxsJOk2wx0q8XYyLdzxagU2FlEre1703aa5yGxc/y69
         R8nyr/cM8zebCxRXJWyk8AIKWMJxqDSzqSkCcXQBgThsA1GeC+RLriA1H1Qod08Kza
         9/HV3OSTExeBEaXILZykHl7GWCa87zE2QqtoRdMQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 109/280] net: set static variable an initial value in atl2_probe()
Date:   Fri, 22 Mar 2019 12:14:22 +0100
Message-Id: <20190322111313.240419430@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index bb41becb6609..31ff1e0d1baa 100644
--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1335,13 +1335,11 @@ static int atl2_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
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



