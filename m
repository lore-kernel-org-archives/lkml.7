Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8ABC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4BF20880
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 18:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554142273;
	bh=HRI9+3COnMDY4d0HFTnlT7Xz6I5iNEa/lWT6ZpoCWKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxabzHrCXCmiShGAqvmFuUcUBYPML/vNOPo8qJUXfSmnuGGWkYFEYaaEJUXvWZozN
	 nZaM6DF8Ob1JXNZYQytHaoJx8mz8wsPsdYY+F5SJTrBS9xXOpBV6OBuCOuVf/lJavh
	 VChDsHd8MdPenfx7JT8IIqQu+vRutIUBddCrraew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729261AbfDARGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728831AbfDARGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:06:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9563B21925;
        Mon,  1 Apr 2019 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554138391;
        bh=HRI9+3COnMDY4d0HFTnlT7Xz6I5iNEa/lWT6ZpoCWKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cD8SCcD+YrnPwgFaZi/fMmm9jHOyXylK3bPzDS9Ok8o0ouawZfAJRNjnyb303PUwr
         nyT+A3c+FestPZr8JIzfDTYg29jgwXFNTG+yBh81FTG82NWYBFv+EFI+SrCrHlLiea
         CYOYKCr6NQQjePL7ddOoAEiwdu/GCrmFEf1P4gWQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christian Lamparter <chunkeey@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.0 053/146] net: dsa: qca8k: remove leftover phy accessors
Date:   Mon,  1 Apr 2019 19:01:05 +0200
Message-Id: <20190401170053.118455500@linuxfoundation.org>
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

From: Christian Lamparter <chunkeey@gmail.com>

commit 1eec7151ae0e134bd42e3f128066b2ff8da21393 upstream.

This belated patch implements Andrew Lunn's request of
"remove the phy_read() and phy_write() functions."
<https://lore.kernel.org/patchwork/comment/902734/>

While seemingly harmless, this causes the switch's user
port PHYs to get registered twice. This is because the
DSA subsystem will create a slave mdio-bus not knowing
that the qca8k_phy_(read|write) accessors operate on
the external mdio-bus. So the same "bus" gets effectively
duplicated.

Cc: stable@vger.kernel.org
Fixes: 6b93fb46480a ("net-next: dsa: add new driver for qca8xxx family")
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/dsa/qca8k.c |   18 ------------------
 1 file changed, 18 deletions(-)

--- a/drivers/net/dsa/qca8k.c
+++ b/drivers/net/dsa/qca8k.c
@@ -620,22 +620,6 @@ qca8k_adjust_link(struct dsa_switch *ds,
 	qca8k_port_set_status(priv, port, 1);
 }
 
-static int
-qca8k_phy_read(struct dsa_switch *ds, int phy, int regnum)
-{
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
-
-	return mdiobus_read(priv->bus, phy, regnum);
-}
-
-static int
-qca8k_phy_write(struct dsa_switch *ds, int phy, int regnum, u16 val)
-{
-	struct qca8k_priv *priv = (struct qca8k_priv *)ds->priv;
-
-	return mdiobus_write(priv->bus, phy, regnum, val);
-}
-
 static void
 qca8k_get_strings(struct dsa_switch *ds, int port, u32 stringset, uint8_t *data)
 {
@@ -876,8 +860,6 @@ static const struct dsa_switch_ops qca8k
 	.setup			= qca8k_setup,
 	.adjust_link            = qca8k_adjust_link,
 	.get_strings		= qca8k_get_strings,
-	.phy_read		= qca8k_phy_read,
-	.phy_write		= qca8k_phy_write,
 	.get_ethtool_stats	= qca8k_get_ethtool_stats,
 	.get_sset_count		= qca8k_get_sset_count,
 	.get_mac_eee		= qca8k_get_mac_eee,


