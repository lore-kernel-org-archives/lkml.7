Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41805C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6C327DC3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XEdiNBhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfFCNe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:34:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33955 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbfFCNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:34:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DY7OZ610618
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:34:07 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DY7OZ610618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559568847;
        bh=oDp92secCUoa43S8dFljpvXFHoubG8yt7jgslaGl6aU=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=XEdiNBhvT1SCV2H3R9A0rCt/bVlU9NPF4nq1VfR+EbEaCO9B8QNIPiwlejbDiqudi
         f95YE2/qeLfo+lmYmRBqBoIjQ8Xj7t3Vlw+No6mXK1ggxgka/WnNlP4gFtMGLHuWMU
         MdaljGf7JFd6GgOJu0WHS6ZfoYMzNF4X6ae0WGybFQldVvGgoD2WjRqg+2vepziS9m
         BwGiJkl0+YLKbulhTLsOIn1C4rRHI8xGDGMQOdF+xb2PuumvpYChqRB3qnu5YqyCxx
         te3DzZzFypA7kKx7OHFz6TllAdY5o4W9v8b5KNH3/qq9r+//M9ad9/JNbiESlIqJnJ
         fTsBt4G6T9WRg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DY6xM610615;
        Mon, 3 Jun 2019 06:34:06 -0700
Date:   Mon, 3 Jun 2019 06:34:06 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-90fde663aed0a1c27e50dd1bf3f121141b2fe9f2@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        peterz@infradead.org, will.deacon@arm.com, hpa@zytor.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        herbert@gondor.apana.org.au, mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, mark.rutland@arm.com,
          peterz@infradead.org, will.deacon@arm.com,
          torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
          herbert@gondor.apana.org.au, mingo@kernel.org
In-Reply-To: <20190522132250.26499-2-mark.rutland@arm.com>
References: <20190522132250.26499-2-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, crypto/nx: Prepare for
 atomic64_read() conversion
Git-Commit-ID: 90fde663aed0a1c27e50dd1bf3f121141b2fe9f2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  90fde663aed0a1c27e50dd1bf3f121141b2fe9f2
Gitweb:     https://git.kernel.org/tip/90fde663aed0a1c27e50dd1bf3f121141b2fe9f2
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:33 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:56 +0200

locking/atomic, crypto/nx: Prepare for atomic64_read() conversion

The return type of atomic64_read() varies by architecture. It may return
long (e.g. powerpc), long long (e.g. arm), or s64 (e.g. x86_64). This is
somewhat painful, and mandates the use of explicit casts in some cases
(e.g. when printing the return value).

To ameliorate matters, subsequent patches will make the atomic64 API
consistently use s64.

As a preparatory step, this patch updates the nx-842 code to treat the
return value of atomic64_read() as s64, using explicit casts. These
casts will be removed once the s64 conversion is complete.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: aou@eecs.berkeley.edu
Cc: arnd@arndb.de
Cc: bp@alien8.de
Cc: catalin.marinas@arm.com
Cc: davem@davemloft.net
Cc: fenghua.yu@intel.com
Cc: heiko.carstens@de.ibm.com
Cc: ink@jurassic.park.msu.ru
Cc: jhogan@kernel.org
Cc: linux@armlinux.org.uk
Cc: mattst88@gmail.com
Cc: mpe@ellerman.id.au
Cc: palmer@sifive.com
Cc: paul.burton@mips.com
Cc: paulus@samba.org
Cc: ralf@linux-mips.org
Cc: rth@twiddle.net
Cc: tony.luck@intel.com
Cc: vgupta@synopsys.com
Link: https://lkml.kernel.org/r/20190522132250.26499-2-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/crypto/nx/nx-842-pseries.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index 5c4aa606208c..938332ce3b60 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -856,8 +856,8 @@ static ssize_t nx842_##_name##_show(struct device *dev,		\
 	rcu_read_lock();						\
 	local_devdata = rcu_dereference(devdata);			\
 	if (local_devdata)						\
-		p = snprintf(buf, PAGE_SIZE, "%ld\n",			\
-		       atomic64_read(&local_devdata->counters->_name));	\
+		p = snprintf(buf, PAGE_SIZE, "%lld\n",			\
+		       (s64)atomic64_read(&local_devdata->counters->_name));	\
 	rcu_read_unlock();						\
 	return p;							\
 }
@@ -909,17 +909,17 @@ static ssize_t nx842_timehist_show(struct device *dev,
 	}
 
 	for (i = 0; i < (NX842_HIST_SLOTS - 2); i++) {
-		bytes = snprintf(p, bytes_remain, "%u-%uus:\t%ld\n",
+		bytes = snprintf(p, bytes_remain, "%u-%uus:\t%lld\n",
 			       i ? (2<<(i-1)) : 0, (2<<i)-1,
-			       atomic64_read(&times[i]));
+			       (s64)atomic64_read(&times[i]));
 		bytes_remain -= bytes;
 		p += bytes;
 	}
 	/* The last bucket holds everything over
 	 * 2<<(NX842_HIST_SLOTS - 2) us */
-	bytes = snprintf(p, bytes_remain, "%uus - :\t%ld\n",
+	bytes = snprintf(p, bytes_remain, "%uus - :\t%lld\n",
 			2<<(NX842_HIST_SLOTS - 2),
-			atomic64_read(&times[(NX842_HIST_SLOTS - 1)]));
+			(s64)atomic64_read(&times[(NX842_HIST_SLOTS - 1)]));
 	p += bytes;
 
 	rcu_read_unlock();
