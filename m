Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694F0C4CEC4
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3571C21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 22:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568931838;
	bh=PS4psoici0H95izA0+rLc0LA6/LF/xpQ0WNCxnaETgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=14GweiWDTML8IZwOyCYx5H9J6aHR4JNNmeq0R+M3Setxr+o2jE9oMphglCrRuX3X+
	 uCvYkkkZAJ/3svVgQL7kkzl1jwerRwTJmhqVtjM2YJ0IQ4OPnJJ+IyYQXRxlfPcy5k
	 sY3Z37hXL+5LK6CCfpKVvdLR/FKQPbJT/n12jMkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407072AbfISWX5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 18:23:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:39754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389457AbfISWXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 18:23:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71AE921929;
        Thu, 19 Sep 2019 22:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568931830;
        bh=PS4psoici0H95izA0+rLc0LA6/LF/xpQ0WNCxnaETgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4z7tw40PsZnWhJJT+ScAdkke4oxBkoo8DCxbH27doaP2esy1k8Xs3c+RgDcUvtBF
         fhUa4iZEczFaTIVOHjGoFsZUXUTWapYxCZ4mQNiwwka8cDzB7+TAL+n0S1QGiDfy/Q
         sE7x48NrDa2qwJNEowH9CRQRYNgP+1COO+5nKFHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Popov <alex.popov@linux.com>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.4 54/56] floppy: fix usercopy direction
Date:   Fri, 20 Sep 2019 00:04:35 +0200
Message-Id: <20190919214804.957737167@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190919214742.483643642@linuxfoundation.org>
References: <20190919214742.483643642@linuxfoundation.org>
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


