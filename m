Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7F8C2D0CE
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B852207FF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 17:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577640671;
	bh=7Q4nsvkaGlRoybFthltF/3PxgZHKzpaUX9ZtKI5A5Cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v1f6ReZVIa/fzTTgudj89DmKNRYwJx0sbAmJN+JM7RqkxkW2aADM5ctVp+QMXkpHs
	 QbskY0hW37i7htRQupGjIFT7IFf/nPzkPK1Vv0CkYiTPzGje1TYuP4fAMa3iEh/HvX
	 mbHoXcnAM9pSYOfhRfJSBmv01NDxSQQtwmEOh7jg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfL2RbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Dec 2019 12:31:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729084AbfL2RbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Dec 2019 12:31:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B75F820409;
        Sun, 29 Dec 2019 17:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577640665;
        bh=7Q4nsvkaGlRoybFthltF/3PxgZHKzpaUX9ZtKI5A5Cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fDmICpeb6twfcVpFcwzYVu7wd7+uAKFJpAYz6QfpT5LOPumjSMsRqMeSLJ0+pGeVm
         ht2yuAO862lioCKcsveBVGYr75Q5zDkTl0xUPRsuztxfeeWrRwFZuA0j3ly1ufSSX5
         ZJdm893+bmqiLe83+Fymq5eOOHt7lHtzixcKuR7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Allen Pais <allen.pais@oracle.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 049/219] drm/amdkfd: fix a potential NULL pointer dereference (v2)
Date:   Sun, 29 Dec 2019 18:17:31 +0100
Message-Id: <20191229162514.935680587@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191229162508.458551679@linuxfoundation.org>
References: <20191229162508.458551679@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index c56ac47cd318..bc47f6a44456 100644
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



