Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A31C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0842192C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255838;
	bh=60nWjVLSzNnolshAjXM77sGQ0HZvmZvTQ5rc6wZRJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cD+/iC4x2/W9lTwzKhUBG4iuklrGzN/8EidapqemulO5k2ekk4+p2+lJff3Lh4iR4
	 fhYhL05UGMEC8QoMGZnPE4CPHgc0D7a7pI7ICnCXQnj2NIwCXS4XEbxjBVy9dfPI1c
	 0BCSnU/FFfToOQbybAZdga+vCKR2qrQXXLoQTElk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfCVL5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:57:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387624AbfCVL5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:57:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC3AA2082C;
        Fri, 22 Mar 2019 11:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255831;
        bh=60nWjVLSzNnolshAjXM77sGQ0HZvmZvTQ5rc6wZRJ8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1ZH4SDStgpQSP7n0RgGApRgMhbBVrIJeGQP7uF5JZFuVbzhbScwttbhkQPPE99mM
         nHXof4bVvEn4i3oVNYSLKylsBjhaK5CaxSd+yzZti1kxEyfiTzSQvjqt6Z7hGI5G9W
         8DQ5x1MSeUUPMfIuqsON4F53JS7PhVcvD9r/v1k0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: [PATCH 4.19 001/280] media: videobuf2-v4l2: drop WARN_ON in vb2_warn_zero_bytesused()
Date:   Fri, 22 Mar 2019 12:12:34 +0100
Message-Id: <20190322111306.431235384@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/media/common/videobuf2/videobuf2-v4l2.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/media/common/videobuf2/videobuf2-v4l2.c
+++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
@@ -145,7 +145,6 @@ static void vb2_warn_zero_bytesused(stru
 		return;
 
 	check_once = true;
-	WARN_ON(1);
 
 	pr_warn("use of bytesused == 0 is deprecated and will be removed in the future,\n");
 	if (vb->vb2_queue->allow_zero_bytesused)


