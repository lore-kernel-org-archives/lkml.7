Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012C9C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35A220862
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 17:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZMXitLT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387935AbfFJRJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 13:09:00 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3320 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387638AbfFJRI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:08:59 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cfe8ea80001>; Mon, 10 Jun 2019 10:08:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 10 Jun 2019 10:08:58 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 10 Jun 2019 10:08:58 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 17:08:57 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 10 Jun
 2019 17:08:57 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 10 Jun 2019 17:08:57 +0000
Received: from dhcp-10-19-65-14.client.nvidia.com (Not Verified[10.19.65.14]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cfe8ea60001>; Mon, 10 Jun 2019 10:08:57 -0700
From:   Bitan Biswas <bbiswas@nvidia.com>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        <linux-i2c@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@the-dreams.de>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     Shardar Mohammed <smohammed@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mantravadi Karthik <mkarthik@nvidia.com>,
        "Bitan Biswas" <bbiswas@nvidia.com>
Subject: [PATCH V4 5/6] i2c: tegra: fix msleep warning
Date:   Mon, 10 Jun 2019 10:08:34 -0700
Message-ID: <1560186515-30797-5-git-send-email-bbiswas@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560186515-30797-1-git-send-email-bbiswas@nvidia.com>
References: <1560186515-30797-1-git-send-email-bbiswas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560186536; bh=Qae36JSCpcTdcklRmVE7XBNUMoQSDDFmpYRBvHliYh0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=ZMXitLT20ZzWCVKlrbOq88GKyghIfXWYrl6NU8meERN+Sevk6C6g6jw9fUn4Ll32R
         rPWPd7yu8i7LTPndq89pOq1B8nQkC8TGN3R8NCyxtlFdK65U2EdZvIqTcFUjnc1wDk
         /1LgTZglIUZNMFLPCY5dUYSasgDbO8vMJ87Z4xQ6j8MmcwqSlHvaFAiG4+9pVpGl8o
         CpFS11B2daLQWNGdGHu5oWzF3jcJpYp56a3fwHODTTcM5flJx6W5C1uAxG5XRVCLQw
         HevU6ighyGtWB38Iw/5YS/skectsaYmQl6pj5xCWQTh77LcTp25mG9k6Er+6djwjgZ
         LuYs1vYoYbpSw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix checkpatch.pl WARNING for delay of approximately 1msec
in flush i2c FIFO polling loop by using usleep_range(1000, 2000):
WARNING: msleep < 20ms can sleep for up to 20ms; see ...
Documentation/timers/timers-howto.txt
+               msleep(1);

Signed-off-by: Bitan Biswas <bbiswas@nvidia.com>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/i2c/busses/i2c-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index bececa6..4dfb4c1 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -476,7 +476,7 @@ static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
 			dev_warn(i2c_dev->dev, "timeout waiting for fifo flush\n");
 			return -ETIMEDOUT;
 		}
-		msleep(1);
+		usleep_range(1000, 2000);
 	}
 	return 0;
 }
-- 
2.7.4

