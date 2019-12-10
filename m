Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF326C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 881D32467E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011895;
	bh=rNb+H5LSxb9ktazmFlQfBcK/babKnR1gKD6EbEEnGtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k6Ghxh1Xscp7SxWZ5xmBqrr63JBy0waJ/clDc6s+shWn82OL8cZSxnD9aCIgnUSGn
	 EhiUh6czpBwfegHFjGoGVqhiGlc1LnKr/S1E8Ga1JCa5urWCZcrQJ4pgEnRyMpl3b/
	 O06JTV1e9TniuC3ygTgc0l3ZpC8RzDuMe2PM/hFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbfLJVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:50060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727527AbfLJVEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10A702468B;
        Tue, 10 Dec 2019 21:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011886;
        bh=rNb+H5LSxb9ktazmFlQfBcK/babKnR1gKD6EbEEnGtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iYoxRUfaUbDmURu4ByP++vhPEaZshmOiIhBnVT9pJ9Is3dnmcPxZFavPr8Mqlwzq5
         I+fETX5pukwO0yBYBV2kZ3FJHbxDJwmGv9FSvFJSsVEeNI4ITzH+17KDSuDsGH5BTI
         HIsFPETqK0m/cArr0SRby2RvB95FDGP/yi3sNyiI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 037/350] media: vim2m: Fix abort issue
Date:   Tue, 10 Dec 2019 15:58:49 -0500
Message-Id: <20191210210402.8367-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit c362f77a243bfd1daec21b6c36491c061ee2f31b ]

Currently, if start streaming -> stop streaming -> start streaming
sequence is executed, driver will end job prematurely, if ctx->translen
is higher than 1, because "aborting" flag is still set from previous
stop streaming command.

Fix that by clearing "aborting" flag in start streaming handler.

Fixes: 96d8eab5d0a1 ("V4L/DVB: [v5,2/2] v4l: Add a mem-to-mem videobuf framework test device")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/vim2m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2m.c
index acd3bd48c7e21..2d79cdc130c58 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -1073,6 +1073,9 @@ static int vim2m_start_streaming(struct vb2_queue *q, unsigned int count)
 	if (!q_data)
 		return -EINVAL;
 
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->aborting = 0;
+
 	q_data->sequence = 0;
 	return 0;
 }
-- 
2.20.1

