Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FDEECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FC721D7D
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pmKyjAi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404067AbfJPIlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:41:32 -0400
Received: from mail-qt1-f201.google.com ([209.85.160.201]:56014 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391759AbfJPIl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:27 -0400
Received: by mail-qt1-f201.google.com with SMTP id o34so24138609qtf.22
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6B6hVR43CAiybn1r8unXu0YGQ/l4GfBcUZa3qNay/Lg=;
        b=pmKyjAi9Xr5PlfEX3WN4RXfR5rOUMeCVeHFLxeZBnJX60pdmUJcgmq7H9/mtFPlJFa
         moYsn1hDbJspCdD6Vib5sxCF1XQS2zorrJaslTcgAECl0Igp90eao9ExRzxoghK0ZyKa
         /YWUX8wsqgNhUXxIKWeHu6EHevPZBqeqVPpwiuyJgZFcEq2EuNxKt0GInMFNLlo6Yxif
         PrXK74Aw6W9IKNzvlptjE5I+HNUQvjt7bLAKckauSr7e8Ox9+LMH1ifl8ytlPVg92RDl
         Uels+l0S9OCX6mNGK/TPsotu300tngqOS6U+WCI50TixqqRrW/HI3/xID0mukxXkp8m4
         mUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6B6hVR43CAiybn1r8unXu0YGQ/l4GfBcUZa3qNay/Lg=;
        b=Ll3kXs5m/6epel2SdLworOLgfwVx1vByJrHGjUsAHC2lAv7Q9KQ0T427SJ+qoC+gZr
         +UbvBHwOQeXzv2lGs5kzUPF9IX07vrHWxwZyAPlsHcA4t8zX1RzfPidEP9HasoR0jUDD
         oe/MpaqCcuj3H0+yECFouw7Ts890s4s+sMHo07qdI3SYX3ZLpsgo8qpnb9LZrVTb64Ca
         /ZSUN49upJ7FvqQ8W6dKs7yZNRqSTdRi2Gwi/LfWBstIi9Xtg5gf2PwFd/3VbhrejrlY
         Qr9xzh2Rg4q8NxqInvMcoyE3Q6ZNbZF9AU2Zn3aslvzICQAfJutSSvZETESPE2iRF3vd
         4xlA==
X-Gm-Message-State: APjAAAVlyRLUbGXdD9ji/R3RUoc7AsI+eZM4kBLfxHbxWBpHleiuZVWb
        k/8Y8kvrKymFiQkDo4YDagt08W/Rdw==
X-Google-Smtp-Source: APXvYqyKyeT2RR7s/B/qIqHhRbJpXB+EYhRbk3Rsw+lqlmOIIkoJ+/xVG889AVzjkW0GfsDaRf2mA9694w==
X-Received: by 2002:ac8:3724:: with SMTP id o33mr42240619qtb.87.1571215284755;
 Wed, 16 Oct 2019 01:41:24 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:56 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-6-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 5/8] seqlock: Require WRITE_ONCE surrounding raw_seqcount_barrier
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
        npiggin@gmail.com, paulmck@linux.ibm.com, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch proposes to require marked atomic accesses surrounding
raw_write_seqcount_barrier. We reason that otherwise there is no way to
guarantee propagation nor atomicity of writes before/after the barrier
[1]. For example, consider the compiler tears stores either before or
after the barrier; in this case, readers may observe a partial value,
and because readers are unaware that writes are going on (writes are not
in a seq-writer critical section), will complete the seq-reader critical
section while having observed some partial state.
[1] https://lwn.net/Articles/793253/

This came up when designing and implementing KCSAN, because KCSAN would
flag these accesses as data-races. After careful analysis, our reasoning
as above led us to conclude that the best thing to do is to propose an
amendment to the raw_seqcount_barrier usage.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/seqlock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 1e425831a7ed..5d50aad53b47 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -265,6 +265,13 @@ static inline void raw_write_seqcount_end(seqcount_t *s)
  * usual consistency guarantee. It is one wmb cheaper, because we can
  * collapse the two back-to-back wmb()s.
  *
+ * Note that, writes surrounding the barrier should be declared atomic (e.g.
+ * via WRITE_ONCE): a) to ensure the writes become visible to other threads
+ * atomically, avoiding compiler optimizations; b) to document which writes are
+ * meant to propagate to the reader critical section. This is necessary because
+ * neither writes before and after the barrier are enclosed in a seq-writer
+ * critical section that would ensure readers are aware of ongoing writes.
+ *
  *      seqcount_t seq;
  *      bool X = true, Y = false;
  *
-- 
2.23.0.700.g56cf767bdb-goog

