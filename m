Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF77C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41F4021655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 19:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564428659;
	bh=MXbR2Riu2wdtV+5/uzvxW26kndj2hoEGmL1FkNpIiQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgYofqhY9syMNsrd3PPQGyNYy/YZzZwA12cerpS1kbBOEzVT3S7HN0Oc5WJyzDMOt
	 cYaA7mEFoX8IEhURvH+p8MzqS6hm2yvJrFtPIpsFy2fVdUl+z9dK2DQS8KemtgTJ0G
	 kl9pC/oVCBs6uine1MIUUF5DTTFRcobCLeA6UHx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387859AbfG2Ta4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 15:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbfG2Tav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:30:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5873921655;
        Mon, 29 Jul 2019 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564428650;
        bh=MXbR2Riu2wdtV+5/uzvxW26kndj2hoEGmL1FkNpIiQs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QETL9fg0vofXfc65iJBeIANcIkY65++eZlPJRrUCuKP6YzqwwDIZl/OBbfQzoMiee
         KO489SxAZpz5HyYYMUyd4eDxcjAtZWCzjhe7FXQNanbIxhPWJOPJ6oW3t34sYlvQh/
         D2XFD2QVgU7oy6WcStehC588wWoMu9NKySVX8Xx8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.14 141/293] media: v4l2: Test type instead of cfg->type in v4l2_ctrl_new_custom()
Date:   Mon, 29 Jul 2019 21:20:32 +0200
Message-Id: <20190729190835.352250698@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190820.321094988@linuxfoundation.org>
References: <20190729190820.321094988@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Brezillon <boris.brezillon@collabora.com>

commit 07d89227a983df957a6a7c56f7c040cde9ac571f upstream.

cfg->type can be overridden by v4l2_ctrl_fill() and the new value is
stored in the local type var. Fix the tests to use this local var.

Fixes: 0996517cf8ea ("V4L/DVB: v4l2: Add new control handling framework")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
[hverkuil-cisco@xs4all.nl: change to !qmenu and !qmenu_int (checkpatch)]
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/v4l2-ctrls.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -2113,16 +2113,15 @@ struct v4l2_ctrl *v4l2_ctrl_new_custom(s
 		v4l2_ctrl_fill(cfg->id, &name, &type, &min, &max, &step,
 								&def, &flags);
 
-	is_menu = (cfg->type == V4L2_CTRL_TYPE_MENU ||
-		   cfg->type == V4L2_CTRL_TYPE_INTEGER_MENU);
+	is_menu = (type == V4L2_CTRL_TYPE_MENU ||
+		   type == V4L2_CTRL_TYPE_INTEGER_MENU);
 	if (is_menu)
 		WARN_ON(step);
 	else
 		WARN_ON(cfg->menu_skip_mask);
-	if (cfg->type == V4L2_CTRL_TYPE_MENU && qmenu == NULL)
+	if (type == V4L2_CTRL_TYPE_MENU && !qmenu) {
 		qmenu = v4l2_ctrl_get_menu(cfg->id);
-	else if (cfg->type == V4L2_CTRL_TYPE_INTEGER_MENU &&
-		 qmenu_int == NULL) {
+	} else if (type == V4L2_CTRL_TYPE_INTEGER_MENU && !qmenu_int) {
 		handler_set_err(hdl, -EINVAL);
 		return NULL;
 	}


