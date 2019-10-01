Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C3CC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D18C221855
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbfJAIzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 04:55:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbfJAIzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 04:55:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E890C049D7C;
        Tue,  1 Oct 2019 08:55:18 +0000 (UTC)
Received: from krava (ovpn-204-21.brq.redhat.com [10.40.204.21])
        by smtp.corp.redhat.com (Postfix) with SMTP id 0BE265D9D5;
        Tue,  1 Oct 2019 08:55:12 +0000 (UTC)
Date:   Tue, 1 Oct 2019 10:55:11 +0200
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
Subject: Re: [PATCH 3/4 RESEND] perf inject --jit: Remove //anon mmap events
Message-ID: <20191001085511.GB30823@krava>
References: <BN8PR21MB13622159D33A3EBCADDF4B2FF7820@BN8PR21MB1362.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR21MB13622159D33A3EBCADDF4B2FF7820@BN8PR21MB1362.namprd21.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 01 Oct 2019 08:55:19 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2019 at 09:00:01PM +0000, Steve MacLean wrote:
> While a JIT is jitting code it will eventually need to commit more pages and
> change these pages to executable permissions.
> 
> Typically the JIT will want these collocated to minimize branch displacements.
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
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Stephane Eranian <eranian@google.com>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Steve MacLean <Steve.MacLean@Microsoft.com>
> ---
> tools/perf/builtin-inject.c |  4 +--
>  tools/perf/util/jitdump.c   | 63 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index c14f40b8..4c921e0 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -261,7 +261,7 @@ static int perf_event__jit_repipe_mmap(struct perf_tool *tool,
>          * if jit marker, then inject jit mmaps and generate ELF images
>          */
>         ret = jit_process(inject->session, &inject->output, machine,
> -                         event->mmap.filename, sample->pid, &n);
> +                         event->mmap.filename, event->mmap.pid, &n);
>         if (ret < 0)
>                 return ret;
>         if (ret) {
> @@ -299,7 +299,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_tool *tool,
>          * if jit marker, then inject jit mmaps and generate ELF images
>          */
>         ret = jit_process(inject->session, &inject->output, machine,
> -                         event->mmap2.filename, sample->pid, &n);
> +                         event->mmap2.filename, event->mmap2.pid, &n);
>         if (ret < 0)
>                 return ret;
>         if (ret) {
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index 22d09c4..6a1563f 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -751,6 +751,59 @@ jit_detect(char *mmap_name, pid_t pid)
>         return 0;
>  }
>  
> +struct pid_rbtree
> +{
> +       struct rb_node node;
> +       pid_t pid;
> +};
> +
> +static void jit_add_pid(struct rb_root *root, pid_t pid)
> +{
> +       struct rb_node **new = &(root->rb_node), *parent = NULL;
> +       struct pid_rbtree* data = NULL;
> +
> +       /* Figure out where to put new node */
> +       while (*new) {
> +               struct pid_rbtree *this = container_of(*new, struct pid_rbtree, node);
> +               pid_t nodePid = this->pid;

looks like Andi is right, I'm still getting malformed patch error

the patch has extra characters '=20' and broken lines, like:


	--- a/tools/perf/util/jitdump.c
	+++ b/tools/perf/util/jitdump.c
	@@ -751,6 +751,59 @@ jit_detect(char *mmap_name, pid_t pid)
		return 0;
	 }
	=20
	+struct pid_rbtree
	+{
	+       struct rb_node node;
	+       pid_t pid;
	+};
	+
	+static void jit_add_pid(struct rb_root *root, pid_t pid)
	+{
	+       struct rb_node **new =3D &(root->rb_node), *parent =3D NULL;
	+       struct pid_rbtree* data =3D NULL;
	+
	+       /* Figure out where to put new node */
	+       while (*new) {
	+               struct pid_rbtree *this =3D container_of(*new, struct pid_r=
	btree, node);
	+               pid_t nodePid =3D this->pid;


jirka
