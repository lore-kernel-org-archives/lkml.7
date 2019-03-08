Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D4C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1EAA20449
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049764;
	bh=8ibl9A3Y5fe9XOOjVKaFMenAl0643CtTWshE9mR3uWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YjY995y5XW6A1nN5ylXJx5hPgLdWiI1G7WF53aPnjEbAVQ9mPJK3HekwpBAB8kEQE
	 5ChCIitlVd9uzRyTTcQ+9pLOf1piTQZmLJ0wWFCgEuFavZjtg8lbvzlx1n60hIAPEj
	 r3w0GCouk5MGBFsLcZtRY5HtyJmBtE9W/4zlLn+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbfCHM4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:56:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:60226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726452AbfCHM4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:56:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FDC32085A;
        Fri,  8 Mar 2019 12:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049760;
        bh=8ibl9A3Y5fe9XOOjVKaFMenAl0643CtTWshE9mR3uWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LgK0CNnaxvM/T6ekqpEF/5kvjG8ZReTv73Xw+GDHYffSYDkQUFd5+PWXmt1W1ZetU
         ACz5Ux7pw0PgskZg9dUCKiNRy3w+AfjbNNFQ3G8AjX262GVnwBdlt4G50Xqn/p9RmC
         GHTftPYg6PgAaja5r6EuX1fiqwv+6jEEQaDyeWbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 55/76] net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X
Date:   Fri,  8 Mar 2019 13:50:07 +0100
Message-Id: <20190308124916.752024407@linuxfoundation.org>
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
@@ -405,7 +405,7 @@ int mv88e6390x_port_set_cmode(struct mv8
 			return err;
 	}
 
-	err = mv88e6390_serdes_power(chip, port, false);
+	err = mv88e6390x_serdes_power(chip, port, false);
 	if (err)
 		return err;
 
@@ -421,7 +421,7 @@ int mv88e6390x_port_set_cmode(struct mv8
 		if (err)
 			return err;
 
-		err = mv88e6390_serdes_power(chip, port, true);
+		err = mv88e6390x_serdes_power(chip, port, true);
 		if (err)
 			return err;
 


