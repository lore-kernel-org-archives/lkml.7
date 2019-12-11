Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54003C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBC3214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FWdNHk8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729179AbfLKMoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:44:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727402AbfLKMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576068283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RbM8X8BOJH7yhenGP5DWrVvrufrYWyYLc8Be5/5UfCw=;
        b=FWdNHk8H8lKkR9E3UTVuCxWMIcScsY4IdA56HSWpev2LwDaZC3wbSjWMp6sQR14QlUB9GL
        tX2hj7xhVjyGPsJIX+a8PPFevpgTvHQzwDJpdoExsvJlV1dVib0zD7a/74fsZlFgUdY016
        brw/J7CmGtTImERpmF3X8Qcgxk9aSx0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-YVw6L6FPNTSw3-GZGKLciQ-1; Wed, 11 Dec 2019 07:44:41 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BAAC800D4C;
        Wed, 11 Dec 2019 12:44:39 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9332560BE1;
        Wed, 11 Dec 2019 12:44:37 +0000 (UTC)
Date:   Wed, 11 Dec 2019 13:44:34 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Stephane Eranian <eranian@google.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf inject --jit: Remove //anon mmap events
Message-ID: <20191211124434.GA18167@krava>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
MIME-Version: 1.0
In-Reply-To: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: YVw6L6FPNTSw3-GZGKLciQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2019 at 01:30:36PM -0700, Steve MacLean wrote:
> From: Steve MacLean <Steve.MacLean@Microsoft.com>
>=20
> While a JIT is jitting code it will eventually need to commit more pages =
and
> change these pages to executable permissions.
>=20
> Typically the JIT will want these colocated to minimize branch displaceme=
nts.
>=20
> The kernel will coalesce these anonymous mapping with identical permissio=
ns
> before sending an MMAP event for the new pages. This means the mmap event=
 for
> the new pages will include the older pages.
>=20
> These anonymous mmap events will obscure the jitdump injected pseudo even=
ts.
> This means that the jitdump generated symbols, machine code, debugging in=
fo,
> and unwind info will no longer be used.
>=20
> Observations:
>=20
> When a process emits a jit dump marker and a jitdump file, the perf-xxx.m=
ap
> file represents inferior information which has been superceded by the
> jitdump jit-xxx.dump file.
>=20
> Further the '//anon*' mmap events are only required for the legacy
> perf-xxx.map mapping.
>=20
> When attaching to an existing process, the synthetic anon map events are
> given a time stamp of -1. These should not obscure the jitdump events whi=
ch
> have an actual time.
>=20
> Summary:
>=20
> Use thread->priv to store whether a jitdump file has been processed
>=20
> During "perf inject --jit", discard "//anon*" mmap events for any pid whi=
ch
> has sucessfully processed a jitdump file.
>=20
> Committer testing:
>=20
> // jitdump case
> perf record <app with jitdump>
> perf inject --jit --input perf.data --output perfjit.data
>=20
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
>=20
> // no jitdump case
> perf record <app without jitdump>
> perf inject --jit --input perf.data --output perfjit.data
>=20
> // verify mmap "//anon" events present initially
> perf script --input perf.data --show-mmap-events | grep '//anon'
> // verify mmap "//anon" events not removed
> perf script --input perfjit.data --show-mmap-events | grep '//anon'
>=20
> Repro:
>=20
> This issue was discovered while testing the initial CoreCLR jitdump
> implementation. https://github.com/dotnet/coreclr/pull/26897.
>=20

Stephane,
are you ok with this fix?

thanks,
jirka

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
>  tools/perf/builtin-inject.c |  4 ++--
>  tools/perf/util/jitdump.c   | 31 ++++++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 372ecb3..0f38862 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -263,7 +263,7 @@ static int perf_event__jit_repipe_mmap(struct perf_to=
ol *tool,
>  =09 * if jit marker, then inject jit mmaps and generate ELF images
>  =09 */
>  =09ret =3D jit_process(inject->session, &inject->output, machine,
> -=09=09=09  event->mmap.filename, sample->pid, &n);
> +=09=09=09  event->mmap.filename, event->mmap.pid, &n);
>  =09if (ret < 0)
>  =09=09return ret;
>  =09if (ret) {
> @@ -301,7 +301,7 @@ static int perf_event__jit_repipe_mmap2(struct perf_t=
ool *tool,
>  =09 * if jit marker, then inject jit mmaps and generate ELF images
>  =09 */
>  =09ret =3D jit_process(inject->session, &inject->output, machine,
> -=09=09=09  event->mmap2.filename, sample->pid, &n);
> +=09=09=09  event->mmap2.filename, event->mmap2.pid, &n);
>  =09if (ret < 0)
>  =09=09return ret;
>  =09if (ret) {
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index e3ccb0c..d18596e 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -26,6 +26,7 @@
>  #include "jit.h"
>  #include "jitdump.h"
>  #include "genelf.h"
> +#include "thread.h"
> =20
>  #include <linux/ctype.h>
>  #include <linux/zalloc.h>
> @@ -749,6 +750,28 @@ static int jit_repipe_debug_info(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  =09return 0;
>  }
> =20
> +static void jit_add_pid(struct machine *machine, pid_t pid)
> +{
> +=09struct thread *thread =3D machine__findnew_thread(machine, pid, pid);
> +
> +=09if (!thread) {
> +=09=09pr_err("%s: thread %d not found or created\n", __func__, pid);
> +=09=09return;
> +=09}
> +
> +=09thread->priv =3D (void *)1;
> +}
> +
> +static bool jit_has_pid(struct machine *machine, pid_t pid)
> +{
> +=09struct thread *thread =3D machine__find_thread(machine, pid, pid);
> +
> +=09if (!thread)
> +=09=09return 0;
> +
> +=09return (bool)thread->priv;
> +}
> +
>  int
>  jit_process(struct perf_session *session,
>  =09    struct perf_data *output,
> @@ -764,8 +787,13 @@ static int jit_repipe_debug_info(struct jit_buf_desc=
 *jd, union jr_entry *jr)
>  =09/*
>  =09 * first, detect marker mmap (i.e., the jitdump mmap)
>  =09 */
> -=09if (jit_detect(filename, pid))
> +=09if (jit_detect(filename, pid)) {
> +=09=09// Strip //anon* mmaps if we processed a jitdump for this pid
> +=09=09if (jit_has_pid(machine, pid) && (strncmp(filename, "//anon", 6) =
=3D=3D 0))
> +=09=09=09return 1;
> +
>  =09=09return 0;
> +=09}
> =20
>  =09memset(&jd, 0, sizeof(jd));
> =20
> @@ -784,6 +812,7 @@ static int jit_repipe_debug_info(struct jit_buf_desc =
*jd, union jr_entry *jr)
> =20
>  =09ret =3D jit_inject(&jd, filename);
>  =09if (!ret) {
> +=09=09jit_add_pid(machine, pid);
>  =09=09*nbytes =3D jd.bytes_written;
>  =09=09ret =3D 1;
>  =09}
> --=20
> 1.8.3.1
>=20

