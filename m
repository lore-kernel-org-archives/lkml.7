Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053F8C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96BA21479
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 14:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbfFRO5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 10:57:33 -0400
Received: from foss.arm.com ([217.140.110.172]:45260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728572AbfFRO5d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 10:57:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 673512B;
        Tue, 18 Jun 2019 07:57:32 -0700 (PDT)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.194.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B40143F718;
        Tue, 18 Jun 2019 07:57:31 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     corbet@lwn.net
Subject: [PATCH] docs/vm: hwpoison.rst: Fix quote formatting
Date:   Tue, 18 Jun 2019 15:56:05 +0100
Message-Id: <20190618145605.21208-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asterisks prepended to the quoted text currently get translated to
bullet points, which gets increasingly confusing the smaller your
screen is (when viewing the sphinx output, that is).

Convert the whole quote to a literal block.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 Documentation/vm/hwpoison.rst | 52 +++++++++++++++++------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/vm/hwpoison.rst b/Documentation/vm/hwpoison.rst
index 09bd24a92784..a5c884293dac 100644
--- a/Documentation/vm/hwpoison.rst
+++ b/Documentation/vm/hwpoison.rst
@@ -13,32 +13,32 @@ kill the processes associated with it and avoid using it in the future.
 
 This patchkit implements the necessary infrastructure in the VM.
 
-To quote the overview comment:
-
- * High level machine check handler. Handles pages reported by the
- * hardware as being corrupted usually due to a 2bit ECC memory or cache
- * failure.
- *
- * This focusses on pages detected as corrupted in the background.
- * When the current CPU tries to consume corruption the currently
- * running process can just be killed directly instead. This implies
- * that if the error cannot be handled for some reason it's safe to
- * just ignore it because no corruption has been consumed yet. Instead
- * when that happens another machine check will happen.
- *
- * Handles page cache pages in various states. The tricky part
- * here is that we can access any page asynchronous to other VM
- * users, because memory failures could happen anytime and anywhere,
- * possibly violating some of their assumptions. This is why this code
- * has to be extremely careful. Generally it tries to use normal locking
- * rules, as in get the standard locks, even if that means the
- * error handling takes potentially a long time.
- *
- * Some of the operations here are somewhat inefficient and have non
- * linear algorithmic complexity, because the data structures have not
- * been optimized for this case. This is in particular the case
- * for the mapping from a vma to a process. Since this case is expected
- * to be rare we hope we can get away with this.
+To quote the overview comment::
+
+	High level machine check handler. Handles pages reported by the
+	hardware as being corrupted usually due to a 2bit ECC memory or cache
+	failure.
+
+	This focusses on pages detected as corrupted in the background.
+	When the current CPU tries to consume corruption the currently
+	running process can just be killed directly instead. This implies
+	that if the error cannot be handled for some reason it's safe to
+	just ignore it because no corruption has been consumed yet. Instead
+	when that happens another machine check will happen.
+
+	Handles page cache pages in various states. The tricky part
+	here is that we can access any page asynchronous to other VM
+	users, because memory failures could happen anytime and anywhere,
+	possibly violating some of their assumptions. This is why this code
+	has to be extremely careful. Generally it tries to use normal locking
+	rules, as in get the standard locks, even if that means the
+	error handling takes potentially a long time.
+
+	Some of the operations here are somewhat inefficient and have non
+	linear algorithmic complexity, because the data structures have not
+	been optimized for this case. This is in particular the case
+	for the mapping from a vma to a process. Since this case is expected
+	to be rare we hope we can get away with this.
 
 The code consists of a the high level handler in mm/memory-failure.c,
 a new page poison bit and various checks in the VM to handle poisoned
-- 
2.20.1

