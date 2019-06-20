Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5149BC48BE3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2772621743
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054507;
	bh=49ezs3/aU5lyBfud/X1bg7oOESx5cpNZfLmlGK7x1To=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iK4V7LVufKhc/ENO680vTdugpM1oVYjyOU7TrDe/YqbyS8lDvoesqQd7AmC6+rizx
	 xZUMC4GF3lggszitVFQpf2pv792UC6raoXhm0EIvfKEAcvUzJTSR740783uiyog/lw
	 I2L2qCQK0f+A2ReDNZInqm4SXKyXUluE5ddX10sA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfFTSPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:43594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729531AbfFTSPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273C72082C;
        Thu, 20 Jun 2019 18:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054501;
        bh=49ezs3/aU5lyBfud/X1bg7oOESx5cpNZfLmlGK7x1To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yqW9Qzh/o/iRYzAzoMEyVP6c+cLcvWG5XCWc8NXsI18qb+iH7Nj8QtdnpArwqjvnb
         KZJdi/22QFz+R8agWXu5q74wGWmSKhgKAyPr51/xpPYGr29zPNBsKw2BxPii9trV4/
         s/ZJ13LcL14IvJ/1ju5x5o86Ct5vQ/lBnEljwrJY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Robert Hancock <hancock@sedsystems.ca>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.1 21/98] net: dsa: microchip: Dont try to read stats for unused ports
Date:   Thu, 20 Jun 2019 19:56:48 +0200
Message-Id: <20190620174350.185106211@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Robert Hancock <hancock@sedsystems.ca>

[ Upstream commit 6bb9e376c2a4cc5120c3bf5fd3048b9a0a6ec1f8 ]

If some of the switch ports were not listed in the device tree, due to
being unused, the ksz_mib_read_work function ended up accessing a NULL
dp->slave pointer and causing an oops. Skip checking statistics for any
unused ports.

Fixes: 7c6ff470aa867f53 ("net: dsa: microchip: add MIB counter reading support")
Signed-off-by: Robert Hancock <hancock@sedsystems.ca>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/microchip/ksz_common.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -83,6 +83,9 @@ static void ksz_mib_read_work(struct wor
 	int i;
 
 	for (i = 0; i < dev->mib_port_cnt; i++) {
+		if (dsa_is_unused_port(dev->ds, i))
+			continue;
+
 		p = &dev->ports[i];
 		mib = &p->mib;
 		mutex_lock(&mib->cnt_mutex);


