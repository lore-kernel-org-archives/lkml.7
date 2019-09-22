Return-Path: <SRS0=BACo=XR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F2C3A5A6
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3340D206C2
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Sep 2019 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179913;
	bh=qv9ygTfvEiKSBYql2/cnEalR9CuEm7hiXBuwEhcKLyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=k9JYShTiYqudpYu9r5mmeWy7gA8wlDX/foDFnqFaxXijqAS8tesCHIj5LTuAAHPtR
	 peqo0Ie9bp5V8zd7EKycrUpJMxCqPdNoSNkhxOXSg7ioUXkTRkuS3rQlTDZpaGKudp
	 52ktdns7Mg3B1xfR6pbgZeQhLE2Tto+moPC4hMao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437610AbfIVSzQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Sep 2019 14:55:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437375AbfIVSzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Sep 2019 14:55:06 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E58B12190F;
        Sun, 22 Sep 2019 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178505;
        bh=qv9ygTfvEiKSBYql2/cnEalR9CuEm7hiXBuwEhcKLyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qwvEBzVnWAsR2qr7Nf78HtC6OyrIJ+WFsfPSSXAHRTTqsTrFvAeAk/+AgjTzJuumE
         StwPJD9aKdNb4OD8NxFojVAjfNfp2IRsEjSVIkH8wXQn+hE5jyMD+UEOYvmHX7wWo4
         vujY4r386tea/zN0gDYawcx//e0B/Cv1QrJWsJaU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alessio Balsini <balsini@android.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 037/128] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Sun, 22 Sep 2019 14:52:47 -0400
Message-Id: <20190922185418.2158-37-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index cef8e00c9d9d6..126c2c5146732 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1719,6 +1719,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
 	case LOOP_SET_BLOCK_SIZE:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.20.1

