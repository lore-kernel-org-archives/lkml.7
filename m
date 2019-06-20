Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4160C4646C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D212083B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561053688;
	bh=eqKl0zvJukqapTrsVsf8Glo6wcBxzBGqmpgcdf9rP5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TglMEuasNAUpzqkcTRa0ycJiAEoKHEzOjGPlucpfOKt8qa7KqWLTSuBRoqORwQLSC
	 WerN6eGvP2KpMfY9+do+74aRR4oz9FwD8JkrDOWlChQMELz7IunDG316+HRf7iVFep
	 OAGmHwKFUf2lgsRE/Ar4po2xnw3QYfY8JjLfs8gs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFTSB1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:01:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfFTSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:01:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A4E72083B;
        Thu, 20 Jun 2019 18:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561053682;
        bh=eqKl0zvJukqapTrsVsf8Glo6wcBxzBGqmpgcdf9rP5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02o/49R0ZJB6Zqn5XsatdCxTHztvUVEPQ+ZTuysz5U36HQyVIrb4cwm74SERjOhPj
         rfakEpb/lkBs9ek4QaD6c9qPfWYssEzlbyXWtRPWodq5nft2mZpGbXFssrfeuf4+e5
         BzA4yQa8UmPJFE0EffW1exicKfTlaBkiGHw0wpzE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 75/84] i2c: dev: fix potential memory leak in i2cdev_ioctl_rdwr
Date:   Thu, 20 Jun 2019 19:57:12 +0200
Message-Id: <20190620174348.846387719@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174337.538228162@linuxfoundation.org>
References: <20190620174337.538228162@linuxfoundation.org>
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
index 57e3790c87b1..e56b774e7cf9 100644
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -295,6 +295,7 @@ static noinline int i2cdev_ioctl_rdwr(struct i2c_client *client,
 			    rdwr_pa[i].buf[0] < 1 ||
 			    rdwr_pa[i].len < rdwr_pa[i].buf[0] +
 					     I2C_SMBUS_BLOCK_MAX) {
+				i++;
 				res = -EINVAL;
 				break;
 			}
-- 
2.20.1



