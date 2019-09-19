Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15659C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6F7222BE
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931679;
	bh=PS4psoici0H95izA0+rLc0LA6/LF/xpQ0WNCxnaETgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w74kYIjfq2zLtThQmX5oMaFGLvdNI+DUp6Iinvxkd8XsqgFJk7V9GCelPpNznBexk
	 +dubNmUeyB8NlsvBVYDxp6PfjAqgyTTKpoiTk4RUkgbzS/O7oARNYsVjAnuFzp+1Jp
	 XrEz0WiEo67Mu/o6/h60Mz7J6gmtW1Y2K0tWUyJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406705AbfISWVS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406696AbfISWVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:21:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25CCD21924;
        Thu, 19 Sep 2019 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931675;
        bh=PS4psoici0H95izA0+rLc0LA6/LF/xpQ0WNCxnaETgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RDvWytPPiRfQs3yKd7bm1thG395y3KGSUG37KCFpuxfnGGVvTgPTLCdGTK2ka/tpz
         7RuRp3imJmkCUPgQWMcjpNBVJtUh/HKhxWPUZ5oJc47rmcfodA4+S1pb11tFW+MjWU
         B4R+bEj6XrHg1z6S7U3MICRQJNdGke3Vl6GlS3kE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Popov <alex.popov@linux.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.9 72/74] floppy: fix usercopy direction
Date:   Fri, 20 Sep 2019 00:04:25 +0200
Message-Id: <20190919214811.404794753@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214800.519074117@linuxfoundation.org>
References: <20190919214800.519074117@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jann Horn <jannh@google.com>

commit 52f6f9d74f31078964ca1574f7bb612da7877ac8 upstream.

As sparse points out, these two copy_from_user() should actually be
copy_to_user().

Fixes: 229b53c9bf4e ("take floppy compat ioctls to sodding floppy.c")
Cc: stable@vger.kernel.org
Acked-by: Alexander Popov <alex.popov@linux.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/floppy.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3784,7 +3784,7 @@ static int compat_getdrvprm(int drive,
 	v.native_format = UDP->native_format;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_params)))
 		return -EFAULT;
 	return 0;
 }
@@ -3820,7 +3820,7 @@ static int compat_getdrvstat(int drive,
 	v.bufblocks = UDRS->bufblocks;
 	mutex_unlock(&floppy_mutex);
 
-	if (copy_from_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
+	if (copy_to_user(arg, &v, sizeof(struct compat_floppy_drive_struct)))
 		return -EFAULT;
 	return 0;
 Eintr:


