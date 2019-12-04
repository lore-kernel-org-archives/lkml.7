Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F9FC432C3
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507C9206E4
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 01:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r26EnM3T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLDBGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 20:06:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35688 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfLDBGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 20:06:41 -0500
Received: by mail-wr1-f66.google.com with SMTP id g17so6509317wro.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 17:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUhWP41gAQ+u6lqrVAb//FnSSw9Q7UZjagkqlU3jNOs=;
        b=r26EnM3TD+cn4FCMQ0z4rvYXPIYxZgjzo5RSNJ3thwWSK52RbjKhiP5xmWbX52dCIl
         Fj1PCIwJkfcpqjEXezfZzlhlKZZ9MDznT7iAN2TcP4iVX6luTwlL/RgiVNbArnAhhKHF
         /LlaBRq7RpN26BnEhK9zZxFsa7w+hGQVCrXKMZophce/83Ui7OeTzO1i7V4J1cJ4uHZl
         mAywlg/kNTs8kSFHaZCZictQX9A9Oz9473ire8c4FPt8g9bekgLY33b0fvV/ZnsLW+ME
         eX2FIHy+SrUV7gLIfU9YRqaGwFgsXl7/h5RZD1zT4Qac05aDdVo94Z8xyC2eNuhjrCq2
         MZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUhWP41gAQ+u6lqrVAb//FnSSw9Q7UZjagkqlU3jNOs=;
        b=Yv9y289hW6P7a7RDHnG14O+vsXLqJN+7ccffGR5nT2Ai2DShAAfqLyZ6hcnZfH+bvj
         KAmnbkvCn/orwocOQAQkaati9j1QvoPVZgVJQMeGRvFn0dMNZQHTembZ6WOhXDSl9XFj
         d06nHeb31t06wi8YJuCW+v17Ace+QGXWy8M0tbKp5qJBFgImjSxsRa/VgktJCz5oXucJ
         YPQk3AApHvo+YYoBSWxkDRinjkJ3OgMb+HdKHlSyIrXwfMrgZ2ncE/SUGsodI+wn06v5
         kD/wnen9NaJgEftU0qQx9D2tZDHvf6DWsZDeXy90WuUJiVC076Z5JA3IeuTIVXKn+veZ
         aYAw==
X-Gm-Message-State: APjAAAXiEQaN5IRuZTmUObmjyKSy3Ds7e9rQAYDyE0NX2UyGFn2NEyp+
        iN+gLlGUBUYI5U/8Kc9PENg=
X-Google-Smtp-Source: APXvYqyf/uccJvEUMMLfo99TGyYEpirWwEE+MFH84DyJ/7sT73gav5viQ/axrWMAmsdpnTwDZOwIoQ==
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr1024751wrm.80.1575421599971;
        Tue, 03 Dec 2019 17:06:39 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:404e:f500:a9e5:6fa:6c43:150b])
        by smtp.gmail.com with ESMTPSA id t13sm5024147wmt.23.2019.12.03.17.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2019 17:06:38 -0800 (PST)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Christoph Lameter <cl@linux.com>, Tejun Heo <tj@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH v2] fix __percpu annotation in asm-generic
Date:   Wed,  4 Dec 2019 02:06:23 +0100
Message-Id: <20191204010623.65384-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generic implementation of raw_cpu_generic_add_return() is:

        #define raw_cpu_generic_add_return(pcp, val)            \
        ({                                                      \
                typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));       \
                                                                \
                *__p += val;                                    \
                *__p;                                           \
        })

where the 'pcp' argument is a __percpu lvalue.
There, the variable '__p' is declared as a __percpu pointer
the type of the address of 'pcp') but:
1) the value assigned to it, the return value of raw_cpu_ptr(), is
   a plain (__kernel) pointer, not a __percpu one.
2) this variable is dereferenced just after while a __percpu
   pointer is implicitly __noderef.

So, fix the declaration of the 'pcp' variable to its correct type:
the plain (non-percpu) pointer corresponding to pcp's address,
using the fact that typeof() ignores the address space and the
'noderef' attribute of its agument.

Same for raw_cpu_generic_xchg(), raw_cpu_generic_cmpxchg() &
raw_cpu_generic_cmpxchg_double().

This removes 209 warnings on ARM, 525 on ARM64, 220 on x86 &
more than 2600 on ppc64 (all of them with the default config).

Cc: Dennis Zhou <dennis@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Reported-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Change since v1:
* use the fact that typeof() ignore the address space of its argument.

 include/asm-generic/percpu.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/asm-generic/percpu.h b/include/asm-generic/percpu.h
index c2de013b2cf4..35e4a53b83e6 100644
--- a/include/asm-generic/percpu.h
+++ b/include/asm-generic/percpu.h
@@ -74,7 +74,7 @@ do {									\
 
 #define raw_cpu_generic_add_return(pcp, val)				\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 									\
 	*__p += val;							\
 	*__p;								\
@@ -82,7 +82,7 @@ do {									\
 
 #define raw_cpu_generic_xchg(pcp, nval)					\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	*__p = nval;							\
@@ -91,7 +91,7 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg(pcp, oval, nval)			\
 ({									\
-	typeof(&(pcp)) __p = raw_cpu_ptr(&(pcp));			\
+	typeof(pcp) *__p = raw_cpu_ptr(&(pcp));				\
 	typeof(pcp) __ret;						\
 	__ret = *__p;							\
 	if (__ret == (oval))						\
@@ -101,8 +101,8 @@ do {									\
 
 #define raw_cpu_generic_cmpxchg_double(pcp1, pcp2, oval1, oval2, nval1, nval2) \
 ({									\
-	typeof(&(pcp1)) __p1 = raw_cpu_ptr(&(pcp1));			\
-	typeof(&(pcp2)) __p2 = raw_cpu_ptr(&(pcp2));			\
+	typeof(pcp1) *__p1 = raw_cpu_ptr(&(pcp1));			\
+	typeof(pcp2) *__p2 = raw_cpu_ptr(&(pcp2));			\
 	int __ret = 0;							\
 	if (*__p1 == (oval1) && *__p2  == (oval2)) {			\
 		*__p1 = nval1;						\
-- 
2.24.0

