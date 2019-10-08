Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE88C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD21720679
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 12:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lsDzesG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbfJHMcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 08:32:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56052 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730866AbfJHMcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 08:32:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2937707wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 05:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=shR49NxmVmRzjTPJaHTivjYNGPE5YJPsxJZdgJY6iQM=;
        b=lsDzesG1tUV5boM2JpKkMBg+IFseYB8gNMB/2z51TmpVZtOsSvY9QoCHAHg2xVLTHz
         4L/OzMarSv26biZjm6lJTIIUKbzUqcC+DISaetXJ+5TQhuxKrUPVujtlT8A8Yptd9Im6
         m1XyUCPUkSk1YNzzRWR5e6sn/FlcnhsfWaL7i11yGRo5qt1+a1KGJM++DpPtShOoN7q/
         pHsKNRT7WDiUb+8VUBO4W564RWtu19UZ0RJOo83T7Bzz4gi7DQfUVnUdqwjoHycTDLKK
         cwL0Suha/Ii7w5pamlrveXOVzlUWtl8o6a/V5pORIDIj4w/4DT0VViYdoTgC3hQLbgWC
         akjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=shR49NxmVmRzjTPJaHTivjYNGPE5YJPsxJZdgJY6iQM=;
        b=Jwq69196cWCX1WPai10Flea1v8/0fUukcata0+3HFNnY5w+363hSvkDXOjOybN/rYr
         hVFE1fBbPDdHAwHQx5rh02XLJ9FCTsyLSIKM/B7n5O+OHePrpFlTYfc3zeZqDKMH/IuH
         Ig5V+Mbjq0uXRpkFXMmqg0hbqGRWoUYZryeF1B+/16Tpt29BVLtpi8z3IuqlFeva6Ewg
         jsBhrxRGKKfotoYytVY6Ud5HMBdHf3XlwRsRYD8MYX8KRdK4+T57l9igtkn8adqUuBrh
         FPmxrrzeit82FT35cD2pGsv0Eli+S2hOwd3eA98LifSc4weV8OrxouECp+BwRCqonFe0
         vICw==
X-Gm-Message-State: APjAAAVQ8p3scyyUWrjjOQXdjfDnw8pY0Bem9yZvAmCYQZI4uHLKVSlu
        Z81C+qBYeV3aB/+kg/ok4hU=
X-Google-Smtp-Source: APXvYqyt+SKerakwgnZgEgOsqSfWxhWKoeWLeDJsl5D4yFOTKVeXhAt6PaLtVToSGevP9GB607auBQ==
X-Received: by 2002:a1c:8189:: with SMTP id c131mr3601513wmd.151.1570537931475;
        Tue, 08 Oct 2019 05:32:11 -0700 (PDT)
Received: from mail.google.com ([104.238.174.53])
        by smtp.gmail.com with ESMTPSA id z5sm32094249wrs.54.2019.10.08.05.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 05:32:10 -0700 (PDT)
Date:   Tue, 8 Oct 2019 20:32:02 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] perf: add support for logging debug messages to
 file
Message-ID: <20191008123201.qk5yfeys4ahpjopp@mail.google.com>
References: <20191004023954.1116-1-changbin.du@gmail.com>
 <20191007112624.GG6919@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007112624.GG6919@krava>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2019 at 01:26:24PM +0200, Jiri Olsa wrote:
> On Fri, Oct 04, 2019 at 10:39:52AM +0800, Changbin Du wrote:
> > When in TUI mode, it is impossible to show all the debug messages to
> > console. This make it hard to debug perf issues using debug messages.
> > This patch adds support for logging debug messages to file to resolve
> > this problem.
> > 
> > v3:
> >   o fix a segfault issue.
> 
> heya,
> getting segfault for this:
> 
> [jolsa@krava perf]$ ./perf report -vv 2>out
> Segmentation fault (core dumped)
>
This can be fixed by below change. In this case, log_file is NULL.

--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -37,8 +37,10 @@ int veprintf(int level, int var, const char *fmt, va_list args)
        if (var >= level) {
                if (use_browser >= 1 && !log_file)
                        ui_helpline__vshow(fmt, args);
-               else
+               else if (log_file)
                        ret = vfprintf(log_file, fmt, args);
+               else
+                       ret = vfprintf(stderr, fmt, args);
        }
 
        return ret;



> jirka
> 
> > v2:
> >   o specific all debug options one time.
> > 
> > Changbin Du (2):
> >   perf: support multiple debug options separated by ','
> >   perf: add support for logging debug messages to file
> > 
> >  tools/perf/Documentation/perf.txt |  15 ++--
> >  tools/perf/util/debug.c           | 124 +++++++++++++++++++-----------
> >  2 files changed, 90 insertions(+), 49 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 

-- 
Cheers,
Changbin Du
