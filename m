Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28502C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E418D2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="OLDMyGcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbfD2Skf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:40:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40287 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Skf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:40:35 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIcMRK1028077
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:38:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIcMRK1028077
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563104;
        bh=RmUMTwf0FHcZ3Xi0mcwigAwcLdcHbtBXq6G6lhNpVD4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=OLDMyGcSHaNXHmTKfnWyEkHbQmaZrIanX3rnBn631F1g8FWeDtRPyHA15hKjS45Bt
         AINOAlnUHMH90WXFrN4s0QGpk1X5QXnX2Zy2uqiGw94gYgbECqa7blfkCXi3qgDLtd
         Nlu/VQZqR71fCLLQAFl+NUiBW5OMivNsdW20g85Hx4FSsQUEgOR9zCYwBGL8kVB0ST
         fm3SyqRv2E3aLQ+eXL2XeqDqSM3s+rstVOTFyH+yYQv4edw9qGjjuJMqtPIQT5kfqR
         1ihmNjo3gMJgUb2fGnCnCh2IzeTCtSBdsRiLXUJHX44ZfRw9Z3Ts4fV6gyzFTsO5X3
         p7K8TyHRWctKA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIcLd01028073;
        Mon, 29 Apr 2019 11:38:21 -0700
Date:   Mon, 29 Apr 2019 11:38:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-30191250c2b3ef772cc6125e1c31ac84123f1d20@git.kernel.org>
Cc:     hch@lst.de, snitzer@redhat.com, linux-kernel@vger.kernel.org,
        rodrigo.vivi@intel.com, joonas.lahtinen@linux.intel.com,
        glider@google.com, dvyukov@google.com, airlied@linux.ie,
        akinobu.mita@gmail.com, maarten.lankhorst@linux.intel.com,
        akpm@linux-foundation.org, dsterba@suse.com, robin.murphy@arm.com,
        tglx@linutronix.de, daniel@ffwll.ch, mingo@kernel.org,
        m.szyprowski@samsung.com, tom.zanussi@linux.intel.com,
        catalin.marinas@arm.com, cl@linux.com, hpa@zytor.com,
        adobriyan@gmail.com, mbenes@suse.cz, jpoimboe@redhat.com,
        jthumshirn@suse.de, rientjes@google.com,
        jani.nikula@linux.intel.com, josef@toxicpanda.com,
        aryabinin@virtuozzo.com, agk@redhat.com, luto@kernel.org,
        rppt@linux.vnet.ibm.com, penberg@kernel.org, rostedt@goodmis.org,
        clm@fb.com
Reply-To: rostedt@goodmis.org, clm@fb.com, luto@kernel.org,
          penberg@kernel.org, rppt@linux.vnet.ibm.com,
          aryabinin@virtuozzo.com, agk@redhat.com, josef@toxicpanda.com,
          jani.nikula@linux.intel.com, rientjes@google.com,
          jthumshirn@suse.de, jpoimboe@redhat.com, mbenes@suse.cz,
          adobriyan@gmail.com, tom.zanussi@linux.intel.com,
          catalin.marinas@arm.com, cl@linux.com, hpa@zytor.com,
          mingo@kernel.org, m.szyprowski@samsung.com, robin.murphy@arm.com,
          tglx@linutronix.de, daniel@ffwll.ch, dsterba@suse.com,
          akpm@linux-foundation.org, maarten.lankhorst@linux.intel.com,
          akinobu.mita@gmail.com, dvyukov@google.com, airlied@linux.ie,
          joonas.lahtinen@linux.intel.com, glider@google.com,
          linux-kernel@vger.kernel.org, rodrigo.vivi@intel.com,
          snitzer@redhat.com, hch@lst.de
In-Reply-To: <20190425094802.158306076@linutronix.de>
References: <20190425094802.158306076@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] fault-inject: Simplify stacktrace retrieval
Git-Commit-ID: 30191250c2b3ef772cc6125e1c31ac84123f1d20
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

Commit-ID:  30191250c2b3ef772cc6125e1c31ac84123f1d20
Gitweb:     https://git.kernel.org/tip/30191250c2b3ef772cc6125e1c31ac84123f1d20
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:04 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:50 +0200

fault-inject: Simplify stacktrace retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
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
Link: https://lkml.kernel.org/r/20190425094802.158306076@linutronix.de

---
 lib/fault-inject.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/fault-inject.c b/lib/fault-inject.c
index cf7b129b0b2b..e26aa4f65eb9 100644
--- a/lib/fault-inject.c
+++ b/lib/fault-inject.c
@@ -65,22 +65,16 @@ static bool fail_task(struct fault_attr *attr, struct task_struct *task)
 
 static bool fail_stacktrace(struct fault_attr *attr)
 {
-	struct stack_trace trace;
 	int depth = attr->stacktrace_depth;
 	unsigned long entries[MAX_STACK_TRACE_DEPTH];
-	int n;
+	int n, nr_entries;
 	bool found = (attr->require_start == 0 && attr->require_end == ULONG_MAX);
 
 	if (depth == 0)
 		return found;
 
-	trace.nr_entries = 0;
-	trace.entries = entries;
-	trace.max_entries = depth;
-	trace.skip = 1;
-
-	save_stack_trace(&trace);
-	for (n = 0; n < trace.nr_entries; n++) {
+	nr_entries = stack_trace_save(entries, depth, 1);
+	for (n = 0; n < nr_entries; n++) {
 		if (attr->reject_start <= entries[n] &&
 			       entries[n] < attr->reject_end)
 			return false;
