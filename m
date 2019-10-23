Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F884CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5313C20679
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 08:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HO1PD489"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbfJWI3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:29:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44901 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390034AbfJWI3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 04:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571819358;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tCBC4uaO7/bSswPqkzkCNJ9n1VLTQ1l10Gg1LHPnh4M=;
        b=HO1PD4892jBDp68sIRGhXHPsmO2gcFzBLL/NNcH8e9qF1VK8wpYy+DKGOs88IlPfwbY5nZ
        dwcd5beEKpFRqrIXtPohHgWfrvSx3anqJm8+etLonxNECjpgAcFyru55fIs0sLGTPPj6uk
        M3c0iuZSd2vrvNZLdtAVo9H76i8Vr4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-sDomfEK0NrKBUEk1qlS5Vw-1; Wed, 23 Oct 2019 04:29:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74390107AD31;
        Wed, 23 Oct 2019 08:29:15 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2DF6D608C0;
        Wed, 23 Oct 2019 08:29:13 +0000 (UTC)
Date:   Wed, 23 Oct 2019 10:29:12 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     He Kuang <hekuang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: avoid reading out of scope array
Message-ID: <20191023082912.GB22919@krava>
References: <20191017170531.171244-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191017170531.171244-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sDomfEK0NrKBUEk1qlS5Vw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 10:05:31AM -0700, Ian Rogers wrote:
> Modify tracepoint name into 2 sys components and assemble at use. This
> avoids the sys_name array being out of scope at the point of use.
> Bug caught with LLVM's address sanitizer with fuzz generated input of
> ":cs\1" to parse_events.
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 36 +++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>=20
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-event=
s.y
> index 48126ae4cd13..28be39a703c9 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -104,7 +104,8 @@ static void inc_group_count(struct list_head *list,
>  =09struct list_head *head;
>  =09struct parse_events_term *term;
>  =09struct tracepoint_name {
> -=09=09char *sys;
> +=09=09char *sys1;
> +=09=09char *sys2;
>  =09=09char *event;
>  =09} tracepoint_name;
>  =09struct parse_events_array array;
> @@ -425,9 +426,19 @@ tracepoint_name opt_event_config
>  =09if (error)
>  =09=09error->idx =3D @1.first_column;
> =20
> -=09if (parse_events_add_tracepoint(list, &parse_state->idx, $1.sys, $1.e=
vent,
> -=09=09=09=09=09error, $2))
> -=09=09return -1;
> +        if ($1.sys2) {
> +=09=09char sys_name[128];
> +=09=09snprintf(&sys_name, sizeof(sys_name), "%s-%s",
> +=09=09=09$1.sys1, $1.sys2);
> +=09=09if (parse_events_add_tracepoint(list, &parse_state->idx,
> +=09=09=09=09=09=09sys_name, $1.event,
> +=09=09=09=09=09=09error, $2))
> +=09=09=09return -1;
> +        } else
> +=09=09if (parse_events_add_tracepoint(list, &parse_state->idx,
> +=09=09=09=09=09=09$1.sys1, $1.event,
> +=09=09=09=09=09=09error, $2))
> +=09=09=09return -1;

nice catch, please enclose all multiline condition legs with {}

other than that

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> =20
>  =09$$ =3D list;
>  }
> @@ -435,19 +446,22 @@ tracepoint_name opt_event_config
>  tracepoint_name:
>  PE_NAME '-' PE_NAME ':' PE_NAME
>  {
> -=09char sys_name[128];
> -=09struct tracepoint_name tracepoint;
> -
> -=09snprintf(&sys_name, 128, "%s-%s", $1, $3);
> -=09tracepoint.sys =3D &sys_name;
> -=09tracepoint.event =3D $5;
> +=09struct tracepoint_name tracepoint =3D {
> +=09=09.sys1 =3D $1,
> +=09=09.sys2 =3D $3,
> +=09=09.event =3D $5,
> +=09};
> =20
>  =09$$ =3D tracepoint;
>  }
>  |
>  PE_NAME ':' PE_NAME
>  {
> -=09struct tracepoint_name tracepoint =3D {$1, $3};
> +=09struct tracepoint_name tracepoint =3D {
> +=09=09.sys1 =3D $1,
> +=09=09.sys2 =3D NULL,
> +=09=09.event =3D $3,
> +=09};
> =20
>  =09$$ =3D tracepoint;
>  }
> --=20
> 2.23.0.700.g56cf767bdb-goog
>=20

