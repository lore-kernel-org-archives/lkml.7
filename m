Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689AFC43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F47C2082C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054293;
	bh=pF+dbvagrtjDNBYMe9nGKRdkI3dXz2/olQGKQUQ4cMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oECZO/txskhpaji7H84tNtA5NNYDXfna011LWlo1/VlLpzEDG0iroJNRP6VhpRE6j
	 DQKwGc9GbxqPcsby0S4PGOanX5Bpwi4Axdlw1O34L1jKaOEA+waB5ESzxEIKQ1JOWs
	 zwghkTLXKdnUxyIOafPuc2TOxEIlX0if4huf+SKI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfFTSLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:11:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728922AbfFTSL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:11:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908DF2070B;
        Thu, 20 Jun 2019 18:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054287;
        bh=pF+dbvagrtjDNBYMe9nGKRdkI3dXz2/olQGKQUQ4cMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uuuEVHYxqcgL76nHdHY+IA+axGwLMnAcNFZxdYNyYwkaZifWT6t9WkGRpkP3a0IDI
         j/ZgjhL/CZH+HTaUnCBl4SZVKl7FBA246hydgaDAMicpQY3JQnjG2mKzLbJWnZ4I1Z
         CjETDhAqjFCvk43ycgk34v6MFxJMQaVbIOmNhkbM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/61] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date:   Thu, 20 Jun 2019 19:57:32 +0200
Message-Id: <20190620174343.862992817@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174336.357373754@linuxfoundation.org>
References: <20190620174336.357373754@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a0692f0eef91354b62c2b4c94954536536be5425 ]

If I2C_M_RECV_LEN check failed, msgs[i].buf allocated by memdup_user
will not be freed. Pump index up so it will be freed.

Fixes: 838bfa6049fb ("i2c-dev: Add support for I2C_M_RECV_LEN")
Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/i2c-dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
index ccd76c71af09..cb07651f4b46 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -283,6 +283,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			    msgs[i].len < 1 || msgs[i].buf[0] < 1 ||
 			    msgs[i].len < msgs[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
+				i++;
 				res = -EINVAL;
 				break;
 			}
-- 
2.20.1



