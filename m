Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750E5C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458FD218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 13:15:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="X8qk1vIN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfLSNPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 08:15:36 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:30947 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbfLSNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 08:15:35 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576761335; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MatkvjJ++f5xYHSRzGDp53AIHwv/yYm+qCfukmt6X8c=; b=X8qk1vINpmH+IJqhWIUYrbZIqtdGLNpMgE5cv4+DjBcYVUyLqBWejmRH3y5omxrOqo5Sa5sh
 g+gZ5VSYd/9/1q5oGXJSY/Gvn8Q4gQ9N9kkn9oIDL7otnct1F7qlxH2NQb+/pWJxIrgCrowi
 R6xro8BSovYrl2We34iu673f1GM=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb77f3.7fc3d169fe68-smtp-out-n03;
 Thu, 19 Dec 2019 13:15:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0DE6BC447A4; Thu, 19 Dec 2019 13:15:30 +0000 (UTC)
Received: from smasetty-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: smasetty)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 15F0AC447A3;
        Thu, 19 Dec 2019 13:15:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 15F0AC447A3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=smasetty@codeaurora.org
From:   Sharat Masetty <smasetty@codeaurora.org>
To:     freedreno@lists.freedesktop.org
Cc:     dri-devel@freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org,
        iommu@lists.linux-foundation.org, jcrouse@codeaurora.org,
        saiprakash.ranjan@codeaurora.org,
        Sharat Masetty <smasetty@codeaurora.org>
Subject: [PATCH 0/5] drm/msm/a6xx: System Cache Support
Date:   Thu, 19 Dec 2019 18:44:41 +0530
Message-Id: <1576761286-20451-1-git-send-email-smasetty@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware variants contain a system level cache or the last level
cache(llc). This cache is typically a large block which is shared by multiple
clients on the SOC. GPU uses the system cache to cache both the GPU data
buffers(like textures) as well the SMMU pagetables. This helps with
improved render performance as well as lower power consumption by reducing
the bus traffic to the system memory.

The system cache architecture allows the cache to be split into slices which
then be used by multiple SOC clients. This patch series is an effort to enable
and use two of those slices perallocated for the GPU, one for the GPU data
buffers and another for the GPU SMMU hardware pagetables.

To enable the system cache driver, add [1] to your stack if not already
present. Please review.

[1] https://lore.kernel.org/patchwork/patch/1165298/

Jordan Crouse (1):
  iommu/arm-smmu: Pass io_pgtable_cfg to impl specific init_context

Sharat Masetty (3):
  drm/msm: rearrange the gpu_rmw() function
  drm/msm: Pass mmu features to generic layers
  drm/msm/a6xx: Add support for using system cache(LLC)

Vivek Gautam (1):
  iommu/arm-smmu: Add domain attribute for QCOM system cache

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 122 +++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h   |   9 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |   4 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |   2 +-
 drivers/gpu/drm/msm/msm_drv.c           |   8 +++
 drivers/gpu/drm/msm/msm_drv.h           |   1 +
 drivers/gpu/drm/msm/msm_gpu.c           |   6 +-
 drivers/gpu/drm/msm/msm_gpu.h           |   6 +-
 drivers/gpu/drm/msm/msm_iommu.c         |  13 ++++
 drivers/gpu/drm/msm/msm_mmu.h           |  14 ++++
 drivers/iommu/arm-smmu-impl.c           |   3 +-
 drivers/iommu/arm-smmu-qcom.c           |  10 +++
 drivers/iommu/arm-smmu.c                |  25 +++++--
 drivers/iommu/arm-smmu.h                |   4 +-
 include/linux/iommu.h                   |   1 +
 19 files changed, 216 insertions(+), 20 deletions(-)

--
1.9.1
