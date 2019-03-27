Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50007C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2007C2063F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553709844;
	bh=sLMwQcevGfBq0KbV71LfP6MGB2pFjKAuD5ONjyeeVtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ss9lGqWHjoSJeLHNfF4i9njGComFzzf8mZ2mc3ei/s0wryB2P4V3I+MbS5bmcI+gg
	 WiEovMAXiH3B1BnecGxbIiDWxNdikDJAUm0NjmRfhQpkqH7gGugwwQZQn4BIAPD25n
	 arHANMys3dTZb8hXhpIcndLGi5g1f5YcBwWPiKYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733124AbfC0SEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:04:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733019AbfC0SD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:03:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 320D121734;
        Wed, 27 Mar 2019 18:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709835;
        bh=sLMwQcevGfBq0KbV71LfP6MGB2pFjKAuD5ONjyeeVtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vjkGyqRlwrAKGlrR+OrGmdQY9O5VpL4hli+mm+Ik3+7sE+GAnpeJnYSdVobjjWN9q
         899viOS7Yl4tTC61DO5abFHkt+MvpUahgB6mMNJVmfuT1QK0xoVuP/eZGAaASHAsPM
         0cUYN3D3kvs6Gu0s2TT+CCkqJWZPJ1X8d3XJpOvM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will.deacon@arm.com>, johannes.berg@intel.com,
        tj@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 066/262] lockdep/lib/tests: Fix run_tests.sh
Date:   Wed, 27 Mar 2019 13:58:41 -0400
Message-Id: <20190327180158.10245-66-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bart Van Assche <bvanassche@acm.org>

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

