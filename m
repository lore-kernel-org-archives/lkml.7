Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3B1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A3A214AF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572210483;
	bh=H9qPFSXEmi517p5/bsJsJ4u13zprYepTA2/NdxCmPqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SC59Xn+eTCmMwa5usU/vctugkamF+NSfff60Vh5UzFaWBzMbTYjqmhd/NRJ/WvakL
	 FD0YzcTWRUiwiyi0sP5DXnQMF4q02vrnJRW14fkxw6+G7AzGUTN7Lf6kOfAQYrwoOT
	 WpJLMXuWXiXNUQkgkxtyb7N/YbqjWd1rKr0dO0wg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbfJ0VIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729303AbfJ0VH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:07:58 -0400
Received: from localhost (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC5F720873;
        Sun, 27 Oct 2019 21:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572210477;
        bh=H9qPFSXEmi517p5/bsJsJ4u13zprYepTA2/NdxCmPqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yfK4CibjNIkmKHRR4BzMYG7CCeqL+aTAYSnbPYwVo1/P5eNYTZ+3jwJUJalPo2kRm
         Pz0ClHhyazCG8ue27Hg5HKA3Xk8UMWKMmZikwDOaCViqtql4QHHdgQyS9jAyB1PAZQ
         HVlEnpCKpmPo/F16pJ6fD+1camRguC4OrYIYTRBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Alessio Balsini <balsini@android.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 028/119] loop: Add LOOP_SET_DIRECT_IO to compat ioctl
Date:   Sun, 27 Oct 2019 22:00:05 +0100
Message-Id: <20191027203308.865585869@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191027203259.948006506@linuxfoundation.org>
References: <20191027203259.948006506@linuxfoundation.org>
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
index 87d7c42affbc4..ec61dd873c93d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1605,6 +1605,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_DIRECT_IO:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.20.1



