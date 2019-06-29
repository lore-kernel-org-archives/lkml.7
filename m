Return-Path: <SRS0=Dr8o=U4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146F1C5B57B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2419216FD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Jun 2019 21:11:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cBJYEcqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbfF2VLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Jun 2019 17:11:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35955 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfF2VLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jun 2019 17:11:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so12106732wmm.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2019 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=RnN8+araUIrTEOZsBFjA6OS/4XJR8mt8ImjbzPCHMmk=;
        b=cBJYEcqwp4nEnjU9R3h0ZoBvLcdkF+X9VSuvAk68akW9zWj6vJCCrUirrNw3/UJXpZ
         SSi6UaenWa0Nz3yg/67TqBZopY1REBJcPM9iGsKp74eLmIeevpViiAWYaLSc8dHNG0pF
         KZf2GmGdFY+J7AvjAc7L709OZoTbDnzkr544g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RnN8+araUIrTEOZsBFjA6OS/4XJR8mt8ImjbzPCHMmk=;
        b=f4s8vWgkJVb6Xb7t1rOn43ng1dbdmt6zBtANM3YnG2sDsAS7RSgTyFyemRqnq/mCVR
         +VU2pozbWVBfws//RzxFle2zz8dUuRJb1i2rskx3NVsYXyNZrzV5Ib4B+zVIliLFqTWv
         3ITLdTKvE7wm8Zj1oSnSw6K/ILUhULpmKHsYAl8sqh1TpllTjGCiPyl8WImaqKt36yWr
         fG+HXXMqOV3SnNHJdIAhwRgdYM0LMO3gZTqWD4xoYEFkW8+H350Qq5I+pXO04hl78OTp
         MeGUehYfxlsdiT4ZfKWlDgFqDnVNLz2Oj8agLnw/3zyWE1+GvzLcdsfdMMS7FfAyuBjR
         a75w==
X-Gm-Message-State: APjAAAVnSfa3EAPcFrxMamvT1Uq1Qs0V90YMZVuKO0lkOHoSdVo65CuC
        dfj5MSqrbzkwFVZqAN3DNeNr3zoEvHY=
X-Google-Smtp-Source: APXvYqxWmfR5B1+1TqkLISrF7bzXpZeR5DVgcFemebukmqjixJbC8msEscsyZ7BAus7i/llmtJ0hug==
X-Received: by 2002:a7b:c8d4:: with SMTP id f20mr12136114wml.90.1561842662451;
        Sat, 29 Jun 2019 14:11:02 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-62-100.net.upcbroadband.cz. [94.112.62.100])
        by smtp.gmail.com with ESMTPSA id x20sm5402150wmc.1.2019.06.29.14.11.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jun 2019 14:11:01 -0700 (PDT)
From:   Andrea Parri <andrea.parri@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Andrea Parri <andrea.parri@amarulasolutions.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>
Subject: [PATCH] tools/memory-model: Update the informal documentation
Date:   Sat, 29 Jun 2019 23:10:44 +0200
Message-Id: <1561842644-5354-1-git-send-email-andrea.parri@amarulasolutions.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The formal memory consistency model has added support for plain accesses
(and data races).  While updating the informal documentation to describe
this addition to the model is highly desirable and important future work,
update the informal documentation to at least acknowledge such addition.

Signed-off-by: Andrea Parri <andrea.parri@amarulasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@linux.ibm.com>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
---
 tools/memory-model/Documentation/explanation.txt | 47 +++++++++++-------------
 tools/memory-model/README                        | 18 ++++-----
 2 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
index 68caa9a976d0c..b42f7cd718242 100644
--- a/tools/memory-model/Documentation/explanation.txt
+++ b/tools/memory-model/Documentation/explanation.txt
@@ -42,7 +42,8 @@ linux-kernel.bell and linux-kernel.cat files that make up the formal
 version of the model; they are extremely terse and their meanings are
 far from clear.
 
-This document describes the ideas underlying the LKMM.  It is meant
+This document describes the ideas underlying the LKMM, but excluding
+the modeling of bare C (or plain) shared memory accesses.  It is meant
 for people who want to understand how the model was designed.  It does
 not go into the details of the code in the .bell and .cat files;
 rather, it explains in English what the code expresses symbolically.
