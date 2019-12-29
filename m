Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16B5C2D0D1
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DF0B207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577642961;
	bh=z+IZKJRaJPxusKXmSuBV2nkmuvRVyX141KVDsdaa2v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lJb8PHNpN/5UHWQcixLM1E7eNtON2DZqutT5nALvVd+owWDXKeVqkF8B0Lpvodt3N
	 ghoD26m7esvbzCF9C8l6BVG2AQnLWvUt8IXrgdJBSiGR8t6o/W1o09zIAH9y0H4DvS
	 NnYuR3Y1A6R4gEmdpdC4wjq2w30/b0zOxjVjEYCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730701AbfL2Rpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:45:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:55164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730970AbfL2Rpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:45:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B788A206A4;
        Sun, 29 Dec 2019 17:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577641550;
        bh=z+IZKJRaJPxusKXmSuBV2nkmuvRVyX141KVDsdaa2v8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H92k1kfuiS1xQDsgqo3YxBglNod3VP3VFQnNu+p3Sd/noMx5YCDJRjYKSISfxNrOl
         WlqMQAhMVWQ1aRUbbJuBMpbtVVsuwMgTc3OnEuxPsT4b47hqoCCNjVJHUwhUj/m6kx
         ZMkszgRQB5g8v+12rxWH9cc4UpBMNGVn9cwQQcXw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Kim <Jonathan.Kim@amd.com>,
        Oak Zeng <Oak.Zeng@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 113/434] drm/amdkfd: Fix MQD size calculation
Date:   Sun, 29 Dec 2019 18:22:46 +0100
Message-Id: <20191229172709.167510434@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229172702.393141737@linuxfoundation.org>
References: <20191229172702.393141737@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oak Zeng <Oak.Zeng@amd.com>

[ Upstream commit 40a9592a26608e16f7545a068ea4165e1869f629 ]

On device initialization, a chunk of GTT memory is pre-allocated for
HIQ and all SDMA queues mqd. The size of this allocation was wrong.
The correct sdma engine number should be PCIe-optimized SDMA engine
number plus xgmi SDMA engine number.

Reported-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Jonathan Kim <Jonathan.Kim@amd.com>
Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index d985e31fcc1e..f335f73919d1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1676,7 +1676,8 @@ static int allocate_hiq_sdma_mqd(struct device_queue_manager *dqm)
 	struct kfd_dev *dev = dqm->dev;
 	struct kfd_mem_obj *mem_obj = &dqm->hiq_sdma_mqd;
 	uint32_t size = dqm->mqd_mgrs[KFD_MQD_TYPE_SDMA]->mqd_size *
-		dev->device_info->num_sdma_engines *
+		(dev->device_info->num_sdma_engines +
+		dev->device_info->num_xgmi_sdma_engines) *
 		dev->device_info->num_sdma_queues_per_engine +
 		dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ]->mqd_size;
 
-- 
2.20.1



