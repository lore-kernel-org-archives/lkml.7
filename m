Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40047C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 122DF2166E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576519632;
	bh=lFMA8F5IsifbE13LGxhgzKLWUnJu7KQspWTXFnixgM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k/q8nbh4FsD6uBU6quIq0ZDzHI5d+q/TQdvKjU6m+HbKadTd0QBtf5fVTzkpF6Oa1
	 LVW6joHNA3pDaNmn332Zro7RzHOeRYzuPAp08jxMzmpX5V41+bK1iXP+1W5TV6+Aaj
	 FKglqGOq5jFML1ZeoKP/GQhmhhYQ4Mz0+HRiIbs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730111AbfLPSHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729761AbfLPSHI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:07:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2FC62072B;
        Mon, 16 Dec 2019 18:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519628;
        bh=lFMA8F5IsifbE13LGxhgzKLWUnJu7KQspWTXFnixgM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wL9EdyJXF0ignpRfhhUSrR6lVn9JX5KEwv5kZ7wVuxBHLSLgqoojyXL0HcqvhejLw
         3VXw/GgOOaVh16+WNBybMG1E6H4vx0DvTSXtSoHEXqnkdBNO99p6PUYGyeD1/JIHjD
         sk5VjEEOYPY99XZSii2ktXFuuNU3NKs4XHRhkiCQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Elaine Zhang <zhangqing@rock-chips.com>,
        Joseph Chen <chenjh@rock-chips.com>,
        Daniel Schultz <d.schultz@phytec.de>,
        Heiko Stuebner <heiko@sntech.de>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 137/140] mfd: rk808: Fix RK818 ID template
Date:   Mon, 16 Dec 2019 18:50:05 +0100
Message-Id: <20191216174829.596868253@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174747.111154704@linuxfoundation.org>
References: <20191216174747.111154704@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Schultz <d.schultz@phytec.de>

[ Upstream commit 37ef8c2c15bdc1322b160e38986c187de2b877b2 ]

The Rockchip PMIC driver can automatically detect connected component
versions by reading the ID_MSB and ID_LSB registers. The probe function
will always fail with RK818 PMICs because the ID_MSK is 0xFFF0 and the
RK818 template ID is 0x8181.

This patch changes this value to 0x8180.

Fixes: 9d6105e19f61 ("mfd: rk808: Fix up the chip id get failed")
Cc: stable@vger.kernel.org
Cc: Elaine Zhang <zhangqing@rock-chips.com>
Cc: Joseph Chen <chenjh@rock-chips.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mfd/rk808.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mfd/rk808.h b/include/linux/mfd/rk808.h
index d3156594674c2..338e0f6e2226b 100644
--- a/include/linux/mfd/rk808.h
+++ b/include/linux/mfd/rk808.h
@@ -443,7 +443,7 @@ enum {
 enum {
 	RK805_ID = 0x8050,
 	RK808_ID = 0x0000,
-	RK818_ID = 0x8181,
+	RK818_ID = 0x8180,
 };
 
 struct rk808 {
-- 
2.20.1



