Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B9C004C9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F3521655
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BF/+XdUP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbfD2Soy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:44:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50627 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728962AbfD2Soy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:44:54 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIgR2c1028972
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:42:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIgR2c1028972
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563349;
        bh=u+jb+t+SVHAwZMBx/7HVZsPxzffqtSQHvWFFXm5MwpI=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=BF/+XdUP2j/Nso2II1R2V/RxtpglRDsC2g35TLXjTA2ogwSV+tFiUxqShiAufNNtg
         FyLktsRAYIOuYsO+pmhoI8nRzO7M3j546+Pa8gL7/plSrjzvQ36Re/xWWri4+clQbn
         OO5PT+Oonp8Dzj0zOhr0oQEEpf4NnJlCAeuf586d0jopKfrhOYFTdrhBZyi2ZCJOpL
         3PEJGjMJ9VVlRvTP3QIwNRcKQe5iFMqNN+dgDvZM3lP8xwuGwxBa6Tm+Gq5lw9MAnt
         5o5TU1r7HxJ3FJT5ujz6BStMO9NHNshCHHbV/qAy4JnGxK6XR1mFezgtmWUNqNexQ1
         cXYODi2HmROLw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIgRBS1028968;
        Mon, 29 Apr 2019 11:42:27 -0700
Date:   Mon, 29 Apr 2019 11:42:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-b1abe4622d4cc32b3b37cfefbc7ac070a8f868e0@git.kernel.org>
Cc:     daniel@ffwll.ch, penberg@kernel.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, rientjes@google.com, agk@redhat.com,
        hpa@zytor.com, josef@toxicpanda.com, snitzer@redhat.com,
        airlied@linux.ie, akpm@linux-foundation.org,
        m.szyprowski@samsung.com, adobriyan@gmail.com,
        catalin.marinas@arm.com, cl@linux.com, glider@google.com,
        akinobu.mita@gmail.com, tglx@linutronix.de, hch@lst.de,
        mbenes@suse.cz, aryabinin@virtuozzo.com, rppt@linux.vnet.ibm.com,
        tom.zanussi@linux.intel.com, rodrigo.vivi@intel.com,
        dvyukov@google.com, jthumshirn@suse.de,
        jani.nikula@linux.intel.com, robin.murphy@arm.com,
        joonas.lahtinen@linux.intel.com, maarten.lankhorst@linux.intel.com,
        rostedt@goodmis.org, dsterba@suse.com, jpoimboe@redhat.com,
        luto@kernel.org, clm@fb.com
Reply-To: robin.murphy@arm.com, jani.nikula@linux.intel.com,
          rostedt@goodmis.org, maarten.lankhorst@linux.intel.com,
          joonas.lahtinen@linux.intel.com, luto@kernel.org,
          jpoimboe@redhat.com, dsterba@suse.com, clm@fb.com,
          glider@google.com, cl@linux.com, catalin.marinas@arm.com,
          m.szyprowski@samsung.com, adobriyan@gmail.com,
          tglx@linutronix.de, akinobu.mita@gmail.com,
          rppt@linux.vnet.ibm.com, mbenes@suse.cz, aryabinin@virtuozzo.com,
          hch@lst.de, jthumshirn@suse.de, dvyukov@google.com,
          rodrigo.vivi@intel.com, tom.zanussi@linux.intel.com,
          agk@redhat.com, hpa@zytor.com, snitzer@redhat.com,
          josef@toxicpanda.com, airlied@linux.ie,
          akpm@linux-foundation.org, mingo@kernel.org, penberg@kernel.org,
          daniel@ffwll.ch, linux-kernel@vger.kernel.org,
          rientjes@google.com
In-Reply-To: <20190425094802.716274532@linutronix.de>
References: <20190425094802.716274532@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] lockdep: Remove unused trace argument from
 print_circular_bug()
Git-Commit-ID: b1abe4622d4cc32b3b37cfefbc7ac070a8f868e0
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

Commit-ID:  b1abe4622d4cc32b3b37cfefbc7ac070a8f868e0
Gitweb:     https://git.kernel.org/tip/b1abe4622d4cc32b3b37cfefbc7ac070a8f868e0
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:10 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:53 +0200

lockdep: Remove unused trace argument from print_circular_bug()

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
Link: https://lkml.kernel.org/r/20190425094802.716274532@linutronix.de

---
 kernel/locking/lockdep.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 2edf9501d906..d7615d299d08 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -1522,10 +1522,9 @@ static inline int class_equal(struct lock_list *entry, void *data)
 }
 
 static noinline int print_circular_bug(struct lock_list *this,
-				struct lock_list *target,
-				struct held_lock *check_src,
-				struct held_lock *check_tgt,
-				struct stack_trace *trace)
+				       struct lock_list *target,
+				       struct held_lock *check_src,
+				       struct held_lock *check_tgt)
 {
 	struct task_struct *curr = current;
 	struct lock_list *parent;
@@ -2206,7 +2205,7 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
 			 */
 			save(trace);
 		}
-		return print_circular_bug(&this, target_entry, next, prev, trace);
+		return print_circular_bug(&this, target_entry, next, prev);
 	}
 	else if (unlikely(ret < 0))
 		return print_bfs_bug(ret);
