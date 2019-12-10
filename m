Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC18C2D0BF
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081F824683
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576011929;
	bh=jUX+meOjtZV//GqFGyoQ+wHgjVWLBegLExrdKoy8yZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gPC+s5tsAi0VUfNGfEiVEkzHrgfvpXokDK/juJNIEZKZ6KAZgC7g1Lfqxk9YvNcon
	 D3zN8QTp4y8WkUqVnu2I8GZ01XSaQpbTPfclvrBdsNBoc3hE6Mp6GIylsHQU5qpxi0
	 sqehf74vdDJbk6zvA4ruGGm7Ltwr9bo6OlbLPrO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLJVEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:04:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:49652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727320AbfLJVEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:04:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6572424687;
        Tue, 10 Dec 2019 21:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576011873;
        bh=jUX+meOjtZV//GqFGyoQ+wHgjVWLBegLExrdKoy8yZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YOlgQkX0jEb/+d4YdQ5D9yqRZxogEWYVD+BekSfWS/3yYWKdKAW7aOz+kFfN9K6uJ
         PIyV5luRe0bYBxy334tMGPoQW6XTyDbMAJfl8a6+bC72fv16OQn8EsNpVnhuqQKUir
         oZs0ZejO8BpsCOVRc2dTbJT4rjLTMkZGb38U3au8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        kbuild test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 025/350] objtool: add kunit_try_catch_throw to the noreturn list
Date:   Tue, 10 Dec 2019 15:58:37 -0500
Message-Id: <20191210210402.8367-25-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191210210402.8367-1-sashal@kernel.org>
References: <20191210210402.8367-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brendan Higgins <brendanhiggins@google.com>

[ Upstream commit 33adf80f5b52e3f7c55ad66ffcaaff93c6888aaa ]

Fix the following warning seen on GCC 7.3:
  kunit/test-test.o: warning: objtool: kunit_test_unsuccessful_try() falls through to next function kunit_test_catch()

kunit_try_catch_throw is a function added in the following patch in this
series; it allows KUnit, a unit testing framework for the kernel, to
bail out of a broken test. As a consequence, it is a new __noreturn
function that objtool thinks is broken (as seen above). So fix this
warning by adding kunit_try_catch_throw to objtool's noreturn list.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://www.spinics.net/lists/linux-kbuild/msg21708.html
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/objtool/check.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 044c9a3cb2472..543c068096b12 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -144,6 +144,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"usercopy_abort",
 		"machine_real_restart",
 		"rewind_stack_do_exit",
+		"kunit_try_catch_throw",
 	};
 
 	if (!func)
-- 
2.20.1

