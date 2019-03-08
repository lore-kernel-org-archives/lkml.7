Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F041C2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049930;
	bh=+tWqQpoGlSUBXWg7b3K5jYVvoqZdOJ7oj/XDwrUJ91I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/tXoDMJf0JtRtWRmJr8Zqb98djejQFnnMpCe2ecXsFZ4v0SutM/QXk/Oioc4lVDq
	 ghwg50EDIH+Dp544r55eQ6jl206pMgxM10FTLlJ6bDQKuO0KYrgHiV6AKr3hSuHBA3
	 Hy1WNr03aAgCwiknR88l42S1ADlRaG3u6bYXDLeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCHM6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727503AbfCHM6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C742520449;
        Fri,  8 Mar 2019 12:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049925;
        bh=+tWqQpoGlSUBXWg7b3K5jYVvoqZdOJ7oj/XDwrUJ91I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2USIOcj3FQ672t2dFkSSKy/b9kcB3/w9MWXWE/apQAdkUXkcRODKdYrMQtjuf4O78
         vrxXQKtCB0XmlebkIvh3S4Cz/GnWLQGh8XW7qJ189q7X6MBfR1cBJV5yfcDYiDfvNP
         kEqIsKS6blGU8P0mAOrmTWe4n4y0rDLYud//Z3lk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 29/68] net: dsa: mv88e6xxx: Fix u64 statistics
Date:   Fri,  8 Mar 2019 13:49:59 +0100
Message-Id: <20190308124912.218220847@linuxfoundation.org>
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

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit 6e46e2d821bb22b285ae8187959096b65d063b0d ]

The switch maintains u64 counters for the number of octets sent and
received. These are kept as two u32's which need to be combined.  Fix
the combing, which wrongly worked on u16's.

Fixes: 80c4627b2719 ("dsa: mv88x6xxx: Refactor getting a single statistic")
Reported-by: Chris Healy <Chris.Healy@zii.aero>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -884,7 +884,7 @@ static uint64_t _mv88e6xxx_get_ethtool_s
 	default:
 		return U64_MAX;
 	}
-	value = (((u64)high) << 16) | low;
+	value = (((u64)high) << 32) | low;
 	return value;
 }
 


