Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A02C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D93522CB8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 15:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564155204;
	bh=iv41E8Xkoz/Gx491upJuOMOJegDpsEKW4zDDb4NP148=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gjn4p+qg+buq4BC602kGqRsKXowaK9IPQpFWqJ/xVGyksOEQzIXzG5tsmKc+an4Ai
	 /sgBlyxtHLyT4ppZy18WN4mFNoS+4DXmLanyLx/hub6M9juKWz5OzLuf0tVg7VxF5f
	 bqPiM/VlIED/UZSENRsKc0iZ8/WLQT5VCfdq6uIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389630AbfGZPdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 11:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:48642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389616AbfGZPdQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 11:33:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF63D22CD0;
        Fri, 26 Jul 2019 15:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564155196;
        bh=iv41E8Xkoz/Gx491upJuOMOJegDpsEKW4zDDb4NP148=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xyzjk+mwzcz709SUaAI2RNQXrCCqV2l3rkMxQ1TP4OD+ATJKs/nJYW65gGeouykLV
         S5dn5r72Q8K/EM6dgSWXwwboQ8f76XpHuHuN1dHoQp1EytySsh+jsQF7mdBMb5mM8C
         oYQhBa2X4FM3nA/D7LCw2dTckR7qRnM3OFYbc9+0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 09/50] net: dsa: mv88e6xxx: wait after reset deactivation
Date:   Fri, 26 Jul 2019 17:24:44 +0200
Message-Id: <20190726152301.584679551@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726152300.760439618@linuxfoundation.org>
References: <20190726152300.760439618@linuxfoundation.org>
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
@@ -4816,6 +4816,8 @@ static int mv88e6xxx_probe(struct mdio_d
 		err = PTR_ERR(chip->reset);
 		goto out;
 	}
+	if (chip->reset)
+		usleep_range(1000, 2000);
 
 	err = mv88e6xxx_detect(chip);
 	if (err)


