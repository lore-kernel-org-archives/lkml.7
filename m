Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81702C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 420682087C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552414133;
	bh=8mY5KHVtibOZlB4ZnARHtsed2sk1nZcvBwJd82aM34E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D2C0V6kTn9gHftOOiM1g++08xl38Cu8suN1QQO0Z1dLhSLz3q7h2Uc1/vSl2WJNcX
	 hE9Wxbm2byE0054Nn6wOfl6yxsexzOfjw1yw+0kOW05l7CXE/doAmIyEh5Ul5eFBA4
	 xzw6VyV0pxRegFBvPoxNcpzxFxAVeUm+jrE1as9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727318AbfCLRMK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:12:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727223AbfCLRL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:11:57 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38C28206DF;
        Tue, 12 Mar 2019 17:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410717;
        bh=8mY5KHVtibOZlB4ZnARHtsed2sk1nZcvBwJd82aM34E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a/iR16CxLFRGLa2AZcSx5yUpa2+FNyo7tPfnHGSXZUI/YM1qkljs1uOvc4J6QqE3p
         LxM41BnvdaZ/Sff2xs52600Vak0gj7tANXQXF7B5bhD8TOi7wuMrH3RR9jrAosHbSa
         5gMf80+UzXxAMmewWlR7nUZ90VSR830MD1nVjxZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Yonglong Liu <liuyonglong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 032/171] net: hns: Fix for missing of_node_put() after of_parse_phandle()
Date:   Tue, 12 Mar 2019 10:06:52 -0700
Message-Id: <20190312170350.786672708@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170347.868927101@linuxfoundation.org>
References: <20190312170347.868927101@linuxfoundation.org>
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

[ Upstream commit 263c6d75f9a544a3c2f8f6a26de4f4808d8f59cf ]

In hns enet driver, we use of_parse_handle() to get hold of the
device node related to "ae-handle" but we have missed to put
the node reference using of_node_put() after we are done using
the node. This patch fixes it.

Note:
This problem is stated in Link: https://lkml.org/lkml/2018/12/22/217

Fixes: 48189d6aaf1e ("net: hns: enet specifies a reference to dsaf")
Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index 6242249c9f4c..b043370c2685 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -2419,6 +2419,8 @@ static int hns_nic_dev_probe(struct platform_device *pdev)
 out_notify_fail:
 	(void)cancel_work_sync(&priv->service_task);
 out_read_prop_fail:
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
 	free_netdev(ndev);
 	return ret;
 }
@@ -2448,6 +2450,9 @@ static int hns_nic_dev_remove(struct platform_device *pdev)
 	set_bit(NIC_STATE_REMOVING, &priv->state);
 	(void)cancel_work_sync(&priv->service_task);
 
+	/* safe for ACPI FW */
+	of_node_put(to_of_node(priv->fwnode));
+
 	free_netdev(ndev);
 	return 0;
 }
-- 
2.19.1



