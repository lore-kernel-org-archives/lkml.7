Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D1AC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76182087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lDa0bNHd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfD2Sm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:42:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33001 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbfD2Sm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:42:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIeOew1028552
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:40:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIeOew1028552
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563225;
        bh=bkMvuE92jdOa5rlLjMrziE5cNpKXsrFew2xoRhacUzo=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lDa0bNHdCZQi5CxMg85sxg936rweop4T8Y23+c0ni3rT/6+UIXiFH72sPrthUAz3J
         Mr6+vr9CfRiyqC9j8a65Uz9KdGyJsqVN6i8Q4jXuCiEn5xzlsuEWdpgbUXUcAg7L89
         4jgKSlHX8y6jP+rMh2QnbpVTESYIX4CXOviNrip4Kb4Xl99a0fj9O3xhw2K+v5k+UK
         tcAB5d3UkYB8FK1xj+lpGaPqVXmWZoiMiNELQlHCKvgvzi715YblTtAk64aoEwquWV
         NRcLtnUCHqbCZlrHUfqPDhPwEX0PUZLD57UlCbLaTjv1az6pnmZ+W2GziSDzONwfB1
         MF0s7Fck4qUwQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIeNA31028548;
        Mon, 29 Apr 2019 11:40:23 -0700
Date:   Mon, 29 Apr 2019 11:40:23 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-741b58f3e23673a666c700361711a91022a69e56@git.kernel.org>
Cc:     jpoimboe@redhat.com, rodrigo.vivi@intel.com, jthumshirn@suse.de,
        glider@google.com, daniel@ffwll.ch, dvyukov@google.com, hch@lst.de,
        airlied@linux.ie, hpa@zytor.com, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        tom.zanussi@linux.intel.com, mbenes@suse.cz,
        catalin.marinas@arm.com, dsterba@suse.com, rppt@linux.vnet.ibm.com,
        clm@fb.com, akpm@linux-foundation.org, robin.murphy@arm.com,
        agk@redhat.com, adobriyan@gmail.com,
        joonas.lahtinen@linux.intel.com, snitzer@redhat.com,
        akinobu.mita@gmail.com, cl@linux.com, penberg@kernel.org,
        aryabinin@virtuozzo.com, josef@toxicpanda.com,
        maarten.lankhorst@linux.intel.com, mingo@kernel.org,
        m.szyprowski@samsung.com, luto@kernel.org, tglx@linutronix.de,
        rientjes@google.com
Reply-To: rppt@linux.vnet.ibm.com, dsterba@suse.com,
          catalin.marinas@arm.com, mbenes@suse.cz,
          akpm@linux-foundation.org, clm@fb.com, robin.murphy@arm.com,
          agk@redhat.com, adobriyan@gmail.com, snitzer@redhat.com,
          akinobu.mita@gmail.com, joonas.lahtinen@linux.intel.com,
          cl@linux.com, josef@toxicpanda.com, penberg@kernel.org,
          aryabinin@virtuozzo.com, maarten.lankhorst@linux.intel.com,
          mingo@kernel.org, m.szyprowski@samsung.com, luto@kernel.org,
          tglx@linutronix.de, rientjes@google.com, jpoimboe@redhat.com,
          jthumshirn@suse.de, rodrigo.vivi@intel.com, glider@google.com,
          dvyukov@google.com, daniel@ffwll.ch, airlied@linux.ie,
          hch@lst.de, hpa@zytor.com, jani.nikula@linux.intel.com,
          linux-kernel@vger.kernel.org, rostedt@goodmis.org,
          tom.zanussi@linux.intel.com
In-Reply-To: <20190425094802.446326191@linutronix.de>
References: <20190425094802.446326191@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] dm bufio: Simplify stack trace retrieval
Git-Commit-ID: 741b58f3e23673a666c700361711a91022a69e56
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

Commit-ID:  741b58f3e23673a666c700361711a91022a69e56
Gitweb:     https://git.kernel.org/tip/741b58f3e23673a666c700361711a91022a69e56
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:07 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:52 +0200

dm bufio: Simplify stack trace retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>
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
Link: https://lkml.kernel.org/r/20190425094802.446326191@linutronix.de

---
 drivers/md/dm-bufio.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 1ecef76225a1..2a48ea3f1b30 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -150,7 +150,7 @@ struct dm_buffer {
 	void (*end_io)(struct dm_buffer *, blk_status_t);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 #define MAX_STACK 10
-	struct stack_trace stack_trace;
+	unsigned int stack_len;
 	unsigned long stack_entries[MAX_STACK];
 #endif
 };
@@ -232,11 +232,7 @@ static DEFINE_MUTEX(dm_bufio_clients_lock);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
 static void buffer_record_stack(struct dm_buffer *b)
 {
-	b->stack_trace.nr_entries = 0;
-	b->stack_trace.max_entries = MAX_STACK;
-	b->stack_trace.entries = b->stack_entries;
-	b->stack_trace.skip = 2;
-	save_stack_trace(&b->stack_trace);
+	b->stack_len = stack_trace_save(b->stack_entries, MAX_STACK, 2);
 }
 #endif
 
@@ -438,7 +434,7 @@ static struct dm_buffer *alloc_buffer(struct dm_bufio_client *c, gfp_t gfp_mask)
 	adjust_total_allocated(b->data_mode, (long)c->block_size);
 
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-	memset(&b->stack_trace, 0, sizeof(b->stack_trace));
+	b->stack_len = 0;
 #endif
 	return b;
 }
@@ -1520,8 +1516,9 @@ static void drop_buffers(struct dm_bufio_client *c)
 			DMERR("leaked buffer %llx, hold count %u, list %d",
 			      (unsigned long long)b->block, b->hold_count, i);
 #ifdef CONFIG_DM_DEBUG_BLOCK_STACK_TRACING
-			print_stack_trace(&b->stack_trace, 1);
-			b->hold_count = 0; /* mark unclaimed to avoid BUG_ON below */
+			stack_trace_print(b->stack_entries, b->stack_len, 1);
+			/* mark unclaimed to avoid BUG_ON below */
+			b->hold_count = 0;
 #endif
 		}
 
