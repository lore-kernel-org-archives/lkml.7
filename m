Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21487C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EC02173E
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 11:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556624797;
	bh=eUQUjbJZXwJvAIl8IRN9aj4vSZWvYjg+7dqI2/qrr9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xj3GJHrKtaoyt8mSknBFEVP5FGc5lrKKVaHxPs+7AQ1e8Gm0A/yWPQ8V4SgHNE5SV
	 kY3mjcXKb+rZXnds68VFLwFUWJ50P+DX846i0QePi2XmGn6/7gteQf/EozEIf9kMax
	 zUDbrqtZ4bKvQILbNCSpTPpKREGsA4k4Utr0/6fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730577AbfD3Lqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 07:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:59444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730568AbfD3Lqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 07:46:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3077217D6;
        Tue, 30 Apr 2019 11:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556624790;
        bh=eUQUjbJZXwJvAIl8IRN9aj4vSZWvYjg+7dqI2/qrr9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7CR8Ws5M/D87JGzhxWDbdzTMZlM0Dht//AHYUJANaKDw+6XT6UPHwo8Vyl2UFQV8
         uv7uXETZJFTs0tnn/yxF2xaMU2RtQWsB/yJyMbBcGp8AW4rpnN/WanZZiOq55Mt8yG
         4m/F24C4aBnP3PjaPyivVSMqmXe5OYyz8PSfyoGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Marshall <hubcap@omnibond.com>,
        Jens Axboe <axboe@kernel.dk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.19 073/100] aio: initialize kiocb private in case any filesystems expect it.
Date:   Tue, 30 Apr 2019 13:38:42 +0200
Message-Id: <20190430113612.187536714@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430113608.616903219@linuxfoundation.org>
References: <20190430113608.616903219@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Marshall <hubcap@omnibond.com>

commit ec51f8ee1e63498e9f521ec0e5a6d04622bb2c67 upstream.

A recent optimization had left private uninitialized.

Fixes: 2bc4ca9bb600 ("aio: don't zero entire aio_kiocb aio_get_req()")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/aio.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1430,6 +1430,7 @@ static int aio_prep_rw(struct kiocb *req
 	if (unlikely(!req->ki_filp))
 		return -EBADF;
 	req->ki_complete = aio_complete_rw;
+	req->private = NULL;
 	req->ki_pos = iocb->aio_offset;
 	req->ki_flags = iocb_flags(req->ki_filp);
 	if (iocb->aio_flags & IOCB_FLAG_RESFD)


