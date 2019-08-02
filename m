Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE063C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8832067D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564740395;
	bh=y/tFP1q6ez118d5g/w5ccfPqluyoGvl2LPmw7pO1EuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=K/pxdVCxdhM5kDeVkrJMsBnM0n8y+K9wPPTX6EBWs/T2dGm1QtM+B4K3jpcCmKJJm
	 cvjZxoW5ZjJAq7onsAwCVXR2spOcvdlknnf7KXaylwyxppN0CsAVoZ7932Da1b5qWm
	 FNrsF4oCdupHDfDT5ehqyAiXAL/Td05QVpzqh+G4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391699AbfHBKGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 06:06:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390974AbfHBJbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:31:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE144217D6;
        Fri,  2 Aug 2019 09:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564738259;
        bh=y/tFP1q6ez118d5g/w5ccfPqluyoGvl2LPmw7pO1EuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clDCEXECu1Tlob09B8vgsG/aKPYLpwb0VT4DasevdBCRoPQKEmohSX4QFUzMfSogQ
         6VryZXwS+3HesOVYzmWQ0y6813IUpGvOlnPwAy4MroYr/xTt60bu80n22lfRAcWRnA
         32FBtqNukO/9fwoNZfiOxXfyp1dcl0uoElzozrOc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Shailendra Verma <shailendra.v@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 017/158] media: staging: media: davinci_vpfe: - Fix for memory leak if decoder initialization fails.
Date:   Fri,  2 Aug 2019 11:27:18 +0200
Message-Id: <20190802092206.971621102@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190802092203.671944552@linuxfoundation.org>
References: <20190802092203.671944552@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 6995a659101bd4effa41cebb067f9dc18d77520d ]

Fix to avoid possible memory leak if the decoder initialization
got failed.Free the allocated memory for file handle object
before return in case decoder initialization fails.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/davinci_vpfe/vpfe_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/media/davinci_vpfe/vpfe_video.c b/drivers/staging/media/davinci_vpfe/vpfe_video.c
index 0fdff91624fd..43474f562b43 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe_video.c
+++ b/drivers/staging/media/davinci_vpfe/vpfe_video.c
@@ -406,6 +406,9 @@ static int vpfe_open(struct file *file)
 	/* If decoder is not initialized. initialize it */
 	if (!video->initialized && vpfe_update_pipe_state(video)) {
 		mutex_unlock(&video->lock);
+		v4l2_fh_del(&handle->vfh);
+		v4l2_fh_exit(&handle->vfh);
+		kfree(handle);
 		return -ENODEV;
 	}
 	/* Increment device users counter */
-- 
2.20.1



