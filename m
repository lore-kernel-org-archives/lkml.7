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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042DAECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C948E21925
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 08:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WKlCHYh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbfJPIlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 04:41:23 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:44905 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391754AbfJPIlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 04:41:22 -0400
Received: by mail-wr1-f74.google.com with SMTP id n18so11368517wro.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 01:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yDFha54hv48kEXnfmjDw3jNhkPyH3I98qNMyU9YzKxs=;
        b=WKlCHYh2/KCP6oxfJeI7pN2aRjDhk/aZL2Kh+OHu8RjMDz5oofdRa1ovtsNeuIcJ1A
         OJyOKoHGK0lGKl0ZSuYrstwQ7yJwrEKE2bBaeq7zuTCQSD5ERzUuW7i9Uu7Eu317e6sY
         ZfreMP9oBmPbmfrsG7riIXbL/Dz245BjblD2T/QzOu2yp6s3SRXlPP/f42tIOiLXNym4
         9B06plwFtBoIf5gyi99EmyMwdQgTP1f8I+WYLl30cXsjuFYcO2peywzDu4bN920T/4hG
         EtNJevcAFO0Tya/jcC6adNraMgojVBHN6cjbEln5v5CtOfL8p125eIgxK72XosA24BBQ
         hGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yDFha54hv48kEXnfmjDw3jNhkPyH3I98qNMyU9YzKxs=;
        b=nYKRo9V60IB06z0hwD65iTJQ8Q1mrmCymEb95iwPwwk6x9qvVh+XI/V+h9Fti9IasB
         kmCpE7deWeiRkUH9ezeY868M3Ll7AyBVZ+7u3HKDTIR0JxVczaH8Yb0Aekc3QbW0yF+f
         ofcD7cHdjeRUFcJXSHDqVbtbwytGMAPThl35a/gcsXK/VOm+HjY51oXZh3wXdxC8UX84
         0m6e7sceM+/TyD1mMsFpWDK7GrKCbZTjXYbWN3xXqLyXz7MtzhTHncaqg4MPkRC7xUsb
         BdgEY71MdOpPzFtGE6buyxlyoVJtS8IQOsnLKECB6nCX67Fh85q4JnuM8DqwKQukWd6Y
         NEHA==
X-Gm-Message-State: APjAAAXfqHqvJudj3GjSg3HoavyE4z0brXpRzH2GQjYJ2S7LnU7SGhDY
        EXnc2LwXijT27DH+8y5r7WJ5bSaDNw==
X-Google-Smtp-Source: APXvYqzdOQF6tPWDtDYGYyxoxWJlQPExqvV+Kb3qpGIfQVYmIvwOLf4GM2Yg4APXhJ/KjtagamObSVVqQA==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr1713158wrr.304.1571215277931;
 Wed, 16 Oct 2019 01:41:17 -0700 (PDT)
Date:   Wed, 16 Oct 2019 10:39:54 +0200
In-Reply-To: <20191016083959.186860-1-elver@google.com>
Message-Id: <20191016083959.186860-4-elver@google.com>
Mime-Version: 1.0
References: <20191016083959.186860-1-elver@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: [PATCH 3/8] build, kcsan: Add KCSAN build exceptions
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

This blacklists several compilation units from KCSAN. See the respective
inline comments for the reasoning.

Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/Makefile       | 5 +++++
 kernel/sched/Makefile | 6 ++++++
 mm/Makefile           | 8 ++++++++
 3 files changed, 19 insertions(+)

diff --git a/kernel/Makefile b/kernel/Makefile
index 74ab46e2ebd1..4a597a68b8bc 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -23,6 +23,9 @@ endif
 # Prevents flicker of uninteresting __do_softirq()/__local_bh_disable_ip()
 # in coverage traces.
 KCOV_INSTRUMENT_softirq.o := n
+# Avoid KCSAN instrumentation in softirq ("No shared variables, all the data
+# are CPU local" => assume no data-races), to reduce overhead in interrupts.
+KCSAN_SANITIZE_softirq.o = n
 # These are called from save_stack_trace() on slub debug path,
 # and produce insane amounts of uninteresting coverage.
 KCOV_INSTRUMENT_module.o := n
@@ -30,6 +33,7 @@ KCOV_INSTRUMENT_extable.o := n
 # Don't self-instrument.
 KCOV_INSTRUMENT_kcov.o := n
 KASAN_SANITIZE_kcov.o := n
+KCSAN_SANITIZE_kcov.o := n
 CFLAGS_kcov.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 # cond_syscall is currently not LTO compatible
@@ -118,6 +122,7 @@ obj-$(CONFIG_RSEQ) += rseq.o
 
 obj-$(CONFIG_GCC_PLUGIN_STACKLEAK) += stackleak.o
 KASAN_SANITIZE_stackleak.o := n
+KCSAN_SANITIZE_stackleak.o := n
 KCOV_INSTRUMENT_stackleak.o := n
 
 $(obj)/configs.o: $(obj)/config_data.gz
diff --git a/kernel/sched/Makefile b/kernel/sched/Makefile
index 21fb5a5662b5..e9307a9c54e7 100644
--- a/kernel/sched/Makefile
+++ b/kernel/sched/Makefile
@@ -7,6 +7,12 @@ endif
 # that is not a function of syscall inputs. E.g. involuntary context switches.
 KCOV_INSTRUMENT := n
 
+# There are numerous races here, however, most of them due to plain accesses.
+# This would make it even harder for syzbot to find reproducers, because these
+# bugs trigger without specific input. Disable by default, but should re-enable
+# eventually.
+KCSAN_SANITIZE := n
+
 ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
 # needed for x86 only.  Why this used to be enabled for all architectures is beyond
diff --git a/mm/Makefile b/mm/Makefile
index d996846697ef..33ea0154dd2d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -7,6 +7,14 @@ KASAN_SANITIZE_slab_common.o := n
 KASAN_SANITIZE_slab.o := n
 KASAN_SANITIZE_slub.o := n
 
+# These produce frequent data-race reports: most of them are due to races on
+# the same word but accesses to different bits of that word. Re-enable KCSAN
+# for these when we have more consensus on what to do about them.
+KCSAN_SANITIZE_slab_common.o := n
+KCSAN_SANITIZE_slab.o := n
+KCSAN_SANITIZE_slub.o := n
+KCSAN_SANITIZE_page_alloc.o := n
+
 # These files are disabled because they produce non-interesting and/or
 # flaky coverage that is not a function of syscall inputs. E.g. slab is out of
 # free pages, or a task is migrated between nodes.
-- 
2.23.0.700.g56cf767bdb-goog

