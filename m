Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C6C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C350120679
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 14:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFp7pShT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732088AbfFTOK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 10:10:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44502 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfFTOKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 10:10:54 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so2818659ljc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=82RNRj4Ws3WKF9cxlVXNJLmsquuhfKULKVw6AFYJ16c=;
        b=cFp7pShT6i7/fho46pPx3VfJ9H6HZRp+uzIaU/xW5pzWC0SXvkSQvNuMB+9jthFcaM
         sb3Qwho+0kVWZcoxCkZG/JxsrxnnLxHXi58bKeyjZTz9DLdLQIwC2YdxgdiZfKrk2Z9/
         hziAybW6itfaNRusIpQPwRjrUZ938ppHDaBf10LxZJf67rirJX1LsDhaqZ0VXhbY6MJb
         Bi49LUb6lsxqdNOxtjn5OTrybVy6ltucEdTHriJmf14o/wtraTsz7x1oClBZJOqQHfuk
         xnK2P+KDEZYjDjuWfsueVMX1DriCzho9MwzJzvGE//zJlpYHPGY1Aard+srNGw79CVaR
         ykYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=82RNRj4Ws3WKF9cxlVXNJLmsquuhfKULKVw6AFYJ16c=;
        b=D9/0Eq1UuIMFo60cd+ymBBv+1HqQNd97hNJOFVVO6eDvyX7gSgqonjseOt6xAxywZo
         La/Mr54kLPCBTC20uOY/ZurMMAEqZqQIXNe4o0eh/a6OMgr7NhkjvI243wEXTZ2e0msJ
         nwQqUkjBG7QPNpclcmKWY648n7kdUtuJXY/GTN5mjPO1wfjOnjbV7i7rM696kFBw2tng
         4B1Nn6iQUuG3BZ+4n0t/9ycZAKswxNTbhOVb1vaol/Ul7+dS1djeO5KG5t3SEkNv+im+
         I/JMdqiZK6SOotYxmwCbT8g4/yWfuGVR6AjGtGJNfxQDpUHoOxxt5uQJ6/+amDXs7fpd
         6igw==
X-Gm-Message-State: APjAAAVRwDKhOYprxiYXmjTdkv7/qCMAMHxJElrkUkw3r740q2J5DTsU
        cFIqGR7mB1VxszojhKMkYta+toZ3
X-Google-Smtp-Source: APXvYqz6ek6MRtkVXcABdE15pbror9YSVS8zSHOcYGvVno4dpVsx/4r1VOjcRs029NIkrT6/HTLasg==
X-Received: by 2002:a2e:970d:: with SMTP id r13mr58767605lji.126.1561039851814;
        Thu, 20 Jun 2019 07:10:51 -0700 (PDT)
Received: from localhost.localdomain (v902-804.aalto.fi. [130.233.11.55])
        by smtp.gmail.com with ESMTPSA id 27sm3524684ljw.97.2019.06.20.07.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 07:10:51 -0700 (PDT)
From:   Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 2/7] rslib: Fix decoding of shortened codes
Date:   Thu, 20 Jun 2019 17:10:34 +0300
Message-Id: <20190620141039.9874-3-ferdinand.blomqvist@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
References: <20190620141039.9874-1-ferdinand.blomqvist@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The decoding of shortenend codes is broken. It only works as expected if
there are no erasures.

When decoding with erasures, Lambda (the error and erasure locator
polynomial) is initialized from the given erasure positions. The pad
parameter is not accounted for by the initialisation code, and hence
Lambda is initialized from incorrect erasure positions. The fix is
to adjust the erasure positions by the supplied pad.

Signed-off-by: Ferdinand Blomqvist <ferdinand.blomqvist@gmail.com>
---
 lib/reed_solomon/decode_rs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/reed_solomon/decode_rs.c b/lib/reed_solomon/decode_rs.c
index 1db74eb098d0..3313bf944ff1 100644
--- a/lib/reed_solomon/decode_rs.c
+++ b/lib/reed_solomon/decode_rs.c
@@ -99,9 +99,9 @@
 	if (no_eras > 0) {
 		/* Init lambda to be the erasure locator polynomial */
 		lambda[1] = alpha_to[rs_modnn(rs,
-					      prim * (nn - 1 - eras_pos[0]))];
+					prim * (nn - 1 - (eras_pos[0] + pad)))];
 		for (i = 1; i < no_eras; i++) {
-			u = rs_modnn(rs, prim * (nn - 1 - eras_pos[i]));
+			u = rs_modnn(rs, prim * (nn - 1 - (eras_pos[i] + pad)));
 			for (j = i + 1; j > 0; j--) {
 				tmp = index_of[lambda[j - 1]];
 				if (tmp != nn) {
-- 
2.17.2

