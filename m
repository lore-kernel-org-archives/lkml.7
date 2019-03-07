Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86141C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A10F20675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 01:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfCGBCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 20:02:03 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43246 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfCGBCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 20:02:03 -0500
Received: by mail-pg1-f196.google.com with SMTP id l11so9825855pgq.10;
        Wed, 06 Mar 2019 17:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EywQfr1WO6BEscc2q0KVphXUCp0kmUTPgs8IpDeVa/M=;
        b=ZF4b9nKKkWAEXP59zsKcZHtCYGozxvZSM9xflXPE8m9/KWonkGlTIPfwevClf26os0
         Oiah3XfDAG7Hco6fFyD3IY2PAZniWPrBoGgQy0jBZne+SfTFeSaFqZp16cSkSmUjtNks
         rlqsiVpFtqbJ+HP3tBdh6InjnBKJV9MV5qSZog9HwsT9r9VY1hyhHqBYIJt7P8FIdhNq
         pndD72NaPsULrgbq0+B8khrSiRa6YqcK0mMfMiiro0tP5MqKiKCEhlM3EHi2EDZD4JIl
         s8WIpGUGUrTVPsNJ9zIvcnVzbyRiAZ/pPAdZDpj3+Q93lXjTcOLTe0UEWyiTEj979oOT
         BnWw==
X-Gm-Message-State: APjAAAXqKInZIpzq/BPbopTTgrXx3cn6gODPTf+/N3obicAi3i1m4Zl+
        l8Lz6TQSFs1yykjJS7i4luw=
X-Google-Smtp-Source: APXvYqyup+C6xNWfTHH0+9MflWfXsBBjZ2OYhoNA8+9dTsPBl070wq0VB5UXgeI+zqXAd7NoI7gXKQ==
X-Received: by 2002:a65:41ca:: with SMTP id b10mr8977079pgq.146.1551920521812;
        Wed, 06 Mar 2019 17:02:01 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id i193sm8059703pgc.63.2019.03.06.17.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 17:02:00 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] Avoid that check_shl_overflow() triggers a compiler warning when building with W=1
Date:   Wed,  6 Mar 2019 17:01:53 -0800
Message-Id: <20190307010153.81157-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that the following warning is reported when building
the mlx5 driver with W=1:

drivers/infiniband/hw/mlx5/qp.c: In function set_user_rq_size:
./include/linux/overflow.h:230:6: warning: comparison of unsigned expression >= 0 is always true [-Wtype-limits]
   _s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;  \
      ^
drivers/infiniband/hw/mlx5/qp.c:5820:6: note: in expansion of macro check_shl_overflow
  if (check_shl_overflow(rwq->wqe_count, rwq->wqe_shift, &rwq->buf_size))
      ^~~~~~~~~~~~~~~~~~

Cc: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leonro@mellanox.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Fixes: 0c66847793d1 ("overflow.h: Add arithmetic shift helper") # v4.19
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/overflow.h | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 40b48e2133cb..8afe0c0ada6f 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -202,6 +202,24 @@
 
 #endif /* COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW */
 
+/*
+ * Evaluate a >= 0 without triggering a compiler warning if the type of a
+ * is an unsigned type.
+ */
+#define is_positive(a) ({					\
+	typeof(a) _minus_one = -1LL;				\
+	typeof((a) + 0U) _sign_mask = _minus_one > 0 ? 0 :	\
+				1ULL << (8 * sizeof(a) - 1);	\
+								\
+	((a) & _sign_mask) == 0;				\
+})
+
+/*
+ * Evaluate a < 0 without triggering a compiler warning if the type of a
+ * is an unsigned type.
+ */
+#define is_negative(a) !is_positive(a)
+
 /** check_shl_overflow() - Calculate a left-shifted value and check overflow
  *
  * @a: Value to be shifted
@@ -227,9 +245,9 @@
 	typeof(d) _d = d;						\
 	u64 _a_full = _a;						\
 	unsigned int _to_shift =					\
-		_s >= 0 && _s < 8 * sizeof(*d) ? _s : 0;		\
+		is_positive(_s) && _s < 8 * sizeof(*d) ? _s : 0;	\
 	*_d = (_a_full << _to_shift);					\
-	(_to_shift != _s || *_d < 0 || _a < 0 ||			\
+	(_to_shift != _s || is_negative(*_d) || is_negative(_a) ||	\
 		(*_d >> _to_shift) != _a);				\
 })
 
-- 
2.21.0

