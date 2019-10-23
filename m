Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB05CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB91020684
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQfI7LGL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390385AbfJWIgX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:36:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56438 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390137AbfJWIgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571819781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=48N02/jvRuAsgRhdv+Mi4mPU3dLRpyX+8I00gXgPOW0=;
        b=VQfI7LGLjgN1E/qDp2uaVSr2tzciRlaNR06mn8VFWrQcVQ5x02EXyN0/tD+MVLGqMDnNPN
        +FeLSVrO2j2y/UXG4l6x7L2z+s1OmzlKPZv81zkOv7RaG/8+QY9H1Wy16LkCIBME5UW22a
        Y3xkjs5JMy3c9JuERlJj0HxjV/juD1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-4xhr8qFvOJ-YzFpi8NFASg-1; Wed, 23 Oct 2019 04:36:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 623CC107AD31;
        Wed, 23 Oct 2019 08:36:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 36E185DD78;
        Wed, 23 Oct 2019 08:36:09 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:36:08 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/9] perf tools: add parse events append error
Message-ID: <20191023083608.GC22919@krava>
References: <20191017170531.171244-1-irogers@google.com>
 <20191023005337.196160-1-irogers@google.com>
 <20191023005337.196160-2-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191023005337.196160-2-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4xhr8qFvOJ-YzFpi8NFASg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:53:29PM -0700, Ian Rogers wrote:
> Parse event error handling may overwrite one error string with another
> creating memory leaks and masking errors. Introduce a helper routine
> that appends error messages and avoids the memory leak.

good idea, it became little messy with time ;-)
some comments below

thanks,
jirka


>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 102 ++++++++++++++++++++++-----------
>  tools/perf/util/parse-events.h |   2 +
>  tools/perf/util/pmu.c          |  36 ++++++------
>  3 files changed, 89 insertions(+), 51 deletions(-)
>=20
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-event=
s.c
> index db882f630f7e..4d42344698b8 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -182,6 +182,34 @@ static int tp_event_has_id(const char *dir_path, str=
uct dirent *evt_dir)
> =20
>  #define MAX_EVENT_LENGTH 512
> =20
> +void parse_events__append_error(struct parse_events_error *err, int idx,
> +=09=09=09=09char *str, char *help)
> +{
> +=09char *new_str =3D NULL;
> +
> +=09WARN(!str, "WARNING: failed to provide error string");

should we also bail out if str is NULL?

> +=09if (err->str) {
> +=09=09int ret;
> +
> +=09=09if (err->help)
> +=09=09=09ret =3D asprintf(&new_str,
> +=09=09=09=09"%s (previous error: %s(help: %s))",
> +=09=09=09=09str, err->str, err->help);
> +=09=09else

please use {} for multiline condition legs

> +=09=09=09ret =3D asprintf(&new_str,
> +=09=09=09=09"%s (previous error: %s)",
> +=09=09=09=09str, err->str);

does this actualy happen? could you please provide output
of this in the changelog?

> +=09=09if (ret < 0)
> +=09=09=09new_str =3D NULL;
> +=09=09else
> +=09=09=09zfree(&str);
> +=09}
> +=09err->idx =3D idx;
> +=09free(err->str);
> +=09err->str =3D new_str ?: str;
> +=09free(err->help);
> +=09err->help =3D help;
> +}
> =20

SNIP

