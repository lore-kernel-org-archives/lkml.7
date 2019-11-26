Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68872C432C3
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366F82075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEzPIU2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbfKZJuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:50:39 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59365 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727397AbfKZJui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:50:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574761836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMSnKW8Pd9gSHrFUdDBscrx4mNtflEbaAmDH0U1SsmY=;
        b=jEzPIU2WHvpp3UdXHitujh854CKbx6RajCpGq4CZNDdqDdthn5BJviwwqdyrqW7kXBsQV3
        TU+TM0OtCQetKydvGjFej7kh/ouBwlWl6XCr0QlGakUXrYHJmi/C3Q04FP7WHL65sXWwRS
        ftJidicsDjJdu0seg08xjrvUbXcIVf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-wtmqAqwINNmlOR0iKVk0Vw-1; Tue, 26 Nov 2019 04:50:30 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4518A800D24;
        Tue, 26 Nov 2019 09:50:29 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id BE9105D9CA;
        Tue, 26 Nov 2019 09:50:27 +0000 (UTC)
Date:   Tue, 26 Nov 2019 10:50:27 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] perf: add support for logging debug messages to
 file
Message-ID: <20191126095027.GC32367@krava>
References: <20191125151446.10948-1-changbin.du@gmail.com>
 <20191125151446.10948-3-changbin.du@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20191125151446.10948-3-changbin.du@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: wtmqAqwINNmlOR0iKVk0Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 11:14:46PM +0800, Changbin Du wrote:
> When in TUI mode, it is impossible to show all the debug messages to
> console. This make it hard to debug perf issues using debug messages.
> This patch adds support for logging debug messages to file to resolve
> this problem.
>=20
> The usage is:
> perf -debug verbose=3D2,file=3D~/perf.log COMMAND
>=20
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
>=20
> ---
> v5: doc default log path.
> v4: fix another segfault.
> v3: fix a segfault issue.
> ---
>  tools/perf/Documentation/perf.txt | 15 +++++++----
>  tools/perf/util/debug.c           | 44 ++++++++++++++++++++++++++++---
>  2 files changed, 50 insertions(+), 9 deletions(-)
>=20
> diff --git a/tools/perf/Documentation/perf.txt b/tools/perf/Documentation=
/perf.txt
> index fd8d790f68a7..a47933b53fbe 100644
> --- a/tools/perf/Documentation/perf.txt
> +++ b/tools/perf/Documentation/perf.txt
> @@ -16,15 +16,20 @@ OPTIONS
>  =09Setup debug variable (see list below) in value
>  =09range (0, 10). Use like:
>  =09  --debug verbose   # sets verbose =3D 1
> -=09  --debug verbose=3D2 # sets verbose =3D 2
> +=09  --debug verbose=3D2,file=3D~/perf.log
> +=09                    # sets verbose =3D 2 and save log to file
> =20
>  =09List of debug variables allowed to set:
> -=09  verbose=3Dlevel=09=09- general debug messages
> -=09  ordered-events=3Dlevel=09- ordered events object debug messages
> -=09  data-convert=3Dlevel=09- data convert command debug messages
> -=09  stderr=09=09- write debug output (option -v) to stderr
> +=09  verbose=3Dlevel         - general debug messages
> +=09  ordered-events=3Dlevel  - ordered events object debug messages
> +=09  data-convert=3Dlevel    - data convert command debug messages
> +=09  stderr                - write debug output (option -v) to stderr
> +=09                          in browser mode

hum, why is this changed in this patch?

jirka

>  =09  perf-event-open=09- Print perf_event_open() arguments and
>  =09                          return value in browser mode
> +=09  file[=3Dpath]           - write debug output to log file, default
> +=09                          'perf.log' (stderr and file options are
> +=09                          exclusive)
> =20
>  --buildid-dir::
>  =09Setup buildid cache directory. It has higher priority than
> diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
> index 929da46ece92..21bc889976bc 100644
> --- a/tools/perf/util/debug.c
> +++ b/tools/perf/util/debug.c
> @@ -6,6 +6,7 @@
>  #include <stdarg.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <errno.h>
>  #include <sys/wait.h>
>  #include <api/debug.h>
>  #include <linux/kernel.h>
> @@ -27,7 +28,7 @@ int verbose;
>  int debug_peo_args;
>  bool dump_trace =3D false, quiet =3D false;
>  int debug_ordered_events;
> -static bool redirect_to_stderr;
> +static FILE *log_file;
>  int debug_data_convert;
> =20
>  int veprintf(int level, int var, const char *fmt, va_list args)
> @@ -35,8 +36,10 @@ int veprintf(int level, int var, const char *fmt, va_l=
ist args)
>  =09int ret =3D 0;
> =20
>  =09if (var >=3D level) {
> -=09=09if (use_browser >=3D 1 && !redirect_to_stderr)
> +=09=09if (use_browser >=3D 1 && !log_file)
>  =09=09=09ui_helpline__vshow(fmt, args);
> +=09=09else if (log_file)
> +=09=09=09ret =3D vfprintf(log_file, fmt, args);
>  =09=09else
>  =09=09=09ret =3D vfprintf(stderr, fmt, args);
>  =09}
> @@ -198,6 +201,24 @@ static int str2loglevel(const char *vstr)
>  =09return v;
>  }
> =20
> +static void flush_log(void)
> +{
> +=09if (log_file)
> +=09=09fflush(log_file);
> +}
> +
> +static void set_log_output(FILE *f)
> +{
> +=09if (f =3D=3D log_file)
> +=09=09return;
> +
> +=09if (log_file && log_file !=3D stderr)
> +=09=09fclose(log_file);
> +
> +=09log_file =3D f;
> +=09atexit(flush_log);
> +}
> +
>  int perf_debug_option(const char *str)
>  {
>  =09char *sep, *vstr;
> @@ -219,10 +240,25 @@ int perf_debug_option(const char *str)
>  =09=09else if (!strcmp(opt, "data-convert"))
>  =09=09=09debug_data_convert =3D str2loglevel(vstr);
>  =09=09else if (!strcmp(opt, "stderr"))
> -=09=09=09redirect_to_stderr =3D true;
> +=09=09=09set_log_output(stderr);
>  =09=09else if (!strcmp(opt, "perf-event-open"))
>  =09=09=09debug_peo_args =3D true;
> -=09=09else {
> +=09=09else if (!strcmp(opt, "file")) {
> +=09=09=09FILE *f;
> +
> +=09=09=09if (!vstr)
> +=09=09=09=09vstr =3D (char *)"perf.log";
> +
> +=09=09=09f =3D fopen(vstr, "a");
> +=09=09=09if (!f) {
> +=09=09=09=09pr_err("Can not create log file: %s\n",
> +=09=09=09=09       strerror(errno));
> +=09=09=09=09free(dstr);
> +=09=09=09=09return -1;
> +=09=09=09}
> +=09=09=09fprintf(f, "\n=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dperf log=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> +=09=09=09set_log_output(f);
> +=09=09} else {
>  =09=09=09fprintf(stderr, "unkown debug option '%s'\n", opt);
>  =09=09=09free(dstr);
>  =09=09=09return -1;
> --=20
> 2.20.1
>=20

