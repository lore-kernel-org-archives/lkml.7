Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E68AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53D7D217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552410957;
	bh=fyoiYFkmVdt54Ha06/C5gs1UBSUQYtcD8g5jgm/OS/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kyUmIdfGvHJGM4xfooUXWtjhATbpMXUhgfRe0u6XAF79E8Rmri/r7iqv5KDf/SNAz
	 EBvwPyXPJJxYw86vIzNJrr+k3VqzKrfr8L0KpABUiMKIwpGn4K7eSw7pNONTv1SlMP
	 nayapg1c3cLx69z6qFEyEY73jldrx+11L8XOh3tY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbfCLRP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:15:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbfCLRPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:15:02 -0400
Received: from localhost (unknown [104.133.8.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 279922186A;
        Tue, 12 Mar 2019 17:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552410901;
        bh=fyoiYFkmVdt54Ha06/C5gs1UBSUQYtcD8g5jgm/OS/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eGYtQMSK+UQVdjT1cWX+0atkFA0tdgKn+FCDwTJ+2hvcGZ4ZZ2Q4IdyqbRvdCZfzx
         YqMEXDH2vXjiI7bl0eKgTnrboILPEgkFeW0EtL7TYXHLM0Jv3pHbCTMWUygPEgr903
         0S2LKZySEQkgYNcx4sQKu2bbQzgoUOKnQJHy7Mjg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 114/149] drm/amdgpu: use spin_lock_irqsave to protect vm_manager.pasid_idr
Date:   Tue, 12 Mar 2019 10:08:52 -0700
Message-Id: <20190312170359.036898726@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190312170349.421581206@linuxfoundation.org>
References: <20190312170349.421581206@linuxfoundation.org>
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

[ Upstream commit 0a5f49cbf9d6ad3721c16f8a6d823363ea7a160f ]

amdgpu_vm_get_task_info is called from interrupt handler and sched timeout
workqueue, we should use irq version spin_lock to avoid deadlock.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a84526e20e0..49fe5084c53d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3011,14 +3011,15 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int pasid,
 			 struct amdgpu_task_info *task_info)
 {
 	struct amdgpu_vm *vm;
+	unsigned long flags;
 
-	spin_lock(&adev->vm_manager.pasid_lock);
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
 
 	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm)
 		*task_info = vm->task_info;
 
-	spin_unlock(&adev->vm_manager.pasid_lock);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
 }
 
 /**
-- 
2.19.1



