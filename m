Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D69CC072B1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E71F425AFF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 04:44:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559191498;
	bh=i1++ugkGFy9cTN8Pw+YwfRoCFDrSB4l8XHeSdcQnPQ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVLdP+QVjdanJfniIo853pCpZQuwWzWWtd9BOR8/8xrhnN/vtDNPwa2OghweEuek1
	 TCXD8SIkcE5+Nusjbra4TeIJc9s5PB+lfvds6gaEcxbKOxlgR7mxdTqcfEVfvlVj5q
	 3axdv0Lvu9My9TjaSTQm84dwsKUfOPTYYPS6tjos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfE3Eo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 00:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:52788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbfE3DL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 23:11:59 -0400
Received: from localhost (ip67-88-213-2.z213-88-67.customer.algx.net [67.88.213.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2ECC24481;
        Thu, 30 May 2019 03:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185919;
        bh=i1++ugkGFy9cTN8Pw+YwfRoCFDrSB4l8XHeSdcQnPQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cdbp2w4UUQGtCFw6xJl1P+9OdGnec5iLvphhsABkVp6CITqukx1O0I/MgZJel0Si9
         G5+MlZL2r2DbW0w9R5OYr5Ng2l8yf2dm7TSrr8/VMPw3gJbhvIs6IrShdA4YS9q1mU
         gWiY5HNHHJIAcuYJkLnZAQkB91hpE8coTuKMjaGE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.1 304/405] overflow: Fix -Wtype-limits compilation warnings
Date:   Wed, 29 May 2019 20:05:02 -0700
Message-Id: <20190530030556.192614956@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190530030540.291644921@linuxfoundation.org>
References: <20190530030540.291644921@linuxfoundation.org>
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



