Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E2C04AAB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EEC2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nU5w+Riv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfEFIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:20:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:37720 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbfEFIT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:19:56 -0400
Received: by mail-pg1-f193.google.com with SMTP id e6so6096712pgc.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 01:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hxM4OPcLJIRvKRZKnlbAjNaieUHiqlFDr4aEtb2F+l4=;
        b=nU5w+RivHgf9Qapr+S9cAYeGbHiOgHYM3Ufpp0MvkqnXXX0lLSxiH5j2CzmbF3ixpX
         B3tWzysLZTMjgRhdVraQDfcMMCB69OsxMGnCXA0RwjVdqHvS8hwuUvDqghvkYPhTIiL1
         SQgzs06vJpquV03cGYyetMqkZIMMgF5ZPqSP/SCj0UY81QDtRTPWv0YD4rwY+uWbDY8i
         HM+kQRbKhTz9WsUByATqYmUi+dENgT8tvDGnTBFD5QCVdrztad7wnWCWFzn/3akjd0sj
         9A7sou8/dWxUfbIgECVTpmXYZgzeNcZr26DVyDWt2KdXv66oUdjrZm46u7hlNYtogPew
         o5eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hxM4OPcLJIRvKRZKnlbAjNaieUHiqlFDr4aEtb2F+l4=;
        b=tuoSFyAaCGhpW/v7EH8G9hqnbGBnn200wKkbrwmgbtUZb9OPoSYQQLU+qzxli/uHFy
         qr/ZW7MStDVkN+ao71zld1IOZWtN4EMo5IxngGp2jbr2AVsmP6YztqLP8HUZBYa4P9tp
         yIu7azF46kGpnyUH+fTPC7Ly0zT+1U8CNLfw7mXTvwHE4hvxxIa4OEouQHRQwqqkGd+H
         QpvAOp09uAa1hqeUw0/N32JAT2kJnGHn/hLritiKLx4G0FPA18G1fRpSyeErG9qQOhjC
         iqHc/v/h4l7FygvMMglcJ4uJfmDlz2t/ad3K31Y7FMmfC57vqO8FnNAV162GgC6Vjuj+
         Cdsw==
X-Gm-Message-State: APjAAAXO9XMa/+QnUEhdYy2UWxg4OU9UlscvDo77+LFxuuMd+QtQR6WR
        CWONeyYu2/SM8eQ6FN2Q6C0=
X-Google-Smtp-Source: APXvYqwcvYAIXcFWOHOk0jOm51KRiKEwUcYOtdQvXi6YdjGfC9i4Bk48ggn4n++6ODYaMGMZ2ttG8w==
X-Received: by 2002:a63:17:: with SMTP id 23mr30193506pga.206.1557130796079;
        Mon, 06 May 2019 01:19:56 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm20958013pfa.138.2019.05.06.01.19.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 01:19:55 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH v2 02/23] locking/lockdep: Add description and explanation in lockdep design doc
Date:   Mon,  6 May 2019 16:19:18 +0800
Message-Id: <20190506081939.74287-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190506081939.74287-1-duyuyang@gmail.com>
References: <20190506081939.74287-1-duyuyang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

More words are added to lockdep design document regarding key concepts,
which should help people without lockdep experience read and understand
lockdep reports.

Signed-off-by: Yuyang Du <duyuyang@gmail.com>
---
 Documentation/locking/lockdep-design.txt | 79 ++++++++++++++++++++++++--------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 39fae14..ae65758 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -15,34 +15,48 @@ tens of thousands of) instantiations. For example a lock in the inode
 struct is one class, while each inode has its own instantiation of that
 lock class.
 
