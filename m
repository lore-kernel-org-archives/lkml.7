Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3DB215EA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="dUPjlFEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfD2Skb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:40:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48101 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728300AbfD2Sk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:40:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TId3EM1028205
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:39:03 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TId3EM1028205
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563145;
        bh=oUyLDDqI7PhEFg5s22vsO8km2m2rsNIUoZ0+YIEfPO4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=dUPjlFEFXTPsYENSKeeO77+C7ltEs1PCxRtQj6lfJqbO8qcSTAKWzmEIXUqVb1TEL
         U/Rk2H3Xsr8SysIgkfpyYoG2od0WIT96A7YkW4xv2L2A0VQy+5yFoHzZGYzQdgOBTM
         XBwYOV5x4FKp80mMDfsCoc43bb+aZQw30RLWVFc/aK2RxUxt9txqyR1MZDn0H+Gtn/
         H/qUEG0LrG5Za+psYTEwYPacauxs7e2wUFOhoPGZGHdcpp2PgdI4d0O7Rye2m7hpAY
         3nJZ1xaKtcmxXsRGAA4xuWZLueOVSvL2/KZyisYO9vwAvNCqzMzccnAml3/qdZ+0ei
         RIPdJpFAXqlaQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TId2Vi1028200;
        Mon, 29 Apr 2019 11:39:02 -0700
Date:   Mon, 29 Apr 2019 11:39:02 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-746017ed8d4d3c2070bb03aee9536f24da43c778@git.kernel.org>
Cc:     maarten.lankhorst@linux.intel.com, robin.murphy@arm.com,
        mingo@kernel.org, snitzer@redhat.com, catalin.marinas@arm.com,
        luto@kernel.org, linux-kernel@vger.kernel.org,
        tom.zanussi@linux.intel.com, jani.nikula@linux.intel.com,
        akinobu.mita@gmail.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, josef@toxicpanda.com, dsterba@suse.com,
        aryabinin@virtuozzo.com, clm@fb.com, jthumshirn@suse.de,
        daniel@ffwll.ch, rppt@linux.vnet.ibm.com, airlied@linux.ie,
        jpoimboe@redhat.com, adobriyan@gmail.com, rodrigo.vivi@intel.com,
        rostedt@goodmis.org, m.szyprowski@samsung.com, hch@lst.de,
        glider@google.com, tglx@linutronix.de, akpm@linux-foundation.org,
        hpa@zytor.com, joonas.lahtinen@linux.intel.com, agk@redhat.com,
        mbenes@suse.cz, dvyukov@google.com
Reply-To: maarten.lankhorst@linux.intel.com, robin.murphy@arm.com,
          catalin.marinas@arm.com, snitzer@redhat.com, mingo@kernel.org,
          luto@kernel.org, linux-kernel@vger.kernel.org,
          jani.nikula@linux.intel.com, tom.zanussi@linux.intel.com,
          penberg@kernel.org, cl@linux.com, akinobu.mita@gmail.com,
          dsterba@suse.com, josef@toxicpanda.com, rientjes@google.com,
          aryabinin@virtuozzo.com, clm@fb.com, daniel@ffwll.ch,
          jthumshirn@suse.de, airlied@linux.ie, rppt@linux.vnet.ibm.com,
          adobriyan@gmail.com, jpoimboe@redhat.com, rodrigo.vivi@intel.com,
          rostedt@goodmis.org, m.szyprowski@samsung.com, hch@lst.de,
          glider@google.com, akpm@linux-foundation.org, tglx@linutronix.de,
          hpa@zytor.com, joonas.lahtinen@linux.intel.com, agk@redhat.com,
          mbenes@suse.cz, dvyukov@google.com
In-Reply-To: <20190425094802.248658135@linutronix.de>
References: <20190425094802.248658135@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] dma/debug: Simplify stracktrace retrieval
Git-Commit-ID: 746017ed8d4d3c2070bb03aee9536f24da43c778
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

Commit-ID:  746017ed8d4d3c2070bb03aee9536f24da43c778
Gitweb:     https://git.kernel.org/tip/746017ed8d4d3c2070bb03aee9536f24da43c778
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:05 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:50 +0200

dma/debug: Simplify stracktrace retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: iommu@lists.linux-foundation.org
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
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
Link: https://lkml.kernel.org/r/20190425094802.248658135@linutronix.de

---
 kernel/dma/debug.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index a218e43cc382..badd77670d00 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -89,8 +89,8 @@ struct dma_debug_entry {
 	int		 sg_mapped_ents;
 	enum map_err_types  map_err_type;
 #ifdef CONFIG_STACKTRACE
-	struct		 stack_trace stacktrace;
-	unsigned long	 st_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
+	unsigned int	stack_len;
+	unsigned long	stack_entries[DMA_DEBUG_STACKTRACE_ENTRIES];
 #endif
 };
 
@@ -174,7 +174,7 @@ static inline void dump_entry_trace(struct dma_debug_entry *entry)
 #ifdef CONFIG_STACKTRACE
 	if (entry) {
 		pr_warning("Mapped at:\n");
-		print_stack_trace(&entry->stacktrace, 0);
+		stack_trace_print(entry->stack_entries, entry->stack_len, 0);
 	}
 #endif
 }
@@ -704,12 +704,10 @@ static struct dma_debug_entry *dma_entry_alloc(void)
 	spin_unlock_irqrestore(&free_entries_lock, flags);
 
 #ifdef CONFIG_STACKTRACE
-	entry->stacktrace.max_entries = DMA_DEBUG_STACKTRACE_ENTRIES;
-	entry->stacktrace.entries = entry->st_entries;
-	entry->stacktrace.skip = 1;
-	save_stack_trace(&entry->stacktrace);
+	entry->stack_len = stack_trace_save(entry->stack_entries,
+					    ARRAY_SIZE(entry->stack_entries),
+					    1);
 #endif
-
 	return entry;
 }
 
