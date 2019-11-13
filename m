Return-Path: <SRS0=LLNM=ZF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED51C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788F221D7F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Nov 2019 02:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573611849;
	bh=/fUyGVnz4vUZV7QqWfrT9JvA8+OesvTPpl/KA51g0nE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2ndmES9krhvA7+M9SCdju9kN7nKwWu2fyxEKPRmh9U+HnZvKL1ia6Yp8E1f7VGzN3
	 W+3gQ+g/D1H+Ssq5hfkl8tu2+rXo5eOiZAVleKLBAqxvoGKgheloiybp0SzwIdc1Ip
	 wKdr9UoIj8Uj6qhRyAW58uri1qk8SLfKcAitonAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbfKMCYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 21:24:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:40812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728185AbfKMBwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 20:52:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5D4E222CE;
        Wed, 13 Nov 2019 01:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573609933;
        bh=/fUyGVnz4vUZV7QqWfrT9JvA8+OesvTPpl/KA51g0nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vF2i8ldmfvVQirprQN2PW38v/4lQD5dFlF7ixj3QVAb0h4RB5Zr1geiezZIsQEN8J
         ttqNCZhxaXaNUt6R38GSY6fRZ9Y4LPXnR/iDYgsHwvxkVXZdH/lyRMaKsubjj627wf
         uyRviSqM8Qo1ueQr1wl3Jw7H12Of3UTaZgBtDvII=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arun Kumar Neelakantam <aneela@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 078/209] rpmsg: glink: smem: Support rx peak for size less than 4 bytes
Date:   Tue, 12 Nov 2019 20:48:14 -0500
Message-Id: <20191113015025.9685-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191113015025.9685-1-sashal@kernel.org>
References: <20191113015025.9685-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arun Kumar Neelakantam <aneela@codeaurora.org>

[ Upstream commit 928002a5e9dab2ddc1a0fe3e00739e89be30dc6b ]

The current rx peak function fails to read the data if size is
less than 4bytes.

Use memcpy_fromio to support data reads of size less than 4 bytes.

Cc: stable@vger.kernel.org
Fixes: f0beb4ba9b18 ("rpmsg: glink: Remove chunk size word align warning")
Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_glink_smem.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index 2b5cf27909540..7b6544348a3e0 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -89,15 +89,11 @@ static void glink_smem_rx_peak(struct qcom_glink_pipe *np,
 		tail -= pipe->native.length;
 
 	len = min_t(size_t, count, pipe->native.length - tail);
-	if (len) {
-		__ioread32_copy(data, pipe->fifo + tail,
-				len / sizeof(u32));
-	}
+	if (len)
+		memcpy_fromio(data, pipe->fifo + tail, len);
 
-	if (len != count) {
-		__ioread32_copy(data + len, pipe->fifo,
-				(count - len) / sizeof(u32));
-	}
+	if (len != count)
+		memcpy_fromio(data + len, pipe->fifo, (count - len));
 }
 
 static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
-- 
2.20.1

