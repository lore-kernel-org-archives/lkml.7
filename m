Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2B7CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4ABA20874
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 11:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbvw6A61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfJ3LuK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 07:50:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37578 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfJ3LuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 07:50:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id g50so2780703qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 04:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wlKcSgJ6VIQSbi39vhT5J2AzL3oGEIyJc9PzAltSPGo=;
        b=sbvw6A61OB/VcVQ1WXmwGSfwG+eyG5H621Qu9Ep1IsUVaV/BKFkSFjWoWNcIUQXiL2
         0EYlX9u/VhT9bhtiIvB7QzAmT6P49Soyu1xBMKXKXtL2p6tKZQVDKUMa4Fevn935piNn
         Xz8PLdxnFelulwnePIRMVCxZzL/Y4yuMAkueDnBIpcRxtS5ENvchKnZ78/iPNAMSGaE8
         irhnmugLQttal6XV8xbQAkglqAEqLXdHQhVunHwBNneqnrJ3bf6gTyZCu4U5f6NPW99q
         Ce7U48Zbl5q+eYT8aAPr43WaIBsh4Iz2e+LmlY39RIWeSUea5v3ebqP284pFQv9gsw8o
         Jn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wlKcSgJ6VIQSbi39vhT5J2AzL3oGEIyJc9PzAltSPGo=;
        b=JQCRtcnyqwzhkWfVL0FgqGmLePkVgPmZpXyNOl2c88ug/PJfUAEgCCaIdLboblmLEW
         GzCBGsMVlfG+fuoBQ1Luz4cf3rFNEcIYPrUG4oexETAuMV1gfSMWWlORdyE7HvbZux2f
         pgyqxNzEojF+apClLyi+pBkWJkAYwGmcNmlbFS6+SgDIfVgQPH7IKtjrafPELYwTBh9/
         +4SbZ6EEvwKHccoscPBPm6rLYlI/bY7VL/BlkQvGi+Ia4lWKpnwuG8gxRoF1PImHAM4f
         7Dd7e9y5sPcU1mW1lQ5xTqmkYwQd4Zy/sbpOq5kffswNObGxJUOMtKAGMKfU9nhg+vC3
         sB4A==
X-Gm-Message-State: APjAAAUo/VSnRuaEgfvhKLh9rMk6T0u5kBnVb1rzy2H+JTy1sxCI+/wK
        ngPTvVtwOVFYM5q1J77NorY=
X-Google-Smtp-Source: APXvYqx8kjcxMgyfSy07YXWCvULVjQvODvD3G2pSUhGXmIEVuaJMcYWSXpodGAfbRnZuk75gK35YSQ==
X-Received: by 2002:ac8:29a5:: with SMTP id 34mr4350641qts.56.1572436207998;
        Wed, 30 Oct 2019 04:50:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id 50sm1279938qtv.88.2019.10.30.04.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 04:50:07 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6EF8F410D7; Wed, 30 Oct 2019 08:50:04 -0300 (-03)
Date:   Wed, 30 Oct 2019 08:50:04 -0300
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Chandan Rajendra <chandanrlinux@gmail.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, rostedt@goodmis.org, tstoyanov@vmware.com,
        gregkh@linuxfoundation.org, kstewart@linuxfoundation.org,
        tglx@linutronix.de, chandan@linux.ibm.com
Subject: Re: [PATCH] perf script: Fix obtaining next event
Message-ID: <20191030115004.GA27327@kernel.org>
References: <20191030084032.31503-1-chandanrlinux@gmail.com>
 <0befd460-b9bf-ba2b-556a-aa06798b16b9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0befd460-b9bf-ba2b-556a-aa06798b16b9@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 30, 2019 at 03:16:10PM +0530, Ravi Bangoria escreveu:
> 
> 
> On 10/30/19 2:10 PM, Chandan Rajendra wrote:
> > The current code segfaults when perf.data file contains two or more
> > events. This happens due to incorrect pointer arithmetic being performed
> > in trace_find_next_event().
> > 
> > tep_handle->events is an array of pointers to 'struct tep_event'. The
> > pointer arithmetic interprets tep_handle->events as an array of 'struct
> > tep_event' elements.
> > 
> > This commit replaces the usage of pointer arithmetic with calls to
> > tep_get_event().
> > 
> > Fixes: bb3dd7e ("tools lib traceevent, perf tools: Move struct tep_handler definition in a local header file")
> > Signed-off-by: Chandan Rajendra <chandanrlinux@gmail.com>
> 
>   $ sudo ./perf record -e sched:sched_switch -e syscalls:sys_enter_openat -- make
> 
> Without patch:
>   $ sudo ./perf script -g python
>   Segmentation fault
> 
> With patch:
>   $ sudo ./perf script -g python
>   generated Python script: perf-script.py
> 
> Reviewed-and-tested-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>

This was fixed already in perf/core, by Steven:

commit 9bdff5b6436655d42dd30253c521e86ce07b9961
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Oct 17 17:05:23 2019 -0400

    perf tools: Remove unused trace_find_next_event()

    trace_find_next_event() was buggy and pretty much a useless helper. As
    there are no more users, just remove it.

    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
    Cc: linux-trace-devel@vger.kernel.org
    Link: http://lore.kernel.org/lkml/20191017210636.224045576@goodmis.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

commit a5e05abc6b8d81148b35cd8632a4a6252383d968
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Thu Oct 17 17:05:22 2019 -0400

    perf scripting engines: Iterate on tep event arrays directly

    Instead of calling a useless (and broken) helper function to get the
    next event of a tep event array, just get the array directly and iterate
    over it.

    Note, the broken part was from trace_find_next_event() which after this
    will no longer be used, and can be removed.

    Committer notes:

    This fixes a segfault when generating python scripts from perf.data
    files with multiple tracepoint events, i.e. the following use case is
    fixed by this patch:

      # perf record -e sched:* sleep 1
      [ perf record: Woken up 31 times to write data ]
      [ perf record: Captured and wrote 0.031 MB perf.data (9 samples) ]
      # perf script -g python
      Segmentation fault (core dumped)
      #

    Reported-by: Daniel Bristot de Oliveira <bristot@redhat.com>
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Jiri Olsa <jolsa@redhat.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Tzvetomir Stoyanov <tstoyanov@vmware.com>
    Cc: linux-trace-devel@vger.kernel.org
    Link: http://lkml.kernel.org/r/20191017153733.630cd5eb@gandalf.local.home
    Link: http://lore.kernel.org/lkml/20191017210636.061448713@goodmis.org
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
