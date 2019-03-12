Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 496A0214AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 06:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="jWGw53lZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfCLGdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 02:33:11 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:53570 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfCLGdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 02:33:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 7E1B2B35
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 06:33:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qqg4UlefxG9M for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 01:33:09 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 4A139B32
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 01:33:09 -0500 (CDT)
Received: by mail-io1-f72.google.com with SMTP id k24so1042866ioa.18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 23:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ha9PW7pIPJPn/3E35z3kTO9/Th37iu1RWxZGXsOeCtg=;
        b=jWGw53lZcMw7+b3WK4goiihsxr7OqN+Auv/UvXG/K13EIP5f+cOiWxsUEq9odYb4M2
         XvOEGEZToOxyZhhTCIiHEJkYRNPDizZEIw6fu7SN4ZcGB3NeDUtWm4wqo0hpeGIKKyPb
         YRxDp1zrrnS2B3eFlYq5RKun/Ijmhm9i0AFo5E8zUTrlJSKDgMs+lSqoAvBqBU/Xh0vH
         IzSD2DlaoZZ2diMf1Cyca/zr0ryO3CBNuoUEuz9X+Mk2QUs5d/vhJPCV3u4WBj0AvMr3
         CigBfr54gBncNW0yhoTirEKoHvZlyy5ZGFe6MB1ETmam2r3HUvPfGH1twc+iZqN9M7k8
         bSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ha9PW7pIPJPn/3E35z3kTO9/Th37iu1RWxZGXsOeCtg=;
        b=ZKKX5BXMAQJEN7Px0QBFbJPUuRa9c0H0aU7Qx1QJ3eOMZxuiu0TXb8edA2zr7vNtCX
         KX4Lg18hVGrTkxbzJUY11wEbBF8/q26CxUGdQoiYdRmTPFbxIW/4Rh6plxOzq7tJ0AXs
         FPipI7Xnr1VFylojM4svniQ9cwJksC9cjDs8J8K+Cr6sSn0GlRNsxWOeUp8KHN0DkNXK
         SCAePJmbuWAihzTf3q/lA5AYwnwEXzLIQgIqcwQWuA4Ly2IvgdkbLQCIGZkLfABIejzB
         JzuDBJ0ifasXXv1U2OvqmRVH2shp2Lhq8eZuM88hcTTXzoyc479sLud8dXxJaIYFWm6E
         ouRA==
X-Gm-Message-State: APjAAAVlDfC02/vY4lsAiqD16ZyUA/9bIFQk3Hf1jwp5GSQJcnxoySz2
        TTxhYsjrHQSCOl5KZgh2VkwgamtYCX5478XAEYV5npTDWhM50IZ9ELK31/LGJ/5sSuaQc6tOcQx
        pRovRar/pVBSYdP76DK4fpbMpL+hq
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr9689464ioc.291.1552372388768;
        Mon, 11 Mar 2019 23:33:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwJKL43alLWjqG0b6skYN7rnA1g31yJYG8Wi9Bu3Xc6MwUOEVw6D/gxFoQ0Q+dN5gP/rfYZEQ==
X-Received: by 2002:a6b:ea19:: with SMTP id m25mr9689450ioc.291.1552372388470;
        Mon, 11 Mar 2019 23:33:08 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id p18sm897264itp.10.2019.03.11.23.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 23:33:07 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: sh_eth: fix a missing check of of_get_phy_mode
Date:   Tue, 12 Mar 2019 01:30:24 -0500
Message-Id: <20190312063026.15083-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <c205461c-edb1-c9c1-a928-8068374aef2b@cogentembedded.com>
References: <c205461c-edb1-c9c1-a928-8068374aef2b@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_phy_mode may fail and return a negative error code;
the fix checks the return value of of_get_phy_mode and
returns NULL of it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/renesas/sh_eth.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 239eeafe1b2d..e33af371b169 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3181,14 +3181,16 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct sh_eth_plat_data *pdata;
 	const char *mac_addr;
+	int ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-	pdata->phy_interface = of_get_phy_mode(np);
-	if (pdata->phy_interface < 0)
+	ret = of_get_phy_mode(np);
+	if (ret < 0)
 		return NULL;
+	pdata->phy_interface = ret;
 
 	mac_addr = of_get_mac_address(np);
 	if (mac_addr)
-- 
2.17.1

