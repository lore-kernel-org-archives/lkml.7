Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822FBC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A92A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556625735;
	bh=jHi1+utP488YjCLPjiKpXcpbs0/BNkGiO4dU2uOG6eE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LACDmnyCnnMZCW7BaNBkkwXGa9mrPKntF0XilcfhYrOy3TzqGYk9UGcIxBX5oRuOY
	 pcjO8NGogZLPf/SAMBb/3sLJINAqOHuplOe8UrNJLfkLJKUD4aKmGFDruFHJfHzExD
	 oP4nXDqzBMvNt2d4zs5rquD1cVvYeAH3y2TK7O5w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730147AbfD3LoR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:44:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730119AbfD3LoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:44:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198A92177B;
        Tue, 30 Apr 2019 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624653;
        bh=jHi1+utP488YjCLPjiKpXcpbs0/BNkGiO4dU2uOG6eE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IE50iIogviqJZoOZxWCFgM2AnIPZRSEjplSM1+w5YGj8mv0RJMyTFt5VmR9chSRWF
         5uS1zDuV6XVPGh5cJM8ihovwjx87k3KxDTiUH8hTF6YjeBdfIjVfd9B1566xFH8Qd2
         j1ko7NQ6fX2S3PW0eUDX+GpgFUL0PTz5425ZDntA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 022/100] net: dsa: mv88e6xxx: add call to mv88e6xxx_ports_cmode_init to probe for new DSA framework
Date:   Tue, 30 Apr 2019 13:37:51 +0200
Message-Id: <20190430113609.945413299@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 3acca1dd17060332cfab15693733cdaf9fba1c90 ]

In the original patch I missed to add mv88e6xxx_ports_cmode_init()
to the second probe function, the one for the new DSA framework.

Fixes: ed8fe20205ac ("net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode")
Reported-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index dabe89968a78..2caa5c0c2bc4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4821,6 +4821,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 	if (err)
 		goto out;
 
+	mv88e6xxx_ports_cmode_init(chip);
 	mv88e6xxx_phy_init(chip);
 
 	if (chip->info->ops->get_eeprom) {
-- 
2.19.1



