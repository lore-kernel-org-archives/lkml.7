Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B06C4360C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 708AC222C2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 00:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570062505;
	bh=TTWbSUu+VjBXirKgPkg65har3CKzOpn5Jt7wIGMmUOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ug6t1e7/EXQl92JrvsesK+FN9HzZYwy1AqhOgtP99zJ+/USS1fp7sNEWIEUGjhgJ/
	 GO2wH6VO5dYFH0uF9om1N+uBvBB2rbhUcm/iepXCUzRU9tzNVNRn5FOJowvILIPVne
	 hikAaE3OYjAwyFmU93PWDif0+/NJKUCzN2gKi6vM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfJCA04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 20:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729587AbfJCA0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 20:26:54 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93A40222C9;
        Thu,  3 Oct 2019 00:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570062413;
        bh=TTWbSUu+VjBXirKgPkg65har3CKzOpn5Jt7wIGMmUOE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2K69PeLZmg7NZQnDu3yE6B1WhC3tBowXctylxG3D9ZY1rVe9meXZO+3aViaiZpbA
         SI4a0qk0CAzmnyg3nTdjdsxU4fGsBAhIFel/GE24+A9w0gFykqEfaYOHbmNbXIepH6
         vbJGxKpFR0ErH6NbL3N8E3b9ck/EhB3Pw85B0nTs=
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 05/32] tools/memory-model: Make judgelitmus.sh note timeouts
Date:   Wed,  2 Oct 2019 17:26:23 -0700
Message-Id: <20191003002650.11249-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191003001039.GA8027@paulmck-ThinkPad-P72>
References: <20191003001039.GA8027@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@linux.ibm.com>

Currently, judgelitmus.sh treats timeouts (as in the "--timeout" argument)
as "!!! Verification error".  This can be misleading because it is quite
possible that running the test longer would have produced a verification.
This commit therefore changes judgelitmus.sh to check for timeouts and
to report them with "!!! Timeout".

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 tools/memory-model/scripts/judgelitmus.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/memory-model/scripts/judgelitmus.sh b/tools/memory-model/scripts/judgelitmus.sh
index 0cc6387..d3c313b 100755
--- a/tools/memory-model/scripts/judgelitmus.sh
+++ b/tools/memory-model/scripts/judgelitmus.sh
@@ -42,6 +42,14 @@ grep '^Observation' $LKMM_DESTDIR/$litmus.out
 if grep -q '^Observation' $LKMM_DESTDIR/$litmus.out
 then
 	:
+elif grep '^Command exited with non-zero status 124' $LKMM_DESTDIR/$litmus.out
+then
+	echo ' !!! Timeout' $litmus
+	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
+	then
+		echo ' !!! Timeout' >> $LKMM_DESTDIR/$litmus.out 2>&1
+	fi
+	exit 124
 else
 	echo ' !!! Verification error' $litmus
 	if ! grep -q '!!!' $LKMM_DESTDIR/$litmus.out
-- 
2.9.5

