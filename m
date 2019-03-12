Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A460C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC17214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="nHSku0XL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbfCLHuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:50:51 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:37342 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbfCLHuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:50:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 95A1EB3D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:50:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MtEkdF2mJE7E for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:50:49 -0500 (CDT)
Received: from mail-it1-f198.google.com (mail-it1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 60BEDA69
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:50:49 -0500 (CDT)
Received: by mail-it1-f198.google.com with SMTP id v125so1458782itc.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=cCzogPH+NILYsqX4kJaeZubessnMrupncJNs9YIpvCw=;
        b=nHSku0XLPT8YAk3cPSEu5ouAgNXBY137dQqHd7glQY1duamQeYYEYMMF8EbxnAQiW4
         BSgPlerCbgnEeLV2mivsCmK+ZAo9x/hsQv/WJEiq2iIG7ogyy3UhBJZd82rwafWRqlp9
         7itDVVnNCWCtUxYY6Wpv0NkqTOpIC8u0NrIUiucmlT+bov+QrXc+1lI03+7IIomUWBIu
         b6ldMUpfSXaQogsfwYKZ93I1cTZ/wAiiF5LN4ngWcUj8auo5mh/Nb/hcMlacCAK320/e
         kgjwCcTEmvruFRJmxksIWoA9t/szI88I+8M7Up6bM6KwfyMAGyR9GCX8pJRS5f1rXsLs
         VSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cCzogPH+NILYsqX4kJaeZubessnMrupncJNs9YIpvCw=;
        b=IRf5pa4uJqrpxuT0zT70eIqXM3PgI7090qdjNqGOYZ3c0y+pgt3b1eCPgoZ7Cy8ybh
         4e3WrMq3hh+WFDKOhHc0bggeZZ9DRZzUy/XnP0Mea7uayoQKLSC5d82PK5o/ZRgCwjaF
         i9VitM3USx43g/J+wgr4+ZWXecLvSyAa5Y561/DyUTN87111Tly3Kj30wZLH8/MJKHZH
         eidPBOMo0q8mUBMenSUFgKocw0awCZu2NyR2K1GvIkpMfGTzFMC0TBT4mNxjwT5anHgf
         XTpalznv5YFtbSLD2w+FFYoudXs2bKe79vW4+057ntZWSQ7RP4lYGP1OZCoP+zZhcvZZ
         Dl6Q==
X-Gm-Message-State: APjAAAXLkdTjxNNxflOcBjvyDUQlP7zkd5ZjvXzybAMshmnHvcZPWcLq
        ySrPRkqQ/iu9U9m/u/3/uamSkBuYVyOihztUuaTSVCltLZT4ogwYxLBCsU3vKe15er5FWeNYXLk
        ScQL/5BRp7eC6REeIwKS4xNP7zO0l
X-Received: by 2002:a5d:93d9:: with SMTP id j25mr20449496ioo.305.1552377049005;
        Tue, 12 Mar 2019 00:50:49 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySKdTwSbF12uEqKV+X5R0H6vQ6AW+F8lgxZfBZnn/CNF8EZx5T4x9srmlhOqht6eSmWxveLA==
X-Received: by 2002:a5d:93d9:: with SMTP id j25mr20449475ioo.305.1552377048729;
        Tue, 12 Mar 2019 00:50:48 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id c14sm3409784iot.13.2019.03.12.00.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:50:48 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: dwmac-sun8i: fix a missing check of of_get_phy_mode
Date:   Tue, 12 Mar 2019 02:50:40 -0500
Message-Id: <20190312075040.32115-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_phy_mode may fail and return a negative error code;
the fix checks the return value of of_get_phy_mode and
returns -EINVAL of it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 0f660af01a4b..195669f550f0 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -1147,7 +1147,10 @@ static int sun8i_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	plat_dat->interface = of_get_phy_mode(dev->of_node);
+	ret = of_get_phy_mode(dev->of_node);
+	if (ret < 0)
+		return -EINVAL;
+	plat_dat->interface = ret;
 
 	/* platform data specifying hardware features and callbacks.
 	 * hardware features were copied from Allwinner drivers.
-- 
2.17.1

