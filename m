Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706EC0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14CB2189E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 18:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcrCBtv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfGCSqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 14:46:53 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36513 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbfGCSqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 14:46:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so3663496qkl.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lxu8VUMKdHDWmo8g651uclV2QTSciyGC6y+pb/rVSnA=;
        b=LcrCBtv0ZLyYgyWByF03aD3dLFbITDwQ1iSk30xGE3IhRzWt5t1cWtvKTGuSak9Ac1
         quTV3uebdg2gbweRYhm/FLETgusswD3ACUx5Jp7wyeDzi/4MgZJI5nQNtHzYXmGViOLA
         1aD4NTa7kMGsGryyYAfTMCyd7CcCDAXDjiZJhPjjR1xSm/5lAVeSJFEjJZapJfQfTVAn
         rkKPnVnzu8UZgRolZzWrcKM3QWca9yP4REnXyY9uqXM6p5fSTHmoK3sI0rQRRZUjcsRD
         EtYmCcEKrC6pWoGvdbTsC5Zgu4IcSDW2fq4MbgFGwlID1ZWslqA795FQevvT0yvubwLu
         wBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lxu8VUMKdHDWmo8g651uclV2QTSciyGC6y+pb/rVSnA=;
        b=IgnQfNsHpLxaS4b9+WzuIkT+ApZ9Aqk4flLQ1/bYsK/88zjmeQtKtMupibHAJZ+LiX
         J3sDjrNSAlVV2h43QRHbRuRl6C4eF2i2Nbnhilj86SCPeenrK4PiTd2AQk7PDtZSLCWB
         FOddjB6vadMCaqHW0U68tVwEg6i65Sv1zFBjbCboSRLnxuGBkG0V8OC4tMT9fGs3IRSy
         SVzXEfwsom1cyNi3WkJKVhQvFuix/JXSDvGTX3Co+NS0x2AdMGC7u2SZZ2S9Uk3Bb1IY
         0zTztuqBYvUOsHtp43HyLnun4G+ydoRXUu5FUNBgg657AZ1XHNvu9LMc02fClfic2qZF
         iAYg==
X-Gm-Message-State: APjAAAUSnKmFn9mgn9JTJu8eIuFH6JxJrgDhQdz/8iG0kMT9uViljjWf
        2QbWcdkd34MAGN7R/JWuI5s=
X-Google-Smtp-Source: APXvYqzDpt++1yhZV/LZqaA/Mo161b2L7HhcxUJ5L6Nvz8+pmH1ZynDUyuCrcHkK0BTItHD+miOUTw==
X-Received: by 2002:a37:4dc6:: with SMTP id a189mr31364013qkb.41.1562179611820;
        Wed, 03 Jul 2019 11:46:51 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.209.182])
        by smtp.gmail.com with ESMTPSA id u7sm1402263qta.82.2019.07.03.11.46.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 11:46:51 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CAA0141154; Wed,  3 Jul 2019 15:46:06 -0300 (-03)
Date:   Wed, 3 Jul 2019 15:46:06 -0300
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 05/11] perf trace: Smatch: Fix potential NULL pointer
 dereference
Message-ID: <20190703184606.GF10740@kernel.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
 <20190702103420.27540-6-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190702103420.27540-6-leo.yan@linaro.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 02, 2019 at 06:34:14PM +0800, Leo Yan escreveu:
> Based on the following report from Smatch, fix the potential
> NULL pointer dereference check.
> 
>   tools/perf/builtin-trace.c:1044
>   thread_trace__new() error: we previously assumed 'ttrace' could be
>   null (see line 1041).
> 
> tools/perf/builtin-trace.c
> 1037 static struct thread_trace *thread_trace__new(void)
> 1038 {
> 1039         struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
> 1040
> 1041         if (ttrace)
> 1042                 ttrace->files.max = -1;
> 1043
> 1044         ttrace->syscall_stats = intlist__new(NULL);
>              ^^^^^^^^
> 1045
> 1046         return ttrace;
> 1047 }
> 
> This patch directly returns NULL when fail to allocate memory for
> ttrace; this can avoid potential NULL pointer dereference.

I did it slightly different, to avoid having two return lines, and that
is what most other constructors (foo__new()) do in tools/perf/, kept
your changeset comment and patch authorship, thanks.

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d0eb7224dd36..e3fc9062f136 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1038,10 +1038,10 @@ static struct thread_trace *thread_trace__new(void)
 {
 	struct thread_trace *ttrace =  zalloc(sizeof(struct thread_trace));
 
-	if (ttrace)
+	if (ttrace) {
 		ttrace->files.max = -1;
-
-	ttrace->syscall_stats = intlist__new(NULL);
+		ttrace->syscall_stats = intlist__new(NULL);
+	}
 
 	return ttrace;
 }
