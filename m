Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D46C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C706D205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 07:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="pLBwS237"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbfCKHBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 03:01:46 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:48214 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfCKHBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 03:01:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 8F4339B9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 07:01:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mG7sF-_A_l1Z for <linux-kernel@vger.kernel.org>;
        Mon, 11 Mar 2019 02:01:44 -0500 (CDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 591FC9A2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 02:01:44 -0500 (CDT)
Received: by mail-io1-f71.google.com with SMTP id p17so3457401ios.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 00:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=KlxYLl9A5+lfbSkhTvNH/NPSfz6/FOooyJkl4ukt/HI=;
        b=pLBwS237v3GmbibpSvNDgYl9MJ+Mc3N9xHzn9ZSfExW3xYAhsnAM2pj/AaxN0zQf5M
         DgmRXiYB+EkBZlhwtiDLe1ePpVDqzayr37navfsjQ7TpbqmTcixT4Hzi4afQME8Aoi+Y
         oOWIxDSgUhKZY0Qnk8A7FDp6CjL3opI5pZmbG0LN3ChTm483atvY8yEjuXpKFPDW+5x0
         y0vXwxS0ht6WPpgPTsKuzWXrSVX19V0jtDH+OYmqSE+q/60Fz1wWLK502CUM0VQHyoal
         nle4Yiawho6M8J8+Mp09ZB+U2xUEIjlL5RoxtkapGXc+EmO6+XriW+VxndUD3UM+tlGA
         PbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KlxYLl9A5+lfbSkhTvNH/NPSfz6/FOooyJkl4ukt/HI=;
        b=GZDDdTScaVodDUWtAa5dJ7pj4QJakONMUvfdrAhQEH3xjSbM8bcdAVkM9iIwP5ozRR
         pa9sF7fbD+x8yERDL3YahStL3IV+pDmUYPP3reGQghqc3phLzl2xVEHvRD4ZxJlih+HO
         huOefpn5PyrXyKCxGyQK88YM0b6rcCPziM9cdrwcqXcWbdqh3/fOXgvifrgnvm2YkbM7
         c4Idwlg5rspdObul8X46tziKtcnBiF1A5AN55sxV8MOmB1RTpTSuOE6osJ15bwK96PVk
         QXEzLq+CPnV6/IHByrEIqfyvqlhygftTN54Yz9PTq2w2KmybGbodXpOyYseXPlU2wid7
         dgrw==
X-Gm-Message-State: APjAAAW7+StRxD0Nx/GCywkyXjwG/nDFF0yMZcppQIpPOlXmALKdaPD7
        gekiA0zwFPFZOI3rvVHq1v67gltjIzcF/tecVn52Xe/C8D/iK17spE/wLl5Nmivtop6/+Rgm6+G
        eYZXFQGqfPStBMrTZfFT8ENtSx0LI
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr4044011iop.33.1552287703998;
        Mon, 11 Mar 2019 00:01:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoDxgrixltTM9JSqenvK/ZXS61q3HNAGzXHJC3KNsYgG5nhMY2tKYLyjwgh0RsRcE4NBBdEA==
X-Received: by 2002:a6b:7b08:: with SMTP id l8mr4043993iop.33.1552287703775;
        Mon, 11 Mar 2019 00:01:43 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id e10sm1283881iok.85.2019.03.11.00.01.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 00:01:42 -0700 (PDT)
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
Subject: [PATCH] net: renesas: fix a potential NULL pointer dereference
Date:   Mon, 11 Mar 2019 02:01:36 -0500
Message-Id: <20190311070138.24084-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case of_get_phy_mode fails, the fix returns NULL to avoid
the NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 339b2eae2100..b119587ec673 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3187,6 +3187,8 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 		return NULL;
 
 	pdata->phy_interface = of_get_phy_mode(np);
+	if (unlikely(!pdata->phy_interface))
+		return NULL;
 
 	mac_addr = of_get_mac_address(np);
 	if (mac_addr)
-- 
2.17.1

