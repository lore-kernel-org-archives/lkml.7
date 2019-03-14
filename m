Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6636C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761542077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="JbTQSV5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfCNU0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:26:32 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:50536 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfCNU0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:26:31 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 0C451CBD
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:26:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V3UfHmBZQuKa for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 15:26:29 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id D8BC7636
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 15:26:29 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id q184so5706254itd.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=xdslacYhQZZKNwXnMb2h8BZbjck81jlgr4zK4v0NdbA=;
        b=JbTQSV5Hyh19sOg1dc9TbvTLC8+tmJYTFcShuNIhYcVy3UWfjqFKJzxaruxGTk8cxC
         rgWRoRQSgfKMI5W1395xJOBm780JCTo12fjFqhYEF24nFczsaXQDyBHQCftvQ/X1IuZ6
         d+3DJxL71/lAV/V54Y1OYMI3gAbehPY0T19H1bYRNPNSeWXBtBOETzbHUvVyAn92DbQ/
         IfUTv1iVuj0TaGA/zJgW4s16jmmNLhVlrec0V98sa7N8rMKXL0PRsKHDr5DwZrVgQlEI
         vLQaqO4jQhAUi+tzUjeX4uKtYEPJ2Rvfb1aFaR19YPdRAXWfzruR8B/4T1zCTtwDg79b
         t+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xdslacYhQZZKNwXnMb2h8BZbjck81jlgr4zK4v0NdbA=;
        b=ibKG7Wx0yk0QGG4CjncBVfQRDEuL9as4Mny+6CfrYw60kP8rjJ4Q4Dx7HpFJB9KRAb
         dC6IeRri6IhIJvifhZdnOpsFa++vYB7bf44PaCoiTwkrnYs1qNibsSFrLzASWUjqizBa
         R7K3SNmckG1FaVqhHogVjBj9p8fXK8oAUAN61hROAU4x2BIz/IjeEDOxXeBwWL3zeXOc
         YJdWvO5S6xBooey/ObewPz4vX0xbHIdFAb8IdOvR6T+f7epp/PZV+bAe/8wayDaUAJgM
         pcc+KOKGUNlp3HZrY/uHQDRjQTbtylbMWzPk6qOVkR6r2cZDec6+VaguaJ78ZH4rGg1b
         42jQ==
X-Gm-Message-State: APjAAAUjrZYhEauPRbQ8GsbqbAXihrfw9AA8yU4zLN9vsQRXsNevJIla
        1WbyBBFypgbgTYol4I1RNHt/xvLJPNGNC+m4/LQFFqGLifJXnt7qxCqPXS5/cRJ+abnQJ73PG8s
        wLhxFvaBx0Ybz/kXS2BWgKy04Pwws
X-Received: by 2002:a02:7124:: with SMTP id n36mr106731jac.122.1552595189473;
        Thu, 14 Mar 2019 13:26:29 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyloQrhIseeEK985E9nkNOQAHiHsZXoQARzJnvlBZivM/NtZ679E/10r1Lkfk74+ssu1c7Q8g==
X-Received: by 2002:a02:7124:: with SMTP id n36mr106719jac.122.1552595189259;
        Thu, 14 Mar 2019 13:26:29 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id g2sm20947iom.7.2019.03.14.13.26.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:26:28 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Shahed Shaikh <shshaikh@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qlcnic: Avoid potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 15:26:20 -0500
Message-Id: <20190314202620.19767-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

netdev_alloc_skb can fail and return a NULL pointer which is
dereferenced without a check. The patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
index 3b0adda7cc9c..826571029b21 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1048,6 +1048,8 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
 
 	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
 		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
+		if (!unlikely(skb))
+			break;
 		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
 		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
 		adapter->ahw->diag_cnt = 0;
-- 
2.17.1

