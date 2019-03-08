Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318CBC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAFE2085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049928;
	bh=RwfKB2IeNVEDA84hpAvqr4EoCGU59xUT9gm9arikQWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vs2qoU6DAv9806+844IWrehjQceXTo1t5cNdkLjk9QbmytzxQhq4sDjzzQhZ+CeXX
	 El4/NroNImfF7VZdVBVUEumvNUyL3NEp3+s5yrDCFe8f/SA4vgIyoBld/88g8nbtc3
	 AXz4iJuUPI5WT7w1C79MBuej/HY1cpRishMXMQfM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfCHM6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:58:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728044AbfCHM6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:58:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 052692085A;
        Fri,  8 Mar 2019 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049922;
        bh=RwfKB2IeNVEDA84hpAvqr4EoCGU59xUT9gm9arikQWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rTBX9aDGFfMO6bTa1gObibBJzJbbKOQeeoUQtGvdAIiCD6xPPLhiyquG6b5uN5yDU
         UsLkJY7/g4jQh/WyqHyEN8WQq4mGKN29bF5zgcK3ckyv7tHGtaX4N7M8XXLx+iyF4m
         O5ErPkJrcwA75/h7V7uzgWN/Hph9iBbClq7itVbw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris.Healy@zii.aero,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 28/68] net: dsa: mv88e6xxx: Fix statistics on mv88e6161
Date:   Fri,  8 Mar 2019 13:49:58 +0100
Message-Id: <20190308124912.173890754@linuxfoundation.org>
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
@@ -3070,7 +3070,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
 	.port_link_state = mv88e6352_port_link_state,
 	.port_get_cmode = mv88e6185_port_get_cmode,
-	.stats_snapshot = mv88e6320_g1_stats_snapshot,
+	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,


