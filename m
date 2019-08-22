Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54EEC3A59D
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A11A0206BB
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="UsKrpxXP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfHVHwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:52:14 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42552 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730037AbfHVHwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:52:14 -0400
Received: by mail-lj1-f195.google.com with SMTP id l14so4619279ljj.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCTePgG7RYdXOtsqMn/EGiKAq/u1kBDj9aPT9Dfgczw=;
        b=UsKrpxXPuL+ZKlwuc+ITBE2tuLBFTuT+d1kgO/pLG86lqhfUTqbrbhF74QLrk18Pzb
         aOSONgtap5+EOa0YnJJ0gx+bb3jdFQaJOFn7UB33gwPAQlJWy8VDqNOK6ZTbyqKmTSVM
         pvhaBbl0n3KZ4qFLlOKtQ5UHKddxuxb/jsrZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCTePgG7RYdXOtsqMn/EGiKAq/u1kBDj9aPT9Dfgczw=;
        b=l2RtoUtQwH+8Wa9whFkQZYBZXxLPKAPBCiB7cUvUg1LovP4F0HzeRO3ROE+YiV0mU8
         KT8FuR75RBnNdTzTvNMsqitLVABvTwwWHUpk/urLuhhEF6Lwl4qJ/2rqOSZKIW9uCgVf
         EMqx6Ag52HA8MXnA27PMxkeopAnu7XBbp5Dk5xV7EQd5cz4THKc40+KZgIhYkQlAvlPP
         0k1RNNIeB2AhPnqvrc+Yg9rkbgd9pNgv2c4Qct8txc3XPGeircaMw0ykNAIfQ4kU2Z1Y
         t/TVqnPdqV45MbltLu6xGJuOPUtbIL2PLl17XCQiu++DQ7UtnEhdntnr3UVyA/WwB8Fx
         e5Zg==
X-Gm-Message-State: APjAAAW4E6Bpcr1EdZPsRkv2ivqKN6YyYEha/2YPWF3VIqUAG9KWjoK1
        llTG+PxXx9B3LGBaXl2C7PiGNA==
X-Google-Smtp-Source: APXvYqxV31j+6lX+In5ijbALOUcTYMKfDsts8VM2xlJCyXRU+AgvcViEXDeB82pw2Jxiz7jc352mNA==
X-Received: by 2002:a05:651c:104a:: with SMTP id x10mr20266511ljm.238.1566460332223;
        Thu, 22 Aug 2019 00:52:12 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id x13sm3699675ljm.7.2019.08.22.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2019 00:52:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/init-mm.c: use CPU_BITS_NONE to initialize .cpu_bitmap
Date:   Thu, 22 Aug 2019 09:52:07 +0200
Message-Id: <20190822075207.26400-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_mm is sizeof(long) larger than it needs to be. Use the
CPU_BITS_NONE macro meant for this, which will initialize just the
indices 0...(BITS_TO_LONGS(NR_CPUS)-1) and hence make the array size
actually BITS_TO_LONGS(NR_CPUS).

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 mm/init-mm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/init-mm.c b/mm/init-mm.c
index a787a319211e..fb1e15028ef0 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -35,6 +35,6 @@ struct mm_struct init_mm = {
 	.arg_lock	=  __SPIN_LOCK_UNLOCKED(init_mm.arg_lock),
 	.mmlist		= LIST_HEAD_INIT(init_mm.mmlist),
 	.user_ns	= &init_user_ns,
-	.cpu_bitmap	= { [BITS_TO_LONGS(NR_CPUS)] = 0},
+	.cpu_bitmap	= CPU_BITS_NONE,
 	INIT_MM_CONTEXT(init_mm)
 };
-- 
2.20.1

