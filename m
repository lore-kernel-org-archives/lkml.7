Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B16C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDD22186A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="TmTCtb98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfCNUbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:31:51 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:58570 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbfCNUbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:31:50 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id EDA97621
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 20:31:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id inUuHyZKR0qS for <linux-kernel@vger.kernel.org>;
        Thu, 14 Mar 2019 15:31:48 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id B8A27B97
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 15:31:48 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id v12so5704137itv.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Ketx5lcPbjs2u5cL2yD0+SQZEso5pjEXT5x31vv+J6o=;
        b=TmTCtb98Tw5YQJY0GsXj3Jv+MXr1sTDFYd7Qz4MlcpWWO2SHT8GzmwsUufIs5jukOI
         ptsvWpiGLnp9FklPqgAsXJ6SwzqaJqtq8fqgPN5HsAvpBCjwuH0SQtVemcKkT09onyHM
         b4C1tVuW4feorv3lXPqcCCjbSNgc+UqrDI1nrKH/rk/WbU/oxhU8Jzn5SmFAQhk64m0S
         OmvL9b3YgpwFs5UjwPdxeVq5GqFua0wrxfD5x5K5kffOjUmve+uJBYxvbLmgSvI9qHBg
         3FRxVSbk5EfrohoOtpghInBFE8IScJqIITjl6AEghPx7+BszCUVF5fdiiBWobC3LHzFY
         QvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ketx5lcPbjs2u5cL2yD0+SQZEso5pjEXT5x31vv+J6o=;
        b=U8aTrVik62fQV96QbdPSLBMedmtiYJQJWMM1V5UARpi7iVJ2fTYF+kUN8hGeLcEbAA
         BjUkticIHe9bGfBOWUIBVhfSq7nlZcWRUJ2yGWwlss1zsFSDgKWlPMETBkJomd0cu4Eb
         HwAJlbV7dGQPAL9B5St/NfQgS0gSrBZx/VNGa1DmA7BsQBU5SeCLzdvsD92+ELIdWERa
         vwZPeU78jqGIjkoaz+K0f8vmvUq1jBZk6TU4BDCdYpNiXiSeeQC176ejOsx8tL3PghQ4
         6FtIIMmbPC5CJft1PnMRyS49oIFAvDn8w1+ekGOu0emBM6wQpaJ+ffNKYd85aJU36xwX
         5CFA==
X-Gm-Message-State: APjAAAXdsiSAPn14Aup3EcOw0by9tIg6Z1BHjKrnrdRSrExQZFWTx4jH
        7XYZcURik8qr5vFVATXID8VrhXngG85BVLFcY+tBtCAFA8yEYjIv0B+VirrCz3GpBCIF23U3ng4
        MUKmsFnORBVUQg5P/VR345lLH9rD7
X-Received: by 2002:a24:5589:: with SMTP id e131mr290381itb.94.1552595508360;
        Thu, 14 Mar 2019 13:31:48 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwRl2xiH+mN7l05XuXgraDdSGX/ixT/ad3M6UK4mzRRrpROzcUTFZx7XG6D9o7n0Q4XidYSWA==
X-Received: by 2002:a24:5589:: with SMTP id e131mr290371itb.94.1552595508163;
        Thu, 14 Mar 2019 13:31:48 -0700 (PDT)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id l131sm1893806itc.17.2019.03.14.13.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:31:47 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Shahed Shaikh <shshaikh@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qlcnic: Avoid potential NULL pointer dereference
Date:   Thu, 14 Mar 2019 15:31:40 -0500
Message-Id: <20190314203140.20039-1-pakki001@umn.edu>
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
index 3b0adda7cc9c..a4cd6f2cfb86 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_ethtool.c
@@ -1048,6 +1048,8 @@ int qlcnic_do_lb_test(struct qlcnic_adapter *adapter, u8 mode)
 
 	for (i = 0; i < QLCNIC_NUM_ILB_PKT; i++) {
 		skb = netdev_alloc_skb(adapter->netdev, QLCNIC_ILB_PKT_SIZE);
+		if (!skb)
+			break;
 		qlcnic_create_loopback_buff(skb->data, adapter->mac_addr);
 		skb_put(skb, QLCNIC_ILB_PKT_SIZE);
 		adapter->ahw->diag_cnt = 0;
-- 
2.17.1

