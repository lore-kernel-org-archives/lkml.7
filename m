Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0BAC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27FE22186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610754;
	bh=rF+Wvh0psB2+lZH1CCbeb4BeZB8yJQ/sEkCb/oYaytU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AoyHPvAEIefRT978YyurRkp18GKieFtvyOFlBV+k/fXjd/tuqm+PQ5UfFBKuitRcz
	 at5yEmYualIZYyxxU936Q8XS9KpZrCE6vu0S20g2aUszqxaAcc1rIE8UfwJ09TTf2K
	 THEJOB7reTai5TR6JMIySWppi4vywC460EnXknOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391396AbfDRSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391365AbfDRSFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:05:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F0E217FA;
        Thu, 18 Apr 2019 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610746;
        bh=rF+Wvh0psB2+lZH1CCbeb4BeZB8yJQ/sEkCb/oYaytU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ9rKRDYIw69V2CzxtlqOIqVrA6EqJTX+7Y9r6GSD/cXR7fQWF5HFqgvCO/nzUxFN
         /SqwNySFo2HT719BiDX5EKGYO5+iak6v+DB21aOSS81xi0uyqvKpHHmar1csu9paPz
         GEJq0fjrZVB9Dd8vLpB7b20Novo3KS2uyWb1fsbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kevin Wang <kevin1.wang@amd.com>,
        Oak Zeng <Oak.Zeng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 67/92] drm/amdkfd: use init_mqd function to allocate object for hid_mqd (CI)
Date:   Thu, 18 Apr 2019 19:57:25 +0200
Message-Id: <20190418160436.083506334@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit cac734c2dbd2514f14c8c6a17caba1990d83bf1d ]

if use the legacy method to allocate object, when mqd_hiq need to run
uninit code, it will be cause WARNING call trace.

