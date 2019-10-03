Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E043C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081A3222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062471;
	bh=nsciKRDOc+pypUGnfFIzRu+a/zz4G70PGaJlIJxvmiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dDoJmX9NE7dZ/c/pZrk0KuwpP5eQG4T/GZ5Ixgelq5TjuovaP1vNh1Lv1uJ+W5qwA
	 JeRdYBg3j0IamqDy2k84rbb2AwQPhaeiDrogm54uR+QEZLb8oLbDR7kdmvEymAdIE9
	 4gWHC+m5QV/mI34O08h4F4INHdn6EI4xYKztQ4Og=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfJCA1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729688AbfJCA1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:27:00 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 694832246B;
        Thu,  3 Oct 2019 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062419;
        bh=nsciKRDOc+pypUGnfFIzRu+a/zz4G70PGaJlIJxvmiA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olBcY0dMsL8YYtCgs3BM4OpaL5lWsbTCZyDrnZ71A6s7yJT2huM+ds/Yl/+kkx+hx
         8zYLqbM1aIC2Qe12gArKPGZinXopRCm3DrNLgVaPW6PYfkVJjCOP/c7HcxPe23VhVS
         PYt5qewLXuQmDBqF3I6m9ozuWQYYOKmMNg4o1Pxc=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 25/32] tools/memory-model: Make checkghlitmus.sh use mselect7
Date:   Wed,  2 Oct 2019 17:26:43 -0700
Message-Id: <20191003002650.11249-25-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

The checkghlitmus.sh script currently uses grep to ignore non-C-language
litmus tests, which is a bit fragile.  This commit therefore enlists the
aid of "mselect7 -arch C", given Luc Maraget's recent modifications that
allow mselect7 to operate in filter mode.

This change requires herdtools 7.52-32-g1da3e0e50977 or later.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/checkghlitmus.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/memory-model/scripts/checkghlitmus.sh b/tools/memory-model/scripts/checkghlitmus.sh
index 2ea220d..cedd029 100755
--- a/tools/memory-model/scripts/checkghlitmus.sh
+++ b/tools/memory-model/scripts/checkghlitmus.sh
@@ -41,7 +41,7 @@ fi
 
 # Create a list of C-language litmus tests with "Result:" commands and
 # no more than the specified number of processes.
-find litmus -name '*.litmus' -exec grep -l -m 1 "^C " {} \; > $T/list-C
+find litmus -name '*.litmus' -print | mselect7 -arch C > $T/list-C
 xargs < $T/list-C -r egrep -l '^ \* Result: (Never|Sometimes|Always|DEADLOCK)' > $T/list-C-result
 xargs < $T/list-C-result -r grep -L "^P${LKMM_PROCS}" > $T/list-C-result-short
 
-- 
2.9.5

