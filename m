Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16CFC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE7FA2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 06:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553582111;
	bh=2zNhWIne/jcg3g2L78ZiPHDqlDTQB/ciTgZJQc/0Nr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pVTvga2rpwxtWAqEBUv9pOJiu2QeMmknSS1qI3tImyl4VR+Ff0HjMIafW9MrFw3iu
	 mdceBOiWcpnPl041mx4sBN29aAFA4sGgIhdi5hd+0Mqnw9oHHULZ7ajpuNsSiNUnzw
	 LtXyM2do89rTz3fcGtI5a6KXB6DwJkLoQeiJujw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731996AbfCZGfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 02:35:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:46248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731961AbfCZGfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 02:35:05 -0400
Received: from localhost (unknown [104.132.152.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A3B320823;
        Tue, 26 Mar 2019 06:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553582105;
        bh=2zNhWIne/jcg3g2L78ZiPHDqlDTQB/ciTgZJQc/0Nr4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=goIUsLwvUh0e6ArxNuhJw6tzZR/fV1M2vlYQYMGryujotIA9ekKgvPzLm5odvJpgJ
         pB3TC8K1OnKJp7nghd+HU8fxT5qzLf1I61XJpzpBXoCzWCEjeWDfna+0ev1CrBndYN
         O82LbPn33DzY1oRAzaNAxmK94TEmdqps4XDzpPrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        syzbot+4f021cf3697781dbd9fb@syzkaller.appspotmail.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 18/41] media: v4l2-ctrls.c/uvc: zero v4l2_event
Date:   Tue, 26 Mar 2019 15:29:55 +0900
Message-Id: <20190326042650.919864909@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
References: <20190326042649.889479098@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1203,7 +1203,7 @@ static void uvc_ctrl_fill_event(struct u
 
 	__uvc_query_v4l2_ctrl(chain, ctrl, mapping, &v4l2_ctrl);
 
-	memset(ev->reserved, 0, sizeof(ev->reserved));
+	memset(ev, 0, sizeof(*ev));
 	ev->type = V4L2_EVENT_CTRL;
 	ev->id = v4l2_ctrl.id;
 	ev->u.ctrl.value = value;
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -1239,7 +1239,7 @@ static u32 user_flags(const struct v4l2_
 
 static void fill_event(struct v4l2_event *ev, struct v4l2_ctrl *ctrl, u32 changes)
 {
-	memset(ev->reserved, 0, sizeof(ev->reserved));
+	memset(ev, 0, sizeof(*ev));
 	ev->type = V4L2_EVENT_CTRL;
 	ev->id = ctrl->id;
 	ev->u.ctrl.changes = changes;


