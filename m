Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6EC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC69218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962401;
	bh=VdwnfoZOwTW/qkf1SJD7k6BhKVlobA00pdlu90t0HTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q4NaEHipXywfAH84vkmvYuA15ePg5IXlyyjXvFeTrTK8qpUrgjPsjK9ushjxanR55
	 j3wJkMPgv8pPWpn+6bvut0Jj4BeKWq0b1Jy1fssfSKDPcBr3NldP5obtJQG/aN0DXL
	 Dnei2Km0sZzt/UMCPpFHo2Jk5caiSOVGx9ySI1Tg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfDVTqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:46:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfDVTqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:46:36 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98D02218D9;
        Mon, 22 Apr 2019 19:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962396;
        bh=VdwnfoZOwTW/qkf1SJD7k6BhKVlobA00pdlu90t0HTY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EE8HQ8COHevuv3kuohQVtUepTU3Iu0peMnVo9AMcVbwM/j91VpOO7cnc5iveK1RkW
         OVp+3BKr5Anrex7B7xQZoZrl66BCeZVhpIkGzOUsprfw6gTbvWG0X3YwNFDN2YR7Yl
         O2w0MXdnH+Mw3GLcrXef7mWT2vT4oARpiGmpLqpw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.19 34/68] staging: rtlwifi: Fix potential NULL pointer dereference of kzalloc
Date:   Mon, 22 Apr 2019 15:44:42 -0400
Message-Id: <20190422194516.11634-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194516.11634-1-sashal@kernel.org>
References: <20190422194516.11634-1-sashal@kernel.org>
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
index 9930ed954abb..4cc77b2016e1 100644
--- a/drivers/staging/rtlwifi/phydm/rtl_phydm.c
+++ b/drivers/staging/rtlwifi/phydm/rtl_phydm.c
@@ -180,6 +180,8 @@ static int rtl_phydm_init_priv(struct rtl_priv *rtlpriv,
 
 	rtlpriv->phydm.internal =
 		kzalloc(sizeof(struct phy_dm_struct), GFP_KERNEL);
+	if (!rtlpriv->phydm.internal)
+		return 0;
 
 	_rtl_phydm_init_com_info(rtlpriv, ic, params);
 
-- 
2.19.1

