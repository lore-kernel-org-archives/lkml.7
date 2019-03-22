Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD0C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D891C218B0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255237;
	bh=P7wdg7jLX1D+SxEXBB2jdwr6ddkJ9eGFuiXy7JkM4Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qu6KuSNg1xqvDe9873CwsE0OobsOdhqTaAV6oib0HmAc6mqtdbDWvdlzT3Tr0p67c
	 BwltWPgIW/02aC0vzWVpMJ9xercAhtfQtZQOXyzk+lWCrnmxEKVoDU0WIj1Q9JbMwW
	 hVkJLVONjOvXIF/Bn2fhy4yBYCTPqp24p3Y9/ZqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfCVLrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbfCVLrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E312A218B0;
        Fri, 22 Mar 2019 11:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255232;
        bh=P7wdg7jLX1D+SxEXBB2jdwr6ddkJ9eGFuiXy7JkM4Jo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WDuTjxBdrbPphj0rsRNvPoZ2z4bzoevcB0NXForBw3Kr0Fk5CSIGyC3uRYmPT9/s/
         MnqOEno2HKi58dihzA+UkuJPQK//2pJRXDPAZgQ9o39kaYm3bo0vwgaZ+x2Fouy+1b
         JFVqy99hBOd6QnmLXPENfjxaYQBQKYY8f1+uTQmc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 027/183] floppy: check_events callback should not return a negative number
Date:   Fri, 22 Mar 2019 12:14:15 +0100
Message-Id: <20190322111243.718355145@linuxfoundation.org>
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

[ Upstream commit 96d7cb932e826219ec41ac02e5af037ffae6098c ]

floppy_check_events() is supposed to return bit flags to say which
events occured. We should return zero to say that no event flags are
set.  Only BIT(0) and BIT(1) are used in the caller. And .check_events
interface also expect to return an unsigned int value.

However, after commit a0c80efe5956, it may return -EINTR (-4u).
Here, both BIT(0) and BIT(1) are cleared. So this patch shouldn't
affect runtime, but it obviously is still worth fixing.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: a0c80efe5956 ("floppy: fix lock_fdc() signal handling")
Signed-off-by: Yufen Yu <yuyufen@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/floppy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index a7f212ea17bf..3ea9c3e9acb3 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4079,7 +4079,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (lock_fdc(drive))
-			return -EINTR;
+			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
-- 
2.19.1



