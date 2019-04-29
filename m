Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38AFC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61DE02067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 18:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="lxcHRzsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbfD2SrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 14:47:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729200AbfD2Sqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 14:46:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x3TIiRuC1030790
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 29 Apr 2019 11:44:27 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x3TIiRuC1030790
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1556563469;
        bh=SpcIPw3izbUD1OBVUMxyZW5hQOacs6cWzBORRy0E9sY=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=lxcHRzsXyeVGvTbh2MqbPyVEs+3XYIiRYjtkucAEIV42AC9YbYosGINff4Di6ZQ3+
         R+Ug64KrWXgFImvVDUVCaRMxCvCnNlJS68UUdQirSP/SLgQBWCXYy3/xEx/GiFNGLH
         iIhup2uhYRD3o98CVXxqEeoOJFKxfDZCO2feUwfkgopvrAeXtS3ZA8r3pOwXjAfdrB
         uWf/8DvEXymWWPaflHfoICVJvLAbmzHcfjmLyxzrWbCuiPL8VvmcJS8McKUxMYN0IO
         23sags6AKtgFgOFD43Q+U3aekoIfOIsEQVkTlpAzKVcUWMabOBOBawy1aQjU/MCaCH
         WViU2g8NXubaA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x3TIiQno1030785;
        Mon, 29 Apr 2019 11:44:26 -0700
Date:   Mon, 29 Apr 2019 11:44:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-e7d916632b528e8cccc8e9ccca81acfc591a5fde@git.kernel.org>
Cc:     jani.nikula@linux.intel.com, rppt@linux.vnet.ibm.com,
        airlied@linux.ie, rientjes@google.com, josef@toxicpanda.com,
        tom.zanussi@linux.intel.com, adobriyan@gmail.com,
        akpm@linux-foundation.org, jthumshirn@suse.de,
        aryabinin@virtuozzo.com, agk@redhat.com,
        maarten.lankhorst@linux.intel.com, luto@kernel.org,
        rostedt@goodmis.org, cl@linux.com, daniel@ffwll.ch, clm@fb.com,
        penberg@kernel.org, mbenes@suse.cz, snitzer@redhat.com,
        dvyukov@google.com, dsterba@suse.com, m.szyprowski@samsung.com,
        jpoimboe@redhat.com, hch@lst.de, linux-kernel@vger.kernel.org,
        glider@google.com, mingo@kernel.org, akinobu.mita@gmail.com,
        catalin.marinas@arm.com, robin.murphy@arm.com, tglx@linutronix.de,
        hpa@zytor.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com
Reply-To: mbenes@suse.cz, snitzer@redhat.com, glider@google.com,
          linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
          m.szyprowski@samsung.com, hch@lst.de, dsterba@suse.com,
          dvyukov@google.com, catalin.marinas@arm.com, mingo@kernel.org,
          akinobu.mita@gmail.com, rodrigo.vivi@intel.com, hpa@zytor.com,
          joonas.lahtinen@linux.intel.com, robin.murphy@arm.com,
          tglx@linutronix.de, adobriyan@gmail.com,
          tom.zanussi@linux.intel.com, rientjes@google.com,
          josef@toxicpanda.com, jani.nikula@linux.intel.com,
          rppt@linux.vnet.ibm.com, airlied@linux.ie,
          maarten.lankhorst@linux.intel.com, agk@redhat.com,
          aryabinin@virtuozzo.com, akpm@linux-foundation.org,
          jthumshirn@suse.de, rostedt@goodmis.org, luto@kernel.org,
          penberg@kernel.org, daniel@ffwll.ch, clm@fb.com, cl@linux.com
In-Reply-To: <20190425094802.979089273@linutronix.de>
References: <20190425094802.979089273@linutronix.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:core/stacktrace] tracing: Simplify stacktrace retrieval in
 histograms
Git-Commit-ID: e7d916632b528e8cccc8e9ccca81acfc591a5fde
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

Commit-ID:  e7d916632b528e8cccc8e9ccca81acfc591a5fde
Gitweb:     https://git.kernel.org/tip/e7d916632b528e8cccc8e9ccca81acfc591a5fde
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 25 Apr 2019 11:45:13 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Mon, 29 Apr 2019 12:37:54 +0200

tracing: Simplify stacktrace retrieval in histograms

The indirection through struct stack_trace is not necessary at all. Use the
storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Reviewed-by: Josh Poimboeuf <jpoimboe@redhat.com>
Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Cc: Andy Lutomirski <luto@kernel.org>
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
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: linux-arch@vger.kernel.org
Link: https://lkml.kernel.org/r/20190425094802.979089273@linutronix.de

---
 kernel/trace/trace_events_hist.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 21ceae299f7e..a1d20421f4b0 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5186,7 +5186,6 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt = NULL;
-	struct stack_trace stacktrace;
 	struct hist_field *key_field;
 	u64 field_contents;
 	void *key = NULL;
@@ -5198,14 +5197,9 @@ static void event_hist_trigger(struct event_trigger_data *data, void *rec,
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			stacktrace.max_entries = HIST_STACKTRACE_DEPTH;
-			stacktrace.entries = entries;
-			stacktrace.nr_entries = 0;
-			stacktrace.skip = HIST_STACKTRACE_SKIP;
-
-			memset(stacktrace.entries, 0, HIST_STACKTRACE_SIZE);
-			save_stack_trace(&stacktrace);
-
+			memset(entries, 0, HIST_STACKTRACE_SIZE);
+			stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
+					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
 			field_contents = key_field->fn(key_field, elt, rbe, rec);
