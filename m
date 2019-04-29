Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25518C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF196215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="qZCViHIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfD2Sfx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:35:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729130AbfD2Sfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:35:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIYkPd1027462
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:34:46 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIYkPd1027462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562888;
        bh=tD78nErbFOXSLjomx3YZxxwA14XMQMWEldwwMWwz7JY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=qZCViHIWeK7BMnVGyg8206MWsT3c/ZwJtmFJVqVMe7KR7aFW0DkYr3OBO/GdH3Adi
         lvX6wHs7nGqVtyWInIFeCzZ5G2J8m9lN72C6f/d3FCzkhdVyD8bFLLz0zZgRoUSXM4
         iXXxICd/tf6n6kNFZ2eCM9lAGcME5LuXtyf23CEypq5853VZmdspckOKW0R7WMDG5x
         iv4PtyZpFWDDJHBVuAP3TRKUpdbdXeQQyQ/9kf6XVypNKbv9hXGC1nYjpmh5yIIrci
         16j2j3EvYJu4jI7IxXS9z6ejJ7vr7lqiSl3llhwFPcotH71mIZIJivdGpWeC/0OMz9
         4IIYU/RE8KgpA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIYktY1027458;
        Mon, 29 Apr 2019 11:34:46 -0700
Date:   Mon, 29 Apr 2019 11:34:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-f93877214a83e88373b20801c2d671923d03d07d@git.kernel.org>
Cc:     akpm@linux-foundation.org, akinobu.mita@gmail.com,
        penberg@kernel.org, luto@kernel.org, dvyukov@google.com,
        linux-kernel@vger.kernel.org, joonas.lahtinen@linux.intel.com,
        mbenes@suse.cz, rostedt@goodmis.org, jpoimboe@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, rientjes@google.com,
        catalin.marinas@arm.com, robin.murphy@arm.com,
        rodrigo.vivi@intel.com, snitzer@redhat.com, agk@redhat.com,
        jthumshirn@suse.de, adobriyan@gmail.com, m.szyprowski@samsung.com,
        daniel@ffwll.ch, glider@google.com, aryabinin@virtuozzo.com,
        cl@linux.com, mingo@kernel.org, tom.zanussi@linux.intel.com,
        dsterba@suse.com, airlied@linux.ie, clm@fb.com,
        josef@toxicpanda.com, maarten.lankhorst@linux.intel.com,
        hch@lst.de, jani.nikula@linux.intel.com, rppt@linux.vnet.ibm.com
Reply-To: josef@toxicpanda.com, maarten.lankhorst@linux.intel.com,
          hch@lst.de, jani.nikula@linux.intel.com, rppt@linux.vnet.ibm.com,
          tom.zanussi@linux.intel.com, mingo@kernel.org, dsterba@suse.com,
          airlied@linux.ie, clm@fb.com, jthumshirn@suse.de,
          adobriyan@gmail.com, m.szyprowski@samsung.com,
          aryabinin@virtuozzo.com, daniel@ffwll.ch, glider@google.com,
          cl@linux.com, rodrigo.vivi@intel.com, snitzer@redhat.com,
          agk@redhat.com, rientjes@google.com, tglx@linutronix.de,
          catalin.marinas@arm.com, robin.murphy@arm.com,
          linux-kernel@vger.kernel.org, joonas.lahtinen@linux.intel.com,
          mbenes@suse.cz, rostedt@goodmis.org, hpa@zytor.com,
          jpoimboe@redhat.com, penberg@kernel.org, luto@kernel.org,
          dvyukov@google.com, akpm@linux-foundation.org,
          akinobu.mita@gmail.com
In-Reply-To: <20190425094801.683039030@linutronix.de>
References: <20190425094801.683039030@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] latency_top: Simplify stack trace handling
Git-Commit-ID: f93877214a83e88373b20801c2d671923d03d07d
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

Commit-ID:  f93877214a83e88373b20801c2d671923d03d07d
Gitweb:     https://git.kernel.org/tip/f93877214a83e88373b20801c2d671923d03d07d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:44:59 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:48 +0200

latency_top: Simplify stack trace handling

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

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
Link: https://lkml.kernel.org/r/20190425094801.683039030@linutronix.de

---
 kernel/latencytop.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index f5a90ab3c6b9..99a5b5f46dc5 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -141,20 +141,6 @@ account_global_scheduler_latency(struct task_struct *tsk,
 	memcpy(&latency_record[i], lat, sizeof(struct latency_record));
 }
 
-/*
- * Iterator to store a backtrace into a latency record entry
- */
-static inline void store_stacktrace(struct task_struct *tsk,
-					struct latency_record *lat)
-{
-	struct stack_trace trace;
-
-	memset(&trace, 0, sizeof(trace));
-	trace.max_entries = LT_BACKTRACEDEPTH;
-	trace.entries = &lat->backtrace[0];
-	save_stack_trace_tsk(tsk, &trace);
-}
-
 /**
  * __account_scheduler_latency - record an occurred latency
  * @tsk - the task struct of the task hitting the latency
@@ -191,7 +177,8 @@ __account_scheduler_latency(struct task_struct *tsk, int usecs, int inter)
 	lat.count = 1;
 	lat.time = usecs;
 	lat.max = usecs;
-	store_stacktrace(tsk, &lat);
+
+	stack_trace_save_tsk(tsk, lat.backtrace, LT_BACKTRACEDEPTH, 0);
 
 	raw_spin_lock_irqsave(&latency_lock, flags);
 
