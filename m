Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1836EC28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E764F25316
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559190057;
	bh=i1++ugkGFy9cTN8Pw+YwfRoCFDrSB4l8XHeSdcQnPQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=l98PXix9CL7CQSr41NEiJJweH/GtvSmhLLgQbtaYs14KmSWoYjXfFd1IJj6gJ4K7l
	 D5q+q3FYSgusUWXozN+OfxHG0+mpKTeyRZ++I2R0UQi6S99saq/JU1+HUTm1mXWELb
	 eApjChMPsafmLYl8L+Di4bZoSaNaTVlUWmi3002I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbfE3EU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730202AbfE3DPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:15:17 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B56F24580;
        Thu, 30 May 2019 03:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559186116;
        bh=i1++ugkGFy9cTN8Pw+YwfRoCFDrSB4l8XHeSdcQnPQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M1AfVCcC6MGXwNCh5lxMBBMVR5Y4JifLjSnma36oDD+vZr/pHYfGfqJ7Ikiy0BeVz
         pbzyX31wyuIDKVmpvr9Sb/AlcqL6kwU3VtoL0T35WVixtesFl63iSc4Q8qWuMFIXae
         3VrZoPpjtKGbXO6xeRb4yFZhHAQx03UqEETU7QXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 269/346] overflow: Fix -Wtype-limits compilation warnings
Date:   Wed, 29 May 2019 20:05:42 -0700
Message-Id: <20190530030554.595619067@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.363386121@linuxfoundation.org>
References: <20190530030540.363386121@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit dc7fe518b0493faa0af0568d6d8c2a33c00f58d0 ]

Attempt to use check_shl_overflow() with inputs of unsigned type
produces the following compilation warnings.

drivers/infiniband/hw/mlx5/qp.c: In function _set_user_rq_size_:
./include/linux/overflow.h:230:6: warning: comparison of unsigned
expression >= 0 is always true [-Wtype-limits]
   _s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;  \
      ^~
drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro _check_shl_overflow_
  if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift,
&rwq->buf_size))
      ^~~~~~~~~~~~~~~~~~
./include/linux/overflow.h:232:26: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  (_to_shift != _s || *_d < 0 || _a < 0 ||   \
                          ^
drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro _check_shl_overflow_
  if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
      ^~~~~~~~~~~~~~~~~~
./include/linux/overflow.h:232:36: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
  (_to_shift != _s || *_d < 0 || _a < 0 ||   \
                                    ^
drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro _check_shl_overflow_
  if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift,&rwq->buf_size))
      ^~~~~~~~~~~~~~~~~~

Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper")
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/overflow.h | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb8..15eb85de92269 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -36,6 +36,12 @@
 #define type_max(T) ((T)((__type_half_max(T) - 1) + __type_half_max(T)))
 #define type_min(T) ((T)((T)-type_max(T)-(T)1))
 
+/*
+ * Avoids triggering -Wtype-limits compilation warning,
+ * while using unsigned data types to check a < 0.
+ */
+#define is_non_negative(a) ((a) > 0 || (a) == 0)
+#define is_negative(a) (!(is_non_negative(a)))
 
 #ifdef COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW
 /*
@@ -227,10 +233,10 @@
 	typeof(d) _d = d;						\
 	u64 _a_full = _a;						\
 	unsigned int _to_shift =					\
-		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
+		is_non_negative(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
 	*_d = (_a_full << _to_shift);					\
-	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
-		(*_d >> _to_shift) != _a);				\
+	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
+	(*_d >> _to_shift) != _a);					\
 })
 
 /**
-- 
2.20.1



