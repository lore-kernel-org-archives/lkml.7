Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B00C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880852075C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 19:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUoVPtse"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfCSTO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 15:14:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43678 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbfCSTO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 15:14:58 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so23487004qtc.10;
        Tue, 19 Mar 2019 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pmu6sJRjWyAJbK62xgndsOFf8NmipejuVSIwuHcv4kE=;
        b=YUoVPtseHdzz5vLYcTPHpr2RlHnQ3xKg4qP4vO93ljZlAAMVTU+S59vgl9mCEmdmcg
         mOwcEpel67ycgJwpstWcrP7nmWskplMQcbr8bl+vh3uBAXs62dIc07aU6uVPMiHFO81+
         DwlZq6Cl764R9ki9gm6x3+8lerMOXQSzHBJikDiK8oFlNGEu1MG7IW9dsnMkVF9rU/e7
         YtLhQpm8bx102iqUV6aX1mk+sEhvQXg5CfIJ0GDdARb0ttFG9ZDkYrjb/55dzr9Fwl6e
         ZrINz3bT1rd9x1p1nMWoqwgEkZMRhBNiM0uXEpQIo6QjDEZjw//P2167uroExAgohEKw
         0nPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pmu6sJRjWyAJbK62xgndsOFf8NmipejuVSIwuHcv4kE=;
        b=RSk1V/zncTkLjVn7jQtoGqr8DLiAy8Zdg9+I0eeic9v1jiRCSbyE7xP1Egw9660UNA
         UVrALQoRwIMQ03Y4VFMZBQ8MYaD7HmcYyUqyV+dDqUf00veWUtdevj4bnSDnlsUlK4rz
         WjGf/xARRoiSCuzL4lHvxvL9S+Fq2Jt/uXlayC9B2zjTSyJIxlnDQXTEDFBr6ypmFGF5
         Ie4EFLZPsiougJAdOsptCXt1Afhhu0JCxV/L4D548mZLdAPyFM78xnpd2pAHoKwe8C7V
         2khY9M7Dc7vlRYipXCQEjuLI9t8LhIl2rmYv9l/Y7anoxoM7+/jU0nLJFZan7uo6NRYu
         lE0g==
X-Gm-Message-State: APjAAAUWJZCqn0GoLMnlFeoPyYg26tq2rf2hg0y7QxQ1Z0ZxlmiFwht3
        aW9FJ4fO9VCecPIChTYqFd9kKnpR
X-Google-Smtp-Source: APXvYqwyYfwhsFFOY9iYrR7OlzvvVq6tPzIA9NTB0cr5JBzngq/CDgo6GUS7SvqfstEDn9O5ZqQGSQ==
X-Received: by 2002:ac8:2f98:: with SMTP id l24mr3424772qta.261.1553022897279;
        Tue, 19 Mar 2019 12:14:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id p46sm6069827qtc.41.2019.03.19.12.14.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Mar 2019 12:14:55 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 94FD34039C; Tue, 19 Mar 2019 16:14:52 -0300 (-03)
Date:   Tue, 19 Mar 2019 16:14:52 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 02/10] perf, tools, stat: Avoid memory overrun with -r
Message-ID: <20190319191452.GM3029@kernel.org>
References: <20190314225002.30108-1-andi@firstfloor.org>
 <20190314225002.30108-2-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190314225002.30108-2-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 14, 2019 at 03:49:54PM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When -r is used memory would get corrupted because the evsel->id array
> would get overrun. evsel->ids is a running counter of the last id.
> Normally this works fine, but with -r the same event is initialized
> multiple times, but not this counter, so it would keep growing
> beyond the array limit and corrupt random memory.
> 
> Always reinitialize ->ids, and also add an assert to catch
> such overruns in the future.
> 
> This fixes a perf segfault when running it from toplev.
> 
> Before:
> 
> $ valgrind perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
> ==27012== Memcheck, a memory error detector
> ==27012== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==27012== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
> ==27012== Command: perf stat -r2 -e {cycles,cycles,cycles,cycles} true
> ==27012==
> ==27012== Invalid write of size 8
> ==27012==    at 0x33090F: perf_evlist__id_add_fd (in /usr/bin/perf)
> ==27012==    by 0x33C99B: perf_evsel__store_ids (in /usr/bin/perf)
> ==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
> ==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
> ==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
> ==27012==    by 0x29C7A9: main (in /usr/bin/perf)
> ==27012==  Address 0x13182be8 is 0 bytes after a block of size 8 alloc'd
> ==27012==    at 0x483AB1A: calloc (vg_replace_malloc.c:762)
> ==27012==    by 0x33C921: perf_evsel__store_ids (in /usr/bin/perf)
> ==27012==    by 0x2B7E1D: ??? (in /usr/bin/perf)
> ==27012==    by 0x2B97DE: cmd_stat (in /usr/bin/perf)
> ==27012==    by 0x31BFC0: ??? (in /usr/bin/perf)
> ==27012==    by 0x29C7A9: main (in /usr/bin/perf)
> ==27012==
> ...
> 
> After:
> 
> $ valgrind ./perf stat -r2 -e '{cycles,cycles,cycles,cycles}' true
> ==27026== Memcheck, a memory error detector
> ==27026== Copyright (C) 2002-2017, and GNU GPL'd, by Julian Seward et al.
> ==27026== Using Valgrind-3.14.0 and LibVEX; rerun with -h for copyright info
> ==27026== Command: ./perf stat -r2 -e {cycles,cycles,cycles,cycles} true
> ==27026==
> 
>  Performance counter stats for 'true' (2 runs):

So, this made this break:

[root@quaco perf]# perf test backward
50: Read backward ring buffer                             : FAILED!
[root@quaco perf]# perf test -v backward
50: Read backward ring buffer                             :
--- start ---
test child forked, pid 11127
Using CPUID GenuineIntel-6-8E-A
registering plugin: /root/.traceevent/plugins/plugin_cfg80211.so
registering plugin: /root/.traceevent/plugins/plugin_kvm.so
registering plugin: /root/.traceevent/plugins/plugin_function.so
registering plugin: /root/.traceevent/plugins/plugin_scsi.so
registering plugin: /root/.traceevent/plugins/plugin_jbd2.so
registering plugin: /root/.traceevent/plugins/plugin_sched_switch.so
registering plugin: /root/.traceevent/plugins/plugin_xen.so
registering plugin: /root/.traceevent/plugins/plugin_kmem.so
registering plugin: /root/.traceevent/plugins/plugin_hrtimer.so
registering plugin: /root/.traceevent/plugins/plugin_mac80211.so
mmap size 1052672B
mmap size 8192B
perf: util/evlist.c:533: perf_evlist__id_add: Assertion `evsel->ids < evsel->sample_id->max_x * evsel->sample_id->max_y' failed.
test child interrupted
---- end ----
Read backward ring buffer: FAILED!


I'm removing it till we go thru it to figure out what is the best way to
go, not to get in the way of the other patches going upstream.

- Arnaldo