-The validator tracks the 'state' of lock-classes, and it tracks
-dependencies between different lock-classes. The validator maintains a
-rolling proof that the state and the dependencies are correct.
-
-Unlike an lock instantiation, the lock-class itself never goes away: when
-a lock-class is used for the first time after bootup it gets registered,
-and all subsequent uses of that lock-class will be attached to this
-lock-class.
+The validator tracks the 'usage state' of lock-classes, and it tracks
+the dependencies between different lock-classes. Lock usage indicates
+how a lock is used with regard to its IRQ contexts, while lock
+dependency can be understood as lock order, where L1 -> L2 suggests that
+a task is attempting to acquire L2 while holding L1. From lockdep's
+perspective, the two locks (L1 and L2) are not necessarily related; that
+dependency just means the order ever happened. The validator maintains a
+continuing effort to prove lock usages and dependencies are correct or
+the validator will shoot a splat if incorrect.
+
+A lock-class's behavior is constructed by its instances collectively:
+when the first instance of a lock-class is used after bootup the class
+gets registered, then all (subsequent) instances will be mapped to the
+class and hence their usages and dependecies will contribute to those of
+the class. A lock-class does not go away when a lock instance does, but
+it can be removed if the memory space of the lock class (static or
+dynamic) is reclaimed, this happens for example when a module is
+unloaded or a workqueue is destroyed.
 
 State
 -----
 
-The validator tracks lock-class usage history into 4 * nSTATEs + 1 separate
-state bits:
+The validator tracks lock-class usage history and divides the usage into
+(4 usages * n STATEs + 1) categories:
 
+where the 4 usages can be:
 - 'ever held in STATE context'
 - 'ever held as readlock in STATE context'
 - 'ever held with STATE enabled'
 - 'ever held as readlock with STATE enabled'
 
-Where STATE can be either one of (kernel/locking/lockdep_states.h)
- - hardirq
- - softirq
+where the n STATEs are coded in kernel/locking/lockdep_states.h and as of
+now they include:
+- hardirq
+- softirq
 
+where the last 1 category is:
 - 'ever used'                                       [ == !unused        ]
 
-When locking rules are violated, these state bits are presented in the
-locking error messages, inside curlies. A contrived example:
+When locking rules are violated, these usage bits are presented in the
+locking error messages, inside curlies, with a total of 2 * n STATEs bits.
+A contrived example:
 
    modprobe/2287 is trying to acquire lock:
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
@@ -51,15 +65,44 @@ locking error messages, inside curlies. A contrived example:
     (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
 
 
-The bit position indicates STATE, STATE-read, for each of the states listed
-above, and the character displayed in each indicates:
+For a given lock, the bit positions from left to right indicate the usage
+of the lock and readlock (if exists), for each of the n STATEs listed
+above respectively, and the character displayed at each bit position
+indicates:
 
    '.'  acquired while irqs disabled and not in irq context
    '-'  acquired in irq context
    '+'  acquired with irqs enabled
    '?'  acquired in irq context with irqs enabled.
 
-Unused mutexes cannot be part of the cause of an error.
+The bits are illustrated with an example:
+
+    (&sio_locks[i].lock){-.-.}, at: [<c02867fd>] mutex_lock+0x21/0x24
+                         ||||
+                         ||| \-> softirq disabled and not in softirq context
+                         || \--> acquired in softirq context
+                         | \---> hardirq disabled and not in hardirq context
+                          \----> acquired in hardirq context
+
+
+For a given STATE, whether the lock is ever acquired in that STATE
+context and whether that STATE is enabled yields four possible cases as
+shown in the table below. The bit character is able to indicate which
+exact case is for the lock as of the reporting time.
+
+   -------------------------------------------
+  |              | irq enabled | irq disabled |
+  |-------------------------------------------|
+  | ever in irq  |      ?      |       -      |
+  |-------------------------------------------|
+  | never in irq |      +      |       .      |
+   -------------------------------------------
+
+The character '-' suggests irq is disabled because if otherwise the
+charactor '?' would have been shown instead. Similar deduction can be
+applied for '+' too.
+
+Unused locks (e.g., mutexes) cannot be part of the cause of an error.
 
 
 Single-lock state rules:
-- 
1.8.3.1

