Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0AFC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BBC6206B8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 14:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563201011;
	bh=Z2C3HufjUHrPzmgZsm1CRu6TQ4yusZvqq5FNYlE8FfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MB790A3iuJ6TPz3heuXqfDPYqrsOfdLHMjVTdsR7eki/TCOQ1dhfObc1uoaawSg5W
	 K33rCV0Dgieb4+UMRXsHoqoRscIMiqzS+M1p498AENySKI8VTXjlilXuY8qYuDjiEH
	 xk1wjzUm3C2TeL0cQWr/ZH6tkD55qWZR9yq42liA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403886AbfGOOaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 10:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391640AbfGOOaH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 10:30:07 -0400
Received: from sasha-vm.mshome.net (unknown [73.61.17.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC68B205ED;
        Mon, 15 Jul 2019 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563201006;
        bh=Z2C3HufjUHrPzmgZsm1CRu6TQ4yusZvqq5FNYlE8FfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v5BVxSZ/Loqv/pr5bDOjYL9P6uwZ+o8xzoNKL5elcjMrrYQIj0jHQB/AFgOL4ug9z
         pQYPNYWbhIbk+6Cq/gGbKcI3NrakgOZNx88s2u8LmHNgseDjmAWOiVWvtIVL7uzGj6
         eG3Wk7SluH76SI1X443m8I3fum2IijJZVBA/20to=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Shailendra Verma <shailendra.v@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH AUTOSEL 4.14 025/105] media: staging: media: davinci_vpfe: - Fix for memory leak if decoder initialization fails.
Date:   Mon, 15 Jul 2019 10:27:19 -0400
Message-Id: <20190715142839.9896-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190715142839.9896-1-sashal@kernel.org>
References: <20190715142839.9896-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shailendra Verma <shailendra.v@samsung.com>

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
index 155e8c758e4b..346e60d230f3 100644
--- a/drivers/staging/media/davinci_vpfe/vpfe_video.c
+++ b/drivers/staging/media/davinci_vpfe/vpfe_video.c
@@ -422,6 +422,9 @@ static int vpfe_open(struct file *file)
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

