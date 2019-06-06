Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E56C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB912053B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 20:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8L4iSF+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728408AbfFFUId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 16:08:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42004 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbfFFUIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 16:08:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so4193471qtk.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 13:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jwTK+3qegEhCDQurHdthlAfm2HEBzC8AuSyBQLKd0wk=;
        b=H8L4iSF+E2yUjaostn80V+PTJwCs4985ILG/iUE8G8MAQFgutoft9xTOgmh3LkgoZg
         MxeHzjh74gwAxDs+kaIdTf7lPHIsCFVG/WFx9Lj9+1hwH1hrbcTpgowl4QjggfKJSPWo
         IFF4gUt1kRTBBjLvk1335FeW3GY+w5U8xPFfLCCQesUe8N7qoeK2TMMhOrYSV35+VkgF
         eM1xNesr6om0gKoxHrzBllUzxHou16EOyjEn/DvWf18w6hYZKqyXt+1Yncg0ratARY7+
         ezIrnQD3XpAbv5GGpRxffJhtbcdSGlXVn2AQEwD+FYu/sbi+Y/Ka7us873+xFx+NlEla
         I6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jwTK+3qegEhCDQurHdthlAfm2HEBzC8AuSyBQLKd0wk=;
        b=jnmTWHPeJCd4or0A4jCoOEQjmUMPf0EhvgS/Kr3r++Q24sLKdkrX2W9xxhF7neR5bi
         xsPkWlBR8RfMpE0wAtPHfCOkgkPQ/FxJHfjYhVEDPoZBW58YeHvcR20Rb6sQ1KlqrgHt
         5H02qeL4DGXeb+d1uKW5ljIg8lSB2fbIxyhexZ76h76ZqBUGCeJ6hg37OnQ7KvNBBmQz
         sWlOHw8mmtEWQJ0pnHu7pjn6WNJgCvhDzpbaCq732YR6vpww3h2rvP4u9pB5h8ZssTdx
         DCvy6ol2Z1ehQbv2MhSWIRn/C2FE5OvLdCdWqa+I6Rs6aOS0jFyeEAU8vhgPJcyjgcNF
         x8XQ==
X-Gm-Message-State: APjAAAXJ36D8FLj8yFxvEm7v44ioch9yMoTnjzUOjhVaHGu/8Alrq8gq
        20QbVM/3RZ6vtthVxKZ+JBaFT1zQ
X-Google-Smtp-Source: APXvYqzbYDHqOqfJ82EpXUuPmNBKsleJduxlFIXw/9ogHPCdjHAyz7ghvCMgcsoIEzWUhBv6akg5gg==
X-Received: by 2002:aed:39e5:: with SMTP id m92mr42823372qte.106.1559851711219;
        Thu, 06 Jun 2019 13:08:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id a139sm1375648qkb.48.2019.06.06.13.08.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 06 Jun 2019 13:08:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 87B6C41149; Thu,  6 Jun 2019 17:08:26 -0300 (-03)
Date:   Thu, 6 Jun 2019 17:08:26 -0300
To:     kan.liang@linux.intel.com
Cc:     jolsa@kernel.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        ak@linux.intel.com
Subject: Re: [PATCH V3 2/5] perf header: Add die information in CPU topology
Message-ID: <20190606200826.GI21245@kernel.org>
References: <1559688644-106558-1-git-send-email-kan.liang@linux.intel.com>
 <1559688644-106558-2-git-send-email-kan.liang@linux.intel.com>
 <20190606191210.GG21245@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606191210.GG21245@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 06, 2019 at 04:12:10PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Jun 04, 2019 at 03:50:41PM -0700, kan.liang@linux.intel.com escreveu:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > With the new CPUID.1F, a new level type of CPU topology, 'die', is
> > introduced. The 'die' information in CPU topology should be added in
> > perf header.
> > 
> > To be compatible with old perf.data, the patch checks the section size
> > before reading the die information. The new info is added at the end of
> > the cpu_topology section, the old perf tool ignores the extra data.
> > It never reads data crossing the section boundary.
> > 
> > The new perf tool with the patch can be used on legacy kernel. Add a
> > new function has_die_topology() to check if die topology information is
> > supported by kernel. The function only check X86 and CPU 0. Assuming
> > other CPUs have same topology.
> 
> You're changing the header, how would a new tool handle an old perf.data
> where this 'die_id' is not present? What about an old tool dealing with
> a perf.data with this die_id?
> 
> I couldn't see any provision for that, am I missing something?
> 
> /me goes to read tools/perf/util/cputopo.c ...
> 
> Yeah, its just the description on the perf.data doc file that confused
> me, I'll clarify that after finishing reviewing/applying this patchkit.

So I have this on top, please check.

- Arnaldo

commit a9396a70fc7101c108e1c91fa1771557bbbb57a1
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Jun 6 17:03:18 2019 -0300

    perf data: Fix perf.data documentation for HEADER_CPU_TOPOLOGY
    
    The 'die' info isn't in the same array as core and socket ids, and we
    missed the 'dies' string list, that comes right after the 'core' +
    'socket' id variable length array, followed by the VLA for the dies.
    
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Jiri Olsa <jolsa@kernel.org>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Fixes: c9cb12c5ba08 ("perf header: Add die information in CPU topology")
    Link: https://lkml.kernel.org/n/tip-nubi6mxp2n8ofvlx7ph6k3h6@git.kernel.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/Documentation/perf.data-file-format.txt b/tools/perf/Documentation/perf.data-file-format.txt
index de78183f6881..5f54feb19977 100644
--- a/tools/perf/Documentation/perf.data-file-format.txt
+++ b/tools/perf/Documentation/perf.data-file-format.txt
@@ -151,20 +151,35 @@ struct {
 
 	HEADER_CPU_TOPOLOGY = 13,
 
-String lists defining the core and CPU threads topology.
-The string lists are followed by a variable length array
-which contains core_id, die_id (for x86) and socket_id of each cpu.
-The number of entries can be determined by the size of the
-section minus the sizes of both string lists.
-
 struct {
+	/*
+	 * First revision of HEADER_CPU_TOPOLOGY
+	 *
+	 * See 'struct perf_header_string_list' definition earlier
+	 * in this file.
+	 */
+
        struct perf_header_string_list cores; /* Variable length */
        struct perf_header_string_list threads; /* Variable length */
+
+       /*
+        * Second revision of HEADER_CPU_TOPOLOGY, older tools
+        * will not consider what comes next
+        */
+
        struct {
 	      uint32_t core_id;
-	      uint32_t die_id;
 	      uint32_t socket_id;
        } cpus[nr]; /* Variable length records */
+       /* 'nr' comes from previously processed HEADER_NRCPUS's nr_cpu_avail */
+
+        /*
+	 * Third revision of HEADER_CPU_TOPOLOGY, older tools
+	 * will not consider what comes next
+	 */
+
+	struct perf_header_string_list dies; /* Variable length */
+	uint32_t die_id[nr_cpus_avail]; /* from previously processed HEADER_NR_CPUS, VLA */
 };
 
 Example:
