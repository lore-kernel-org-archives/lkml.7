Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B807C74A44
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED335214DA
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 19:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Ve7HD8EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfGNTWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 15:22:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728125AbfGNTWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 15:22:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id 207so13079502wma.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 12:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TOBxcCB5CfbyU19IsOQqj/unz3pBQwhkjvYM4QBwvI=;
        b=Ve7HD8EAgySgMHY76dTo8ImKMu88em783+DC1jRlNGpEbWzVY8izhhoEMLieCS50jJ
         tW8XFqB6ZkRdP7AmmRQ89TTMYeLuQZGrfPyJ+7K1WxoM7YqHI53+8yIzGoTTmG4XXwNH
         8Tnvde95HhzQA7MU9phA5TbOrQxYCLQa/fgv5H9N64wgp59hnk+CuI43sEfWp9y0lkVA
         gzfgnOK4e49o5k1xYcvMWng9zj2kXJbz4Odmbmw2Iqf5fGw3YzLJ/kkpPHF8SEyC4sNp
         kS5oLmFZ847PAdUVOVLI2pGRtH2niefOycwIYaZUn4T/izW0dtlp/GIQQnIP1HjHDPUN
         e6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TOBxcCB5CfbyU19IsOQqj/unz3pBQwhkjvYM4QBwvI=;
        b=uiiyYZNm4WDktSy/fWAOdIsX3AHf+iU7kTeRK+dxcI/CiegarYw3oQRBfFwqug9i55
         RdtF2uQhoemcLsEHPiug+HtOkm+URMBHsZqWf5z15cnN4vGzMZhjZyF53NM9HDX2rVza
         SK4WaDj8fiPHHZqKnyqQtgcxue1YMovqBUdyV92Rg87JSy1SEUK5WBuRzGY3WrfE55QC
         L1ww3ouw5ULx019sR1EF+RbVJyTBQVNfrIrwLhm5iuL+HlEsxOGBA6f+q4Qn1WyTCmaK
         sOfplrEX0SEfvN6El9eLN03YvuYa1mnn49EuWfbN4QTwn3r6avQs40XuQ7Z0cdPt/fCo
         acxQ==
X-Gm-Message-State: APjAAAUcnCbvgbYv91xDbrJ7oCV4nfML3SZPL/Tp2J5hkConrBNorXa9
        ZVRlIQuSdpsX8f2B7NL/9xRTTiv8YbU=
X-Google-Smtp-Source: APXvYqyzQ0gcWa61AoX1CO9Ux02D1Lg5fF4pwvRX1xYAX2T/XeDECuUqcGMUdMfiEpNnvxRMVT9JVA==
X-Received: by 2002:a1c:a481:: with SMTP id n123mr18881972wme.123.1563132170402;
        Sun, 14 Jul 2019 12:22:50 -0700 (PDT)
Received: from localhost.localdomain ([213.220.153.21])
        by smtp.gmail.com with ESMTPSA id r12sm18142743wrt.95.2019.07.14.12.22.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 12:22:49 -0700 (PDT)
From:   Christian Brauner <christian@brauner.io>
To:     linux-kernel@vger.kernel.org
Cc:     arnd@arndb.de, Christian Brauner <christian@brauner.io>
Subject: [PATCH 2/2] unistd: protect clone3 via __ARCH_WANT_SYS_CLONE3
Date:   Sun, 14 Jul 2019 21:22:05 +0200
Message-Id: <20190714192205.27190-3-christian@brauner.io>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714192205.27190-1-christian@brauner.io>
References: <20190714192205.27190-1-christian@brauner.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This lets us catch new architectures that implicitly make use of clone3
without setting __ARCH_WANT_SYS_CLONE3.
Failing on missing __ARCH_WANT_SYS_CLONE3 is a good indicator that they
either did not really want this syscall or haven't really thought about
whether it needs special treatment and just accidently included it in
their entrypoints by e.g. generating their syscall table automatically
via asm-generic/unistd.h

This patch has been compile-tested for the h8300 architecture which is
one of the architectures that does not yet implement clone3 and
generates its syscall table via asm-generic/unistd.h.

Signed-off-by: Christian Brauner <christian@brauner.io>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 9acfff0cd153..1be0e798e362 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -846,8 +846,10 @@ __SYSCALL(__NR_fsmount, sys_fsmount)
 __SYSCALL(__NR_fspick, sys_fspick)
 #define __NR_pidfd_open 434
 __SYSCALL(__NR_pidfd_open, sys_pidfd_open)
+#ifdef __ARCH_WANT_SYS_CLONE3
 #define __NR_clone3 435
 __SYSCALL(__NR_clone3, sys_clone3)
+#endif
 
 #undef __NR_syscalls
 #define __NR_syscalls 436
-- 
2.22.0