eg: (s3 suspend test)
[   34.918944] Call Trace:
[   34.918948]  [<ffffffff92961dc1>] dump_stack+0x19/0x1b
[   34.918950]  [<ffffffff92297648>] __warn+0xd8/0x100
[   34.918951]  [<ffffffff9229778d>] warn_slowpath_null+0x1d/0x20
[   34.918991]  [<ffffffffc03ce1fe>] uninit_mqd_hiq_sdma+0x4e/0x50 [amdgpu]
[   34.919028]  [<ffffffffc03d0ef7>] uninitialize+0x37/0xe0 [amdgpu]
[   34.919064]  [<ffffffffc03d15a6>] kernel_queue_uninit+0x16/0x30 [amdgpu]
[   34.919086]  [<ffffffffc03d26c2>] pm_uninit+0x12/0x20 [amdgpu]
[   34.919107]  [<ffffffffc03d4915>] stop_nocpsch+0x15/0x20 [amdgpu]
[   34.919129]  [<ffffffffc03c1dce>] kgd2kfd_suspend.part.4+0x2e/0x50 [amdgpu]
[   34.919150]  [<ffffffffc03c2667>] kgd2kfd_suspend+0x17/0x20 [amdgpu]
[   34.919171]  [<ffffffffc03c103a>] amdgpu_amdkfd_suspend+0x1a/0x20 [amdgpu]
[   34.919187]  [<ffffffffc02ec428>] amdgpu_device_suspend+0x88/0x3a0 [amdgpu]
[   34.919189]  [<ffffffff922e22cf>] ? enqueue_entity+0x2ef/0xbe0
[   34.919205]  [<ffffffffc02e8220>] amdgpu_pmops_suspend+0x20/0x30 [amdgpu]
[   34.919207]  [<ffffffff925c56ff>] pci_pm_suspend+0x6f/0x150
[   34.919208]  [<ffffffff925c5690>] ? pci_pm_freeze+0xf0/0xf0
[   34.919210]  [<ffffffff926b45c6>] dpm_run_callback+0x46/0x90
[   34.919212]  [<ffffffff926b49db>] __device_suspend+0xfb/0x2a0
[   34.919213]  [<ffffffff926b4b9f>] async_suspend+0x1f/0xa0
[   34.919214]  [<ffffffff922c918f>] async_run_entry_fn+0x3f/0x130
[   34.919216]  [<ffffffff922b9d4f>] process_one_work+0x17f/0x440
[   34.919217]  [<ffffffff922bade6>] worker_thread+0x126/0x3c0
[   34.919218]  [<ffffffff922bacc0>] ? manage_workers.isra.25+0x2a0/0x2a0
[   34.919220]  [<ffffffff922c1c31>] kthread+0xd1/0xe0
[   34.919221]  [<ffffffff922c1b60>] ? insert_kthread_work+0x40/0x40
[   34.919222]  [<ffffffff92974c1d>] ret_from_fork_nospec_begin+0x7/0x21
[   34.919224]  [<ffffffff922c1b60>] ? insert_kthread_work+0x40/0x40
[   34.919224] ---[ end trace 38cd9f65c963adad ]---

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  | 52 +------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 164fa4b1f9a9..732b8fbbca68 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -285,57 +285,7 @@ static int init_mqd_hiq(struct mqd_manager *mm, void **mqd,
 		struct kfd_mem_obj **mqd_mem_obj, uint64_t *gart_addr,
 		struct queue_properties *q)
 {
-	uint64_t addr;
-	struct cik_mqd *m;
-	int retval;
-
-	retval = kfd_gtt_sa_allocate(mm->dev, sizeof(struct cik_mqd),
-					mqd_mem_obj);
-
-	if (retval != 0)
-		return -ENOMEM;
-
-	m = (struct cik_mqd *) (*mqd_mem_obj)->cpu_ptr;
-	addr = (*mqd_mem_obj)->gpu_addr;
-
-	memset(m, 0, ALIGN(sizeof(struct cik_mqd), 256));
-
-	m->header = 0xC0310800;
-	m->compute_pipelinestat_enable = 1;
-	m->compute_static_thread_mgmt_se0 = 0xFFFFFFFF;
-	m->compute_static_thread_mgmt_se1 = 0xFFFFFFFF;
-	m->compute_static_thread_mgmt_se2 = 0xFFFFFFFF;
-	m->compute_static_thread_mgmt_se3 = 0xFFFFFFFF;
-
-	m->cp_hqd_persistent_state = DEFAULT_CP_HQD_PERSISTENT_STATE |
-					PRELOAD_REQ;
-	m->cp_hqd_quantum = QUANTUM_EN | QUANTUM_SCALE_1MS |
-				QUANTUM_DURATION(10);
-
-	m->cp_mqd_control             = MQD_CONTROL_PRIV_STATE_EN;
-	m->cp_mqd_base_addr_lo        = lower_32_bits(addr);
-	m->cp_mqd_base_addr_hi        = upper_32_bits(addr);
-
-	m->cp_hqd_ib_control = DEFAULT_MIN_IB_AVAIL_SIZE;
-
-	/*
-	 * Pipe Priority
-	 * Identifies the pipe relative priority when this queue is connected
-	 * to the pipeline. The pipe priority is against the GFX pipe and HP3D.
-	 * In KFD we are using a fixed pipe priority set to CS_MEDIUM.
-	 * 0 = CS_LOW (typically below GFX)
-	 * 1 = CS_MEDIUM (typically between HP3D and GFX
-	 * 2 = CS_HIGH (typically above HP3D)
-	 */
-	m->cp_hqd_pipe_priority = 1;
-	m->cp_hqd_queue_priority = 15;
-
-	*mqd = m;
-	if (gart_addr)
-		*gart_addr = addr;
-	retval = mm->update_mqd(mm, m, q);
-
-	return retval;
+	return init_mqd(mm, mqd, mqd_mem_obj, gart_addr, q);
 }
 
 static int update_mqd_hiq(struct mqd_manager *mm, void *mqd,
-- 
2.19.1



