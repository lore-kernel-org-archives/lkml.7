Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E5DC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC75320657
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkssBhC+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfCFUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:53:47 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40555 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbfCFUxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 15:53:47 -0500
Received: by mail-qt1-f195.google.com with SMTP id j36so14560429qta.7;
        Wed, 06 Mar 2019 12:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l99MLJomUwenhlUTWjjaor/4tVQ4rgdHkT5ChzA3iBw=;
        b=fkssBhC+ejpfnTHSXHJNTlcefCd0aJgHrEtDxWqovGzU32jLO3iJbBr1zYRkwavGCe
         3C208xMC2sDQ4AvDmOTuDize4yR92GpIVFrC44ocAG96Y4g+wDuguxgDIsJQs7D5CQdk
         LOAs3i/mVAcOn5SAyPtVgraX60cX9680IN9nnFMJujpFthokhRD3Mu+dtvvx1D3HjF/0
         hzAxEzz52Duo0Ze+rSYOb1oxo2oocZCIqU4zkgQeYJ0Pd9TqPUNtar5LaXIg019CgkFb
         TvvNTNMg2B9sSsheugCy8ljUkC0bVkTmf50i6OTMEuX0JQg1yLyJsn9BXzS1rcaZJoOG
         gPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l99MLJomUwenhlUTWjjaor/4tVQ4rgdHkT5ChzA3iBw=;
        b=l2T5DHqRk0OWi4UbyHhvGk4S/tRtBbfg5j2CywUOq7C0EVlr2z4Xsu3Nf7T8pEcysY
         o7lKkdJsd+LjTAnO3+c/6QY9mg/EidkNhdc2jW0YdUvLFdLUsQti+mG34045FeaIlSD1
         BpZwpJTgd6uJcEuGtI5RZKSJwwBbKXDxLJK0FM4NRjFMlVNEGuJqai8OyvEP0op21ZXt
         4SRabyl75+2IxWo1zKUTXnMwGEkKKPwZQC4pIChdH4ZAjiYccaBl3jPeKQ2exBEb4jRJ
         ttZuP5dck0aMzK50fwuvWDvPh30bdsJOY5ZUeBwQBFxOKZeyTVRgoYgPGWOqUIZUEJqW
         44gA==
X-Gm-Message-State: APjAAAXTlXhiqI53gpckwMvCX6nBo9MpnqQDS05oRp44r6rcZB0RTUyr
        Y2KrElsxqQn0JKm3i2cUDfbM/HRs
X-Google-Smtp-Source: APXvYqyuh3gpW72SnGxB2/GcHfvz7+O7fCqr4SX8XAnmfr4kOHtCuQ7yLbakXsjAoz+MwxdPcYGL4g==
X-Received: by 2002:ac8:1754:: with SMTP id u20mr7310407qtk.190.1551905625722;
        Wed, 06 Mar 2019 12:53:45 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id 81sm1426072qkg.75.2019.03.06.12.53.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 12:53:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 711164039C; Wed,  6 Mar 2019 17:53:37 -0300 (-03)
Date:   Wed, 6 Mar 2019 17:53:37 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 01/15] perf tools: Add utility function to fetch
 executable
Message-ID: <20190306205337.GK30734@kernel.org>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190305144758.12397-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 05, 2019 at 06:47:44AM -0800, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Add a utility function to fetch executable code. Convert one
> user over to it. There are more places doing that, but they
> do significantly different actions, so they are not
> easy to fit into a single library function.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/util/Build       |  1 +
>  tools/perf/util/fetch.c     | 28 ++++++++++++++++++++++++++++
>  tools/perf/util/fetch.h     |  7 +++++++
>  tools/perf/util/intel-bts.c | 21 +++------------------
>  4 files changed, 39 insertions(+), 18 deletions(-)
>  create mode 100644 tools/perf/util/fetch.c
>  create mode 100644 tools/perf/util/fetch.h

So I've made some changes and the end result is below, will fixup the
following patches, holler if you find any problems:

Changes:

. No need to cast around, make 'buf' be a void pointer

. Rename it to thread__memcpy() to reflect the fact it is about copying
  a chunk of memory from a thread, i.e. from its address space.

. No need to have it in a separate object file, move it to thread.[ch]

. Check the return of map__load(), the original code didn't do it, but
  since we're moving this around, check that as well, could be moved to
  a separate patch tho.

- Arnaldo

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 0c0180c67574..47025bc727e1 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -328,35 +328,19 @@ static int intel_bts_get_next_insn(struct intel_bts_queue *btsq, u64 ip)
 {
 	struct machine *machine = btsq->bts->machine;
 	struct thread *thread;
-	struct addr_location al;
 	unsigned char buf[INTEL_PT_INSN_BUF_SZ];
 	ssize_t len;
-	int x86_64;
-	uint8_t cpumode;
+	bool x86_64;
 	int err = -1;
 
-	if (machine__kernel_ip(machine, ip))
-		cpumode = PERF_RECORD_MISC_KERNEL;
-	else
-		cpumode = PERF_RECORD_MISC_USER;
-
 	thread = machine__find_thread(machine, -1, btsq->tid);
 	if (!thread)
 		return -1;
 
-	if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso)
-		goto out_put;
-
-	len = dso__data_read_addr(al.map->dso, al.map, machine, ip, buf,
-				  INTEL_PT_INSN_BUF_SZ);
+	len = thread__memcpy(thread, machine, buf, ip, INTEL_PT_INSN_BUF_SZ, &x86_64);
 	if (len <= 0)
 		goto out_put;
 
-	/* Load maps to ensure dso->is_64_bit has been updated */
-	map__load(al.map);
-
-	x86_64 = al.map->dso->is_64_bit;
-
 	if (intel_pt_get_insn(buf, len, x86_64, &btsq->intel_pt_insn))
 		goto out_put;
 
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 4c179fef442d..50678d318185 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -12,6 +12,7 @@
 #include "debug.h"
 #include "namespaces.h"
 #include "comm.h"
+#include "map.h"
 #include "symbol.h"
 #include "unwind.h"
 
@@ -393,3 +394,25 @@ struct thread *thread__main_thread(struct machine *machine, struct thread *threa
 
 	return machine__find_thread(machine, thread->pid_, thread->pid_);
 }
+
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit)
+{
+       u8 cpumode = PERF_RECORD_MISC_USER;
+       struct addr_location al;
+       long offset;
+
+       if (machine__kernel_ip(machine, ip))
+               cpumode = PERF_RECORD_MISC_KERNEL;
+
+       if (!thread__find_map(thread, cpumode, ip, &al) || !al.map->dso ||
+	   al.map->dso->data.status == DSO_DATA_STATUS_ERROR ||
+	   map__load(al.map) < 0)
+               return -1;
+
+       offset = al.map->map_ip(al.map, ip);
+       if (is64bit)
+               *is64bit = al.map->dso->is_64_bit;
+
+       return dso__data_read_offset(al.map->dso, machine, offset, buf, len);
+}
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 8276ffeec556..cf8375c017a0 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -113,6 +113,9 @@ struct symbol *thread__find_symbol_fb(struct thread *thread, u8 cpumode,
 void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 					struct addr_location *al);
 
+int thread__memcpy(struct thread *thread, struct machine *machine,
+		   void *buf, u64 ip, int len, bool *is64bit);
+
 static inline void *thread__priv(struct thread *thread)
 {
 	return thread->priv;
