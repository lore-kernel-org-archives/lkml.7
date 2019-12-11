Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F510C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9742077B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 15:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576079870;
	bh=EhvTr/MTOlFXNS/W68gn6gejFmcu49STTLixKu3GOpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hMwvJX7Sy7IETax496u+EY5UAQiJWllhLZ2vyBOh1frtHiov9QJf3FAQSL77iCw+E
	 WqeP2tUX3DROv8xQD3HXpSxQ06XRBRlnu7uFijHVp4xYMlhcsAeQcVJ2Vwc++1Q3dq
	 ySQIKBWiYp/+Obf1sRoueOd9M0VJzRsLWghJTSmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732028AbfLKP5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:57:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731690AbfLKPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:14:58 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7242220663;
        Wed, 11 Dec 2019 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077297;
        bh=EhvTr/MTOlFXNS/W68gn6gejFmcu49STTLixKu3GOpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hbgHV+sXo2m53rHUdQ9zpJdYPMOctTFB1BaxCDDV7pfNwEaASAfcY+gXCvCqcSsud
         Z1+mnmnHyy/xb6bpLhieQJlsHjC4drCh9cDu0zQfjWMvjUcM8rlVqg0WvT9RspOs/q
         lBBA/nIuNljKFF+l7tVlj/DjR9hX8sk5t3Wa/Dig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.3 044/105] io_uring: transform send/recvmsg() -ERESTARTSYS to -EINTR
Date:   Wed, 11 Dec 2019 16:05:33 +0100
Message-Id: <20191211150238.516607407@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191211150221.153659747@linuxfoundation.org>
References: <20191211150221.153659747@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 441cdbd5449b4923cd413d3ba748124f91388be9 upstream.

We should never return -ERESTARTSYS to userspace, transform it into
-EINTR.

Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1535,6 +1535,8 @@ static int io_send_recvmsg(struct io_kio
 		ret = fn(sock, msg, flags);
 		if (force_nonblock && ret == -EAGAIN)
 			return ret;
+		if (ret == -ERESTARTSYS)
+			ret = -EINTR;
 	}
 
 	io_cqring_add_event(req->ctx, sqe->user_data, ret);


