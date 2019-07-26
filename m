Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE70C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6873822CB9
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564154838;
	bh=BXoVL70uyHqrbLPJEtaZuhY2haiuS7rbcpUMXg0lr5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JarliE1T9AMjPbmNxP7PCLErFpKfmz/lvU9tNPY3VapXssPONj17yvBQbeJhvTeJl
	 kuHIqI0KDVAu8vUVzVdCtb4fuG3+lP74MUJfwTz+A5+B/rsBopRY1hJrGb4yujwSaR
	 IgZk4dQfO+76jRqPz2lzGx/7+Eoh+EdNNhiPBOqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388266AbfGZP1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:27:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388233AbfGZP1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:27:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8CC22CBF;
        Fri, 26 Jul 2019 15:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564154833;
        bh=BXoVL70uyHqrbLPJEtaZuhY2haiuS7rbcpUMXg0lr5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tO5GjJIVGTNYQDY6XxmDNhbZNeGjq/gld92rkBmdwxnlvpDVAuN6W16bHfvILu1HI
         zGzLdj+HfLwKPGGDa9d1mKGgmYXe36dGEVX9qUVoinAs7DoLAH6jkB7clt9d2y32DR
         rzSLVSGoBl7P0o4QPf3H/CBDc4eBcevJRY9zv3WQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 09/66] net: dsa: mv88e6xxx: wait after reset deactivation
Date:   Fri, 26 Jul 2019 17:24:08 +0200
Message-Id: <20190726152302.892794279@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152301.936055394@linuxfoundation.org>
References: <20190726152301.936055394@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baruch Siach <baruch@tkos.co.il>

[ Upstream commit 7b75e49de424ceb53d13e60f35d0a73765626fda ]

Add a 1ms delay after reset deactivation. Otherwise the chip returns
bogus ID value. This is observed with 88E6390 (Peridot) chip.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4711,6 +4711,8 @@ static int mv88e6xxx_probe(struct mdio_d
 		err = PTR_ERR(chip->reset);
 		goto out;
 	}
+	if (chip->reset)
+		usleep_range(1000, 2000);
 
 	err = mv88e6xxx_detect(chip);
 	if (err)


