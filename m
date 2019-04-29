Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A72EC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02CEC215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="iJNUn4RJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbfD2Sss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:48:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34595 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Sss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:48:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIllh41031367
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:47:48 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIllh41031367
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563669;
        bh=ZIciOh8pJJlt/6ku4x8UkzAzAS1+BU+uMmHy2d/Xiq8=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=iJNUn4RJkhEWgwxEKSqC1gG9NuPOT7BHVNvZxuhMP+NLnpEjULURS36c2npx7L3cK
         BKlSKer61XqgpG8MfTmVbhFD5iPaVx4hGzpo+DFC6rBpm5jHTXBsY1T2ctX449NuC4
         KmxExlTeTN5kPUBBzv76sOIBkrCpixCE2d6k54Nm3lHjIgr7spSSnPFLefbX+0f4tw
         cjY+yggSaGaAZLt2lokAZ4eYTO5Q664G3m0QGwZjgFDCJlyIKzRdCmrp/fIIBPTezE
         4lM2te80a5wNF/07NP4ZcrXzLfByKA3zzIfGMPjXakFNT8JCaATHbvhWGSFyFHbo9Q
         zY7SxCZAQ3FeQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIllQY1031363;
        Mon, 29 Apr 2019 11:47:47 -0700
Date:   Mon, 29 Apr 2019 11:47:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-25e39e32b0a3f99b9db320605f20f91d425b6a65@git.kernel.org>
Cc:     tglx@linutronix.de, akinobu.mita@gmail.com,
        joonas.lahtinen@linux.intel.com, robin.murphy@arm.com,
        mbenes@suse.cz, jpoimboe@redhat.com, snitzer@redhat.com,
        clm@fb.com, luto@kernel.org, penberg@kernel.org,
        maarten.lankhorst@linux.intel.com, jthumshirn@suse.de,
        glider@google.com, dvyukov@google.com, tom.zanussi@linux.intel.com,
        hpa@zytor.com, rodrigo.vivi@intel.com, rostedt@goodmis.org,
        rientjes@google.com, dsterba@suse.com, mingo@kernel.org,
        catalin.marinas@arm.com, hch@lst.de, agk@redhat.com,
        m.szyprowski@samsung.com, airlied@linux.ie,
        aryabinin@virtuozzo.com, akpm@linux-foundation.org, cl@linux.com,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch, adobriyan@gmail.com,
        rppt@linux.vnet.ibm.com, josef@toxicpanda.com,
        jani.nikula@linux.intel.com
Reply-To: josef@toxicpanda.com, rppt@linux.vnet.ibm.com,
          jani.nikula@linux.intel.com, adobriyan@gmail.com,
          akpm@linux-foundation.org, cl@linux.com, daniel@ffwll.ch,
          linux-kernel@vger.kernel.org, airlied@linux.ie,
          aryabinin@virtuozzo.com, m.szyprowski@samsung.com,
          agk@redhat.com, catalin.marinas@arm.com, hch@lst.de,
          dsterba@suse.com, mingo@kernel.org, rientjes@google.com,
          rodrigo.vivi@intel.com, rostedt@goodmis.org, hpa@zytor.com,
          tom.zanussi@linux.intel.com, glider@google.com,
          maarten.lankhorst@linux.intel.com, jthumshirn@suse.de,
          penberg@kernel.org, dvyukov@google.com, jpoimboe@redhat.com,
          luto@kernel.org, clm@fb.com, snitzer@redhat.com, mbenes@suse.cz,
          robin.murphy@arm.com, joonas.lahtinen@linux.intel.com,
          akinobu.mita@gmail.com, tglx@linutronix.de
In-Reply-To: <20190425094803.437950229@linutronix.de>
References: <20190425094803.437950229@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] livepatch: Simplify stack trace retrieval
Git-Commit-ID: 25e39e32b0a3f99b9db320605f20f91d425b6a65
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

Commit-ID:  25e39e32b0a3f99b9db320605f20f91d425b6a65
Gitweb:     https://git.kernel.org/tip/25e39e32b0a3f99b9db320605f20f91d425b6a65
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:18 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:56 +0200

livepatch: Simplify stack trace retrieval

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
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
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094803.437950229@linutronix.de

---
 kernel/livepatch/transition.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 9c89ae8b337a..c53370d596be 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -202,15 +202,15 @@ void klp_update_patch_state(struct task_struct *task)
  * Determine whether the given stack trace includes any references to a
  * to-be-patched or to-be-unpatched function.
  */
-static int klp_check_stack_func(struct klp_func *func,
-				struct stack_trace *trace)
+static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
+				unsigned int nr_entries)
 {
 	unsigned long func_addr, func_size, address;
 	struct klp_ops *ops;
 	int i;
 
-	for (i = 0; i < trace->nr_entries; i++) {
-		address = trace->entries[i];
+	for (i = 0; i < nr_entries; i++) {
+		address = entries[i];
 
 		if (klp_target_state == KLP_UNPATCHED) {
 			 /*
@@ -254,29 +254,25 @@ static int klp_check_stack_func(struct klp_func *func,
 static int klp_check_stack(struct task_struct *task, char *err_buf)
 {
 	static unsigned long entries[MAX_STACK_ENTRIES];
-	struct stack_trace trace;
 	struct klp_object *obj;
 	struct klp_func *func;
-	int ret;
+	int ret, nr_entries;
 
-	trace.skip = 0;
-	trace.nr_entries = 0;
-	trace.max_entries = MAX_STACK_ENTRIES;
-	trace.entries = entries;
-	ret = save_stack_trace_tsk_reliable(task, &trace);
+	ret = stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
 	WARN_ON_ONCE(ret == -ENOSYS);
-	if (ret) {
+	if (ret < 0) {
 		snprintf(err_buf, STACK_ERR_BUF_SIZE,
 			 "%s: %s:%d has an unreliable stack\n",
 			 __func__, task->comm, task->pid);
 		return ret;
 	}
+	nr_entries = ret;
 
 	klp_for_each_object(klp_transition_patch, obj) {
 		if (!obj->patched)
 			continue;
 		klp_for_each_func(obj, func) {
-			ret = klp_check_stack_func(func, &trace);
+			ret = klp_check_stack_func(func, entries, nr_entries);
 			if (ret) {
 				snprintf(err_buf, STACK_ERR_BUF_SIZE,
 					 "%s: %s:%d is sleeping on function %s\n",
