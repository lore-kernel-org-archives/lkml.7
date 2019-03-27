Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DATE_IN_FUTURE_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34453C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01FD020645
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 16:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTJir5OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbfC0Qtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 12:49:41 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45184 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfC0Qtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 12:49:41 -0400
Received: by mail-pf1-f193.google.com with SMTP id e24so9116963pfi.12;
        Wed, 27 Mar 2019 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=GLShcatoNZX24t/HIxQvgO8K4LRIkCqfBm1q42DIwbQ=;
        b=rTJir5OKnr+JBR8AipX2KaLi6FSWVvTnENC9TNxlVeG9wA6I9MeHK24OtZErrcOJQ2
         0U5qWZrSfa9LVtiweOoV8VwfvFFb48x9orixafY5INPsVtAPw8thZ78Bgr0sPF+krqwA
         pGVHlW8SinLiCUP1D72vzKV7uSKJx/ZatXqxJG9+YAORyQs3jXTL0Mg0+w0PAoiWAL8G
         e00jehh+ewBJbxEilsh8ZhxEno4vHivyMGpJgciECY0xbvXwxLUm24MhjgRyMN3orvQd
         4pIrVQa60CayeBjSCt0U8wFGHhmbFTZr9FTtusxywl1tRVq7s068prc/Ew3vZiZqoMUC
         K1JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GLShcatoNZX24t/HIxQvgO8K4LRIkCqfBm1q42DIwbQ=;
        b=B9FiKGsv8QFmdPQlb5ZKAWL6zi52W6orCkM0ZIuMptGsl9XZfPQk7vvsSWBY+2uJan
         2HvRRRkMPoLTMDy0yUoYxcBtwss7Pi5QuOC77TA6YDQqrFFc5DMo/sr8zXGayyYDWDGW
         lOiCTXcbwcPzDqgXO+8vqgTQbe3oJmDgQI3u61VKIUOEMl55/7XCjX0fNVHnFQ1mdBWU
         XuXCg+bG/nqdTiu/BirnCHF01z3JQCk29SXJP9YjtsqD9q2x+cQ7DV67WsAcOWyRPk25
         tY2B5duJCn0dBrZc/SR12VvCRfdQbm4ylv2KmmTrUx0No76o4zmDjHEA/Rz2jyfHc2Pv
         GRKQ==
X-Gm-Message-State: APjAAAUhHtmOb04rRSkwHSB1MOxrtgbEi3DCYb2Foh2wkCfR/yUfHrnx
        ri81E16b66d0FpHUZkqXiouKqt/v
X-Google-Smtp-Source: APXvYqwYpBBnWXZi19YihdnBb9dn1aoTh3yKYPC6i8vCGgrMlYcdWUwXmWuofPpqhHAKs5POr8beSA==
X-Received: by 2002:aa7:8443:: with SMTP id r3mr35822292pfn.143.1553705380544;
        Wed, 27 Mar 2019 09:49:40 -0700 (PDT)
Received: from CentOS76.localdomain.localdomain ([27.59.54.136])
        by smtp.gmail.com with ESMTPSA id k9sm41575711pfc.57.2019.03.27.09.49.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Mar 2019 09:49:39 -0700 (PDT)
From:   jagdsh.linux@gmail.com
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        shuah@kernel.org, paul.burton@mips.com
Cc:     inuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>
Subject: [PATCH] selftests:powerpc/tm/tm-vmx-unavail.c : Remove duplicate header
Date:   Thu, 28 Mar 2019 03:19:16 +0530
Message-Id: <1553723356-40069-1-git-send-email-jagdsh.linux@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jagadeesh Pagadala <jagdsh.linux@gmail.com>

Remove duplicate header which is included twice.

Signed-off-by: Jagadeesh Pagadala <jagdsh.linux@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
index 137185b..1cb963a 100644
--- a/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
+++ b/tools/testing/selftests/powerpc/tm/tm-vmx-unavail.c
@@ -17,7 +17,6 @@
 #include <pthread.h>
 #include <sys/mman.h>
 #include <unistd.h>
-#include <pthread.h>
 
 #include "tm.h"
 #include "utils.h"
-- 
1.8.3.1

