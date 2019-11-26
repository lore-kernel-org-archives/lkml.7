Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B83BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE4320748
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 09:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpRY/Oue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbfKZJR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 04:17:59 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727397AbfKZJR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 04:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574759878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=acmtuqpCwRmzVm+0/ZLebQVZLAfDVu2Uv7iUsPGGz70=;
        b=WpRY/OueJS7zd+wIT6MQZMwEwIVE3HqJKrkxBP7BNU/Yt4wZMMBGKbSQyhsVZZyF1X2S+5
        cBtXYCtZGlnyE5C4u5soqBUD4cvSY2Gl2uX7odXicAQVhjYqdEZk6ca17rfTHdzWuQlEwv
        sl+p9zyJeCzFpwMwC1ZyUXLDKexT3E8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-sBo3jGggPjGrHsAXadaG6w-1; Tue, 26 Nov 2019 04:17:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E57810071FA;
        Tue, 26 Nov 2019 09:17:52 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 246065D6BE;
        Tue, 26 Nov 2019 09:17:49 +0000 (UTC)
Date:   Tue, 26 Nov 2019 10:17:49 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: avoid segv in pmu_resolve_param_term
Message-ID: <20191126091749.GA32367@krava>
References: <20191125174136.95893-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191125174136.95893-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: sBo3jGggPjGrHsAXadaG6w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 09:41:35AM -0800, Ian Rogers wrote:
> PE_TERMS may set the config to NULL, avoid dereferencing this in
> pmu_resolve_param_term. Error detected by LLVM's libFuzzer.
> To reproduce the segv run:
> $ perf record -e 'm/event=3D?,time/' ls
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index e8d348988026..1a6e36353407 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -988,13 +988,17 @@ static int pmu_resolve_param_term(struct parse_even=
ts_term *term,
>  =09struct parse_events_term *t;
> =20
>  =09list_for_each_entry(t, head_terms, list) {
> -=09=09if (t->type_val =3D=3D PARSE_EVENTS__TERM_TYPE_NUM) {
> -=09=09=09if (!strcmp(t->config, term->config)) {
> -=09=09=09=09t->used =3D true;
> -=09=09=09=09*value =3D t->val.num;
> -=09=09=09=09return 0;
> -=09=09=09}
> -=09=09}
> +=09=09if (t->type_val !=3D PARSE_EVENTS__TERM_TYPE_NUM)
> +=09=09=09continue;
> +
> +=09=09if (t->config =3D=3D NULL && term->config !=3D NULL)
> +=09=09=09continue;

hum, I might be missing something but should above condition
be more like this?

=09=09if (t->config =3D=3D NULL || term->config =3D=3D NULL)
=09=09=09continue;

jirka

> +=09=09else if (strcmp(t->config, term->config))
> +=09=09=09continue;
> +
> +=09=09t->used =3D true;
> +=09=09*value =3D t->val.num;
> +=09=09return 0;
>  =09}
> =20
>  =09if (verbose > 0)
> --=20
> 2.24.0.432.g9d3f5f5b63-goog
>=20

