Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0554C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1921939
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257478;
	bh=YwOjUSfApPw2RRIHDeR+1A4Q9j1FM8zm960NCXLalkY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jb5TcqMg/3yahi4U9whdgZta9szZ5JcoTrmyWTBO6a7M7dSIjatwaxGkXnn8LTVEE
	 rH4udnrsJpyrGPu3GgzpFvxncfe6NMqByeY1rnYGcKWqXQJp3l1pp1tAUX+xGz99SV
	 N7H3cEcXwWaDegN5Ru4lmY+yOJ6rZefg+X6O+gDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390463AbfCVMYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390892AbfCVMYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:24:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B0CB2195D;
        Fri, 22 Mar 2019 12:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257472;
        bh=YwOjUSfApPw2RRIHDeR+1A4Q9j1FM8zm960NCXLalkY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cykjqq8CkdxXe0RJq8weHFgH2GvyD12Tw6n2S+2cBNcHrWFLVU3Us7TT1PHeh1x9K
         47yokloDEmI9BiwLkgxyOg1D7SnPjx+JuULkjjbMs3LAbcIBGDNzpUTdQTkB+ACSsl
         +X8vYIxjVvXl3YyReipX9qa0lVEZSxRe+hkym2MQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Johan Hovold <johan@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 233/238] net: dsa: lantiq_gswip: fix use-after-free on failed probe
Date:   Fri, 22 Mar 2019 12:17:32 +0100
Message-Id: <20190322111312.132165143@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
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

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit aed13f2e00ce278f039b76e7ac84d419aff48ef6 upstream.

Make sure to disable and deregister the switch on late probe errors to
avoid use-after-free when the device-resource-managed switch is freed.

Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
Cc: stable <stable@vger.kernel.org>	# 4.20
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/dsa/lantiq_gswip.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/net/dsa/lantiq_gswip.c
+++ b/drivers/net/dsa/lantiq_gswip.c
@@ -1099,7 +1099,7 @@ static int gswip_probe(struct platform_d
 		dev_err(dev, "wrong CPU port defined, HW only supports port: %i",
 			priv->hw_info->cpu_port);
 		err = -EINVAL;
-		goto mdio_bus;
+		goto disable_switch;
 	}
 
 	platform_set_drvdata(pdev, priv);
@@ -1109,6 +1109,9 @@ static int gswip_probe(struct platform_d
 		 (version & GSWIP_VERSION_MOD_MASK) >> GSWIP_VERSION_MOD_SHIFT);
 	return 0;
 
+disable_switch:
+	gswip_mdio_mask(priv, GSWIP_MDIO_GLOB_ENABLE, 0, GSWIP_MDIO_GLOB);
+	dsa_unregister_switch(priv->ds);
 mdio_bus:
 	if (mdio_np)
 		mdiobus_unregister(priv->ds->slave_mii_bus);


