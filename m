Return-Path: <SRS0=q9dy=R2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC06C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AB2218A2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Mar 2019 03:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="EnYJTOQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfCWDjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 23:39:51 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:52600 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCWDjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 23:39:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id B5B58979
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2019 03:39:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O4a0l1Pxs4j7 for <linux-kernel@vger.kernel.org>;
        Fri, 22 Mar 2019 22:39:49 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 89E91DB8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 22:39:49 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id k2so3397905ioj.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 20:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yPe4X+swcjVILKrgufDwWCskIHphXiOXeWYQLTYgrPI=;
        b=EnYJTOQB7pxEQaJ/KryD06HwBrh1AWmGf1WhrtU7AYcRJO25mP3OveDYFo5IxIi70W
         8HPgzXJfNuyWfP0lF7w7/9DbVFaQZ0I5RXRlQE/FiG6qgn1FDAwyQBWrxmrMWkoY2Zh/
         D8UISFl7Cq0k0uexRpeHsZ5l2ta6MYjnKm15KgWNKkyL4COVEHqVE/ch+RpX51F2vSIP
         N8Bx+Jk9kU8jjqZ9vFwMDX9aaqp57hkuMLjAT2h3AYNBO/KoJcnPZZ1adQeGd0ShZm9x
         yAIPYJONyEXhCVofagsTjM7E5RC4Uj5PkQMXicoaX7jqhUf1fpY6b7sBT59vSkDuIqgn
         kNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yPe4X+swcjVILKrgufDwWCskIHphXiOXeWYQLTYgrPI=;
        b=AKAI/FuqeSN7ofWlKthsqwX0AfYfDgHoILjA0WLzl7TTwU/DBFL2C8Z8auDCaDmZ7f
         6qUhnTk9sD1JudqX3BnZt30dVYf+SFm1r/6934y5w/WmyN1QT1T67KAzRKnzFnQRI4c+
         sS/CvyqKjsW5KXsR1RPmyba17zAs4E+ujCg3Rya2WO3j9nrS62eUqXirpHzC+uH+EZ2v
         6FCcKoWtwmkn//SzV0sH+yX0KM3LGAnht9eDxG6O0NRbM9vGGxWut47onVCLxg6rE/gK
         B6qp6W+H3YC2FaSseFjOWGtpRJqV7d5nFe+W2QvI3Jpir+MLLguPtw58eFYC7xM50Cq/
         I0sg==
X-Gm-Message-State: APjAAAVuQ0rZ7cYC+iRDABp6xPvQj/dhfDa4yVrKVmFBIJVEswzvVXk5
        /hEV+y3TIZ1LX4tFf+JFFou2UeBShS/zsmDX1CgM+9vBrBTGNJ9eWpOBYjg100sN37TTWMz3KCc
        iHE4C4ptf7eKwjyHVMdQt3clhWiOd
X-Received: by 2002:a24:5f90:: with SMTP id r138mr860098itb.122.1553312389117;
        Fri, 22 Mar 2019 20:39:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdbHUKj5gmBvxOS+g01uyFCnkZBjgpvDhazyOQ1dSU39WekRj+JjGVHvIPcgayUJFhglibSA==
X-Received: by 2002:a24:5f90:: with SMTP id r138mr860076itb.122.1553312388909;
        Fri, 22 Mar 2019 20:39:48 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id g136sm2378651itg.18.2019.03.22.20.39.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 20:39:48 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: fix a potential NULL pointer dereference
Date:   Fri, 22 Mar 2019 22:39:42 -0500
Message-Id: <20190323033942.21796-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_device_get_match_data fails, the fix return -EINVAL
to avoid the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
index 3256e5cbad27..344ead5949b1 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
@@ -485,6 +485,8 @@ static int dwc_eth_dwmac_remove(struct platform_device *pdev)
 	int err;
 
 	data = of_device_get_match_data(&pdev->dev);
+	if (!data)
+		return -EINVAL;
 
 	err = stmmac_dvr_remove(&pdev->dev);
 	if (err < 0)
-- 
2.17.1

