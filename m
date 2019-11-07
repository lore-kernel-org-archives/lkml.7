Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD97C5DF60
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318602087E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 11:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnsaizJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbfKGLOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 06:14:03 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46302 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbfKGLOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 06:14:02 -0500
Received: by mail-qt1-f196.google.com with SMTP id u22so1903141qtq.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 03:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lyoKYhruCXtXlSxyKmofty3V/5Ux1OewKAWp0cBjjOk=;
        b=SnsaizJEVn4hd48OZGCHcsXB0TloFYJUE4Vgp7rsMS5PXFGs0P6wFzXlDZO0Eu0SDb
         hHSKxt0uu9EqFCbk5Y0S+yh8eweYJPR1bauYyh8lsDHj+wa8afwsTuSDk1Fj8GA850LK
         XrLMp40TmO/TfvdI15UuOrsdl5MMScvkz+gpR3DUiGazQAgOUXj+47ofSu5l3PlYcwaB
         GQTr48MfnrIrTBoRwA2uoZrYoPp3909UJBG966z0tmAGqNolAFVVguk0+FCjrEH3Qj9e
         VadllTvF02ehjzIpPli3aKiOxR2UuBhWLgv1Bao4w77tdISNBtWhmWq5VH7TCsr3mXZd
         6EHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lyoKYhruCXtXlSxyKmofty3V/5Ux1OewKAWp0cBjjOk=;
        b=i6e9fTBVq9XN+jFBxpOyNAIz5lBN3CH4bB7vtas6CkSZuVItdP9vVjqraOaDrmIEWW
         +iuKbhylwnm2bbKNYJnXYUB4KN55tP1im6+KelltFZYgzsYopA6x+idwF6Zr24wSEg+h
         SzOnHxuxXq3fLHVcpDk2RAJqB11YgY60Gd4i1dgXAklE8394dSw6ttWaWfKAKeSlcujq
         P75ooykfxOZn55p8+brMt58flqDQroYnvSNgDxks7ShE6dbW1cwscQkYOD5XPKsLYIfF
         MaBV0um3wRpjtkjJUUjznyNEy/JQEHy9CRgXVu9H/vRrtPd7GU+2lMXFSubn/YTDREqe
         V5Zw==
X-Gm-Message-State: APjAAAU7PDjMkA/xTpkqfHZUoX4Od6X7j8TG9WYBhhPyD7IqH0YpNi2R
        CEhk0ioiFJM9cD72eRmAAlo=
X-Google-Smtp-Source: APXvYqwySJ0cAy6fjP1KY1LxLGYyLu4llKd5Zo/VrArJm+A4Z19vLVn9LHxTuMtCzXBCxcrAIYyQ+g==
X-Received: by 2002:ac8:1814:: with SMTP id q20mr3216882qtj.38.1573125239942;
        Thu, 07 Nov 2019 03:13:59 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id o13sm1026814qto.96.2019.11.07.03.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 03:13:58 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7910A40B1D; Thu,  7 Nov 2019 08:13:56 -0300 (-03)
Date:   Thu, 7 Nov 2019 08:13:56 -0300
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     jsun4 <jiwei.sun@windriver.com>, acme@redhat.com,
        arnaldo.melo@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
        namhyung@kernel.org, a.p.zijlstra@chello.nl,
        adrian.hunter@intel.com, Richard.Danter@windriver.com,
        jiwei.sun.bj@qq.com
Subject: Re: [PATCH v5] perf record: Add support for limit perf output file
 size
Message-ID: <20191107111356.GA23651@kernel.org>
References: <20191022080901.3841-1-jiwei.sun@windriver.com>
 <20191101081300.GA2172@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101081300.GA2172@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Nov 01, 2019 at 09:13:00AM +0100, Jiri Olsa escreveu:
> On Tue, Oct 22, 2019 at 04:09:01PM +0800, jsun4 wrote:
> > The patch adds a new option to limit the output file size, then based
> > on it, we can create a wrapper of the perf command that uses the option
> > to avoid exhausting the disk space by the unconscious user.
> > 
> > In order to make the perf.data parsable, we just limit the sample data
> > size, since the perf.data consists of many headers and sample data and
> > other data, the actual size of the recorded file will bigger than the
> > setting value.
> > 
> > Testing it:
> > 
> >  # ./perf record -a -g --max-size=10M
> >  Couldn't synthesize bpf events.
> >  [ perf record: perf size limit reached (10249 KB), stopping session ]
> >  [ perf record: Woken up 32 times to write data ]
> >  [ perf record: Captured and wrote 10.133 MB perf.data (71964 samples) ]
> > 
> >  # ls -lh perf.data
> >  -rw------- 1 root root 11M Oct 22 14:32 perf.data
> > 
> >  # ./perf record -a -g --max-size=10K
> >  [ perf record: perf size limit reached (10 KB), stopping session ]
> >  Couldn't synthesize bpf events.
> >  [ perf record: Woken up 0 times to write data ]
> >  [ perf record: Captured and wrote 1.546 MB perf.data (69 samples) ]
> > 
> >  # ls -l perf.data
> >  -rw------- 1 root root 1626952 Oct 22 14:36 perf.data
> > 
> > Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
> > ---
> > v5 changes:
> >   - Change the output format like [ perf record: perf size limit XX ]
> >   - change the killing perf way from "raise(SIGTERM)" to set "done == 1"
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

So, had to add this on top to fix the build on multiple building
environments, rec->bytes_written is an u64, so we must use PRIu64 or
else get errors like:

  builtin-record.c: In function 'record__write':
  builtin-record.c:150:5: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Werror=format=]
       rec->bytes_written >> 10);
       ^
    CC       /tmp/build/pe


- Arnaldo

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index b9ddfcda9611..b95c000c1ed9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -145,7 +145,7 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 	rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
-		fprintf(stderr, "[ perf record: perf size limit reached (%lu KB),"
+		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
 				" stopping session ]\n",
 				rec->bytes_written >> 10);
 		done = 1;
