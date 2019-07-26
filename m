Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E3C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C705422CE5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564149574;
	bh=lT53jVn0x4o2nj7YOhRR5yqWqMQqPXBWboEqcOgNnb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ajR04guXYCdfAt8S2XFmBbrVvqPFfazQ4vlMeR4GpDqJSJJzNwJX7Mn21njrYOCEx
	 t8sUJG8wbwdFYLOltgqYDAaanROQLWJQWk7RgcaHbVkIjNmgxLZKL/lFRptUvkNT5g
	 HyNAS6/EmUHpU7/gtmRS9gT0S3NYugY4LncUqXc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388058AbfGZN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:46490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387423AbfGZNk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:40:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93BAE22BE8;
        Fri, 26 Jul 2019 13:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564148426;
        bh=lT53jVn0x4o2nj7YOhRR5yqWqMQqPXBWboEqcOgNnb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jg3B5WedHTAKoUQ0ScBeOq56eeLdYN3AhVQtnI2eAeE6NChXxYK6vv4Nk6awA3+U+
         0rf+zCsjkK3s4+SUDvEurDyB08uyfnoiIekWhr0H/S01jb5i3OfBu7DY3l5txVy1KU
         jSKUIBjrhTxIpByxAaDMp4AFss3/+WuY1T5YdF6I=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Clement Leger <cleger@kalray.eu>,
        Loic Pallardy <loic.pallardy@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 29/85] remoteproc: copy parent dma_pfn_offset for vdev
Date:   Fri, 26 Jul 2019 09:38:39 -0400
Message-Id: <20190726133936.11177-29-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190726133936.11177-1-sashal@kernel.org>
References: <20190726133936.11177-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Leger <cleger@kalray.eu>

[ Upstream commit 72f64cabc4bd6985c7355f5547bd3637c82762ac ]

When preparing the subdevice for the vdev, also copy dma_pfn_offset
since this is used for sub device dma allocations. Without that, there
is incoherency between the parent dma settings and the childs one,
potentially leading to dma_alloc_coherent failure (due to phys_to_dma
using dma_pfn_offset for translation).

Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Clement Leger <cleger@kalray.eu>
Acked-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/remoteproc_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 8b5363223eaa..5031c6806908 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -512,6 +512,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
 	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
 	dev_set_drvdata(&rvdev->dev, rvdev);
-- 
2.20.1

