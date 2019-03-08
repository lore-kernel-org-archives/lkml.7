Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0E5C20811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049993;
	bh=3+P1x8LmfuRHSOJWfnaz3HuG/sWPkyWO058Qpum2HsM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uth4GgzAEMp4vPVRk0XlzUa77L2hNRHKp7uV1Tddy24U8J+9MDB7AuEaINW/wdzX/
	 Pjr0Asa8eR/+qZYnqs2GHXW3SaH4mvaQYTI0fj/wVkWu0gve3WO5WnVhjvKQ3E8Rxn
	 j/ZNS+k7syINByzHPnC1up8BjrOAlD7fMR+rmRaw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfCHM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:59:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727513AbfCHM7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:59:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B7EE2087C;
        Fri,  8 Mar 2019 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049987;
        bh=3+P1x8LmfuRHSOJWfnaz3HuG/sWPkyWO058Qpum2HsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTKbPImeB+wLUS6cEN2M5uLixKHvj9ip1mz3eLuqE2a2fyswnGsJ5AFQ0zlhMVnTn
         tYHV6MMDdXN38MOTzuoiB6T9WEfmu497tl7+pbArao4JdzuWe3pSIt3DqkbEd1RuXd
         HnKt5xQh+6ApGi4brzSmljvKrVZIe6sxOU/TUAnU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 49/68] net: dsa: mv88e6xxx: prevent interrupt storm caused by mv88e6390x_port_set_cmode
Date:   Fri,  8 Mar 2019 13:50:19 +0100
Message-Id: <20190308124913.073792238@linuxfoundation.org>
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

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit ed8fe20205ac054bf585156709de3913d1890f30 ]

When debugging another issue I faced an interrupt storm in this
driver (88E6390, port 9 in SGMII mode), consisting of alternating
link-up / link-down interrupts. Analysis showed that the driver
wanted to set a cmode that was set already. But so far
mv88e6390x_port_set_cmode() doesn't check this and powers down
SERDES, what causes the link to break, and eventually results in
the described interrupt storm.

Fix this by checking whether the cmode actually changes. We want
that the very first call to mv88e6390x_port_set_cmode() always
configures the registers, therefore initialize port.cmode with
a value that is different from any supported cmode value.
We have to take care that we only init the ports cmode once
chip->info->num_ports is set.

v2:
- add small helper and init the number of actual ports only

Fixes: 364e9d7776a3 ("net: dsa: mv88e6xxx: Power on/off SERDES on cmode change")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |   10 ++++++++++
 drivers/net/dsa/mv88e6xxx/port.c |    4 ++++
 drivers/net/dsa/mv88e6xxx/port.h |    1 +
 3 files changed, 15 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4561,6 +4561,14 @@ static int mv88e6xxx_smi_init(struct mv8
 	return 0;
 }
 
+static void mv88e6xxx_ports_cmode_init(struct mv88e6xxx_chip *chip)
+{
+	int i;
+
+	for (i = 0; i < mv88e6xxx_num_ports(chip); i++)
+		chip->ports[i].cmode = MV88E6XXX_PORT_STS_CMODE_INVALID;
+}
+
 static enum dsa_tag_protocol mv88e6xxx_get_tag_protocol(struct dsa_switch *ds,
 							int port)
 {
@@ -4597,6 +4605,8 @@ static const char *mv88e6xxx_drv_probe(s
 	if (err)
 		goto free;
 
+	mv88e6xxx_ports_cmode_init(chip);
+
 	mutex_lock(&chip->reg_lock);
 	err = mv88e6xxx_switch_reset(chip);
 	mutex_unlock(&chip->reg_lock);
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -374,6 +374,10 @@ int mv88e6390x_port_set_cmode(struct mv8
 		cmode = 0;
 	}
 
+	/* cmode doesn't change, nothing to do for us */
+	if (cmode == chip->ports[port].cmode)
+		return 0;
+
 	lane = mv88e6390x_serdes_get_lane(chip, port);
 	if (lane < 0)
 		return lane;
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -52,6 +52,7 @@
 #define MV88E6185_PORT_STS_CMODE_1000BASE_X	0x0005
 #define MV88E6185_PORT_STS_CMODE_PHY		0x0006
 #define MV88E6185_PORT_STS_CMODE_DISABLED	0x0007
+#define MV88E6XXX_PORT_STS_CMODE_INVALID	0xff
 
 /* Offset 0x01: MAC (or PCS or Physical) Control Register */
 #define MV88E6XXX_PORT_MAC_CTL				0x01


