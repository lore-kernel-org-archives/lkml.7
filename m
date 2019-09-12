Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD4C4CEC7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 18:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CE862081B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 18:56:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbfILS4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 14:56:05 -0400
Received: from mailoutvs9.siol.net ([185.57.226.200]:51018 "EHLO mail.siol.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfILS4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 14:56:04 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 1CBC0521637;
        Thu, 12 Sep 2019 20:56:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id lL0ERO98_Ars; Thu, 12 Sep 2019 20:56:01 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id C35CF5223A8;
        Thu, 12 Sep 2019 20:56:01 +0200 (CEST)
Received: from localhost.localdomain (cpe-86-58-59-25.static.triera.net [86.58.59.25])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPSA id 6E0E9521637;
        Thu, 12 Sep 2019 20:56:01 +0200 (CEST)
From:   Jernej Skrabec <jernej.skrabec@siol.net>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: vim2m: Fix abort issue
Date:   Thu, 12 Sep 2019 20:55:55 +0200
Message-Id: <20190912185555.9221-1-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if start streaming -> stop streaming -> start streaming
sequence is executed, driver will end job prematurely, if ctx->translen
is higher than 1, because "aborting" flag is still set from previous
stop streaming command.

Fix that by clearing "aborting" flag in start streaming handler.

Fixes: 96d8eab5d0a1 ("V4L/DVB: [v5,2/2] v4l: Add a mem-to-mem videobuf fr=
amework test device")
Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
Hi!

This was only compile tested. Any suggestion how to properly test it
would be appreciated.

Best regards,
Jernej

 drivers/media/platform/vim2m.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vim2m.c b/drivers/media/platform/vim2=
m.c
index acd3bd48c7e2..2d79cdc130c5 100644
--- a/drivers/media/platform/vim2m.c
+++ b/drivers/media/platform/vim2m.c
@@ -1073,6 +1073,9 @@ static int vim2m_start_streaming(struct vb2_queue *=
q, unsigned int count)
 	if (!q_data)
 		return -EINVAL;
=20
+	if (V4L2_TYPE_IS_OUTPUT(q->type))
+		ctx->aborting =3D 0;
+
 	q_data->sequence =3D 0;
 	return 0;
 }
--=20
2.23.0

