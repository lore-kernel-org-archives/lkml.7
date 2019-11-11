Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75283C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4956821872
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATwkMiIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfKKMDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:03:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57974 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726810AbfKKMDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573473832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6iw74DnvADLDHD+oyZ5sT4nFBJD2T/ZL85QnTrbp6k=;
        b=ATwkMiIlGsmOWFJaNVIdqbI8UGI0ALPbG/DVGY2ySbdVpsQUWCwpWZJWOYClSgWNpidy/3
        pwigYBKr/bkK0WbvnUsST+mkm6TPKvEWu1ttyC6f+MnCo4YVCwsqQwhwAF6FacRBHlBARW
        vxoZrIwaBluIrvX3wa9C2tbJO1VrzzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-QPZNRhliNKOL4UeCniFU4Q-1; Mon, 11 Nov 2019 07:03:49 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1631B8C51EA;
        Mon, 11 Nov 2019 12:03:47 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3078B5C651;
        Mon, 11 Nov 2019 12:03:42 +0000 (UTC)
Date:   Mon, 11 Nov 2019 13:03:41 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf tools: report initial event parsing error
Message-ID: <20191111120341.GE9791@krava>
References: <20191107222315.GA7261@kernel.org>
 <20191108181533.222053-1-irogers@google.com>
MIME-Version: 1.0
In-Reply-To: <20191108181533.222053-1-irogers@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: QPZNRhliNKOL4UeCniFU4Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 10:15:33AM -0800, Ian Rogers wrote:
> Record the first event parsing error and report. Implementing feedback
> from Jiri Olsa:
> https://lkml.org/lkml/2019/10/28/680
>=20
> An example error is:
>=20
> $ tools/perf/perf stat -e c/c/
> WARNING: multiple event parsing errors
> event syntax error: 'c/c/'
>                        \___ unknown term
>=20
> valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,fil=
ter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_=
not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore
>=20
> Initial error:
> event syntax error: 'c/c/'
>                     \___ Cannot find PMU `c'. Missing kernel support?
> Run 'perf list' for a list of valid events
>=20
>  Usage: perf stat [<options>] [<command>]
>=20
>     -e, --event <event>   event selector. use 'perf list' to list availab=
le events
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/arch/powerpc/util/kvm-stat.c |  9 ++-
>  tools/perf/builtin-stat.c               |  2 +
>  tools/perf/builtin-trace.c              | 16 ++++--
>  tools/perf/tests/parse-events.c         |  3 +-
>  tools/perf/util/metricgroup.c           |  2 +-
>  tools/perf/util/parse-events.c          | 76 ++++++++++++++++++-------
>  tools/perf/util/parse-events.h          |  4 ++
>  7 files changed, 84 insertions(+), 28 deletions(-)
>=20
> diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/po=
werpc/util/kvm-stat.c
> index 9cc1c4a9dec4..30f5310373ca 100644
> --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> @@ -113,10 +113,15 @@ static int is_tracepoint_available(const char *str,=
 struct evlist *evlist)
>  =09struct parse_events_error err;
>  =09int ret;
> =20
> -=09err.str =3D NULL;
> +=09bzero(&err, sizeof(err));
>  =09ret =3D parse_events(evlist, str, &err);
> -=09if (err.str)
> +=09if (err.str) {
>  =09=09pr_err("%s : %s\n", str, err.str);
> +=09=09free(&err->str);
> +=09=09free(&err->help);
> +=09=09free(&err->first_str);
> +=09=09free(&err->first_help);

it's used in other places, so it's better to put it in
parse_events_error__exit or such..

jirka

