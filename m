Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597CDC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A336218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254486;
	bh=r7JQZ73wpSx10LK5yYX9F/1gGQH6VumgDsMDicvcUek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAOJvJX1R9Ljzv3Ssg/IzTs5nik+4BW0ALS4Zf103JxAnYrQryBRy/pV3G1dHTX+6
	 ONXPMFZZ5WE+/yzETRS3mVZDD1KhMX6SvIg+IxvHZHQGPBOMnAvpRkg2aZmeMqbZQX
	 pliq2embnLjwbscCRyQUbT21jtKD/jdQxUgJYD0c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbfCVLen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:34:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730077AbfCVLem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:34:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03A332183E;
        Fri, 22 Mar 2019 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254481;
        bh=r7JQZ73wpSx10LK5yYX9F/1gGQH6VumgDsMDicvcUek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dh8eh8M2Pmth64vvso0+5/FyMZihrdeYdKODPKyfXTdHYsiQGIXzSPAAluQpmIOPG
         I+sYuwCJe/BTwAfRawZDopfu6OYcxn8CeZ78i5qmhQCHriNS0iH+Y/PYo5YSbWDt7n
         T4InpyAPcQuWNAC6CpaxoBX+xFb2umhMGyZkb2gE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH 4.4 149/230] media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()
Date:   Fri, 22 Mar 2019 12:14:47 +0100
Message-Id: <20190322111247.121940580@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111236.796964179@linuxfoundation.org>
References: <20190322111236.796964179@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans Verkuil <hverkuil-cisco@xs4all.nl>

commit 5e99456c20f712dcc13d9f6ca4278937d5367355 upstream.

Userspace shouldn't set bytesused to 0 for output buffers.
vb2_warn_zero_bytesused() warns about this (only once!), but it also
calls WARN_ON(1), which is confusing since it is not immediately clear
that it warns about a 0 value for bytesused.

Just drop the WARN_ON as it serves no purpose.

Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Acked-by: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Matthias Maennich <maennich@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/v4l2-core/videobuf2-v4l2.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/media/v4l2-core/videobuf2-v4l2.c
+++ b/drivers/media/v4l2-core/videobuf2-v4l2.c
@@ -141,7 +141,6 @@ static void vb2_warn_zero_bytesused(stru
 		return;
 
 	check_once = true;
-	WARN_ON(1);
 
 	pr_warn("use of bytesused == 0 is deprecated and will be removed in the future,\n");
 	if (vb->vb2_queue->allow_zero_bytesused)


