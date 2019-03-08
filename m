Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA57C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A6620811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049988;
	bh=J6oyChEHTQ59lttyCw+g4Z6+orFJLtQ9YPAT3TMg07I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OQdPq9Kvj3HBns3ZpDeLegAfW0xYRU9ShvQfi9N8bPMZ7mg6PwtE5AZurhoLkiCUS
	 vtbQgVsP9/2b1s2kopI/mHLHGnvnpHMjFK0JWVr0dBjztO7xDdiUprQLYyfcT672od
	 QTslrpCEIEmW1El3o6K/1iCQWWR6Vpfrako1NlD4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbfCHM7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfCHM7o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:44 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E30520811;
        Fri,  8 Mar 2019 12:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049984;
        bh=J6oyChEHTQ59lttyCw+g4Z6+orFJLtQ9YPAT3TMg07I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PTqonPcUSj1HT0rdhRP1+M2TePL4Ws7Doah9bCgSVcw3rek8QBcfQpQ4rsF5KDp8l
         a99eJT3G83QlBquIa6apFFLKHECsEJtFE5wIz+g5/LXHmpKYxuUXEz+HdxNPlLscVL
         jL9jwGtUg+uERW/QyvP4LbF7e5k8uzYdJOGYbXEQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 48/68] net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X
Date:   Fri,  8 Mar 2019 13:50:18 +0100
Message-Id: <20190308124913.035701002@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190308124910.696595153@linuxfoundation.org>
References: <20190308124910.696595153@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maxime Chevallier <maxime.chevallier@bootlin.com>

[ Upstream commit d235c48b40d399328585a68f3f9bf7cc3062d586 ]

Upon setting the cmode on 6390 and 6390X, the associated serdes
interfaces must be powered off/on.

Both 6390X and 6390 share code to do so, but it currently uses the 6390
specific helper mv88e6390_serdes_power() to disable and enable the
serdes interface.

This call will fail silently on 6390X when trying so set a 10G interface
such as XAUI or RXAUI, since mv88e6390_serdes_power() internally grabs
the lane number based on modes supported by the 6390, and returns 0 when
getting -ENODEV as a lane number.

Using mv88e6390x_serdes_power() should be safe here, since we explicitly
rule-out all ports but the 9 and 10, and because modes supported by 6390
ports 9 and 10 are a subset of those supported on 6390X.

This was tested on 6390X using RXAUI mode.

Fixes: 364e9d7776a3 ("net: dsa: mv88e6xxx: Power on/off SERDES on cmode change")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/port.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -384,7 +384,7 @@ int mv88e6390x_port_set_cmode(struct mv8
 			return err;
 	}
 
-	err = mv88e6390_serdes_power(chip, port, false);
+	err = mv88e6390x_serdes_power(chip, port, false);
 	if (err)
 		return err;
 
@@ -400,7 +400,7 @@ int mv88e6390x_port_set_cmode(struct mv8
 		if (err)
 			return err;
 
-		err = mv88e6390_serdes_power(chip, port, true);
+		err = mv88e6390x_serdes_power(chip, port, true);
 		if (err)
 			return err;
 


