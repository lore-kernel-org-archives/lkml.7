Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E83C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D6B2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255363;
	bh=+WEDRVfrID4hFl7xHHfx+qcpb7JxppaIOCUx1Zf+T8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=INJEpOP8H1ydDuyylAp1WJNWNIsfqsoLlXBRuOxsdsTVtI08bYOyarvu8RWilK1s5
	 Ckk/9OMBzCBTuKanmb2hCIYP3SIQrL3JJxiJeqbDDLqZfB1xXMI7FDzMn/rzXLaUSx
	 1ODFGs0+/GNdVfZ4QE7kKbsoVpe74vx0cOo0pCBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfCVLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:49:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732443AbfCVLtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:49:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 550E221929;
        Fri, 22 Mar 2019 11:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255358;
        bh=+WEDRVfrID4hFl7xHHfx+qcpb7JxppaIOCUx1Zf+T8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j+RqiqnMG7sCpvBhOkPcuqvCePloZHQAANVe/PoprUWXxh1l596vHFqiIM50groIk
         nSuQCXX79Oj9C5GrzH08uMpCYfGYJwsg053F2ydSu7G9HsBGLsm6QwMGvuXZTOO+S5
         v99BqWhoxtPNDp9+upeJIVixvbBpKuvKtaV/gSoQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH 4.14 066/183] media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()
Date:   Fri, 22 Mar 2019 12:14:54 +0100
Message-Id: <20190322111246.493185843@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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
@@ -145,7 +145,6 @@ static void vb2_warn_zero_bytesused(stru
 		return;
 
 	check_once = true;
-	WARN_ON(1);
 
 	pr_warn("use of bytesused == 0 is deprecated and will be removed in the future,\n");
 	if (vb->vb2_queue->allow_zero_bytesused)


