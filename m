Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966FC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2EE2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="TTWOo7Nd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfD2Stb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:49:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35535 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Stb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:49:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TImR0b1031691
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:48:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TImR0b1031691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563709;
        bh=ZKRF1EjoYZGHvHIN6RCYaGyX9fxZocG6UYT6n2QfFh4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=TTWOo7NdKOVb9EtJ0Vvu3rPa5YJ4XtvDKm6gWFlSBQY5BXbqIFkNWHjfGB9c3UJyF
         701BDkH/j3FatuK7OzPzoS96nwDOHUzCBdDpPK8K++0Y5JTgBXLCOz3b01GBaXHjid
         01jt1EI/KstvlDkUuvi5NUi8qup+H/TOFNiK6L5VFyDp1raL6zhOb1U2Vk+fSw/wOB
         zxiZkO20HLkUOlkoSA7NeXPz48mDYmDVsudB1uhFmE4bIlL7gcfMrOaRoBc5SKq2pl
         nhaJcOxGOMSW9JPQjw+IEcXihWr4mWkJkm4Vj8yZNqT6deAP0/9o27JQ9vKlut7KPV
         0xr1qVoPGULkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TImRVw1031685;
        Mon, 29 Apr 2019 11:48:27 -0700
Date:   Mon, 29 Apr 2019 11:48:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-988ec8841ca1e22b2978fce0134d8267e838770e@git.kernel.org>
Cc:     airlied@linux.ie, tom.zanussi@linux.intel.com, agk@redhat.com,
        snitzer@redhat.com, cl@linux.com, hpa@zytor.com,
        jpoimboe@redhat.com, mingo@kernel.org, akinobu.mita@gmail.com,
        rostedt@goodmis.org, luto@kernel.org,
        joonas.lahtinen@linux.intel.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dsterba@suse.com, glider@google.com,
        tglx@linutronix.de, rppt@linux.vnet.ibm.com,
        rodrigo.vivi@intel.com, dvyukov@google.com, penberg@kernel.org,
        maarten.lankhorst@linux.intel.com, clm@fb.com, jthumshirn@suse.de,
        rientjes@google.com, m.szyprowski@samsung.com, hch@lst.de,
        jani.nikula@linux.intel.com, aryabinin@virtuozzo.com,
        mbenes@suse.cz, adobriyan@gmail.com, catalin.marinas@arm.com,
        josef@toxicpanda.com, robin.murphy@arm.com,
        akpm@linux-foundation.org
Reply-To: cl@linux.com, hpa@zytor.com, airlied@linux.ie, agk@redhat.com,
          snitzer@redhat.com, tom.zanussi@linux.intel.com,
          rostedt@goodmis.org, akinobu.mita@gmail.com, jpoimboe@redhat.com,
          mingo@kernel.org, joonas.lahtinen@linux.intel.com,
          luto@kernel.org, dsterba@suse.com, glider@google.com,
          linux-kernel@vger.kernel.org, daniel@ffwll.ch,
          rodrigo.vivi@intel.com, dvyukov@google.com, tglx@linutronix.de,
          rppt@linux.vnet.ibm.com, m.szyprowski@samsung.com,
          rientjes@google.com, penberg@kernel.org, clm@fb.com,
          maarten.lankhorst@linux.intel.com, jthumshirn@suse.de,
          jani.nikula@linux.intel.com, aryabinin@virtuozzo.com, hch@lst.de,
          adobriyan@gmail.com, catalin.marinas@arm.com,
          akpm@linux-foundation.org, josef@toxicpanda.com,
          robin.murphy@arm.com, mbenes@suse.cz
In-Reply-To: <20190425094803.524796783@linutronix.de>
References: <20190425094803.524796783@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] stacktrace: Remove obsolete functions
Git-Commit-ID: 988ec8841ca1e22b2978fce0134d8267e838770e
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

Commit-ID:  988ec8841ca1e22b2978fce0134d8267e838770e
Gitweb:     https://git.kernel.org/tip/988ec8841ca1e22b2978fce0134d8267e838770e
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:19 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:57 +0200

stacktrace: Remove obsolete functions

No more users of the struct stack_trace based interfaces. Remove them.

Remove the macro stubs for !CONFIG_STACKTRACE as well as they are pointless
because the storage on the call sites is conditional on CONFIG_STACKTRACE
already. No point to be 'smart'.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: kasan-dev@googlegroups.com
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: David Sterba <dsterba@suse.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094803.524796783@linutronix.de

---
 include/linux/stacktrace.h | 17 -----------------
 kernel/stacktrace.c        | 14 --------------
 2 files changed, 31 deletions(-)

diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index a24340b3e9e1..40decfbb9a24 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -36,24 +36,7 @@ extern void save_stack_trace_tsk(struct task_struct *tsk,
 				struct stack_trace *trace);
 extern int save_stack_trace_tsk_reliable(struct task_struct *tsk,
 					 struct stack_trace *trace);
-
-extern void print_stack_trace(struct stack_trace *trace, int spaces);
-extern int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces);
-
-#ifdef CONFIG_USER_STACKTRACE_SUPPORT
 extern void save_stack_trace_user(struct stack_trace *trace);
-#else
-# define save_stack_trace_user(trace)              do { } while (0)
-#endif
-
-#else /* !CONFIG_STACKTRACE */
-# define save_stack_trace(trace)			do { } while (0)
-# define save_stack_trace_tsk(tsk, trace)		do { } while (0)
-# define save_stack_trace_user(trace)			do { } while (0)
-# define print_stack_trace(trace, spaces)		do { } while (0)
-# define snprint_stack_trace(buf, size, trace, spaces)	do { } while (0)
-# define save_stack_trace_tsk_reliable(tsk, trace)	({ -ENOSYS; })
 #endif /* CONFIG_STACKTRACE */
 
 #if defined(CONFIG_STACKTRACE) && defined(CONFIG_HAVE_RELIABLE_STACKTRACE)
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index b38333b3bc18..dd55312f3fe9 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -30,12 +30,6 @@ void stack_trace_print(unsigned long *entries, unsigned int nr_entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_print);
 
-void print_stack_trace(struct stack_trace *trace, int spaces)
-{
-	stack_trace_print(trace->entries, trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(print_stack_trace);
-
 /**
  * stack_trace_snprint - Print the entries in the stack trace into a buffer
  * @buf:	Pointer to the print buffer
@@ -72,14 +66,6 @@ int stack_trace_snprint(char *buf, size_t size, unsigned long *entries,
 }
 EXPORT_SYMBOL_GPL(stack_trace_snprint);
 
-int snprint_stack_trace(char *buf, size_t size,
-			struct stack_trace *trace, int spaces)
-{
-	return stack_trace_snprint(buf, size, trace->entries,
-				   trace->nr_entries, spaces);
-}
-EXPORT_SYMBOL_GPL(snprint_stack_trace);
-
 /*
  * Architectures that do not implement save_stack_trace_*()
  * get these weak aliases and once-per-bootup warnings
