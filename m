Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66349C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0FB2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Dc5AksKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfD2SvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:51:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34849 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbfD2SvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:51:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIn8Ho1031761
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:49:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIn8Ho1031761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563749;
        bh=b0mGlHKK8bXT+vdqHxDQu3VUmBgRBo+6ZbPq54yg+S4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Dc5AksKqSnuGOShoiUBqXVD2yW+nYTeqXmPDUEmyFRNnOU0NNIT3Q6K8q1CtVWpSc
         zq8Jii58qjXc0/mG8PAHURVV2AKSJT5ANvB+xD4bpcwnaTOzijRfr+t0xMLGYP7/lE
         pE0Ep9afUXhWQ2VXh1zVfIqmHBQkTg2/kRwMrOS2CyoFCiwzP/F1d1PMa+eCObrSIB
         uR8+gi+6NTHz3xvTb4PPsCKOqTTnwEKUehhOsgpOe+V2cSD+2hQzDDieUyY2OExMtd
         sFQOPROQdsm5vlCTpSsZxKdb/GQI+JdI38TjBjHT2iNvMN6Oro0aGhDUWOEfTrMx4Y
         lBkyl68dD2uHg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIn7UR1031757;
        Mon, 29 Apr 2019 11:49:07 -0700
Date:   Mon, 29 Apr 2019 11:49:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-56d8f079c51afc8b564b9fb0252d48e7b437c1e5@git.kernel.org>
Cc:     mingo@kernel.org, snitzer@redhat.com, jthumshirn@suse.de,
        aryabinin@virtuozzo.com, joonas.lahtinen@linux.intel.com,
        jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
        jpoimboe@redhat.com, airlied@linux.ie, catalin.marinas@arm.com,
        rientjes@google.com, agk@redhat.com, cl@linux.com,
        glider@google.com, daniel@ffwll.ch, dsterba@suse.com,
        robin.murphy@arm.com, mbenes@suse.cz, josef@toxicpanda.com,
        hch@lst.de, penberg@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, tom.zanussi@linux.intel.com,
        akinobu.mita@gmail.com, hpa@zytor.com, dvyukov@google.com,
        adobriyan@gmail.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        akpm@linux-foundation.org, luto@kernel.org,
        maarten.lankhorst@linux.intel.com, rppt@linux.vnet.ibm.com,
        clm@fb.com
Reply-To: hch@lst.de, josef@toxicpanda.com, mbenes@suse.cz,
          robin.murphy@arm.com, linux-kernel@vger.kernel.org,
          tom.zanussi@linux.intel.com, rostedt@goodmis.org,
          penberg@kernel.org, dvyukov@google.com, adobriyan@gmail.com,
          akinobu.mita@gmail.com, hpa@zytor.com, akpm@linux-foundation.org,
          clm@fb.com, maarten.lankhorst@linux.intel.com,
          rppt@linux.vnet.ibm.com, luto@kernel.org, tglx@linutronix.de,
          m.szyprowski@samsung.com, mingo@kernel.org, snitzer@redhat.com,
          joonas.lahtinen@linux.intel.com, jthumshirn@suse.de,
          aryabinin@virtuozzo.com, rodrigo.vivi@intel.com,
          jani.nikula@linux.intel.com, airlied@linux.ie,
          jpoimboe@redhat.com, cl@linux.com, glider@google.com,
          dsterba@suse.com, daniel@ffwll.ch, rientjes@google.com,
          catalin.marinas@arm.com, agk@redhat.com
In-Reply-To: <20190425094803.617937448@linutronix.de>
References: <20190425094803.617937448@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lib/stackdepot: Remove obsolete functions
Git-Commit-ID: 56d8f079c51afc8b564b9fb0252d48e7b437c1e5
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

Commit-ID:  56d8f079c51afc8b564b9fb0252d48e7b437c1e5
Gitweb:     https://git.kernel.org/tip/56d8f079c51afc8b564b9fb0252d48e7b437c1e5
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:20 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:57 +0200

lib/stackdepot: Remove obsolete functions

No more users of the struct stack_trace based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Alexander Potapenko <glider@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
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
Link: https://lkml.kernel.org/r/20190425094803.617937448@linutronix.de

---
 include/linux/stackdepot.h |  4 ----
 lib/stackdepot.c           | 20 --------------------
 2 files changed, 24 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 4297c6d2991d..0805dee1b6b8 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -23,13 +23,9 @@
 
 typedef u32 depot_stack_handle_t;
 
-struct stack_trace;
-
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace, gfp_t flags);
 depot_stack_handle_t stack_depot_save(unsigned long *entries,
 				      unsigned int nr_entries, gfp_t gfp_flags);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace);
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries);
 
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index e84f8e58495c..605c61f65d94 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -216,14 +216,6 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 }
 EXPORT_SYMBOL_GPL(stack_depot_fetch);
 
-void depot_fetch_stack(depot_stack_handle_t handle, struct stack_trace *trace)
-{
-	unsigned int nent = stack_depot_fetch(handle, &trace->entries);
-
-	trace->max_entries = trace->nr_entries = nent;
-}
-EXPORT_SYMBOL_GPL(depot_fetch_stack);
-
 /**
  * stack_depot_save - Save a stack trace from an array
  *
@@ -318,15 +310,3 @@ fast_exit:
 	return retval;
 }
 EXPORT_SYMBOL_GPL(stack_depot_save);
-
-/**
- * depot_save_stack - save stack in a stack depot.
- * @trace - the stacktrace to save.
- * @alloc_flags - flags for allocating additional memory if required.
- */
-depot_stack_handle_t depot_save_stack(struct stack_trace *trace,
-				      gfp_t alloc_flags)
-{
-	return stack_depot_save(trace->entries, trace->nr_entries, alloc_flags);
-}
-EXPORT_SYMBOL_GPL(depot_save_stack);
