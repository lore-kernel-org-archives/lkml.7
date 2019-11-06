Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD5C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9DCE217D7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 11:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2FhsOd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729399AbfKFLEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 06:04:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40728 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725890AbfKFLEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 06:04:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573038238;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+yiaFBPNVk5pMIRaf+s+qIRoKfCfzA9T/3QQFstf9Ak=;
        b=Q2FhsOd5ksNqTmbCdWvbPRpYssG61Zjdnkgm3nTwUn8iVcUy9wX2wsV6B1MitK1oyJOM8H
        hV1So2GUHkhOgQJjOyBAFdSQJeKEGYJtCGd3X8MAhrATqq6rchwadlSbR/b4bK0C2CPXu/
        6ms+tJRBI6dGpYu3OqEH+2xrGzBwdU8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-bMR3NZMjPDCsWQYV6M5g8g-1; Wed, 06 Nov 2019 06:03:55 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7BB8A1005500;
        Wed,  6 Nov 2019 11:03:54 +0000 (UTC)
Received: from krava (unknown [10.40.205.189])
        by smtp.corp.redhat.com (Postfix) with SMTP id 696345D6D4;
        Wed,  6 Nov 2019 11:03:53 +0000 (UTC)
Date:   Wed, 6 Nov 2019 12:03:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf inject: Make --strip keep evsels
Message-ID: <20191106110352.GB30214@krava>
References: <20191105100057.21465-1-adrian.hunter@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191105100057.21465-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: bMR3NZMjPDCsWQYV6M5g8g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2019 at 12:00:57PM +0200, Adrian Hunter wrote:
> create_gcov (refer to the autofdo example in
> tools/perf/Documentation/intel-pt.txt) now needs the evsels to read the
> perf.data file. So don't strip them.
>=20
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-inject.c | 54 -------------------------------------
>  1 file changed, 54 deletions(-)

good stats ;-)

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

>=20
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 372ecb3e2c06..1e5d28311e14 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -578,58 +578,6 @@ static void strip_init(struct perf_inject *inject)
>  =09=09evsel->handler =3D drop_sample;
>  }
> =20
> -static bool has_tracking(struct evsel *evsel)
> -{
> -=09return evsel->core.attr.mmap || evsel->core.attr.mmap2 || evsel->core=
.attr.comm ||
> -=09       evsel->core.attr.task;
> -}
> -
> -#define COMPAT_MASK (PERF_SAMPLE_ID | PERF_SAMPLE_TID | PERF_SAMPLE_TIME=
 | \
> -=09=09     PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_IDENTIFIER)
> -
> -/*
> - * In order that the perf.data file is parsable, tracking events like MM=
AP need
> - * their selected event to exist, except if there is only 1 selected eve=
nt left
> - * and it has a compatible sample type.
> - */
> -static bool ok_to_remove(struct evlist *evlist,
> -=09=09=09 struct evsel *evsel_to_remove)
> -{
> -=09struct evsel *evsel;
> -=09int cnt =3D 0;
> -=09bool ok =3D false;
> -
> -=09if (!has_tracking(evsel_to_remove))
> -=09=09return true;
> -
> -=09evlist__for_each_entry(evlist, evsel) {
> -=09=09if (evsel->handler !=3D drop_sample) {
> -=09=09=09cnt +=3D 1;
> -=09=09=09if ((evsel->core.attr.sample_type & COMPAT_MASK) =3D=3D
> -=09=09=09    (evsel_to_remove->core.attr.sample_type & COMPAT_MASK))
> -=09=09=09=09ok =3D true;
> -=09=09}
> -=09}
> -
> -=09return ok && cnt =3D=3D 1;
> -}
> -
> -static void strip_fini(struct perf_inject *inject)
> -{
> -=09struct evlist *evlist =3D inject->session->evlist;
> -=09struct evsel *evsel, *tmp;
> -
> -=09/* Remove non-synthesized evsels if possible */
> -=09evlist__for_each_entry_safe(evlist, tmp, evsel) {
> -=09=09if (evsel->handler =3D=3D drop_sample &&
> -=09=09    ok_to_remove(evlist, evsel)) {
> -=09=09=09pr_debug("Deleting %s\n", perf_evsel__name(evsel));
> -=09=09=09evlist__remove(evlist, evsel);
> -=09=09=09evsel__delete(evsel);
> -=09=09}
> -=09}
> -}
> -
>  static int __cmd_inject(struct perf_inject *inject)
>  {
>  =09int ret =3D -EINVAL;
> @@ -729,8 +677,6 @@ static int __cmd_inject(struct perf_inject *inject)
>  =09=09=09=09evlist__remove(session->evlist, evsel);
>  =09=09=09=09evsel__delete(evsel);
>  =09=09=09}
> -=09=09=09if (inject->strip)
> -=09=09=09=09strip_fini(inject);
>  =09=09}
>  =09=09session->header.data_offset =3D output_data_offset;
>  =09=09session->header.data_size =3D inject->bytes_written;
> --=20
> 2.17.1
>=20

