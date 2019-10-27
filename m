Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E06CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B79BF20679
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572212262;
	bh=hOfR+rEBOsJ0m1U0SLsPKNZcvvGpmMSP6RiTjbY8qp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jUoHlLPscCH7vi2xw6yR7QnTM49vWXRgu/nsNyVDqxR/9S7h6LtMDx0SYuhlHmB9o
	 i+1W4pfe8X7IxujcVI8q+YY89I44lyWD1XBUHOzLPMDXlMmPtNF/inK2BKvjmVWy9W
	 cA2dayQrzyVNNPeTnZWczwWj9JGZKJt9WnbGCsYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731111AbfJ0Vhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:37:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:50672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728727AbfJ0VEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:04:55 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B594020B7C;
        Sun, 27 Oct 2019 21:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210295;
        bh=hOfR+rEBOsJ0m1U0SLsPKNZcvvGpmMSP6RiTjbY8qp8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Slk8ooWb1Tnd186AR8kFUKhlcDi963qaPjqdZ+wzSrk4497hfddcWP9WwTuXcN+ZW
         oUds5waQ5ZQwJ7fQUgSbTU/MZDbs3JznBkLzWTWr448xzTI28RvKEOMuZpDaofMtgn
         SdtZMuM9YcEyF7YjoIK5z1wFrbXPccpoT+VoYbso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alessio Balsini <balsini@android.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 16/49] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Sun, 27 Oct 2019 22:00:54 +0100
Message-Id: <20191027203131.256664465@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203119.468466356@linuxfoundation.org>
References: <20191027203119.468466356@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alessio Balsini <balsini@android.com>

[ Upstream commit fdbe4eeeb1aac219b14f10c0ed31ae5d1123e9b8 ]

Enabling Direct I/O with loop devices helps reducing memory usage by
avoiding double caching.  32 bit applications running on 64 bits systems
are currently not able to request direct I/O because is missing from the
lo_compat_ioctl.

This patch fixes the compatibility issue mentioned above by exporting
LOOP_SET_DIRECT_IO as additional lo_compat_ioctl() entry.
The input argument for this ioctl is a single long converted to a 1-bit
boolean, so compatibility is preserved.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Alessio Balsini <balsini@android.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9f840d9fdfcb5..f236b7984b946 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1546,6 +1546,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.20.1



