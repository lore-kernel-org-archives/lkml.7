Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD48C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A23CB2469E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576012086;
	bh=SBUx8yMp2GaWVuXdQGHugz9n6zPokEyvWLzJ9x4GqU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VA3DJdmOhjBsBMA11o+GiM0QNhllVzRfpHS+yNHoFDPFE1tp8+yBorr23dUSg/abY
	 YzEs1XvmKZbMmCCNzIA71iUVG7F/4jNv2xA+AJeouKn2KYcKOSi/4mDgxZiYVZLOfr
	 QfJbkPOMLEr9JnI8G8MAvoxE04hGA0r3wR66lB4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfLJVIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:54612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727665AbfLJVHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:07:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 535282468B;
        Tue, 10 Dec 2019 21:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576012073;
        bh=SBUx8yMp2GaWVuXdQGHugz9n6zPokEyvWLzJ9x4GqU8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=whdJJl7MCMzVqPkTV8iz0elwtIhrANvDrJfM6H5cWyIEhNRg4soUbd/ndZfUt1Yjh
         nSv+ypy2fByHVZ9AUvDAe7M/c0pBHWWi7YHKQx3M7KxAPEtGPUlWbvZAf6cNgXfuat
         I9rnsH9ukG5k4p9kq7zguqHsfdOpzyMp648fw7RI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Allen Pais <allen.pais@oracle.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 5.4 053/350] drm/amdkfd: fix a potential NULL pointer dereference (v2)
Date:   Tue, 10 Dec 2019 16:02:38 -0500
Message-Id: <20191210210735.9077-14-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210735.9077-1-sashal@kernel.org>
References: <20191210210735.9077-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>

[ Upstream commit 81de29d842ccb776c0f77aa3e2b11b07fff0c0e2 ]

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

v2 (Felix Kuehling):
* Fix compile error (kfifo_free instead of fifo_free)
* Return proper error code

Signed-off-by: Allen Pais <allen.pais@oracle.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index c56ac47cd3189..bc47f6a444564 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -62,6 +62,11 @@ int kfd_interrupt_init(struct kfd_dev *kfd)
 	}
 
 	kfd->ih_wq = alloc_workqueue("KFD IH", WQ_HIGHPRI, 1);
+	if (unlikely(!kfd->ih_wq)) {
+		kfifo_free(&kfd->ih_fifo);
+		dev_err(kfd_chardev(), "Failed to allocate KFD IH workqueue\n");
+		return -ENOMEM;
+	}
 	spin_lock_init(&kfd->interrupt_lock);
 
 	INIT_WORK(&kfd->interrupt_work, interrupt_wq);
-- 
2.20.1

