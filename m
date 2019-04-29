Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8FEC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C70C2087B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="QPKDiWm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbfD2Shr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:37:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56557 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729002AbfD2Shq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:37:46 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIZTUZ1027603
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:35:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIZTUZ1027603
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556562931;
        bh=RoN7JIoaa+3JKRSawqx+X86giRFIjf7jtr8UpntSZSE=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=QPKDiWm3Lfh8XreiEVMXDGeWoztIIZIzafjb+Dfq53OB8mk9zNgG9Xszgir6kUr85
         0OFDU64vxd3dawBIbzoo9MOSm+V7EfWva4RFc5POnU2ikONU5ZGsPT4mMfBmJQG3/i
         LLc1Uj7UbEDRLzSiE84QsrHXl1GGmJy3pR8Y7NqG+AM3EO6NPUf5WD5grLda0X0Tt2
         tGlq7fwBA8YjuL5mNNDVWrOBBwmB5vkTDvnqIciagojanx0ZOhfd0mZzi+DcTfbAME
         mzX3KUgE/XUmaxav9e7Rll81xoZDlOQ/NBhQUMe0OdfUiiGi7KmVPswQVrrr6vbQaI
         tUoZo7tp1pQNQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIZT8C1027599;
        Mon, 29 Apr 2019 11:35:29 -0700
Date:   Mon, 29 Apr 2019 11:35:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-7971679994d3a239538ddcfea9f89468f0bd65e2@git.kernel.org>
Cc:     m.szyprowski@samsung.com, tom.zanussi@linux.intel.com, hch@lst.de,
        snitzer@redhat.com, penberg@kernel.org, dvyukov@google.com,
        joonas.lahtinen@linux.intel.com, akpm@linux-foundation.org,
        akinobu.mita@gmail.com, luto@kernel.org,
        linux-kernel@vger.kernel.org, rientjes@google.com,
        catalin.marinas@arm.com, rodrigo.vivi@intel.com, airlied@linux.ie,
        jpoimboe@redhat.com, glider@google.com, mbenes@suse.cz,
        robin.murphy@arm.com, jthumshirn@suse.de, aryabinin@virtuozzo.com,
        mingo@kernel.org, clm@fb.com, daniel@ffwll.ch,
        josef@toxicpanda.com, adobriyan@gmail.com, tglx@linutronix.de,
        rppt@linux.vnet.ibm.com, rostedt@goodmis.org,
        jani.nikula@linux.intel.com, hpa@zytor.com, cl@linux.com,
        agk@redhat.com, dsterba@suse.com, maarten.lankhorst@linux.intel.com
Reply-To: catalin.marinas@arm.com, rodrigo.vivi@intel.com,
          airlied@linux.ie, jpoimboe@redhat.com,
          tom.zanussi@linux.intel.com, m.szyprowski@samsung.com,
          akinobu.mita@gmail.com, akpm@linux-foundation.org,
          dvyukov@google.com, joonas.lahtinen@linux.intel.com,
          penberg@kernel.org, snitzer@redhat.com, hch@lst.de,
          linux-kernel@vger.kernel.org, luto@kernel.org,
          rientjes@google.com, rostedt@goodmis.org,
          rppt@linux.vnet.ibm.com, cl@linux.com, hpa@zytor.com,
          jani.nikula@linux.intel.com, dsterba@suse.com,
          maarten.lankhorst@linux.intel.com, agk@redhat.com,
          robin.murphy@arm.com, mbenes@suse.cz, glider@google.com,
          daniel@ffwll.ch, clm@fb.com, mingo@kernel.org,
          aryabinin@virtuozzo.com, jthumshirn@suse.de, tglx@linutronix.de,
          adobriyan@gmail.com, josef@toxicpanda.com
In-Reply-To: <20190425094801.771410441@linutronix.de>
References: <20190425094801.771410441@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] mm/slub: Simplify stack trace retrieval
Git-Commit-ID: 7971679994d3a239538ddcfea9f89468f0bd65e2
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

Commit-ID:  7971679994d3a239538ddcfea9f89468f0bd65e2
Gitweb:     https://git.kernel.org/tip/7971679994d3a239538ddcfea9f89468f0bd65e2
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:00 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:48 +0200

mm/slub: Simplify stack trace retrieval

Replace the indirection through struct stack_trace with an invocation of
the storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Christoph Lameter <cl@linux.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: linux-mm@kvack.org
Cc: David Rientjes <rientjes@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexander Potapenko <glider@google.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
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
Link: https://lkml.kernel.org/r/20190425094801.771410441@linutronix.de

---
 mm/slub.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index e2ccd12b6faa..6b28cd2b5a58 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -552,18 +552,14 @@ static void set_track(struct kmem_cache *s, void *object,
 
 	if (addr) {
 #ifdef CONFIG_STACKTRACE
-		struct stack_trace trace;
+		unsigned int nr_entries;
 
-		trace.nr_entries = 0;
-		trace.max_entries = TRACK_ADDRS_COUNT;
-		trace.entries = p->addrs;
-		trace.skip = 3;
 		metadata_access_enable();
-		save_stack_trace(&trace);
+		nr_entries = stack_trace_save(p->addrs, TRACK_ADDRS_COUNT, 3);
 		metadata_access_disable();
 
-		if (trace.nr_entries < TRACK_ADDRS_COUNT)
-			p->addrs[trace.nr_entries] = 0;
+		if (nr_entries < TRACK_ADDRS_COUNT)
+			p->addrs[nr_entries] = 0;
 #endif
 		p->addr = addr;
 		p->cpu = smp_processor_id();
