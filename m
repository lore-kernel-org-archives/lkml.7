Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425EBC76191
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1618C20665
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 19:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563997359;
	bh=K8tCOehphzHY0IO/sbGLCbhffAbFe0XqUIVhEKI7KQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oVpxY4XPp0cIYTRhyl9AKcFM37amTkUPQTd9kAKFGTeNrHYvoX6JPrlPaJuzRtFRI
	 4LdTaDcTUjhpr1iGuBsdMjiH2xYLHqbq6wnaU3fpLRRkewsr2dJy4DY0BJavSgqMX1
	 El53X30SUT/jAXmxBSAN7EvzEXx03O78xwkaXl9M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390065AbfGXTmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 15:42:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388827AbfGXTmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 15:42:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AADF20665;
        Wed, 24 Jul 2019 19:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563997355;
        bh=K8tCOehphzHY0IO/sbGLCbhffAbFe0XqUIVhEKI7KQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/edPh/QdDfLkeSqGD7kh4pHO3aj/ufpYgkxPaCVPahVz1ovBQ6YYn6nP24UZIPt2
         RTRRxjD0RK/3LcjI8a2yr4+wMx0gV16BfxjjM3lKcVOliWEYBcBEMxpjBhXJpliagZ
         uu5+ZVAHWqIj/QVQyheUh2iV8yQ+xGDBXwdadROA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Josua Mayer <josua@solid-run.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.2 408/413] net: mvmdio: allow up to four clocks to be specified for orion-mdio
Date:   Wed, 24 Jul 2019 21:21:39 +0200
Message-Id: <20190724191803.769784497@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190724191735.096702571@linuxfoundation.org>
References: <20190724191735.096702571@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josua Mayer <josua@solid-run.com>

commit 4aabed699c400810981d3dda170f05fa4d782905 upstream.

Allow up to four clocks to be specified and enabled for the orion-mdio
interface, which are required by the Armada 8k and defined in
armada-cp110.dtsi.

Fixes a hang in probing the mvmdio driver that was encountered on the
Clearfog GT 8K with all drivers built as modules, but also affects other
boards such as the MacchiatoBIN.

Cc: stable@vger.kernel.org
Fixes: 96cb43423822 ("net: mvmdio: allow up to three clocks to be specified for orion-mdio")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Josua Mayer <josua@solid-run.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/marvell/mvmdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -64,7 +64,7 @@
 
 struct orion_mdio_dev {
 	void __iomem *regs;
-	struct clk *clk[3];
+	struct clk *clk[4];
 	/*
 	 * If we have access to the error interrupt pin (which is
 	 * somewhat misnamed as it not only reflects internal errors


