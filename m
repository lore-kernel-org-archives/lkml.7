Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040F9CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0938222C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 14:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XpBlnjzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfKDO3M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 09:29:12 -0500
Received: from mail-vs1-f74.google.com ([209.85.217.74]:34949 "EHLO
        mail-vs1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728831AbfKDO3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 09:29:07 -0500
Received: by mail-vs1-f74.google.com with SMTP id w22so253858vse.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 06:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PnlUsFEddsbKHz2GK+uTFYcWeErcIfLobMYOTI3aPFU=;
        b=XpBlnjzTP/JJfoBTfESYVVCyfq0Y28LdV7cBuhtg6jKBy/OVCuDgML+AEak4DEOggE
         4FFwufuSvYhyjQrp6YEdsb+0R9547mXSl11TpqE3J5Gfy2l3SeOKD0jHn1XcAkiVjRsU
         zFnVpDB/HqpAYH+HlBDp/56aQqgVWbG1whyOoHDFClGVo0d7GgzNehqkJPuug6YEWUX4
         GESn0vSshFS4E7Pnv2PBS6OtYbR8LbeNZq2cO3cLxo5KUh9JJuHlMVjnJo2PCOa88WDn
         E2GYi5/xuLjLSp4mmnif68wguqCwwnHfg6wwkzO66h3CRHGlahAtjZeHjE89Qv4ROYOz
         wGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PnlUsFEddsbKHz2GK+uTFYcWeErcIfLobMYOTI3aPFU=;
        b=FYoksJGIoA+/IMTg00Ltxatx8DxHC4OFl0DsEzPz2uoJemeB7fbo3fETJQQgvLZxig
         RoqS3WlNVTXnvpSsnNq/Vn2w0Hvp4Uqdn/w1g4Yy//8rrxv2U/fEgJncsH9p6IaKBqnP
         6icKaAW6BVGTaqTFnf+J93HXBISmj6ylHeT8yyPgTq0T5Z4mYyC07Lx/iiYYgrs/qa+2
         Mj2HPTxI+JHtdqi+YTSzyufI/XOA4L7jKbHbknshVki3lqIM203VyK60Iqwgshq4TNyT
         2a9KfmzI3f3eY5d6KdQYTZ6McHk9Es9yqv90kd8oqnGA/jI2oOFqtwaHXfII35xKJCkX
         0MIA==
X-Gm-Message-State: APjAAAW0zMnMlFB5Tbfb5VFE+OFEqMh5Kjyp5Vc0DiHB/tP/wQZlCmPc
        9Y8+Ea064zQaq/raSVdMepeZIJMlMA==
X-Google-Smtp-Source: APXvYqyxTcSSDIIgKVC9uqJiIVViZoCP8EgkGFOXLAR6swB3rAeT15fCv8Jgf2+FjQb1O2mN+n5pn+lMvg==
X-Received: by 2002:a1f:3249:: with SMTP id y70mr4259895vky.31.1572877745747;
 Mon, 04 Nov 2019 06:29:05 -0800 (PST)
Date:   Mon,  4 Nov 2019 15:27:41 +0100
In-Reply-To: <20191104142745.14722-1-elver@google.com>
Message-Id: <20191104142745.14722-6-elver@google.com>
Mime-Version: 1.0
References: <20191104142745.14722-1-elver@google.com>
X-Mailer: git-send-email 2.24.0.rc1.363.gb1bccd3e3d-goog
Subject: [PATCH v3 5/9] seqlock, kcsan: Add annotations for KCSAN
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since seqlocks in the Linux kernel do not require the use of marked
atomic accesses in critical sections, we teach KCSAN to assume such
accesses are atomic. KCSAN currently also pretends that writes to
`sequence` are atomic, although currently plain writes are used (their
corresponding reads are READ_ONCE).

Further, to avoid false positives in the absence of clear ending of a
seqlock reader critical section (only when using the raw interface),
KCSAN assumes a fixed number of accesses after start of a seqlock
critical section are atomic.

=== Commentary on design around absence of clear begin/end markings ===
Seqlock usage via seqlock_t follows a predictable usage pattern, where
clear critical section begin/end is enforced. With subtle special cases
for readers needing to be flat atomic regions, e.g. because usage such
as in:
  - fs/namespace.c:__legitimize_mnt - unbalanced read_seqretry
  - fs/dcache.c:d_walk - unbalanced need_seqretry

But, anything directly accessing seqcount_t seems to be unpredictable.
Filtering for usage of read_seqcount_retry not following 'do { .. }
while (read_seqcount_retry(..));':

  $ git grep 'read_seqcount_retry' | grep -Ev 'while \(|seqlock.h|Doc|\* '
  => about 1/3 of the total read_seqcount_retry usage.

Just looking at fs/namei.c, we conclude that it is non-trivial to
prescribe and migrate to an interface that would force clear begin/end
seqlock markings for critical sections.

As such, we concluded that the best design currently, is to simply
ensure that KCSAN works well with the existing code.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Remove comment from raw_seqcount_barrier that should have been in next
  patch.
* Renamed kcsan_{nestable,flat}_atomic_{begin,end}
* Elaborate why clear begin/end cannot be enforced easily.
---
 include/linux/seqlock.h | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index bcf4cf26b8c8..61232bc223fd 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -37,8 +37,24 @@
 #include <linux/preempt.h>
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
+#include <linux/kcsan.h>
 #include <asm/processor.h>
 
+/*
+ * The seqlock interface does not prescribe a precise sequence of read
+ * begin/retry/end. For readers, typically there is a call to
+ * read_seqcount_begin() and read_seqcount_retry(), however, there are more
+ * esoteric cases which do not follow this pattern.
+ *
+ * As a consequence, we take the following best-effort approach for raw usage
+ * via seqcount_t under KCSAN: upon beginning a seq-reader critical section,
+ * pessimistically mark then next KCSAN_SEQLOCK_REGION_MAX memory accesses as
+ * atomics; if there is a matching read_seqcount_retry() call, no following
+ * memory operations are considered atomic. Usage of seqlocks via seqlock_t
+ * interface is not affected.
+ */
+#define KCSAN_SEQLOCK_REGION_MAX 1000
+
 /*
  * Version using sequence counter only.
  * This can be used when code has its own mutex protecting the
@@ -115,6 +131,7 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
 		cpu_relax();
 		goto repeat;
 	}
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -131,6 +148,7 @@ static inline unsigned raw_read_seqcount(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret;
 }
 
@@ -183,6 +201,7 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
 {
 	unsigned ret = READ_ONCE(s->sequence);
 	smp_rmb();
+	kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX);
 	return ret & ~1;
 }
 
@@ -202,7 +221,8 @@ static inline unsigned raw_seqcount_begin(const seqcount_t *s)
  */
 static inline int __read_seqcount_retry(const seqcount_t *s, unsigned start)
 {
-	return unlikely(s->sequence != start);
+	kcsan_atomic_next(0);
+	return unlikely(READ_ONCE(s->sequence) != start);
 }
 
 /**
@@ -225,6 +245,7 @@ static inline int read_seqcount_retry(const seqcount_t *s, unsigned start)
 
 static inline void raw_write_seqcount_begin(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 }
@@ -233,6 +254,7 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
 {
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 /**
@@ -271,9 +293,11 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  */
 static inline void raw_write_seqcount_barrier(seqcount_t *s)
 {
+	kcsan_nestable_atomic_begin();
 	s->sequence++;
 	smp_wmb();
 	s->sequence++;
+	kcsan_nestable_atomic_end();
 }
 
 static inline int raw_read_seqcount_latch(seqcount_t *s)
@@ -398,7 +422,9 @@ static inline void write_seqcount_end(seqcount_t *s)
 static inline void write_seqcount_invalidate(seqcount_t *s)
 {
 	smp_wmb();
+	kcsan_nestable_atomic_begin();
 	s->sequence+=2;
+	kcsan_nestable_atomic_end();
 }
 
 typedef struct {
@@ -430,11 +456,21 @@ typedef struct {
  */
 static inline unsigned read_seqbegin(const seqlock_t *sl)
 {
-	return read_seqcount_begin(&sl->seqcount);
+	unsigned ret = read_seqcount_begin(&sl->seqcount);
+
+	kcsan_atomic_next(0);  /* non-raw usage, assume closing read_seqretry */
+	kcsan_flat_atomic_begin();
+	return ret;
 }
 
 static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 {
+	/*
+	 * Assume not nested: read_seqretry may be called multiple times when
+	 * completing read critical section.
+	 */
+	kcsan_flat_atomic_end();
+
 	return read_seqcount_retry(&sl->seqcount, start);
 }
 
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

