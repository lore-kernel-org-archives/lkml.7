Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BE5C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 762242089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054540;
	bh=ZNLpGD2Qmwj7p07ux6Tt5MCr2BG4AVR1RFrcd1bxSws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G2AG0mdz9MMD0UYTrSnR3oh3hadIhHbORbVhtUWOqr/0zyMTmy01dD0HkRu89wUtt
	 KCYfY7z68b4U4/Bs9Gk/ynnOMmWi5gugl9uX9DP0qvb2tIGGTi7eFB33SmRU+L9KKE
	 M463ax4jOM3cV5OfvBYhwyHMY3CwKx3yx1GZiicU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729638AbfFTSPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbfFTSPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A4FE2082C;
        Thu, 20 Jun 2019 18:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054536;
        bh=ZNLpGD2Qmwj7p07ux6Tt5MCr2BG4AVR1RFrcd1bxSws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YR089eZG01h+Cp1TPUtPRMXBNvHL59xWENpVehow9Ou8rGBba8Q89kL4u0KViwFfi
         J+yTtAtHlB+SDHPT/kYufLZ+1GjCnkaKoTL1N4QcQtxS25gYfpJDFrwhJqY3uZPyVa
         LcbOLoIRZKjWjmN/8v8T3G30FKRiZ8WaH6sfRAhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 63/98] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date:   Thu, 20 Jun 2019 19:57:30 +0200
Message-Id: <20190620174352.273247343@linuxfoundation.org>
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
index 3f7b9af11137..776f36690448 100644
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



