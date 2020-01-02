Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F075EC3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23222314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003479;
	bh=A3XE+puTXjA9ypSDzn1jexAtI7UUySgWIBLw+o3TCgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tzBjmwci621q+fNEzVlkQbwAn9ta/zUc/dDpgPMrD5px1ft+8VRaOqMF7q7MpYgND
	 WBd4JrCE7GJDaLQi4ThbQis1W085r7N0ZyIH/v4y74OtJEcjzc++MxYbYpM+Gu+sxE
	 VvChgqee0H6IGJjTheiuVORW4SfIJxUrsGhhC2fI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgABWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbgABWR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:17:56 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB53122314;
        Thu,  2 Jan 2020 22:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003476;
        bh=A3XE+puTXjA9ypSDzn1jexAtI7UUySgWIBLw+o3TCgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lkyAdRHPRJ5yN6gcOyrMHpq37KKdRNJI3Uwf9gu4+vC1wV3+egJuFnCu4vgG+zIie
         VuOPa15sTrNESPogiFwSaiGnmrA+hhQhyA96Gj1Gas5nNywQoGYa4d2xk4U0XOWWJp
         vnwaMYXWj/CbfAwwhqSRAmQzAd9Ba0pp8KLL3pMc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Madalin Bucur <madalin.bucur@oss.nxp.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 150/191] net: phy: aquantia: add suspend / resume ops for AQR105
Date:   Thu,  2 Jan 2020 23:07:12 +0100
Message-Id: <20200102215845.564560391@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@oss.nxp.com>

[ Upstream commit 1c93fb45761e79b3c00080e71523886cefaf351c ]

The suspend/resume code for AQR107 works on AQR105 too.
This patch fixes issues with the partner not seeing the link down
when the interface using AQR105 is brought down.

Fixes: bee8259dd31f ("net: phy: add driver for aquantia phy")
Signed-off-by: Madalin Bucur <madalin.bucur@oss.nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/aquantia_main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/phy/aquantia_main.c
+++ b/drivers/net/phy/aquantia_main.c
@@ -627,6 +627,8 @@ static struct phy_driver aqr_driver[] =
 	.config_intr	= aqr_config_intr,
 	.ack_interrupt	= aqr_ack_interrupt,
 	.read_status	= aqr_read_status,
+	.suspend	= aqr107_suspend,
+	.resume		= aqr107_resume,
 },
 {
 	PHY_ID_MATCH_MODEL(PHY_ID_AQR106),