@@ -354,31 +355,25 @@ be extremely complex.
 Optimizing compilers have great freedom in the way they translate
 source code to object code.  They are allowed to apply transformations
 that add memory accesses, eliminate accesses, combine them, split them
-into pieces, or move them around.  Faced with all these possibilities,
-the LKMM basically gives up.  It insists that the code it analyzes
-must contain no ordinary accesses to shared memory; all accesses must
-be performed using READ_ONCE(), WRITE_ONCE(), or one of the other
-atomic or synchronization primitives.  These primitives prevent a
-large number of compiler optimizations.  In particular, it is
-guaranteed that the compiler will not remove such accesses from the
-generated code (unless it can prove the accesses will never be
-executed), it will not change the order in which they occur in the
-code (within limits imposed by the C standard), and it will not
-introduce extraneous accesses.
-
-This explains why the MP and SB examples above used READ_ONCE() and
-WRITE_ONCE() rather than ordinary memory accesses.  Thanks to this
-usage, we can be certain that in the MP example, P0's write event to
-buf really is po-before its write event to flag, and similarly for the
-other shared memory accesses in the examples.
-
-Private variables are not subject to this restriction.  Since they are
-not shared between CPUs, they can be accessed normally without
-READ_ONCE() or WRITE_ONCE(), and there will be no ill effects.  In
-fact, they need not even be stored in normal memory at all -- in
-principle a private variable could be stored in a CPU register (hence
-the convention that these variables have names starting with the
-letter 'r').
+into pieces, or move them around.  The use of READ_ONCE(), WRITE_ONCE(),
+or one of the other atomic or synchronization primitives prevents a
+large number of compiler optimizations.  In particular, it is guaranteed
+that the compiler will not remove such accesses from the generated code
+(unless it can prove the accesses will never be executed), it will not
+change the order in which they occur in the code (within limits imposed
+by the C standard), and it will not introduce extraneous accesses.
+
+The MP and SB examples above used READ_ONCE() and WRITE_ONCE() rather
+than ordinary memory accesses.  Thanks to this usage, we can be certain
+that in the MP example, the compiler won't reorder P0's write event to
+buf and P0's write event to flag, and similarly for the other shared
+memory accesses in the examples.
+
+Since private variables are not shared between CPUs, they can be
+accessed normally without READ_ONCE() or WRITE_ONCE().  In fact, they
+need not even be stored in normal memory at all -- in principle a
+private variable could be stored in a CPU register (hence the convention
+that these variables have names starting with the letter 'r').
 
 
 A WARNING
diff --git a/tools/memory-model/README b/tools/memory-model/README
index 2b87f3971548c..fc07b52f20286 100644
--- a/tools/memory-model/README
+++ b/tools/memory-model/README
@@ -167,15 +167,15 @@ scripts	Various scripts, see scripts/README.
 LIMITATIONS
 ===========
 
-The Linux-kernel memory model has the following limitations:
-
-1.	Compiler optimizations are not modeled.  Of course, the use
-	of READ_ONCE() and WRITE_ONCE() limits the compiler's ability
-	to optimize, but there is Linux-kernel code that uses bare C
-	memory accesses.  Handling this code is on the to-do list.
-	For more information, see Documentation/explanation.txt (in
-	particular, the "THE PROGRAM ORDER RELATION: po AND po-loc"
-	and "A WARNING" sections).
+The Linux-kernel memory model (LKMM) has the following limitations:
+
+1.	Compiler optimizations are not accurately modeled.  Of course,
+	the use of READ_ONCE() and WRITE_ONCE() limits the compiler's
+	ability to optimize, but under some circumstances it is possible
+	for the compiler to undermine the memory model.  For more
+	information, see Documentation/explanation.txt (in particular,
+	the "THE PROGRAM ORDER RELATION: po AND po-loc" and "A WARNING"
+	sections).
 
 	Note that this limitation in turn limits LKMM's ability to
 	accurately model address, control, and data dependencies.
-- 
2.7.4

