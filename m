Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC7C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD1D2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xq6hHIMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfD2SiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:38:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59207 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfD2SiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:38:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIaCfs1027895
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:36:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIaCfs1027895
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562974;
        bh=59F3kitz3/YkyPLOAWsCOB14DTB8MKH0uw2EIevHsKs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xq6hHIMsHiOf8Id4JKeLWPdOzDIO5gPGgXKaQ+DiTqqIXv4vjBLcDxGl2VHXhp2WY
         oXMJw5o8rde4u32jHoUIWghRuYisQqt7C7vEsZuUEk67xLQKMPxyZZxjg8FTDj+FK9
         aVVtTTRyoB+2yDCnjj4kDJECJoK6RVFG1UKV3RAUBS9H3UblICW9GNoAlqRwDTXw2/
         ChGTCeYSBWuJ8pOl5RHIjQ8fIs1U3PggiApRtD8vJyR0thvjpzi0RL/98Vq0c6lhhW
         ZAWmOli9ajn8c/zSsTjwpnGROrrp/b0Frn4JGnzkz41DFhzHzUwv8Mpse7poMx7lf3
         C2SpLN6JVKi8w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIaBR91027888;
        Mon, 29 Apr 2019 11:36:11 -0700
Date:   Mon, 29 Apr 2019 11:36:11 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-07984aad1c7ed679596f849c0e7d5e029f76e0eb@git.kernel.org>
Cc:     dsterba@suse.com, jpoimboe@redhat.com, mingo@kernel.org,
        penberg@kernel.org, jthumshirn@suse.de, rientjes@google.com,
        adobriyan@gmail.com, catalin.marinas@arm.com, agk@redhat.com,
        mbenes@suse.cz, clm@fb.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        cl@linux.com, joonas.lahtinen@linux.intel.com, hch@lst.de,
        rostedt@goodmis.org, akinobu.mita@gmail.com,
        rppt@linux.vnet.ibm.com, robin.murphy@arm.com, glider@google.com,
        m.szyprowski@samsung.com, hpa@zytor.com,
        jani.nikula@linux.intel.com, tom.zanussi@linux.intel.com,
        luto@kernel.org, daniel@ffwll.ch, josef@toxicpanda.com,
        snitzer@redhat.com, tglx@linutronix.de, dvyukov@google.com,
        akpm@linux-foundation.org, maarten.lankhorst@linux.intel.com,
        rodrigo.vivi@intel.com
Reply-To: linux-kernel@vger.kernel.org, airlied@linux.ie, clm@fb.com,
          cl@linux.com, aryabinin@virtuozzo.com, rientjes@google.com,
          adobriyan@gmail.com, jthumshirn@suse.de, mingo@kernel.org,
          penberg@kernel.org, dsterba@suse.com, jpoimboe@redhat.com,
          mbenes@suse.cz, agk@redhat.com, catalin.marinas@arm.com,
          josef@toxicpanda.com, daniel@ffwll.ch, akpm@linux-foundation.org,
          dvyukov@google.com, snitzer@redhat.com, tglx@linutronix.de,
          luto@kernel.org, tom.zanussi@linux.intel.com,
          rodrigo.vivi@intel.com, maarten.lankhorst@linux.intel.com,
          akinobu.mita@gmail.com, rostedt@goodmis.org, hch@lst.de,
          joonas.lahtinen@linux.intel.com, hpa@zytor.com,
          m.szyprowski@samsung.com, jani.nikula@linux.intel.com,
          robin.murphy@arm.com, glider@google.com, rppt@linux.vnet.ibm.com
In-Reply-To: <20190425094801.863716911@linutronix.de>
References: <20190425094801.863716911@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/kmemleak: Simplify stacktrace handling
Git-Commit-ID: 07984aad1c7ed679596f849c0e7d5e029f76e0eb
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

Commit-ID:  07984aad1c7ed679596f849c0e7d5e029f76e0eb
Gitweb:     https://git.kernel.org/tip/07984aad1c7ed679596f849c0e7d5e029f76e0eb
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:49 +0200

mm/kmemleak: Simplify stacktrace handling

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linux-mm@kvack.org
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
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
Link: https://lkml.kernel.org/r/20190425094801.863716911@linutronix.de

---
 mm/kmemleak.c | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6c318f5ac234..d12b35de1e7e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -410,11 +410,6 @@ static void print_unreferenced(struct seq_file *seq,
  */
 static void dump_object_info(struct kmemleak_object *object)
 {
-	struct stack_trace trace;
-
-	trace.nr_entries = object->trace_len;
-	trace.entries = object->trace;
-
 	pr_notice("Object 0x%08lx (size %zu):\n",
 		  object->pointer, object->size);
 	pr_notice("  comm \"%s\", pid %d, jiffies %lu\n",
@@ -424,7 +419,7 @@ static void dump_object_info(struct kmemleak_object *object)
 	pr_notice("  flags = 0x%x\n", object->flags);
 	pr_notice("  checksum = %u\n", object->checksum);
 	pr_notice("  backtrace:\n");
-	print_stack_trace(&trace, 4);
+	stack_trace_print(object->trace, object->trace_len, 4);
 }
 
 /*
@@ -553,15 +548,7 @@ static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int ali
  */
 static int __save_stack_trace(unsigned long *trace)
 {
-	struct stack_trace stack_trace;
-
-	stack_trace.max_entries = MAX_TRACE;
-	stack_trace.nr_entries = 0;
-	stack_trace.entries = trace;
-	stack_trace.skip = 2;
-	save_stack_trace(&stack_trace);
-
-	return stack_trace.nr_entries;
+	return stack_trace_save(trace, MAX_TRACE, 2);
 }
 
 /*
@@ -2019,13 +2006,8 @@ early_param("kmemleak", kmemleak_boot_config);
 
 static void __init print_log_trace(struct early_log *log)
 {
-	struct stack_trace trace;
-
-	trace.nr_entries = log->trace_len;
-	trace.entries = log->trace;
-
 	pr_notice("Early log backtrace:\n");
-	print_stack_trace(&trace, 2);
+	stack_trace_print(log->trace, log->trace_len, 2);
 }
 
 /*
