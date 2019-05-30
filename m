Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCC0C072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBB52559F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190555;
	bh=5BI3W/bQ/bJ1/zNpqUcHSObyJKPLH/lygxDPR5rIJEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OY8cJ5N2D0w/h8Dw1CygGz4c7MT5eRgEEK0VLCoMsIunefXUmRmraOydA3zm0HMoN
	 4yWXScqSqkWgeFj9+LsS9dtr329PKQwzFt3q5nwVfUmUR3greSwCv2ZnjleEoWHvqH
	 uGY8ralYZXaNfquY0bO3MWh4ehq09XI6pPHjWQ2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729719AbfE3DOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:14:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:52596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728708AbfE3DLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:51 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D232E24502;
        Thu, 30 May 2019 03:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185910;
        bh=5BI3W/bQ/bJ1/zNpqUcHSObyJKPLH/lygxDPR5rIJEo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZG9B/7y5NXjNOYBENxZZnlAVlqq6pq9zjE6Dh5AHiX+A6UzbUbq/LJFP6QhbVVNV
         cowHDjXCWrGpziXfeJX7ceeqTk/SgswfgdlNICTomZlUVVvRR01pcFM6eRyJ4FL3FA
         yAFT1mM24ioomv/xJnYpU5RZqbRG0tiCZ93fcYt4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 244/405] net: hns3: check resetting status in hns3_get_stats()
Date:   Wed, 29 May 2019 20:04:02 -0700
Message-Id: <20190530030553.324991156@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit c4e401e5a934bb0798ebbba98e08dab129695eff ]

hns3_get_stats() should check the resetting status firstly,
since the device will be reinitialized when resetting. If the
reset has not completed, the hns3_get_stats() may access
invalid memory.

Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
index 359d4731fb2db..ea94b5152963f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_ethtool.c
@@ -483,6 +483,11 @@ static void hns3_get_stats(struct net_device *netdev,
 	struct hnae3_handle *h = hns3_get_handle(netdev);
 	u64 *p = data;
 
+	if (hns3_nic_resetting(netdev)) {
+		netdev_err(netdev, "dev resetting, could not get stats\n");
+		return;
+	}
+
 	if (!h->ae_algo->ops->get_stats || !h->ae_algo->ops->update_stats) {
 		netdev_err(netdev, "could not get any statistics\n");
 		return;
-- 
2.20.1



