Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4CAC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E1A02087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="T+Sy885f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfD2SmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:42:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfD2SmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:42:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIdi6n1028396
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:39:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIdi6n1028396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563186;
        bh=m/WV8wbQqe7VqlxyY3dbNq8yGaQRZ1piOP0Q881a2/k=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=T+Sy885fSIP1E46u1t/BJTRP4lg0Jnb0sTG/1Kbdyv9iglvgqhOKOxmA5EIwA0OAK
         Vf4ZlliORoXOe0keewJygezen2H3hUmsbIga7KXe56LqQcJtn+/2jgbiGCGFp0qQug
         ZdgAY4mrGozdgnN3HP0EVpNw90z9fwTGVUUhdBZAdAPrPhcFKVUOsedzQAvUngMbEC
         WL2hqtN7rtS7wYH0x3qkTTaVgAlXJzp78BEvAZGaxWba6PGVwPlUA1hD2kZtCqcrAZ
         09kwQDQ4+1jfzr8r4K290eR2mhRYf7OBJRiUSasEEIbyBWPcSY00eS32XIxZqxqm7H
         Xmmb733ayO6PA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIdhku1028390;
        Mon, 29 Apr 2019 11:39:43 -0700
Date:   Mon, 29 Apr 2019 11:39:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-6924f5feba21ea2bba64b4dc316ee046c48355ca@git.kernel.org>
Cc:     dsterba@suse.com, tglx@linutronix.de, akpm@linux-foundation.org,
        penberg@kernel.org, akinobu.mita@gmail.com, daniel@ffwll.ch,
        aryabinin@virtuozzo.com, agk@redhat.com, jpoimboe@redhat.com,
        glider@google.com, mbenes@suse.cz, rostedt@goodmis.org,
        catalin.marinas@arm.com, adobriyan@gmail.com,
        jani.nikula@linux.intel.com, tom.zanussi@linux.intel.com,
        rppt@linux.vnet.ibm.com, hch@lst.de, dvyukov@google.com,
        hpa@zytor.com, mingo@kernel.org, m.szyprowski@samsung.com,
        cl@linux.com, robin.murphy@arm.com, josef@toxicpanda.com,
        clm@fb.com, maarten.lankhorst@linux.intel.com, rientjes@google.com,
        rodrigo.vivi@intel.com, luto@kernel.org, snitzer@redhat.com,
        jthumshirn@suse.de, linux-kernel@vger.kernel.org, airlied@linux.ie,
        joonas.lahtinen@linux.intel.com
Reply-To: mingo@kernel.org, dvyukov@google.com, hpa@zytor.com, hch@lst.de,
          rppt@linux.vnet.ibm.com, tom.zanussi@linux.intel.com,
          jani.nikula@linux.intel.com, adobriyan@gmail.com,
          catalin.marinas@arm.com, rostedt@goodmis.org, mbenes@suse.cz,
          glider@google.com, jpoimboe@redhat.com, aryabinin@virtuozzo.com,
          agk@redhat.com, daniel@ffwll.ch, akinobu.mita@gmail.com,
          penberg@kernel.org, akpm@linux-foundation.org,
          tglx@linutronix.de, dsterba@suse.com, airlied@linux.ie,
          joonas.lahtinen@linux.intel.com, linux-kernel@vger.kernel.org,
          jthumshirn@suse.de, snitzer@redhat.com, luto@kernel.org,
          rodrigo.vivi@intel.com, rientjes@google.com,
          maarten.lankhorst@linux.intel.com, clm@fb.com,
          josef@toxicpanda.com, cl@linux.com, robin.murphy@arm.com,
          m.szyprowski@samsung.com
In-Reply-To: <20190425094802.338890064@linutronix.de>
References: <20190425094802.338890064@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] btrfs: ref-verify: Simplify stack trace
 retrieval
Git-Commit-ID: 6924f5feba21ea2bba64b4dc316ee046c48355ca
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

Commit-ID:  6924f5feba21ea2bba64b4dc316ee046c48355ca
Gitweb:     https://git.kernel.org/tip/6924f5feba21ea2bba64b4dc316ee046c48355ca
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:06 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:51 +0200

btrfs: ref-verify: Simplify stack trace retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: David Sterba <dsterba@suse.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org
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
Link: https://lkml.kernel.org/r/20190425094802.338890064@linutronix.de

---
 fs/btrfs/ref-verify.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index d09b6cdb785a..b283d3a6e837 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -205,28 +205,17 @@ static struct root_entry *lookup_root_entry(struct rb_root *root, u64 objectid)
 #ifdef CONFIG_STACKTRACE
 static void __save_stack_trace(struct ref_action *ra)
 {
-	struct stack_trace stack_trace;
-
-	stack_trace.max_entries = MAX_TRACE;
-	stack_trace.nr_entries = 0;
-	stack_trace.entries = ra->trace;
-	stack_trace.skip = 2;
-	save_stack_trace(&stack_trace);
-	ra->trace_len = stack_trace.nr_entries;
+	ra->trace_len = stack_trace_save(ra->trace, MAX_TRACE, 2);
 }
 
 static void __print_stack_trace(struct btrfs_fs_info *fs_info,
 				struct ref_action *ra)
 {
-	struct stack_trace trace;
-
 	if (ra->trace_len == 0) {
 		btrfs_err(fs_info, "  ref-verify: no stacktrace");
 		return;
 	}
-	trace.nr_entries = ra->trace_len;
-	trace.entries = ra->trace;
-	print_stack_trace(&trace, 2);
+	stack_trace_print(ra->trace, ra->trace_len, 2);
 }
 #else
 static void inline __save_stack_trace(struct ref_action *ra)
