Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D548AC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E2E720830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554140244;
	bh=Ib5Z/S3ESjEb1A3v8r93JyFqL4biEPC9KJUI9vOuBJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CUQy1r2YWp8M7SM7Zzh6vzkU8wgJq2+ijbujuTVY2/cvcFbXtGaIYaM9ZF8yJnWfV
	 k9CjXgJDLMplZDdtZDR93GYatfhR/aLQIKftmAbgX5EfAU1g8vngXxdFskb+4g9ClN
	 WZqxCMBqbftnA5F3+9WEp8Um8rF0W51dV0ISiVZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388169AbfDARhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:37:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbfDARhS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:37:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8BB32070B;
        Mon,  1 Apr 2019 17:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554140238;
        bh=Ib5Z/S3ESjEb1A3v8r93JyFqL4biEPC9KJUI9vOuBJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eQOqL5XLYQSmW+kGLhkXixRkGAs2ZSFHLuPBn+MDaL0UFUFd++x5ror6Lqq+vR3P3
         Y6gA7bJ/EFhE0DSJTkgO9Qf8ruuoaSiX9FIPUG+wfXdU2vPFCK73cCuKin1HiOZm9G
         xskSKp6WDszvgxEsVxQA/Vtn+P1KVpnhTc7tGp2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+4f021cf3697781dbd9fb@syzkaller.appspotmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 3.18 07/50] media: v4l2-ctrls.c/uvc: zero v4l2_event
Date:   Mon,  1 Apr 2019 19:02:50 +0200
Message-Id: <20190401170041.894948963@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190401170041.257273804@linuxfoundation.org>
References: <20190401170041.257273804@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil@xs4all.nl>

commit f45f3f753b0a3d739acda8e311b4f744d82dc52a upstream.

Control events can leak kernel memory since they do not fully zero the
event. The same code is present in both v4l2-ctrls.c and uvc_ctrl.c, so
fix both.

It appears that all other event code is properly zeroing the structure,
it's these two places.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Reported-by: syzbot+4f021cf3697781dbd9fb@syzkaller.appspotmail.com
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/usb/uvc/uvc_ctrl.c     |    2 +-
 drivers/media/v4l2-core/v4l2-ctrls.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -1202,7 +1202,7 @@ static void uvc_ctrl_fill_event(struct u
 
 	__uvc_query_v4l2_ctrl(chain, ctrl, mapping, &v4l2_ctrl);
 
-	memset(ev->reserved, 0, sizeof(ev->reserved));
+	memset(ev, 0, sizeof(*ev));
 	ev->type = V4L2_EVENT_CTRL;
 	ev->id = v4l2_ctrl.id;
 	ev->u.ctrl.value = value;
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1208,7 +1208,7 @@ static u32 user_flags(const struct v4l2_
 
 static void fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl, u32 changes)
 {
-	memset(ev->reserved, 0, sizeof(ev->reserved));
+	memset(ev, 0, sizeof(*ev));
 	ev->type = V4L2_EVENT_CTRL;
 	ev->id = ctrl->id;
 	ev->u.ctrl.changes = changes;


