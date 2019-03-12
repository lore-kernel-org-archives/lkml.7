Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B51C206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552412585;
	bh=3pFQ6ZDUVuXmlwee6dvH+9l75RYN5D070FLhHkcZmKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l+7Lb669diIxSvAWkuO6AEqcIFXOrddRzI5s2PFFG2w1ODdYFIpeQi4L/5zZqpvRc
	 /kA/WD9uYTLYCFtkh23ihAMC/klWj2O2ImFSoVACoQHuwJXoRfC7+t8GSW3jXzCKjH
	 wD7UiWwi09UMd+xU149vI08sxMcAIcO9oEdk4XOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbfCLRnD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:43:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:57096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728045AbfCLRPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:52 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C55A21741;
        Tue, 12 Mar 2019 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410952;
        bh=3pFQ6ZDUVuXmlwee6dvH+9l75RYN5D070FLhHkcZmKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n5Lvz6Pvaa91/v8UkPeqsZRXRPmG5pSTIyUl01JhODD7tpxHJc1GKihXXOSUroUw+
         L4ZvMZXkfvjihRaW6NOwR1Q5BDWh7V/urXGaXULA7Cm7uyvnAWy36G+won0EWasND2
         ko8iwvGbl4VQIF0QRJiMWGsa1eW1SpsUngY061WA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris.Healy@zii.aero,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 034/135] net: dsa: mv88e6xxx: Fix statistics on mv88e6161
Date:   Tue, 12 Mar 2019 10:08:01 -0700
Message-Id: <20190312170344.255601871@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170341.127810985@linuxfoundation.org>
References: <20190312170341.127810985@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit a6da21bb0eae459a375d5bd48baed821d14301d0 ]

Despite what the datesheet says, the silicon implements the older way
of snapshoting the statistics. Change the op.

Reported-by: Chris.Healy@zii.aero
Tested-by: Chris.Healy@zii.aero
Fixes: 0ac64c394900 ("net: dsa: mv88e6xxx: mv88e6161 uses mv88e6320 stats snapshot")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -2569,7 +2569,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_pause_limit = mv88e6097_port_pause_limit,
 	.port_disable_learn_limit = mv88e6xxx_port_disable_learn_limit,
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
-	.stats_snapshot = mv88e6320_g1_stats_snapshot,
+	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,
 	.stats_get_stats = mv88e6095_stats_get_stats,


