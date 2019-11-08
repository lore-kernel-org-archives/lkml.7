Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94553C5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6816D20869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 17:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573232537;
	bh=TBvj3ZAD/90gzZRZ4Bq7ZuAaAzf+ONWHDHtJ37qd9aY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zfHCQZLxU9Muswpy4YQ7cPePG7zJTxPFT/TY0wZH0VsVSADHObM2UGUHoZQgY1SFi
	 jMWcvUIYdqNGPnZNPz0f+yBPT7WaV7aNaw7KR2RHROXvHvCrqD21BStM1haQ19wjrO
	 2W41/IhZRlf7dpzX0ZDIh6bREQo9TY8g52lml1b8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfKHRCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 12:02:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:46482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731291AbfKHRCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 12:02:15 -0500
Received: from localhost.localdomain (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3D1621D7B;
        Fri,  8 Nov 2019 17:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573232534;
        bh=TBvj3ZAD/90gzZRZ4Bq7ZuAaAzf+ONWHDHtJ37qd9aY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6OOuDwHn0375jbO8T0CHJu4VFrTm+4reQ6H9i4/OduaNg9PuHeaqLsD9Cc7aN5uc
         BZh2RnBJUvSgPh4Zi3uk5VYzcI4RwV3uF6RCRrB2M5XT3/ex1h/cNKgFmotwZkGJ0N
         AnsKDTQSfZIEcITFJukKF69zGgyZsEHi2e45V5qc=
From:   Will Deacon <will@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Yunjae Lee <lyj7694@gmail.com>,
        SeongJae Park <sj38.park@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Boqun Feng <boqun.feng@gmail.com>, linux-alpha@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 13/13] checkpatch: Remove checks relating to [smp_]read_barrier_depends()
Date:   Fri,  8 Nov 2019 17:01:20 +0000
Message-Id: <20191108170120.22331-14-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108170120.22331-1-will@kernel.org>
References: <20191108170120.22331-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '[smp_]read_barrier_depends()' macros no longer exist, so we don't
need to deal with them in the checkpatch script.

Signed-off-by: Will Deacon <will@kernel.org>
---
 scripts/checkpatch.pl | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 6fcc66afb088..7f5a368206bf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5787,8 +5787,7 @@ sub process {
 		my $barriers = qr{
 			mb|
 			rmb|
-			wmb|
-			read_barrier_depends
+			wmb
 		}x;
 		my $barrier_stems = qr{
 			mb__before_atomic|
@@ -5829,12 +5828,6 @@ sub process {
 			}
 		}
 
-# check for smp_read_barrier_depends and read_barrier_depends
-		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
-			WARN("READ_BARRIER_DEPENDS",
-			     "$1read_barrier_depends should only be used in READ_ONCE or DEC Alpha code\n" . $herecurr);
-		}
-
 # check of hardware specific defines
 		if ($line =~ m@^.\s*\#\s*if.*\b(__i386__|__powerpc64__|__sun__|__s390x__)\b@ && $realfile !~ m@include/asm-@) {
 			CHK("ARCH_DEFINES",
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

