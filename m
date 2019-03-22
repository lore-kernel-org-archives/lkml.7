Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6C521934
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553253911;
	bh=2gOdk0SUeovtxMjK8WXtt37c9Ia0hyewpQjb8nEvTng=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b8e1Wi3492roH74ObwZW4lDFjitz8CAGYsDywMovp0UT01UOS4bVEDGmwO2nGcYPT
	 7vos5nP2rjs/iWwDO5EVSmYzHaTOnvSMm1Ms2aY/Rr387qcN4116Hoxl0748hWmTS7
	 pDiezmntoxahewrgo8bNTLnCKegs0IYfsbrJapq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbfCVLZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728215AbfCVLZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:25:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991BB20657;
        Fri, 22 Mar 2019 11:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553253908;
        bh=2gOdk0SUeovtxMjK8WXtt37c9Ia0hyewpQjb8nEvTng=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JFId2uLlqTJjKOKUpHOR7ukDUG8yltxFv3OS2dcDzNFroOIZTXaH0MRRysz4rJpVB
         3pzoiPyDuaCKsm7K/60+S/xx1vzBpL8cng9sezee/AyqLS57pKNSPrkJga17RvF33p
         Q1RD+9WWlwP0D9cJikGL76G/UPBY3F3eFPNGx01A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mao Wenan <maowenan@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 108/134] net: set static variable an initial value in atl2_probe()
Date:   Fri, 22 Mar 2019 12:15:21 +0100
Message-Id: <20190322111218.145540719@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111210.465931067@linuxfoundation.org>
References: <20190322111210.465931067@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 4593403fa516a5a4cffe6883c5062d60932cbfbe ]

cards_found is a static variable, but when it enters atl2_probe(),
cards_found is set to zero, the value is not consistent with last probe,
so next behavior is not our expect.

Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/atheros/atlx/atl2.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/drivers/net/ethernet/atheros/atlx/atl2.c
+++ b/drivers/net/ethernet/atheros/atlx/atl2.c
@@ -1338,13 +1338,11 @@ static int atl2_probe(struct pci_dev *pd
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


