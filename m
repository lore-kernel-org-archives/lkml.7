Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9725BCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EFC9205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm8MTGj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390606AbfJWI6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:58:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43403 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390574AbfJWI6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571821121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ddQIqKhInCWjNW7paFtNB6th72sw/WUL6Px5vuUxikI=;
        b=Qm8MTGj6oDA9LXrJcCJuFaamMcgHJ2bt+bIvmj0rkTJKIWFKo1gQpojwBpmUj9o/q/dVdT
        PZSCjVrpN3V/QNZduKWinO285/peUFAL3sErsrIeJdM9xCPFwem8K00bjJlYwBbm+dAVbE
        EMyfTvW6bpyvlyVMyq89lWfWEWcEGRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-qMdmUyVdML2CtfDDqCaM7g-1; Wed, 23 Oct 2019 04:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23A48476;
        Wed, 23 Oct 2019 08:58:35 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4B27A5D6C8;
        Wed, 23 Oct 2019 08:58:31 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:58:30 +0200
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
Subject: Re: [PATCH v2 5/9] perf tools: avoid a malloc for array events
Message-ID: <20191023085830.GG22919@krava>
References: <20191017170531.171244-1-irogers@google.com>
 <20191023005337.196160-1-irogers@google.com>
 <20191023005337.196160-6-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191023005337.196160-6-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qMdmUyVdML2CtfDDqCaM7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 05:53:33PM -0700, Ian Rogers wrote:
> Use realloc rather than malloc+memcpy to possibly avoid a memory
> allocation when appending array elements.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/parse-events.y | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 26cb65798522..545ab7cefc20 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -691,14 +691,12 @@ array_terms ',' array_term
>  =09struct parse_events_array new_array;
> =20
>  =09new_array.nr_ranges =3D $1.nr_ranges + $3.nr_ranges;
> -=09new_array.ranges =3D malloc(sizeof(new_array.ranges[0]) *
> -=09=09=09=09  new_array.nr_ranges);
> +=09new_array.ranges =3D realloc($1.ranges,
> +=09=09=09=09sizeof(new_array.ranges[0]) *
> +=09=09=09=09new_array.nr_ranges);
>  =09ABORT_ON(!new_array.ranges);
> -=09memcpy(&new_array.ranges[0], $1.ranges,
> -=09       $1.nr_ranges * sizeof(new_array.ranges[0]));
>  =09memcpy(&new_array.ranges[$1.nr_ranges], $3.ranges,
>  =09       $3.nr_ranges * sizeof(new_array.ranges[0]));
> -=09free($1.ranges);
>  =09free($3.ranges);
>  =09$$ =3D new_array;
>  }
> --=20
> 2.23.0.866.gb869b98d4c-goog
>=20

