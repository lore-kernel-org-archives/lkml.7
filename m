Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F26CCA9EC9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF07121734
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 08:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SjoWjotN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfKAI1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 04:27:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729975AbfKAI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 04:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572596869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6JxU8DgukWA0gjba2EtBoGfIBCBKe/ip/gqBv28ZAFM=;
        b=SjoWjotNOb/x3DBBcDbhQtBShgpNBGKSNFpnTVQlagYQzqrFHJdwoYsEnJzHg1C1OnEuZB
        yy3VvdPIOD6VWdzkA8NpxiSDAos5a9hPvYKAHi7WAbcVW7I/J4xeBzVD3ou36iLjWbvYDn
        q0WDN9g5ta3MffL48xMvS61Bd+iMfhM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-KH6CFJLbPcqEWCiiPzlyjg-1; Fri, 01 Nov 2019 04:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB6A41005500;
        Fri,  1 Nov 2019 08:27:44 +0000 (UTC)
Received: from krava (ovpn-204-176.brq.redhat.com [10.40.204.176])
        by smtp.corp.redhat.com (Postfix) with SMTP id D0CAC5D6A7;
        Fri,  1 Nov 2019 08:27:41 +0000 (UTC)
Date:   Fri, 1 Nov 2019 09:27:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Steve MacLean <steve.maclean@linux.microsoft.com>
Cc:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf inject --jit: Remove //anon mmap events
Message-ID: <20191101082740.GB2172@krava>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
MIME-Version: 1.0
In-Reply-To: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: KH6CFJLbPcqEWCiiPzlyjg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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

I'm ok wih the implementation but not sure about the described JIT/mmap log=
ic, Stephane?

jirka

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

