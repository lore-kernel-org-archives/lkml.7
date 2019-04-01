Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462EFC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1759E21929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554138322;
	bh=h86hAaKA0Ah6pwhQnxgq6BJ17E0czsx2sp3TXFDJr3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xvCfFE0SkB+0okwVvX0gGRVjVkMgfBQQgenEPjdkCCiMFCidREvLo488cE1NYrfMG
	 rs4UE5LLxuqQVT+xR6uDDAUIgiNqob8B97vTXkEVmJi0V2m4ZcNwlhWuvmESvOQun8
	 K1Bx/C5xR42Rm9UrdDZfUPRQJe79ZrrretNTf9R0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbfDARFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:05:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:50378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728917AbfDARFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:05:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57D3E21925;
        Mon,  1 Apr 2019 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138318;
        bh=h86hAaKA0Ah6pwhQnxgq6BJ17E0czsx2sp3TXFDJr3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrAlQ1vAUuTtT8fUDKDruAB3wZSZAJfjDoML/a/qhaHqhfylmYMngURltx2E2C1yJ
         o8kK+IDkbfgZDiFJWybk6v0NcY6DRbK62qUFThu22OStCPmBTKHgRYrAd7McGuG/nD
         ADawq93/qANmE8xYQIGnoAjqzPoYNHBG+3IA5P/E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 031/146] net: dsa: mv88e6xxx: fix few issues in mv88e6390x_port_set_cmode
Date:   Mon,  1 Apr 2019 19:00:43 +0200
Message-Id: <20190401170051.178861898@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170048.449559024@linuxfoundation.org>
References: <20190401170048.449559024@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 5ceaeb99ffb4dc002d20f6ac243c19a85e2c7a76 ]

This patches fixes few issues in mv88e6390x_port_set_cmode().

1. When entering the function the old cmode may be 0, in this case
   mv88e6390x_serdes_get_lane() returns -ENODEV. As result we bail
   out and have no chance to set a new mode. Therefore deal properly
   with -ENODEV.

2. Once we have disabled power and irq, let's set the cached cmode to 0.
   This reflects the actual status and is cleaner if we bail out with an
   error in the following function calls.

3. The cached cmode is used by mv88e6390x_serdes_get_lane(),
   mv88e6390_serdes_power_lane() and mv88e6390_serdes_irq_enable().
   Currently we set the cached mode to the new one at the very end of
   the function only, means until then we use the old one what may be
   wrong.

4. When calling mv88e6390_serdes_irq_enable() we use the lane value
   belonging to the old cmode. Get the lane belonging to the new cmode
   before calling this function.

It's hard to provide a good "Fixes" tag because quite a few smaller
changes have been done to the code in question recently.

Fixes: d235c48b40d3 ("net: dsa: mv88e6xxx: power serdes on/off for 10G interfaces on 6390X")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/port.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -427,18 +427,22 @@ int mv88e6390x_port_set_cmode(struct mv8
 		return 0;
 
 	lane = mv88e6390x_serdes_get_lane(chip, port);
-	if (lane < 0)
+	if (lane < 0 && lane != -ENODEV)
 		return lane;
 
-	if (chip->ports[port].serdes_irq) {
-		err = mv88e6390_serdes_irq_disable(chip, port, lane);
+	if (lane >= 0) {
+		if (chip->ports[port].serdes_irq) {
+			err = mv88e6390_serdes_irq_disable(chip, port, lane);
+			if (err)
+				return err;
+		}
+
+		err = mv88e6390x_serdes_power(chip, port, false);
 		if (err)
 			return err;
 	}
 
-	err = mv88e6390x_serdes_power(chip, port, false);
-	if (err)
-		return err;
+	chip->ports[port].cmode = 0;
 
 	if (cmode) {
 		err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_STS, &reg);
@@ -452,6 +456,12 @@ int mv88e6390x_port_set_cmode(struct mv8
 		if (err)
 			return err;
 
+		chip->ports[port].cmode = cmode;
+
+		lane = mv88e6390x_serdes_get_lane(chip, port);
+		if (lane < 0)
+			return lane;
+
 		err = mv88e6390x_serdes_power(chip, port, true);
 		if (err)
 			return err;
@@ -463,8 +473,6 @@ int mv88e6390x_port_set_cmode(struct mv8
 		}
 	}
 
-	chip->ports[port].cmode = cmode;
-
 	return 0;
 }
 


