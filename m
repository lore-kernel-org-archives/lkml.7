Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E3BC04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC5B32542C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 13:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ldQ+tNgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728585AbfFCNpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 09:45:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726780AbfFCNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 09:45:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x53DjSoC614326
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 3 Jun 2019 06:45:28 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x53DjSoC614326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559569529;
        bh=tnCa0VNVmlfW+3+oVVEvRCh2gYklefe4IzvWiy7w82I=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ldQ+tNgWM49Lkd8CRRvzxke/pJSmKJw6fr3w5/qXux2TgASUBQOLt6o1VJzyg+WrH
         7xdHWFwZukoFrpDwGULztoICZdpxvV2kOq+vjg7DpRsMslVddG2YNy8wndHCOAgLlo
         07yNzXRI1FMA4NT25vJMzPD8q7N05Ch68KLgtMZ3+3RklRj3hsiaNoOa7k4EkAPpQB
         bU3Xvh9pfCPHzyX/1cNyDQTRDqZT50pJZpzacsodDitQolQdGcgqHthxGyweaiuv1c
         53TQS4UtraZbAczEcsueT0BYPTqIRwKgAQnVnYDcJA2pjQenoIXZvVFbpdaY4qtROj
         GH9rDBZcg1TQA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x53DjRiw614323;
        Mon, 3 Jun 2019 06:45:27 -0700
Date:   Mon, 3 Jun 2019 06:45:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mark Rutland <tipbot@zytor.com>
Message-ID: <tip-2af7a0f91c3a645ec9f1cd68e41472021746db35@git.kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, herbert@gondor.apana.org.au,
        will.deacon@arm.com, peterz@infradead.org, mark.rutland@arm.com,
        hpa@zytor.com
Reply-To: mark.rutland@arm.com, hpa@zytor.com, herbert@gondor.apana.org.au,
          peterz@infradead.org, will.deacon@arm.com,
          linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
          mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <20190522132250.26499-18-mark.rutland@arm.com>
References: <20190522132250.26499-18-mark.rutland@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:locking/core] locking/atomic, crypto/nx: Remove redundant
 casts
Git-Commit-ID: 2af7a0f91c3a645ec9f1cd68e41472021746db35
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

Commit-ID:  2af7a0f91c3a645ec9f1cd68e41472021746db35
Gitweb:     https://git.kernel.org/tip/2af7a0f91c3a645ec9f1cd68e41472021746db35
Author:     Mark Rutland <mark.rutland@arm.com>
AuthorDate: Wed, 22 May 2019 14:22:49 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 3 Jun 2019 12:32:57 +0200

locking/atomic, crypto/nx: Remove redundant casts

Now that atomic64_read() returns s64 consistently, we don't need to
explicitly cast its return value. Drop the redundant casts.

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
Link: https://lkml.kernel.org/r/20190522132250.26499-18-mark.rutland@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/crypto/nx/nx-842-pseries.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index 938332ce3b60..2de5e3672e42 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -857,7 +857,7 @@ static ssize_t nx842_##_name##_show(struct device *dev,		\
 	local_devdata = rcu_dereference(devdata);			\
 	if (local_devdata)						\
 		p = snprintf(buf, PAGE_SIZE, "%lld\n",			\
-		       (s64)atomic64_read(&local_devdata->counters->_name));	\
+		       atomic64_read(&local_devdata->counters->_name));	\
 	rcu_read_unlock();						\
 	return p;							\
 }
@@ -911,7 +911,7 @@ static ssize_t nx842_timehist_show(struct device *dev,
 	for (i = 0; i < (NX842_HIST_SLOTS - 2); i++) {
 		bytes = snprintf(p, bytes_remain, "%u-%uus:\t%lld\n",
 			       i ? (2<<(i-1)) : 0, (2<<i)-1,
-			       (s64)atomic64_read(&times[i]));
+			       atomic64_read(&times[i]));
 		bytes_remain -= bytes;
 		p += bytes;
 	}
@@ -919,7 +919,7 @@ static ssize_t nx842_timehist_show(struct device *dev,
 	 * 2<<(NX842_HIST_SLOTS - 2) us */
 	bytes = snprintf(p, bytes_remain, "%uus - :\t%lld\n",
 			2<<(NX842_HIST_SLOTS - 2),
-			(s64)atomic64_read(&times[(NX842_HIST_SLOTS - 1)]));
+			atomic64_read(&times[(NX842_HIST_SLOTS - 1)]));
 	p += bytes;
 
 	rcu_read_unlock();
