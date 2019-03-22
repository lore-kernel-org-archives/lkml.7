Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C34621917
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553254805;
	bh=BO4UKfnNWqj7JgBUk8XemiOKKely22TS+9NNAWUMWxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0VbpcBGMNjwZO2HA/Yt4cL5AZJmKfUmFOVpk5vPM+lkL1pjav1p5IQ6R/6kJ7Wo5r
	 5ZGzq6WJ5EapMJqDjJ+3nkTQrVTTK1mVeXxgN0pn5DDWFKXXPJsDMp0I2GCdAEObmx
	 tUxhbRhmJPLqRrnmLtUj2Jzo8I6RBJh/vBNCRO2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731226AbfCVLkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:40:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731006AbfCVLj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:39:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C6A32082C;
        Fri, 22 Mar 2019 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553254799;
        bh=BO4UKfnNWqj7JgBUk8XemiOKKely22TS+9NNAWUMWxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1X7iZAcH5nupbwKxR3skUWhMGcj6zS3xAVbHK8L5xQyTNs92c67VXbFWpoBhITo1Q
         c7kY86ZeQqVYhDofGqclwqI39Ei9nEnOb5mJ84Uz/LYp0hthcIl8H+Soxd1JDjnGnn
         uz65nbzPwcQbzsCEHxOrz11rru8SQvaEsAdWBNkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Yufen Yu <yuyufen@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 015/118] floppy: check_events callback should not return a negative number
Date:   Fri, 22 Mar 2019 12:14:47 +0100
Message-Id: <20190322111217.072059325@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111215.873964544@linuxfoundation.org>
References: <20190322111215.873964544@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
index 326b9ba4518e..6914c6e1e1a8 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3752,7 +3752,7 @@ static unsigned int floppy_check_events(struct gendisk *disk,
 
 	if (time_after(jiffies, UDRS->last_checked + UDP->checkfreq)) {
 		if (lock_fdc(drive))
-			return -EINTR;
+			return 0;
 		poll_drive(false, 0);
 		process_fd_request();
 	}
-- 
2.19.1



