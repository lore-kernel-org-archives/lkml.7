Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9A7C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C772089C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 18:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561054769;
	bh=1vfw/5YDOBpYEgT8fnTZuuzqDh13TDwAsSxwqD/sPoI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h64RawpCejgtlvGL6J3RNBv8SNp8YQ6G+xtvMbSpLvbRdid97ELM0+MSkIpDEJmNp
	 ISzSLy1kVrunMFj6ScPVvG1Dtn1lYhesOMKkDGU9D8rHZvmJRJTZZZ6ghkJcDvfnUx
	 MLhERFOTKabGtzVHoLDx2agrdaKqspN+DM5miKBs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfFTSPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 14:15:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbfFTSPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 14:15:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA4872089C;
        Thu, 20 Jun 2019 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561054513;
        bh=1vfw/5YDOBpYEgT8fnTZuuzqDh13TDwAsSxwqD/sPoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MN1RxeVfeUsjdCP3Pjr5ha7jyWFkh68vxpbN3NH99odZ1r5Pwyifug4gykqM6Ht0T
         RCr7DaOxoIBNv7EZG1RknkGkPieXa8U5agxdqs4LWKuOquM0B7OP5H864xK5GFtUFj
         ah/+AX7slVo5qEa1L1A4BFk/+uB+orhLbp5i0pp4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 55/98] io_uring: Fix __io_uring_register() false success
Date:   Thu, 20 Jun 2019 19:57:22 +0200
Message-Id: <20190620174351.820212114@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190620174349.443386789@linuxfoundation.org>
References: <20190620174349.443386789@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit a278682dad37fd2f8d2f30d8e84e376a856ab472 ]

If io_copy_iov() fails, it will break the loop and report success,
albeit partially completed operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4e32a033394c..e82adbf8adc1 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2506,7 +2506,7 @@ static int io_sqe_buffer_register(struct io_ring_ctx *ctx, void __user *arg,
 
 		ret = io_copy_iov(ctx, &iov, arg, i);
 		if (ret)
-			break;
+			goto err;
 
 		/*
 		 * Don't impose further limits on the size and buffer
-- 
2.20.1



