Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173A5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAD5620673
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 16:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbfD2QR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 12:17:29 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:56242 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbfD2QR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 12:17:26 -0400
Received: from MUA
        by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1hL8y1-0002pd-9M; Mon, 29 Apr 2019 18:17:22 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH v12 3/8] cx25840: implement g_std operation
Date:   Mon, 29 Apr 2019 18:16:54 +0200
Message-Id: <85be545af2ba8ff1ba0c6599a5ed7eb49df16f5e.1556554056.git.mail@maciej.szmigiero.name>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1556554056.git.mail@maciej.szmigiero.name>
References: <cover.1556554056.git.mail@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements g_std operation in cx25840 driver by returning the
last set video standard.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
---
 drivers/media/i2c/cx25840/cx25840-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/i2c/cx25840/cx25840-core.c b/drivers/media/i2c/cx25840/cx25840-core.c
index 2bcaf239b0d2..8c1111ba051b 100644
--- a/drivers/media/i2c/cx25840/cx25840-core.c
+++ b/drivers/media/i2c/cx25840/cx25840-core.c
@@ -1822,6 +1822,15 @@ static int cx25840_g_input_status(struct v4l2_subdev *sd, u32 *status)
 	return 0;
 }
 
+static int cx25840_g_std(struct v4l2_subdev *sd, v4l2_std_id *std)
+{
+	struct cx25840_state *state = to_state(sd);
+
+	*std = state->std;
+
+	return 0;
+}
+
 static int cx25840_s_std(struct v4l2_subdev *sd, v4l2_std_id std)
 {
 	struct cx25840_state *state = to_state(sd);
@@ -5081,6 +5090,7 @@ static const struct v4l2_subdev_audio_ops cx25840_audio_ops = {
 };
 
 static const struct v4l2_subdev_video_ops cx25840_video_ops = {
+	.g_std = cx25840_g_std,
 	.s_std = cx25840_s_std,
 	.querystd = cx25840_querystd,
 	.s_routing = cx25840_s_video_routing,
