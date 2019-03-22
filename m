Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F21FC10F03
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6742183E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254559;
	bh=0pZRMtgw5Cv0coooHofIALEsfReDkC6h/LQgKuWF8sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q+bLADF4KNntDojzZYa2Dx8fRJMcAfuAxNCYIdDm5QdEgyySTKCYc73dK7MwoY78V
	 sLxyTDHMEbRUZdabI/cbg0nKqtqNN787tcvlRJXcLzlsAWEQJ4gezF5oYY2i8lPELn
	 ownCSXfp7TM+THfkdJV3xPDWb4Tj75WmUWt9JusE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730629AbfCVLf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:35:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729668AbfCVLfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:35:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6ADA2082C;
        Fri, 22 Mar 2019 11:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254555;
        bh=0pZRMtgw5Cv0coooHofIALEsfReDkC6h/LQgKuWF8sI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3iIRxjK1tKH7T8os98o2F6XgLNTZ1GsWNbj8EwiVpqlEtUzfGseWiQ1i5kodT15m
         f/oUDTPaMY/9IihzJpGhAdxYbIg17NbdUeu40wFEOEYDs734UU03vC4W56f23l74zv
         4r0rkNynFT8Ko0sUMHN4v/I+0N78MX5P3zGms5RE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 157/230] gpu: ipu-v3: Fix CSI offsets for imx53
Date:   Fri, 22 Mar 2019 12:14:55 +0100
Message-Id: <20190322111247.735501758@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

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
index 0c51b1dde494..df295a0ce87d 100644
--- a/drivers/gpu/ipu-v3/ipu-common.c
+++ b/drivers/gpu/ipu-v3/ipu-common.c
@@ -762,8 +762,8 @@ static struct ipu_devtype ipu_type_imx53 = {
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



