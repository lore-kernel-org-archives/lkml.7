Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A21EC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05FD520659
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 05:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574402138;
	bh=zXt9GqHUeIEH2vibE824zaULD6dlD3GFqN4+W2MhxWM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=umbRoyCZ+GWHzBRX3707t1Z0B47e2mu/XAkbGuDzDVdkUY8cU5cxaCuA4HH0tbEOf
	 21g2VBBZ9JSGR7dColJNFA/yDGxAr2i6KONZhmKQ1I/hcmEUV2UGUM4i4RWVAY54B7
	 vQwfppS7xtPKZNaejVF0qfZ7Eo7EWUs0+kPBnHQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfKVFzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 00:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:58752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727495AbfKVFwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:51 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 544E420721;
        Fri, 22 Nov 2019 05:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574401970;
        bh=zXt9GqHUeIEH2vibE824zaULD6dlD3GFqN4+W2MhxWM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pRTbi4YbXNkVFmKWO3dW4uotjVM7cTdm1zcJGM1S3L3GyXic6o1T/e7QvFbpF5Dlk
         YJ8eJsu3y0na8pukmnFN5K+D7XIazICItbC3acF5Sbc8UXaYqpa8qTBu58+RTRJUBg
         vjRm/U9rLYckoK9xDcK+3xQhlA1HNk/3S1uG1tfo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matteo Croce <mcroce@redhat.com>,
        Andrea Claudi <aclaudi@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 190/219] geneve: change NET_UDP_TUNNEL dependency to select
Date:   Fri, 22 Nov 2019 00:48:42 -0500
Message-Id: <20191122054911.1750-183-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matteo Croce <mcroce@redhat.com>

[ Upstream commit a7603ac1fc8ce1409f8ff70e6ce505f308b2c002 ]

Due to the depends on NET_UDP_TUNNEL, at the moment it is impossible to
compile GENEVE if no other protocol depending on NET_UDP_TUNNEL is
selected.

Fix this changing the depends to a select, and drop NET_IP_TUNNEL from the
select list, as it already depends on NET_UDP_TUNNEL.

Signed-off-by: Matteo Croce <mcroce@redhat.com>
Reviewed-and-tested-by: Andrea Claudi <aclaudi@redhat.com>
Tested-by: Davide Caratti <dcaratti@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 619bf1498a662..0652caad57ec1 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -197,9 +197,9 @@ config VXLAN
 
 config GENEVE
        tristate "Generic Network Virtualization Encapsulation"
-       depends on INET && NET_UDP_TUNNEL
+       depends on INET
        depends on IPV6 || !IPV6
-       select NET_IP_TUNNEL
+       select NET_UDP_TUNNEL
        select GRO_CELLS
        ---help---
 	  This allows one to create geneve virtual interfaces that provide
-- 
2.20.1

