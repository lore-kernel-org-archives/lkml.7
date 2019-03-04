Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1439D20663
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 23:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KW00z5e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbfCDXgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 18:36:38 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:44268 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDXgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 18:36:38 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 53EAD707
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 23:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wyZJGcMa-umZ for <linux-kernel@vger.kernel.org>;
        Mon,  4 Mar 2019 17:36:36 -0600 (CST)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 24B76151
        for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2019 17:36:36 -0600 (CST)
Received: by mail-it1-f198.google.com with SMTP id 190so810080itl.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 15:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4tGCreSBZDaFxjT/bNRD0L/Mus0ZRPPRaDZGQQ8UJ7o=;
        b=KW00z5e8R8g4mp76/B3rb77voxAwHWqWtg9mvGCA1oPjNJSEMtbOEPg2lbzW93MZqb
         f7Q0e+F+qHAEGb5xf6l7x3hK3wqStQzxX2Kx+PIzEZ6PL4cawF/7mX+7g9qugw5727+L
         BeHtyXOuIj2NRek4ro+x0Qh19tOb4FCEE02053DXKHz6efBVdSRYfug5076vTKrIse6p
         ChRkxrKI6n8ndQ2YPYTnHyXSdO8Q/i0ezXNo9Kdp8QKBrt+0FbAJJsPMOGWUCUU4aZA8
         BUuoovcz612FLnIjwQLHcZDxQ4GYBaJ9pi5McXToFgO8Mabc/EkL673GuUj2APs7aXhB
         3Acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4tGCreSBZDaFxjT/bNRD0L/Mus0ZRPPRaDZGQQ8UJ7o=;
        b=U8Avw4+7vJdmt2mGdxC8qHVQrLEYlMafnx+oESz6RA5WQxuOWqwl06QRXk/2QfOxpv
         VihT7imf3lvkwuULbeb+J34rUQC8u3Wxu6yPUzAaB91iL2Edr2PUd0RSUt5MnmOrqZmF
         NxyW70i5kdTIvVINuzU/+o0vMmh9oLtVLIGRVVupRw3DspiZYsZzfXB/PYO/LVPNShbP
         NR0onYKge078i5xMT8Lj2vjL+M5y15qyq2fO3Fj//AAzV/VshQn9TaBTqZWf76ZiKrkX
         K7ZciN/MQ9bSXs5CEitlqElnikd4yIGTXtsyGX45P+WoyVT0Qz/QW6KJonFDS9wK7TPN
         45kQ==
X-Gm-Message-State: APjAAAVQnwdRAG5PNTZmSXyLKVHq9EMPE7Uk2k9kNwMOHTlJzfT0V7ij
        gkCALavJ0arJL/HS60KqlFh9ZDAuVGVKOOnLeAiB5z5+9ebnvAnvM2end46Zffh04PVze6ew0DI
        ggILEqAfF7mDXDlm4Y8UTQx3zemFO
X-Received: by 2002:a24:730f:: with SMTP id y15mr1102065itb.126.1551742595815;
        Mon, 04 Mar 2019 15:36:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqx0wiXrVNrWRTm0hjM67QyXW6DORG1MojYa25ZExPBhRDUaZnfLuUS6evfQp1m+Kva5CiEmgg==
X-Received: by 2002:a24:730f:: with SMTP id y15mr1102054itb.126.1551742595587;
        Mon, 04 Mar 2019 15:36:35 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id d139sm3898132itc.44.2019.03.04.15.36.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 15:36:35 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ethernet: Fix phy_set_max_speed by checking for NULL
Date:   Mon,  4 Mar 2019 17:36:22 -0600
Message-Id: <20190304233622.13981-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phy_device can be a NULL pointer which is further dereferenced
downstream in phy_set_max_speed. This patch avoids such a scenario.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index aceb9b7b55bd..7eaaecb53aa2 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -213,6 +213,8 @@ int bcmgenet_mii_config(struct net_device *dev, bool init)
 		break;
 
 	case PHY_INTERFACE_MODE_MII:
+		if (!phydev)
+			return -ENODEV;
 		phy_name = "external MII";
 		phy_set_max_speed(phydev, SPEED_100);
 		bcmgenet_sys_writel(priv,
-- 
2.17.1

