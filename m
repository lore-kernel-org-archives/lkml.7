Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F15EC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562E9204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555963127;
	bh=yhtmNOLn+AJ/PA7kXEEy3H/Wi1ENlcrS4/Wk1VWO/0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=G0BN1QmjFfEN5qmV6yqI75jqt27KJzNmLmDgQgta5xWmwu8UQ2y4T2ni3h5nnUwR6
	 2YJb8N00K3JYeiioVlIB0XMzj3FXKuUdEvFiC2bgUF1cIqakVpz4kxuFm+dpxA4G9m
	 TTGN1fCVw5ueomOnWJTLhhJFsgn+W2AgAqYOgoRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731813AbfDVT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:58:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730496AbfDVTsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:48:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667B9218FD;
        Mon, 22 Apr 2019 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962498;
        bh=yhtmNOLn+AJ/PA7kXEEy3H/Wi1ENlcrS4/Wk1VWO/0k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=heSrk7kLafl7kgIcLXC8R7GeUkltRIbCuK6PtjspZKxz/v5qsQc5dIV6FMHQ8huyn
         yOd2yQyH8Zg6b88zQ3B9vdg/uKt5uxxtVjv+PXDpuvzPJIv210fkkAjdjqPQs1ae4R
         x3SJfQ+qH4/gpFJGE61hXEQF30ifDV6YofcUuNFc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 21/43] staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc
Date:   Mon, 22 Apr 2019 15:47:05 -0400
Message-Id: <20190422194727.12495-21-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194727.12495-1-sashal@kernel.org>
References: <20190422194727.12495-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>

[ Upstream commit 6a8ca24590a2136921439b376c926c11a6effc0e ]

phydm.internal is allocated using kzalloc which is used multiple
times without a check for NULL pointer. This patch avoids such a
scenario by returning 0, consistent with the failure case.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 drivers/staging/rtlwifi/phydm/rtl_phydm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/phydm/rtl_phydm.c b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
index 85e490d3601f..cab563fefc34 100644
--- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
+++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
@@ -191,6 +191,8 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
 
 	rtlpriv->phydm.internal =
 		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
+	if (!rtlpriv->phydm.internal)
+		return 0;
 
 	_rtl_phydm_init_com_info(rtlpriv, ic, params);
 
-- 
2.19.1

