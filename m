Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D04C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C3720693
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554369008;
	bh=7HhHeJ0/gGt+iD5i54Rqd8/+NPOjcJWaq2fpC9oCORE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S7TUolHOuzCPodxLVWqzIO1rqJ8rLjiTZQvvFJ7wOsxsB5GfjaAfWUnE2907wZ+uo
	 CepXSOOuhc/Ju5tqW2KIDGHELeCLznbvG9U2scRhTgXBzPf/zLSLhAyTXb1BmIJztl
	 3qZi7BH3mNzQxAqgBFkNK8cpYd5Ka6ZW7iPkU2B0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732952AbfDDJKH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:10:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbfDDJKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:10:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 064992054F;
        Thu,  4 Apr 2019 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554369004;
        bh=7HhHeJ0/gGt+iD5i54Rqd8/+NPOjcJWaq2fpC9oCORE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z65CypQGvXuCMqwSvDSwIkynLGe66EPA/meJY5PJRiycAiz5HeiAaz2pdbo9jqVQv
         DLMIarDMn9EVvFByFBHAqho/R6c8g7mUDloiUtJtvzczIAvgKlSLu4sYpWndyHAjys
         CnFkNWu+X4OBQOMgfqM+swSpuCAd3mXKg46c6TOQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>, johannes.berg@intel.com,
        tj@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 062/246] lockdep/lib/tests: Fix run_tests.sh
Date:   Thu,  4 Apr 2019 10:46:02 +0200
Message-Id: <20190404084621.336239355@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190404084619.236418459@linuxfoundation.org>
References: <20190404084619.236418459@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit d93ac78bf7b37db36fa00225f8e9a14c7ed1b2ba ]

Apparently the execute bits were set for the tests/*.sh scripts on my
test setup but these are not set in the kernel tree. Fix this by adding
the interpreter path in front of the script paths.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Waiman Long <longman@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: johannes.berg@intel.com
Cc: tj@kernel.org
Fixes: 5ecb8e94b494 ("tools/lib/lockdep/tests: Improve testing accuracy") # v5.0-rc1
Link: https://lkml.kernel.org/r/20190214230058.196511-23-bvanassche@acm.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/lockdep/run_tests.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/run_tests.sh b/tools/lib/lockdep/run_tests.sh
index c8fbd0306960..11f425662b43 100755
--- a/tools/lib/lockdep/run_tests.sh
+++ b/tools/lib/lockdep/run_tests.sh
@@ -11,7 +11,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	testname=$(basename "$i" .c)
 	echo -ne "$testname... "
 	if gcc -o "tests/$testname" -pthread "$i" liblockdep.a -Iinclude -D__USE_LIBLOCKDEP &&
-		timeout 1 "tests/$testname" 2>&1 | "tests/${testname}.sh"; then
+		timeout 1 "tests/$testname" 2>&1 | /bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -24,7 +24,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		timeout 1 ./lockdep "tests/$testname" 2>&1 |
-		"tests/${testname}.sh"; then
+		/bin/bash "tests/${testname}.sh"; then
 		echo "PASSED!"
 	else
 		echo "FAILED!"
@@ -37,7 +37,7 @@ find tests -name '*.c' | sort | while read -r i; do
 	echo -ne "(PRELOAD + Valgrind) $testname... "
 	if gcc -o "tests/$testname" -pthread -Iinclude "$i" &&
 		{ timeout 10 valgrind --read-var-info=yes ./lockdep "./tests/$testname" >& "tests/${testname}.vg.out"; true; } &&
-		"tests/${testname}.sh" < "tests/${testname}.vg.out" &&
+		/bin/bash "tests/${testname}.sh" < "tests/${testname}.vg.out" &&
 		! grep -Eq '(^==[0-9]*== (Invalid |Uninitialised ))|Mismatched free|Source and destination overlap| UME ' "tests/${testname}.vg.out"; then
 		echo "PASSED!"
 	else
-- 
2.19.1



