Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785B0C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 463E620B7C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeP9QoMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfEFIUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:51 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37787 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfEFIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id e6so6097745pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SQz2jf18ZhbqJGiF1vojuJ/sEIUTmJdMiuQ/TuxIMiQ=;
        b=oeP9QoMfqrvYsVVeDTczuzWMPHS5M4FcWUa5gYiUME40nj1Izqbf9tmrF4nHNvjlHq
         g2Dy1e5xi9tNYBX0pQpHDITLdVHd+yKuyaif6n74MQ/XOwFeAHF5sU/MG5t0M3yZx/KX
         KKEN64unlZdGVMyyA5SvgZvTOZODSbXCBUkFh+jj4cnEfGf/uXMUgcOtUF1ZTCxq7MTb
         bWh9yeorjBRD6Fd5BTz5Pe8XYsk8xz0s4UoQ9+JPKFVJqh+z5fsEui2nbuVTnBsXhHaD
         ruCIxrOB70DGuNw6mrgyElK0GRs4UmFPn3TBrNg9YgNoCSvgH6nGkMuNO9rchu9TURiD
         Dtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SQz2jf18ZhbqJGiF1vojuJ/sEIUTmJdMiuQ/TuxIMiQ=;
        b=lX4PfkTGcE3UoHbSVq6gQbzI+hTCfIkGHMOsssESnOSEoXvb8nXY4S8vrmXdVNAg5b
         k0l46B+r0LRfZnVApHlGV0p5/d9n7xUFHhfCVOmeJkq97ME25/+sYEXQqwR71NASyu8t
         9G7fZF2zPNp7qrBJsBFEBdzeHPNwTd24CIYnbstW8K6te67xzhz+Ge+I8mPyDUHUgD9/
         wUBkozmq2eViTB7ckvuHxqRLX6VtgnhAg/Pl64UtKiS+pWeaJl6kjmJuoRAsFhk9P1k0
         3XwU5aDFEYhnKA9F8hvWu6RQEEZLnUcUT1WHibT5ZtENozqEF/f/cE7qbn0u5sIACFjq
         Ynow==
X-Gm-Message-State: APjAAAVGGl2Iix6psX1YjseIFfFspA/CvJ+ZGqPbD1sDpLMphP80vfuA
        Hw1YUrBAIcFfq+kS5cW7ugI=
X-Google-Smtp-Source: APXvYqwIx+uOCRMH8DADdj4zTgK9ml3evRwlIfwlP1nb+p06taeClNpk8N+eFFgufaqvR+zsYWf/sg==
X-Received: by 2002:a63:a351:: with SMTP id v17mr15329785pgn.431.1557130846304;
        Mon, 06 May 2019 01:20:46 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.20.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:20:45 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 18/23] locking/lockdep: Remove unused argument in __lock_release
Date:   Mon,  6 May 2019 16:19:34 +0800
Message-Id: <20190506081939.74287-19-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The @nested is not used in __release_lock so remove it despite that it
is not used in lock_release in the first place.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 kernel/locking/lockdep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 67b6a76..ebfa42a 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -4095,7 +4095,7 @@ static int __lock_downgrade(struct lockdep_map *lock, unsigned long ip)
  * @nested is an hysterical artifact, needs a tree wide cleanup.
  */
 static int
-__lock_release(struct lockdep_map *lock, int nested, unsigned long ip)
+__lock_release(struct lockdep_map *lock, unsigned long ip)
 {
 	struct task_struct *curr = current;
 	struct held_lock *hlock;
@@ -4383,7 +4383,7 @@ void lock_release(struct lockdep_map *lock, int nested,
 	check_flags(flags);
 	current->lockdep_recursion = 1;
 	trace_lock_release(lock, ip);
-	if (__lock_release(lock, nested, ip))
+	if (__lock_release(lock, ip))
 		check_chain_key(current);
 	current->lockdep_recursion = 0;
 	raw_local_irq_restore(flags);
-- 
1.8.3.1

