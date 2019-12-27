Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBD5C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36D5206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 17:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577468820;
	bh=ZmekE+k1PgyuB6/a4NtSTGrTldWGFVwuQzAQvua1n2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpgzrZXPspgLCCrfEBWGbW7Kvj2OTNB5A6AipI+BFA/P0lssrZqInjEg8VbhtzgCu
	 05YInSQBjdSjiZ9Q5bPTvjk4dpw6lIiVJYWajjKVRUMSThyOcUhBQKzhbsS0+0+GQK
	 lyeiXI0De1M41bx2z5s82nkStdPCzR6jmwKc8HVw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfL0RpD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 12:45:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:43250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728128AbfL0Roy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 12:44:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E0D206F4;
        Fri, 27 Dec 2019 17:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577468693;
        bh=ZmekE+k1PgyuB6/a4NtSTGrTldWGFVwuQzAQvua1n2Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LOwhL4RmPqCJPSLe0YPC8fbIxbWGSF9SxdfqrDxA+J1FiPAFdtQmGnAjOLjBwDHkE
         uE8n82/kDqwtcOYBWryNwNq9vlscpragl32f5Rw4m3o0DbL2s3wsFJ23eT6cwcVPXW
         GbkmBP2e4A4n1s3n0exH/zke6e1iqCXLl5iHd+Eg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 50/84] bnx2x: Fix logic to get total no. of PFs per engine
Date:   Fri, 27 Dec 2019 12:43:18 -0500
Message-Id: <20191227174352.6264-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191227174352.6264-1-sashal@kernel.org>
References: <20191227174352.6264-1-sashal@kernel.org>
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
index ee5159ef837e..df5e8c2e8eaf 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1113,7 +1113,7 @@ static inline u8 bnx2x_get_path_func_num(struct bnx2x *bp)
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

