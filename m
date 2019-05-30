Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42702C28CC1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 126B324812
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 03:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559186947;
	bh=VPQvvo3SHXkAvfMTpOO34xbhbXNiy6XSCXnSvFBY4f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=en83KFwWAyaTI6weDNWkAKErrT7/yMRE0/y4JBMeW8ejnTGGmzqQCuHj1F9zzMicy
	 oCy/aWaxgI098JtF/pzdx40cJLdCLIbpuAOmN4xkZPv3/dMxqD1YQMGSW7Wv/GMR/B
	 5/Z3wbrL7wq2VCvWd30BaBwyiHisHAwEN03Ve5k8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388292AbfE3D3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 23:29:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:58674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732199AbfE3DU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:20:27 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B290A24937;
        Thu, 30 May 2019 03:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186426;
        bh=VPQvvo3SHXkAvfMTpOO34xbhbXNiy6XSCXnSvFBY4f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT60qDdmq+bsePlh16gfK2aB58oHV3LcgOrIAedBmtgzCgFqpcu+dN0cAi9hNsmVg
         YVfDcf1oafHL6Qgr3eRyIpSnVLfc/8L0S8FgbUEjfYTp+bxzJgbg6vhhhV51Jaj5Er
         n+RggXBpUss9cPMF5xnGLyddQH010lwnihhWScPc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Potapenko <glider@google.com>,
        Syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 4.9 017/128] media: vivid: use vfree() instead of kfree() for dev->bitmap_cap
Date:   Wed, 29 May 2019 20:05:49 -0700
Message-Id: <20190530030437.846627438@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030432.977908967@linuxfoundation.org>
References: <20190530030432.977908967@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

commit dad7e270ba712ba1c99cd2d91018af6044447a06 upstream.

syzkaller reported crashes on kfree() called from
vivid_vid_cap_s_selection(). This looks like a simple typo, as
dev->bitmap_cap is allocated with vzalloc() throughout the file.

Fixes: ef834f7836ec0 ("[media] vivid: add the video capture and output
parts")

Signed-off-by: Alexander Potapenko <glider@google.com>
Reported-by: Syzbot <syzbot+6c0effb5877f6b0344e2@syzkaller.appspotmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/platform/vivid/vivid-vid-cap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/platform/vivid/vivid-vid-cap.c
+++ b/drivers/media/platform/vivid/vivid-vid-cap.c
@@ -984,7 +984,7 @@ int vivid_vid_cap_s_selection(struct fil
 		v4l2_rect_map_inside(&s->r, &dev->fmt_cap_rect);
 		if (dev->bitmap_cap && (compose->width != s->r.width ||
 					compose->height != s->r.height)) {
-			kfree(dev->bitmap_cap);
+			vfree(dev->bitmap_cap);
 			dev->bitmap_cap = NULL;
 		}
 		*compose = s->r;


