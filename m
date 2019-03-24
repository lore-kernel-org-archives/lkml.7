Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA19FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A320989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 23:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KI2/RLEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfCXXTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 19:19:04 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:58162 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729057AbfCXXTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 19:19:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id C455F789
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 23:19:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id W0TSjDLqiWYi for <linux-kernel@vger.kernel.org>;
        Sun, 24 Mar 2019 18:19:02 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 98C5E2FB
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 18:19:02 -0500 (CDT)
Received: by mail-io1-f70.google.com with SMTP id z19so3007596ioc.22
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2019 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=DF91ha0dMKA4SNjEEqMCAtpvjdqVDKJqxhx+V1bk7ac=;
        b=KI2/RLEUqprR9I3ac1e06vgceq9vpiWtSsx0rNIfJ0w1Cg16RDmmxxmNSCFS6VbbBp
         pi4ov761hFS48x7HGV/2o51keAMe+AOREUcFuhlyEH7FrhHmAjqwH0VjLCceDCFcE8Wl
         q/0f94sgFQHoPT58o0QIjs4I6gLcKN8udcJYXgCP5nQSDW5UaCcSyR96h/WbpgsPWttY
         bj9T1iaS68titJlWB7vvjY7cvNwtn02EAfOadF2MFehQ7K9p4a523G3GdS3mL+p5EtZ3
         YMEjrldZhvkbzOPCeE0xn8esA3hbxSjvTXzwYThrYr/TTwUcThD9ICulbHZ5nKwwUZk8
         jokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DF91ha0dMKA4SNjEEqMCAtpvjdqVDKJqxhx+V1bk7ac=;
        b=mGH1ykakS7jzLpDpM8iAlIGV1BrYSqdEM4PaOF/NRx96w+rrjAYjTRujnDKtX3ifg/
         LJRkg8wTsJu0aDrlnMybb7IcSA4e5bgfzWFdXEjhugPg0bF7fi+nmngTb1CD/eYaxjuw
         03ooOeZKhuU9WcwOVxtqI2EgAACfzk+AmsZkthesCyLxOiSHZLQdSmrk8LhHCcVeUiOd
         8JgE76CoDEsH0KOugtULvMVg7Yb/Spq/uEWaQQ9zL3TCXRxNQ+tJOQWp/Z+/8W5rfJpm
         vixSD666OtCO9vMsn//WyxIumXQgbw9UxmI3QlyV7Qz5XOkZaK2YPhBvmyh4m20PlVRY
         Sqbw==
X-Gm-Message-State: APjAAAUColCf+xWh0HYnThHTU/h6DPO90Wd8/ji8oNWaad6Jn4k8vw5I
        Fhk+Xx/PlPi5+CAiEBcqsobbOxuo9CbNPvQK8LPYSOyPLpGkzM3T4HxVx+hDuLw4KOHY+73Hla5
        Fz8ypZ55ZO2Z9ZNJGrbYRAkUmGbgv
X-Received: by 2002:a24:640d:: with SMTP id t13mr9096362itc.38.1553469542276;
        Sun, 24 Mar 2019 16:19:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyFQuXEad+2wsrWluMo+QJPb3mFhvyjTn+307I6YvAJC5ILc62zh4cQPSGe7Xoyiwkmxaa2Kw==
X-Received: by 2002:a24:640d:: with SMTP id t13mr9096358itc.38.1553469542100;
        Sun, 24 Mar 2019 16:19:02 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id h131sm4948542itb.6.2019.03.24.16.19.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 16:19:01 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: ieee802154: fix missing checks for regmap_update_bits
Date:   Sun, 24 Mar 2019 18:18:56 -0500
Message-Id: <20190324231856.2664-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

regmap_update_bits could fail and deserves a check.

The patch adds the checks and if it fails, returns its error
code upstream.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ieee802154/mcr20a.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
index c589f5ae75bb..8bb53ec8d9cf 100644
--- a/drivers/net/ieee802154/mcr20a.c
+++ b/drivers/net/ieee802154/mcr20a.c
@@ -533,6 +533,8 @@ mcr20a_start(struct ieee802154_hw *hw)
 	dev_dbg(printdev(lp), "no slotted operation\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_SLOTTED, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* enable irq */
 	enable_irq(lp->spi->irq);
@@ -540,11 +542,15 @@ mcr20a_start(struct ieee802154_hw *hw)
 	/* Unmask SEQ interrupt */
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL2,
 				 DAR_PHY_CTRL2_SEQMSK, 0x0);
+	if (ret < 0)
+		return ret;
 
 	/* Start the RX sequence */
 	dev_dbg(printdev(lp), "start the RX sequence\n");
 	ret = regmap_update_bits(lp->regmap_dar, DAR_PHY_CTRL1,
 				 DAR_PHY_CTRL1_XCVSEQ_MASK, MCR20A_XCVSEQ_RX);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
-- 
2.17.1

