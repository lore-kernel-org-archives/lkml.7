Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78944C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAE23711
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 16:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567527916;
	bh=Yyh/X5Nvc/YP7vxCIa5rLB+CfoURSPuz+berxUZPKkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KWaxAHcH2qycZucJXDeIPMilaJAVzmEWjkOYt5CJZ81CCTOBzCdUxXCKrTCC/X4f7
	 LuS/5t2hIOjr/1S6XcuNtQPkhZaL/k68DTFMdtCWhGN45VO/TmB23HFHHfUXRKGQwf
	 7JlwPuq4xMLSnP0HcsxmSTAPjvWhMI3f8/WFk2Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730319AbfICQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:44900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730261AbfICQZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 12:25:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 563FB23431;
        Tue,  3 Sep 2019 16:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567527908;
        bh=Yyh/X5Nvc/YP7vxCIa5rLB+CfoURSPuz+berxUZPKkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNIu6XuvLUD45W/RvX78c9OI79KXl1MZlNNc5UC1XsvDWoSl0z+2scHqWiYxgi5yw
         hoDyxgYjvaTjg8OriwMTXjyDvamN7BNFPGkNBGaC5dVjxKX4qg5D9wNTOlGNH3D5ol
         orvGVMdxnN4ynX+ud9hG0ZdmlwOtIGG13fyIw1z0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.2 18/23] virtio/s390: fix race on airq_areas[]
Date:   Tue,  3 Sep 2019 12:24:19 -0400
Message-Id: <20190903162424.6877-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190903162424.6877-1-sashal@kernel.org>
References: <20190903162424.6877-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Halil Pasic <pasic@linux.ibm.com>

[ Upstream commit 4f419eb14272e0698e8c55bb5f3f266cc2a21c81 ]

The access to airq_areas was racy ever since the adapter interrupts got
introduced to virtio-ccw, but since commit 39c7dcb15892 ("virtio/s390:
make airq summary indicators DMA") this became an issue in practice as
well. Namely before that commit the airq_info that got overwritten was
still functional. After that commit however the two infos share a
summary_indicator, which aggravates the situation. Which means
auto-online mechanism occasionally hangs the boot with virtio_blk.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 96b14536d935 ("virtio-ccw: virtio-ccw adapter interrupt support.")
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/virtio/virtio_ccw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 6a30768813219..8d47ad61bac3d 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -132,6 +132,7 @@ struct airq_info {
 	struct airq_iv *aiv;
 };
 static struct airq_info *airq_areas[MAX_AIRQ_AREAS];
+static DEFINE_MUTEX(airq_areas_lock);
 
 #define CCW_CMD_SET_VQ 0x13
 #define CCW_CMD_VDEV_RESET 0x33
@@ -244,9 +245,11 @@ static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 	unsigned long bit, flags;
 
 	for (i = 0; i < MAX_AIRQ_AREAS && !indicator_addr; i++) {
+		mutex_lock(&airq_areas_lock);
 		if (!airq_areas[i])
 			airq_areas[i] = new_airq_info();
 		info = airq_areas[i];
+		mutex_unlock(&airq_areas_lock);
 		if (!info)
 			return 0;
 		write_lock_irqsave(&info->lock, flags);
-- 
2.20.1

