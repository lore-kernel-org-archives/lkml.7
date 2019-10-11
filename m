Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17780C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6261214E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 11:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="qSFaZ2px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbfJKLUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 07:20:25 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52895 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727986AbfJKLUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 07:20:22 -0400
Received: by mail-wm1-f66.google.com with SMTP id r19so10023605wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 04:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUFfEqssaOurroMZxJeXFrxni1ka8JYLCPlMCPkng/8=;
        b=qSFaZ2pxK7tqVu4JVRNwFDFnbHCJe5s8N3kv6lmE0U8lV21/6RpD1t6aMCTpAfXxxx
         eCN/dLSJxpeDnMyuvktuqx5yxTMMwpYbhaBz2457jP1vPAAsCmovfIJ6hmXxOeMfHxLO
         7D4tcryPdH9z2aOJCokCQC+gnIv3GvqqygcX+XWDocw8bzAHo3AK2Ol1aw2M/rRzwkUU
         AFEFkssTMMfOCCWjxBbtFx584XmINS8k66sukSBKhBDvwYEMS4nVC0XGM9R/bGWGgL9J
         tlMYEQhhYNeO0OvvzsAZGkaKmxMHZeGudG+2D0D9o7roQnZ6bLLNEhI8D0hjShGRCTG1
         zLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUFfEqssaOurroMZxJeXFrxni1ka8JYLCPlMCPkng/8=;
        b=G9NpcaKdKbOtUbGne2uxR4B99j1OChioRDjW+/Lc/psrYtal/A2PEXxkYeNfqLITIU
         lSz7/Ey8kpzKnBmFG+3+vjlM1OnRxfdKDd1VnWMo02acfepg2oTknIVysoaRHxdTG/Y+
         rWD+vnNzU02KzUYJFnotPhFUhm6RB8fg+Be6BZ9wUMjtWs7PAK2OGCzQ9ulNdssBn/4j
         qy6YoAopHcyVhXHpuskMSkr6Jzxz099NzvafRGGYlHMussstzafDdlT6aqzZXu9a0l17
         3ko40Jm3zPXiEA18OCTmK1j5vZJh+Wt2jbjLJ4aTLbM5b9VaHsixK6/9fuL8sI9DqtVA
         a0CA==
X-Gm-Message-State: APjAAAUg/0H3xKY7I8rwSh3fhUSDLe+nfvGBY82mNlCjqfTITJZBH+fG
        C09JIH0ylrNQfTs6u5WXDfNe9m/vLro=
X-Google-Smtp-Source: APXvYqxUhK6gF2ue4oN6TwOX64whxF94mmkrZ9VotMb868lJuTrdbFIWVRZkWNhaSMLrBsbLrlWVTg==
X-Received: by 2002:a05:600c:22ce:: with SMTP id 14mr2738051wmg.71.1570792820955;
        Fri, 11 Oct 2019 04:20:20 -0700 (PDT)
Received: from linux.fritz.box (p200300D99705BE00E22045ECB41D901D.dip0.t-ipconnect.de. [2003:d9:9705:be00:e220:45ec:b41d:901d])
        by smtp.googlemail.com with ESMTPSA id 63sm12781226wri.25.2019.10.11.04.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 04:20:20 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 5/5] Documentation/memory-barriers.txt: Clarify cmpxchg()
Date:   Fri, 11 Oct 2019 13:20:09 +0200
Message-Id: <20191011112009.2365-6-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011112009.2365-1-manfred@colorfullife.com>
References: <20191011112009.2365-1-manfred@colorfullife.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The documentation in memory-barriers.txt claims that
smp_mb__{before,after}_atomic() are for atomic ops that do not return a
value.

This is misleading and doesn't match the example in atomic_t.txt,
and e.g. smp_mb__before_atomic() may and is used together with
cmpxchg_relaxed() in the wake_q code.

The purpose of e.g. smp_mb__before_atomic() is to "upgrade" a following
RMW atomic operation to a full memory barrier.
The return code of the atomic operation has no impact, so all of the
following examples are valid:

1)
	smp_mb__before_atomic();
	atomic_add();

2)
	smp_mb__before_atomic();
	atomic_xchg_relaxed();

3)
	smp_mb__before_atomic();
	atomic_fetch_add_relaxed();

Invalid would be:
	smp_mb__before_atomic();
	atomic_set();

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 Documentation/memory-barriers.txt | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 1adbb8a371c7..52076b057400 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -1873,12 +1873,13 @@ There are some more advanced barrier functions:
  (*) smp_mb__before_atomic();
  (*) smp_mb__after_atomic();
 
-     These are for use with atomic (such as add, subtract, increment and
-     decrement) functions that don't return a value, especially when used for
-     reference counting.  These functions do not imply memory barriers.
+     These are for use with atomic RMW functions (such as add, subtract,
+     increment, decrement, failed conditional operations, ...) that do
+     not imply memory barriers, but where the code needs a memory barrier,
+     for example when used for reference counting.
 
-     These are also used for atomic bitop functions that do not return a
-     value (such as set_bit and clear_bit).
+     These are also used for atomic RMW bitop functions that do imply a full
+     memory barrier (such as set_bit and clear_bit).
 
      As an example, consider a piece of code that marks an object as being dead
      and then decrements the object's reference count:
-- 
2.21.0

