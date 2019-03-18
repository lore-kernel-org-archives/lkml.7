Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99DEC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1F2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552901380;
	bh=k0q/G9OWExDQH4v4PNlTr5ef+YtWGj6crlzvvdg4yKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o6bIB0Ud/r3bB+EbYhv0UajTXSk41evS9vrWQ5RXbmgEXxJhoGsVWaPoaVGeVFts4
	 CCElM2lmolOyIzry+Hgifet/CDrJP7BJBpd1VQRNXIIL4WBg8EL4DIGHyvCCQI9bC/
	 iVdUwESaOZt0+r4tEvcNJVzIO+FHxtSWgiywRViY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfCRJ3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:29:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728241AbfCRJ3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:29:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BA042075C;
        Mon, 18 Mar 2019 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552901371;
        bh=k0q/G9OWExDQH4v4PNlTr5ef+YtWGj6crlzvvdg4yKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJ5QGHxFkfESJSOwpltqfhbgnhcztUHegFrMyMZnWCxQIQffqcFxszCaYA8fdeaVP
         OhpTpMhYp65CndXzLlcM283Icj4kKV5baFDW9FiJhW9cfDm5EXKfceCNgCMEK+DV1F
         g13pSJDCFnlhKgInbBOtUl1dypIh2kkqu3ZVChsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian Shen <shenjian15@huawei.com>,
        Huazhong Tan <tanhuazhong@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 07/52] net: hns3: add dma_rmb() for rx description
Date:   Mon, 18 Mar 2019 10:24:54 +0100
Message-Id: <20190318083844.286915272@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190318083843.398913295@linuxfoundation.org>
References: <20190318083843.398913295@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jian Shen <shenjian15@huawei.com>

[ Upstream commit d394d33bee22421b39a0bcdc51ca6d68ba308625 ]

HW can not guarantee complete write desc->rx.size, even though
HNS3_RXD_VLD_B has been set. Driver needs to add dma_rmb()
instruction to make sure desc->rx.size is always valid.

Fixes: e55970950556 ("net: hns3: Add handling of GRO Pkts not fully RX'ed in NAPI poll")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2373,6 +2373,9 @@ static int hns3_handle_rx_bd(struct hns3
 	length = le16_to_cpu(desc->rx.size);
 	bd_base_info = le32_to_cpu(desc->rx.bd_base_info);
 
+	/* make sure HW write desc complete */
+	dma_rmb();
+
 	/* Check valid BD */
 	if (unlikely(!hnae3_get_bit(bd_base_info, HNS3_RXD_VLD_B)))
 		return -EFAULT;


