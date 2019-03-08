Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B681C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BC92085A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 12:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552049839;
	bh=R+UDyVvRd5QSFsLymH2JcGpQZ27is08znH1ojbnIUJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tft28Y2Wz/bJqc7AzkxW7tO/EZ9h4p3RxYuZlPz74E87FK0ZdYwDEu38RAP2d8eX/
	 vHaQFapxwNslXph0T+U5uQ7YmLJ/KxArHFUq8EhmY4Zv2yLXA7N8/yWuKY4N0K4Ta9
	 ry0OmqtXwcGGzmj/a7Ga+lerl60GJRl3by46v18s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfCHM5S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 07:57:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:33610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727477AbfCHM5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 07:57:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 871A220449;
        Fri,  8 Mar 2019 12:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552049835;
        bh=R+UDyVvRd5QSFsLymH2JcGpQZ27is08znH1ojbnIUJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f71zDojMz/427xeB/uLT91HZePZNP7qNariiw+Qbh1qVmHJfK10cp/LSGNpHwoqAv
         egzmrFoO7U6Ivd4SEuezZSgkK/7RT+0/huYFpXmQkGnV4MJqokhiUVqw2gEjPHpG7w
         59uAhuNLcEc7wrotiSBvYYgDRGe3S2145rFOvv5U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chris.Healy@zii.aero,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.20 35/76] net: dsa: mv88e6xxx: Fix statistics on mv88e6161
Date:   Fri,  8 Mar 2019 13:49:47 +0100
Message-Id: <20190308124916.062672145@linuxfoundation.org>
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
@@ -3082,7 +3082,7 @@ static const struct mv88e6xxx_ops mv88e6
 	.port_disable_pri_override = mv88e6xxx_port_disable_pri_override,
 	.port_link_state = mv88e6352_port_link_state,
 	.port_get_cmode = mv88e6185_port_get_cmode,
-	.stats_snapshot = mv88e6320_g1_stats_snapshot,
+	.stats_snapshot = mv88e6xxx_g1_stats_snapshot,
 	.stats_set_histogram = mv88e6095_g1_stats_set_histogram,
 	.stats_get_sset_count = mv88e6095_stats_get_sset_count,
 	.stats_get_strings = mv88e6095_stats_get_strings,


