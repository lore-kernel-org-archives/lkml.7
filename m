Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62840C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ACA22075E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255188;
	bh=rbL8NuB46sBcfxqUCQzlMoedAXk/RqnEImWSHQ3gw2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l9BIYiKk6O5gfHDhhwmPSer7ZIk3ihe6sX6SRXjjEM7s5GtqgyamYwWbFlY1udy+L
	 0d3QNsVg1R1udgl0hp/88fsQX6KxCK6KVLlcPspeYMaXsGzI4mFfkYOL1FQ6vP6pBe
	 gX8wWGK2gilz2zEGak7NhIVQPLRnL4yh7ancmkGo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbfCVLq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732039AbfCVLqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:46:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9E2921916;
        Fri, 22 Mar 2019 11:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255179;
        bh=rbL8NuB46sBcfxqUCQzlMoedAXk/RqnEImWSHQ3gw2E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j69jridUyiTcJ8RTuyzpLXhff4vXXn3nIJNuvxNmDWj2DdAC+EOXhd00VzzaQXId8
         9s/0ZzU7R6si9SWY8o2Ptxt+USVFWfrqcC9plXbcluR0iU0O6wypviLiD5FWmb2/yL
         6QmZeN261qyhaEBsbjnVzdUIBx+DYkfLTiiUo+is=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Shiyan <shc_work@mail.ru>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 011/183] gpu: ipu-v3: Fix i.MX51 CSI control registers offset
Date:   Fri, 22 Mar 2019 12:13:59 +0100
Message-Id: <20190322111242.604922304@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 2c0408dd0d8906b26fe8023889af7adf5e68b2c2 ]

The CSI0/CSI1 registers offset is at +0xe030000/+0xe038000 relative
to the control module registers on IPUv3EX.
This patch fixes wrong values for i.MX51 CSI0/CSI1.

Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 2c8411b8d050..5f8b31f879ca 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -894,8 +894,8 @@ static struct ipu_devtype ipu_type_imx51 = {
 	.cpmem_ofs = 0x1f000000,
 	.srm_ofs = 0x1f040000,
 	.tpm_ofs = 0x1f060000,
-	.csi0_ofs = 0x1f030000,
-	.csi1_ofs = 0x1f038000,
+	.csi0_ofs = 0x1e030000,
+	.csi1_ofs = 0x1e038000,
 	.ic_ofs = 0x1e020000,
 	.disp0_ofs = 0x1e040000,
 	.disp1_ofs = 0x1e048000,
-- 
2.19.1



