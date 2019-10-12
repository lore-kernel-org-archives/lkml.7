Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F4AECE58C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBEA5222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 05:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="QEhBf8C0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbfJLFuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 01:50:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33720 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbfJLFuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 01:50:16 -0400
Received: by mail-wr1-f66.google.com with SMTP id b9so14030294wrs.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 22:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUFfEqssaOurroMZxJeXFrxni1ka8JYLCPlMCPkng/8=;
        b=QEhBf8C0IAfzPSfOfrDRxQYkKq/VqXAlAodXaGkh1Amy/6QWwmkVr3/mNG/aiGKbKn
         TmlmF+lFjt3Py2zZR+248+NzL9GbEmrZWkwpUAm7n2X+QtDNOFTcX2XlfQ/5GXan3ZyV
         TSURpmW/NukWxWLLyOHg1EHB94YAGasTsmXBCyJesh/wEpbYDqz7aIrP5tOR9Hxn8X6G
         wAVYIVWq68asKZmDDH1Ga4H5eQQ1Tj4+3iZFcwnSFCFJzCuCtp3ZSqeouXlApF6ZzuM8
         d99TuYz2Pe4n3gTJ4q67eyG9vxRsv4eO/fJ0oHKYwYyHBl9T5ltEUiu3tXlVmyDU0N39
         GHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUFfEqssaOurroMZxJeXFrxni1ka8JYLCPlMCPkng/8=;
        b=nBh8g+ffYM76yfJq9GW4pVSO/wdCn7OIpSz6xb2iuTzLcv91MAHSsah2RFhGCIZ79j
         xrPVjkLRJ8DbirLmoutETgEIdyWHZDKx3m8UjDoBszXaPME3UmpXHK7CnSEEdSnQy5fm
         1Be0rZcC2i0ck7sjI8ZR4mtai+r2r46mb3PaaRFAYHgQW43lvTmHSmnG7zToK2yHg+nY
         wUXTAX7EwYosyLpWxzQtxK8UfjM04/arwhygvW8E/lWgBoSMqfM8IP0I6ROvZU4UbnPf
         9iWTN/dMEbDenxA4RrlBQVKbvYmDtuc3RBIipz9ALM2mP0AdszlCtunIZJi/qBz0/LoA
         af9Q==
X-Gm-Message-State: APjAAAUwungsAdtUwzuUnK0T2GOiLC0/Jy8OU2m+8YYFfbysNYjjxReG
        e+6mtKRV1+SBiOd8/9YjcNycfa+YTqfNoA==
X-Google-Smtp-Source: APXvYqzV0Hdp2ixn0MfFr/2aq9NwoS0W7itSV2KJ1yajVEVzE7UMP+8Hfpolf2WZ/E0FN+RBIgFXYg==
X-Received: by 2002:adf:e403:: with SMTP id g3mr14930705wrm.294.1570859414317;
        Fri, 11 Oct 2019 22:50:14 -0700 (PDT)
Received: from linux.fritz.box (p200300D9973AD600F159A589C745B52A.dip0.t-ipconnect.de. [2003:d9:973a:d600:f159:a589:c745:b52a])
        by smtp.googlemail.com with ESMTPSA id z4sm9344955wrh.93.2019.10.11.22.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 22:50:13 -0700 (PDT)
From:   Manfred Spraul <manfred@colorfullife.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>
Cc:     1vier1@web.de, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH 6/6] Documentation/memory-barriers.txt: Clarify cmpxchg()
Date:   Sat, 12 Oct 2019 07:49:58 +0200
Message-Id: <20191012054958.3624-7-manfred@colorfullife.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191012054958.3624-1-manfred@colorfullife.com>
References: <20191012054958.3624-1-manfred@colorfullife.com>
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

