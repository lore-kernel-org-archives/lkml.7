Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC49C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CF722086A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 15:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbfI2P3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 11:29:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55656 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbfI2P3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 11:29:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 454C659449;
        Sun, 29 Sep 2019 15:29:33 +0000 (UTC)
Received: from krava (ovpn-204-45.brq.redhat.com [10.40.204.45])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1A04A1001956;
        Sun, 29 Sep 2019 15:29:26 +0000 (UTC)
Date:   Sun, 29 Sep 2019 17:29:25 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        John Keeping <john@metanate.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Leo Yan <leo.yan@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brian Robbins <brianrob@microsoft.com>,
        Tom McDonald <Thomas.McDonald@microsoft.com>,
        John Salem <josalem@microsoft.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/4] perf inject --jit: Remove //anon mmap events
Message-ID: <20190929152721.GB16309@krava>
References: <BN8PR21MB13625F8AD3E9C67C0918A750F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB13625F8AD3E9C67C0918A750F7800@BN8PR21MB1362.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Sun, 29 Sep 2019 15:29:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 01:45:36AM +0000, Steve MacLean wrote:
> While a JIT is jitting code it will eventually need to commit more pages and
> change these pages to executable permissions.
> 
> Typically the JIT will want these co-located to minimize branch displacements.
> 
> The kernel will coalesce these anonymous mapping with identical permissions
> before sending an mmap event for the new pages. This means the mmap event for
> the new pages will include the older pages.
> 
> These anonymous mmap events will obscure the jitdump injected pseudo events.
> This means that the jitdump generated symbols, machine code, debugging info,
> and unwind info will no longer be used.
> 
> Observations:
> 
> When a process emits a jit dump marker and a jitdump file, the perf-xxx.map
> file represents inferior information which has been superseded by the
> jitdump jit-xxx.dump file.
> 
> Further the '//anon*' mmap events are only required for the legacy
> perf-xxx.map mapping.
> 
> Summary:
> 
> Add rbtree to track which pids have successfully injected a jitdump file.
> 
> During "perf inject --jit", discard "//anon*" mmap events for any pid which
> has successfully processed a jitdump file.
> 
> Committer testing:
> 
> // jitdump case
> perf record <app with jitdump>
> perf inject --jit --input perf.data --output perfjit.data
> 
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
> 
> // no jitdump case
> perf record <app without jitdump>
> perf inject --jit --input perf.data --output perfjit.data
> 
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events not removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
> 
> Repro:
> 
> This issue was discovered while testing the initial CoreCLR jitdump
> implementation. https://github.com/dotnet/coreclr/pull/26897.

I can't apply this one:

patching file builtin-inject.c
Hunk #1 FAILED at 263.
1 out of 1 hunk FAILED -- saving rejects to file builtin-inject.c.rej
patching file util/jitdump.c
patch: **** malformed patch at line 236: btree, node);

jirka
