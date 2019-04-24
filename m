Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B6BC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0809F21773
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 10:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDLjZ//Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfDXKUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 06:20:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34615 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbfDXKUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 06:20:34 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so9178828pgq.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eYDKLY/J3Ojcc0M0ObUE8MpmgNsUQzKLk0bpzbCdRyY=;
        b=KDLjZ//Z7RG4V1HOK5E1RfcFbXhjMYvNiaMzzOsJ+R6FkbksNGhu7KsmJpHHiJEhwB
         IC0tt+GC5tsv/3awskQjG0KXRDQrpR3PVVpHXZdi+HSzVmxVcbtwzGcTrmNLDT864f0J
         MILItX++OzBwGrKGWGHbQRjWvDD+A4fi5mll65GJH6R+rcK1NQ2Lbog/xIb9uQ6ilJAo
         WUPGfC9UIcRPnMtshpoSqKAHh2cchVbGI519T+aL5vMRL7iOLf1pR0FtO89CpKKghsRN
         njLte3XtBZSn1mkFY9FxPhx0zkM7PS8HSUAxnS/AiSwlIU2m1Q+T13u4turiM9AeDBza
         XWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eYDKLY/J3Ojcc0M0ObUE8MpmgNsUQzKLk0bpzbCdRyY=;
        b=tLZ7TL8c7qJGbgcW6SMnCNQIARaRWWtmMK/u39XBdaGLRbybQpbqDPZb/s9O4OAA/G
         Id+MreS0m95U27pp3yiIyLCeAwuW5WESUaWe9sIiSQKrYNCsswj1dxSaQRnOIzO7kzof
         kJlzeCX1QkN/BPsWlfIa8RKSUxxmdaJw7HyISy9qp/U8WlZFwgJNm2MXPJ2CGeyTJfHv
         PEyxBXxgljZ3iAyQPIhejQOMbiN7CVc3AW55a71Wsz4Mhn4WO4Cvg7vD7bHGayY1w0J4
         XyZmQmGPCPslDMt9fVXk73ayhCvdp63W+gA6tTWeEt7IowD/SsMF5mHuGMLml6u0S2YT
         /IKQ==
X-Gm-Message-State: APjAAAWIoBGdp1w/ddGueOlUBEZ3+wGtrE3BjgpnZJti77zqbuBASTIk
        7XwNoKmGA9eOMblVrsvcZ7E=
X-Google-Smtp-Source: APXvYqz3F4n6rFRRpxF6XNHHG26DWbZi1levuAQq4ZPVphSWsZddw3FELPtW5BoCnSeI9/oi0JNM/Q==
X-Received: by 2002:a63:ff05:: with SMTP id k5mr17374972pgi.342.1556101234275;
        Wed, 24 Apr 2019 03:20:34 -0700 (PDT)
Received: from localhost.localdomain ([203.100.54.194])
        by smtp.gmail.com with ESMTPSA id v19sm25051604pfn.62.2019.04.24.03.20.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 03:20:33 -0700 (PDT)
From:   Yuyang Du <duyuyang@gmail.com>
To:     peterz@infradead.org, will.deacon@arm.com, mingo@kernel.org
Cc:     bvanassche@acm.org, ming.lei@redhat.com, frederic@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Yuyang Du <duyuyang@gmail.com>
Subject: [PATCH 02/28] locking/lockdep: Add description and explanation in lockdep design doc
Date:   Wed, 24 Apr 2019 18:19:08 +0800
Message-Id: <20190424101934.51535-3-duyuyang@gmail.com>
X-Mailer: git-send-email 2.20.1 (Apple Git-117)
In-Reply-To: <20190424101934.51535-1-duyuyang@gmail.com>
References: <20190424101934.51535-1-duyuyang@gmail.com>
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
 Documentation/locking/lockdep-design.txt | 74 ++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 18 deletions(-)

diff --git a/Documentation/locking/lockdep-design.txt b/Documentation/locking/lockdep-design.txt
index 39fae14..d5062fc 100644
--- a/Documentation/locking/lockdep-design.txt
+++ b/Documentation/locking/lockdep-design.txt
@@ -15,34 +15,43 @@ tens of thousands of) instantiations. For example a lock in the inode
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
+the dependencies between different lock-classes. A dependency can be
+understood as lock order, where L1 -> L2 suggests L2 is attempted to be
+acquired with L1 held. From lockdep's perspective, the two locks (L1 and
+L2) are not necessarily related, but just means that order ever
+happened. The validator maintains a continuing effort to prove that the
+lock usages and their dependencies are correct or the validator will
+shoot a splat if they are incorrect.
+
+Unlike a lock instance, a lock-class itself never goes away: when a
+lock-class's instance is used for the first time after bootup the class gets
+registered, and all (subsequent) instances of that lock-class will be mapped
+to the lock-class.
 
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
@@ -51,15 +60,44 @@ locking error messages, inside curlies. A contrived example:
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

