Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD5C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B758214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 07:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="FIzlxwN9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfCLHn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 03:43:28 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:36284 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfCLHn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 03:43:28 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id A83ECB29
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 07:43:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GV0ZuB5bs68M for <linux-kernel@vger.kernel.org>;
        Tue, 12 Mar 2019 02:43:26 -0500 (CDT)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 7E688B4F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 02:43:26 -0500 (CDT)
Received: by mail-io1-f69.google.com with SMTP id n23so1181900ioj.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 00:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HK4OgZu8mL7YFH8Yn0UTw5ixDE3nD8LIl5Uy8tZDA/Y=;
        b=FIzlxwN972Iz/55dCn1E13EbXP6a+3Y7ZiOmR9NYOke2xNh1yBVobWkAH6E3bdVTct
         naSIpKEX2W6e+UF+RBx3qbd8mB6w/ZplLRg6ZFcXlvIUmIIFUa5IVeHvlUaRZR6DH25R
         v0cI2DeLoVtck3+vUYLIDlQEksqclKxo/JO9mhEpvrF/igrDEw3IZFJty6YnFOxKPMsJ
         aJMEeTo1RS/xGzpmngvOW0pRj6K0xMdCwlSccK7RwEKA+r6ZMiJqFBh+bytVsJgWvvg3
         ct+F7NjYW4C65KMVimONK/oPmx422miLro3NaWHs84Yp00fw1FKcuZFzGqkZuuTUB9T1
         mFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HK4OgZu8mL7YFH8Yn0UTw5ixDE3nD8LIl5Uy8tZDA/Y=;
        b=diOo6om0ZuyW0GIEaSI+ZUkLMAfwHoIkFHGxwHScaCZEgvdw3zI3+SmI3ZvXvOWeSw
         XoIx87jQpUMbFHC83J/rCqX2KYXjBmNBHd0AVuTdezaFb6nz8rPBx7xfk3/Qk6pbaC/6
         JU9EEpFW9K0TVnuaWXzYiKMO+2yTAmnt7YVNTPKfIX9EGcjvdbsmjITdVmZp4pARxm08
         7+a4Fd93lV8Y5tye+9ri+VKmsh9BDTyahGhyBI4yYsomHK6/P010XKU8n7z+T6YaLYHC
         tAx6HzLcR57tE9HtXOwMhkrxhnbRO/8ZhaLH/FEJdxUvvlHOJyGt3z/534564P4N+6hk
         0WPw==
X-Gm-Message-State: APjAAAVX3otb4acLyCK8unEqs3jSL2beUgGzQA/rzL2/eupvRpNdID6x
        7b8DY/L5335U/iaf8oDjB60gG7PVgQpdK2NRIynW4cm7QgclJ/+Opge9dz/+ywIPHA8LKjD2GKA
        THBAaHK3mXANg7N0sMbRqE1fsqXn3
X-Received: by 2002:a02:5c5d:: with SMTP id q90mr20323724jab.43.1552376606046;
        Tue, 12 Mar 2019 00:43:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqziIx7hZfdJDBj6/W2JnnoJkCYiPoh9RbBR3Wm4yETXKdgKbSVaonw3ZY1vqTOZCdJf1EARlA==
X-Received: by 2002:a02:5c5d:: with SMTP id q90mr20323718jab.43.1552376605768;
        Tue, 12 Mar 2019 00:43:25 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id y3sm964418itb.2.2019.03.12.00.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 00:43:25 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: sh_eth: fix a missing check of of_get_phy_mode
Date:   Tue, 12 Mar 2019 02:43:18 -0500
Message-Id: <20190312074319.31161-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com>
References: <902bc3a0-94b5-cf00-6b41-f2724744fbe6@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_phy_mode may fail and return a negative error code;
the fix checks the return value of of_get_phy_mode and
returns NULL of it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/renesas/sh_eth.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 339b2eae2100..e33af371b169 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3181,12 +3181,16 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 	struct device_node *np = dev->of_node;
 	struct sh_eth_plat_data *pdata;
 	const char *mac_addr;
+	int ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return NULL;
 
-	pdata->phy_interface = of_get_phy_mode(np);
+	ret = of_get_phy_mode(np);
+	if (ret < 0)
+		return NULL;
+	pdata->phy_interface = ret;
 
 	mac_addr = of_get_mac_address(np);
 	if (mac_addr)
-- 
2.17.1

