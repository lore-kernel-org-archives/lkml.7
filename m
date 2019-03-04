Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6C4C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2DD2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688334;
	bh=omIg148o8yb8AXTGo8Ox3jvNp1zZoWcghBohp2Xbmjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q0mZjbUX2jWCrB/mP2uXiflwNo95sCnW6advsku2u/AR1oydfVgW4ULvp/6WSKNMX
	 luRCIbM0qN9DnjtLA+5schhZp4VQh84LcFvzmVSIHKdtBCeCElScZFVz70SiHcCp2m
	 mZgD5kFMgau3JYUrKWP162t3ZnwAv/4YanVP9P6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbfCDIcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbfCDIcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:08 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EFA420823;
        Mon,  4 Mar 2019 08:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688327;
        bh=omIg148o8yb8AXTGo8Ox3jvNp1zZoWcghBohp2Xbmjo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AmtuoE0XxT1CH2RvPGAJxAoLZ9njg2wrwNmCRgRbRdP1DRBnkvM0ZvvHLLaZV6yUe
         +aX5UO4+XK5CvJUDLyG/HOM1jlQ9Ph2SD8c1oKOdIpITa9GUh3w5YtYc6TYCypVFrX
         192NWz047Kzdz7g863z+v2ockIVdlQNTF89TrnKw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Kristian H. Kristensen" <hoegsberg@chromium.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 03/88] drm/msm: Unblock writer if reader closes file
Date:   Mon,  4 Mar 2019 09:21:46 +0100
Message-Id: <20190304081630.739682091@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 99c66bc051e7407fe0bf0607b142ec0be1a1d1dd ]

Prevents deadlock when fifo is full and reader closes file.

Signed-off-by: Kristian H. Kristensen <hoegsberg@chromium.org>
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/msm_rd.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_rd.c b/drivers/gpu/drm/msm/msm_rd.c
index 0c2c8d2c631f3..25fc161ab6181 100644
--- a/drivers/gpu/drm/msm/msm_rd.c
+++ b/drivers/gpu/drm/msm/msm_rd.c
@@ -115,7 +115,9 @@ static void rd_write(struct msm_rd_state *rd, const void *buf, int sz)
 		char *fptr = &fifo->buf[fifo->head];
 		int n;
 
-		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0);
+		wait_event(rd->fifo_event, circ_space(&rd->fifo) > 0 || !rd->open);
+		if (!rd->open)
+			return;
 
 		/* Note that smp_load_acquire() is not strictly required
 		 * as CIRC_SPACE_TO_END() does not access the tail more
@@ -213,7 +215,10 @@ static int rd_open(struct inode *inode, struct file *file)
 static int rd_release(struct inode *inode, struct file *file)
 {
 	struct msm_rd_state *rd = inode->i_private;
+
 	rd->open = false;
+	wake_up_all(&rd->fifo_event);
+
 	return 0;
 }
 
-- 
2.19.1



