Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50614C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122A821019
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049647;
	bh=/IU/97Io16xqOkIdt1dUc2zfYHPtAnTd1RbOUNQ8XMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dFvMeOC7Ci3h1PfwQNS5yFehJ/P7lgioAHfoUHA64Pb0aBAZixUIUt5QSJzYdG+Jw
	 aWyg7BXWnjOwf+yUa1do4h1v8XzZNVN4av6to2pS65Rz17dQ0L299+QB4Oqh1fUPGK
	 CmlQIeLBYAMKMkGsxB6rizkPNkP4XEWxqg16kpY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfCHMyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbfCHMyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:54:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 093F120449;
        Fri,  8 Mar 2019 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049642;
        bh=/IU/97Io16xqOkIdt1dUc2zfYHPtAnTd1RbOUNQ8XMw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1n606wcy08p+zmnMLv0tOb9Lk2QOsfccYo2TptAhp7wWcYj1/LIbOQJnnqhSTsKLk
         M+JFdzJ4IikOua8ThUbe+h+MI101GErb1mXTm2kOrvHFD0CMs+S10GKCDKSWEIT7KR
         yAkizCUE51n6esj+GlqmuG09ZdYvgFFwMZtvvGD4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 19/76] net: dsa: mv88e6xxx: add call to mv88e6xxx_ports_cmode_init to probe for new DSA framework
Date:   Fri,  8 Mar 2019 13:49:31 +0100
Message-Id: <20190308124915.462229325@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124914.789210760@linuxfoundation.org>
References: <20190308124914.789210760@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 3acca1dd17060332cfab15693733cdaf9fba1c90 ]

In the original patch I missed to add mv88e6xxx_ports_cmode_init()
to the second probe function, the one for the new DSA framework.

Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4821,6 +4821,7 @@ static int mv88e6xxx_probe(struct mdio_d
 	if (err)
 		goto out;
 
+	mv88e6xxx_ports_cmode_init(chip);
 	mv88e6xxx_phy_init(chip);
 
 	if (chip->info->ops->get_eeprom) {


