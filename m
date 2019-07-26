Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D3FC7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B6DF22BE8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 21:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7QorXX0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbfGZVOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 17:14:20 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35810 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfGZVOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 17:14:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id r21so40157307qke.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 14:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qa7ViVywxiIxJWPtWZmtGq8BibVAw9i9Rh7bvc7CIgk=;
        b=i7QorXX0pZFv0rWKoJdA023bJXBN0Iq7ESi3l6XgW0Jz4Hzt8DROQ8o2/0H39uXToR
         Fv+oLBiIVvbwOi4dg/Z103X0Q7lnlxbFM+vn2SmqNeaAhj+nIet4G42OK15BW26juGGj
         0bmNI+tfgqRPK6PdLRgqPWvF+75253zYwx4Rmq95fvxt2BDWumoNKyHD5vLvY4+DqeHu
         pKTjmKCwD7z+aMaVAY5fukUC8NEJkrunt9ZQqX7vPnTHL99Mbd/a5pQ2SURicCyBrNZh
         s3r0H+/eHsCpIBpsPcqnUdpQi77+T3z9pdm0i55Wrn0V3WzNms6h+7Rg2E90pR2l6tC/
         fnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qa7ViVywxiIxJWPtWZmtGq8BibVAw9i9Rh7bvc7CIgk=;
        b=MSWQ6ot1HTYjQjHMBPGs9BTvs8L7j2Ehlpz22UPALVTpNL/alZhuSfQZwxI5ZI74YP
         ftFFWo5YKFy6GSsW2eLQg/Bf6QcD+453cSQAhGpUeNBxsxW6PFrOTLASKtZmZQNN5mON
         3aYhQqBqn5wUiMSsRbM7SYOadJn33rUnxsdM5NHZhJEnTM3trW/fuAvw0HZJ3847SsfA
         3iqhdhpahptJzpL/z+XbAcGzgdr5gVMoNoDat0lB+vGzMmoNsGIUu8axYdMUdSy9XzOC
         IOmrQeTC/UNzdXES3hx6Doggvaufd/3hMNeoPiqszO/RYhuR1+qwAGeywaTqXvDmN6kc
         IF6w==
X-Gm-Message-State: APjAAAW9SnaYlwJE4B1gq/9GO65bYSPscoRu0ELkxKR+w1VbptS/V4Sc
        W2qKNyGifT6dx6kc1MBTW58=
X-Google-Smtp-Source: APXvYqxSLDgjRaqUfzEMaULb9lZjRMr5M3MK+NEJzKWZadssVNY0ISp4BzlqH5uMziHjAUDHtmR+SQ==
X-Received: by 2002:a05:620a:15d3:: with SMTP id o19mr65040066qkm.213.1564175658807;
        Fri, 26 Jul 2019 14:14:18 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id r40sm33390843qtk.2.2019.07.26.14.14.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:14:18 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D83B640340; Fri, 26 Jul 2019 18:14:15 -0300 (-03)
Date:   Fri, 26 Jul 2019 18:14:15 -0300
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: perf: perf report stuck in an infinite loop
Message-ID: <20190726211415.GE24867@kernel.org>
References: <alpine.DEB.2.21.1907261640590.27043@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907261640590.27043@macbook-air>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jul 26, 2019 at 04:46:51PM -0400, Vince Weaver escreveu:
> 
> Currently the perf_data_fuzzer causes perf report to get stuck in an 
> infinite loop.
> 
> >From what I can tell, the issue happens in reader__process_events()
> when an event is mapped using mmap(), but when it goes to process the
> event finds out the internal event header has the size (invalidly) set to 
> something much larger than the mmap buffer size.  This means 
> fetch_mmaped_event() fails, which gotos remap: which tries again with
> the exact same mmap size, and this will loop forever.
> 
> I haven't been able to puzzle out how to fix this, but maybe you have a 
> better feel for what's going on here.

Perhaps the patch below?

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 37efa1f43d8b..f670c028f84b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
 #include <inttypes.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
 #include <traceevent/event-parse.h>
@@ -1954,7 +1955,7 @@ fetch_mmaped_event(struct perf_session *session,
 		/* We're not fetching the event so swap back again */
 		if (session->header.needs_swap)
 			perf_event_header__bswap(&event->header);
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	return event;
@@ -1972,6 +1973,9 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 	while (decomp->head < decomp->size && !session_done()) {
 		union perf_event *event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
 
+		if (IS_ERR(event))
+			return PTR_ERR(event);
+
 		if (!event)
 			break;
 
@@ -2071,6 +2075,9 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 
 more:
 	event = fetch_mmaped_event(session, head, mmap_size, buf);
+	if (IS_ERR(event))
+		return PTR_ERR(event);
+
 	if (!event) {
 		if (mmaps[map_idx]) {
 			munmap(mmaps[map_idx], mmap_size);
