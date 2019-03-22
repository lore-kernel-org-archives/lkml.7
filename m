Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9832192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255890;
	bh=IZ7oe5vqKOhUmjmlBijT5wwSTL34MUSzWantOanFr3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ppxlO2mBTMTYMDnws0U/oshGXn4la3eDyuq1A2IuDG4ZghKnibW0dvgLf75DZ0krE
	 InMPMgrRsLPt1Z7c6ar6Rbg0GLJpTny9K2Q8FllcdUgWtnj3aWTAV/9Gx9PgN17D/O
	 aoMoA13HYjujRc9uhKeXuUc36rhzuIRHPTeKLfTM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387776AbfCVL6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387406AbfCVL6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:58:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B91A20850;
        Fri, 22 Mar 2019 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255884;
        bh=IZ7oe5vqKOhUmjmlBijT5wwSTL34MUSzWantOanFr3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15daWqkmGviKxpWSi7c6YeGkEF4nDpRUXiG8Kfbe2c2NTQ4IZJb4KKCkorsw4OR1O
         UC0qsFDXLLU/n3XXsK2SK0oEb7qQPTyaTo2HADHm/WhJmnRn7midxWuSc986Z0Hu/X
         pH8QwzPiHtSln29B7vCFfEF68xZT6HIhHgB8miws=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 026/280] gpu: ipu-v3: Fix CSI offsets for imx53
Date:   Fri, 22 Mar 2019 12:12:59 +0100
Message-Id: <20190322111307.766782031@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bb867d219fda7fbaabea3314702474c4eac2b91d ]

The CSI offsets are wrong for both CSI0 and CSI1. They are at
physical address 0x1e030000 and 0x1e038000 respectively.

Fixes: 2ffd48f2e7 ("gpu: ipu-v3: Add Camera Sensor Interface unit")

Signed-off-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/ipu-v3/ipu-common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-common.c b/drivers/gpu/ipu-v3/ipu-common.c
index 5b7cdbfe062f..0a7d4395d427 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -914,8 +914,8 @@ static struct ipu_devtype ipu_type_imx53 = {
 	.cpmem_ofs = 0x07000000,
 	.srm_ofs = 0x07040000,
 	.tpm_ofs = 0x07060000,
-	.csi0_ofs = 0x07030000,
-	.csi1_ofs = 0x07038000,
+	.csi0_ofs = 0x06030000,
+	.csi1_ofs = 0x06038000,
 	.ic_ofs = 0x06020000,
 	.disp0_ofs = 0x06040000,
 	.disp1_ofs = 0x06048000,
-- 
2.19.1



