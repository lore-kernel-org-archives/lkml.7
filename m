Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7E8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B1F2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079580;
	bh=JGrtMphqEBRe4KazNKPmtnlXLbIa9M3zw4sRGZJzVmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fPicS9aTA6SBI6bixLD45PE7H/CqvcuFoMUGnt9L7/0EtPNMASYrPbTzQi0TnMiXO
	 eqSnm9EpnXyk9JEXbo9dzcG1L7DCegRcTjgnH2OB2ClRHF9WB8Gpl93MEKg+NVgfjU
	 WkUDbLvRCIeTE6We60KW4wpGP0Nzr0wdhVZwtTBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfLKPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732280AbfLKPTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:19:51 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD22D2073D;
        Wed, 11 Dec 2019 15:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077591;
        bh=JGrtMphqEBRe4KazNKPmtnlXLbIa9M3zw4sRGZJzVmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2iV/p+Pe6ErL4l/OGIGgQi/jfSQDRs8SlLClBWF5ZwTNSZf+iodipsOTi6CsXWMtn
         dnY6jCLvtPvAvSAHuyMIGLZ22TVI88cyRjvaD8I7SmPKe2LvMWQOyJveUGzi7iFFFd
         tgzTpKMIimRy+j62tdVos2nfc3UE2j2fp6p6rkY8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 096/243] net: qualcomm: rmnet: move null check on dev before dereferecing it
Date:   Wed, 11 Dec 2019 16:04:18 +0100
Message-Id: <20191211150345.597562936@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150339.185439726@linuxfoundation.org>
References: <20191211150339.185439726@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 3c18aa1464f9232d6abac8d7b4540f61b0658d62 ]

Currently dev is dereferenced by the call dev_net(dev) before dev is null
checked.  Fix this by null checking dev before the potential null
pointer dereference.

Detected by CoverityScan, CID#1462955 ("Dereference before null check")

Fixes: 23790ef12082 ("net: qualcomm: rmnet: Allow to configure flags for existing devices")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
index f66d1255e36a2..4c476fac78358 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c
@@ -301,10 +301,13 @@ static int rmnet_changelink(struct net_device *dev, struct nlattr *tb[],
 	struct rmnet_port *port;
 	u16 mux_id;
 
+	if (!dev)
+		return -ENODEV;
+
 	real_dev = __dev_get_by_index(dev_net(dev),
 				      nla_get_u32(tb[IFLA_LINK]));
 
-	if (!real_dev || !dev || !rmnet_is_real_dev_registered(real_dev))
+	if (!real_dev || !rmnet_is_real_dev_registered(real_dev))
 		return -ENODEV;
 
 	port = rmnet_get_port_rtnl(real_dev);
-- 
2.20.1



