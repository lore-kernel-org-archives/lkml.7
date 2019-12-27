Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27E8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C734B20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577470627;
	bh=5IQQywv2xDBRw4N0f7mJESsiAz5u/PuZxZiBlyv7lsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2uvn7aKqdgej2DrmUSiDhL1FuA+B4DYBB/IPS4yXtu6nRPp121viR3ExPJ+co76Z
	 6F2BXs+7MxHr4PMt7w/SmasMKt0RId6U0muD4ZZIV4V9wH/vTXdzFrEFcD31/0jgdi
	 jrbH73NQpE2AP7g1BTTlWEDi74AZC9f2lB38M9xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbfL0SRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 13:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:41266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbfL0SQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 13:16:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 537E8208C4;
        Fri, 27 Dec 2019 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577470567;
        bh=5IQQywv2xDBRw4N0f7mJESsiAz5u/PuZxZiBlyv7lsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JxF60Uea3uQ2yZNhTG0xTlAO23+qMAiKQmwczWvJyhaX2JoK8V+C7NwK8g/MT1D9z
         WTVy887hqiHYAjgJPwA+g2iwpbTkfCP+xKyRU6CEaSF/aQN12pFee1EfSOnmPOUYUV
         fmzGDtQP7DdpaOE4QcxIPCTaiG9BNqlHOR48M5w0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 14/25] bnx2x: Fix logic to get total no. of PFs per engine
Date:   Fri, 27 Dec 2019 13:15:38 -0500
Message-Id: <20191227181549.8040-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227181549.8040-1-sashal@kernel.org>
References: <20191227181549.8040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

[ Upstream commit ee699f89bdbaa19c399804504241b5c531b48888 ]

Driver doesn't calculate total number of PFs configured on a
given engine correctly which messed up resources in the PFs
loaded on that engine, leading driver to exceed configuration
of resources (like vlan filters etc.) beyond the limit per
engine, which ended up with asserts from the firmware.

Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index b7d32e8412f1..ec2122acc3c1 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1107,7 +1107,7 @@ static inline u8 bnx2x_get_path_func_num(struct bnx2x *bp)
 		for (i = 0; i < E1H_FUNC_MAX / 2; i++) {
 			u32 func_config =
 				MF_CFG_RD(bp,
-					  func_mf_config[BP_PORT(bp) + 2 * i].
+					  func_mf_config[BP_PATH(bp) + 2 * i].
 					  config);
 			func_num +=
 				((func_config & FUNC_MF_CFG_FUNC_HIDE) ? 0 : 1);
-- 
2.20.1

