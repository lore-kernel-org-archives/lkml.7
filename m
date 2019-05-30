Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68187C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:37:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36FF0249B0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191070;
	bh=DVm8cUoM2GUEV1LjUHxjwniAIsCCEkp6fyjE0tp7TLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Rouk/b1yNI2vd3hqH4hZG6S/jcfJbFgQ9BpZX14YlQqjvj0YbGzMut4Pc3pgRUa2T
	 nn2ZIS4cg5dvuI2xKyM4SDRyQicbdNNifc58qxgz7ANOvN1OFEg0gWw+je/527H2jJ
	 Lr70Oi8Oj6HRpg4fUm1hEVybHELKKcV3KwRWtllY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbfE3DMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:12:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728452AbfE3DLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:16 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18A9F244A0;
        Thu, 30 May 2019 03:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185876;
        bh=DVm8cUoM2GUEV1LjUHxjwniAIsCCEkp6fyjE0tp7TLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ru+9ylJly3vUL9bEBnrMUNVDtOfPPvw5NqAiAH8vfVG8fxoUfkym3vHH5TFE97H0A
         bnn0jLS1YVTsX7++2g9vGK6Uc1xBY/Os7n71nsK2Z17uQQ0o00dWvQj0nZrxFAmXug
         adrkB31ADt0VTRNx1e7XlbRVee6kq/g3YZAmliZA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 222/405] net: hns3: fix keep_alive_timer not stop problem
Date:   Wed, 29 May 2019 20:03:40 -0700
Message-Id: <20190530030552.290139794@linuxfoundation.org>
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

[ Upstream commit e233516e6a92baeec20aa40fa5b63be6b94f1627 ]

When hclgevf_client_start() fails or VF driver unloaded, there is
nobody to disable keep_alive_timer.

So this patch fixes them.

Fixes: a6d818e31d08 ("net: hns3: Add vport alive state checking support")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c    | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8bc28e6f465f1..8dd7fef863f68 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2007,9 +2007,15 @@ static int hclgevf_set_alive(struct hnae3_handle *handle, bool alive)
 static int hclgevf_client_start(struct hnae3_handle *handle)
 {
 	struct hclgevf_dev *hdev = hclgevf_ae_get_hdev(handle);
+	int ret;
+
+	ret = hclgevf_set_alive(handle, true);
+	if (ret)
+		return ret;
 
 	mod_timer(&hdev->keep_alive_timer, jiffies + 2 * HZ);
-	return hclgevf_set_alive(handle, true);
+
+	return 0;
 }
 
 static void hclgevf_client_stop(struct hnae3_handle *handle)
@@ -2051,6 +2057,10 @@ static void hclgevf_state_uninit(struct hclgevf_dev *hdev)
 {
 	set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
 
+	if (hdev->keep_alive_timer.function)
+		del_timer_sync(&hdev->keep_alive_timer);
+	if (hdev->keep_alive_task.func)
+		cancel_work_sync(&hdev->keep_alive_task);
 	if (hdev->service_timer.function)
 		del_timer_sync(&hdev->service_timer);
 	if (hdev->service_task.func)
-- 
2.20.1



