Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03343C17461
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB44D21D7F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 13:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TftV8xrU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389035AbfKENED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 08:04:03 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54999 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388738AbfKENEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 08:04:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572959041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YEDP+P6pRhLlcaoDzbSfhi4FuXteM9+sDOQkk5aS3IQ=;
        b=TftV8xrUzb4iXoFjLDpkz6c82PdWLLiKG8FrN8siAWk9RUh4c4ZUHMUyBFbCcD75Apmzaz
        d5jLHgsOkiQZ4geJDoX2fIr3jaWVVURP08SqDxFaX2stg+R/pKF/WaAtDYpm9Mme5t0d4s
        AkL7o+x/I/624dKDy/rzS51t0tO9ItU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Kedje49YOyiXxCsMh4gcWw-1; Tue, 05 Nov 2019 08:03:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B94BC477;
        Tue,  5 Nov 2019 13:03:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 426025C1B2;
        Tue,  5 Nov 2019 13:03:55 +0000 (UTC)
Date:   Tue, 5 Nov 2019 14:03:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [PATCHv2 0/3] perf stat: Add --per-node option
Message-ID: <20191105130354.GE29390@krava>
References: <20190904073415.723-1-jolsa@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20190904073415.723-1-jolsa@kernel.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Kedje49YOyiXxCsMh4gcWw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 09:34:12AM +0200, Jiri Olsa wrote:
> hi,
> adding --per-node option to aggregate stats per NUMA nodes,
> you can get now use stat command like:
>    =20
>   # perf stat  -a -I 1000 -e cycles --per-node
>   #           time node   cpus             counts unit events
>        1.000542550 N0       20          6,202,097      cycles
>        1.000542550 N1       20            639,559      cycles
>        2.002040063 N0       20          7,412,495      cycles
>        2.002040063 N1       20          2,185,577      cycles
>        3.003451699 N0       20          6,508,917      cycles
>        3.003451699 N1       20            765,607      cycles
>   ...
>=20
> v2 changes:
>   - use mallox instead of zalloc plus adding comment [Arnaldo]
>   - rename --per-numa to --per-node [Alexey]
>   - rename function names to have node instead of numa
>=20
> Available also in:
>   git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   perf/fixes

I forgot about this one ;-) rebased the latest perf/core
and pushed out..

thanks,
jirka


>=20
> thanks,
> jirka
>=20
>=20
> ---
> Jiri Olsa (3):
>       libperf: Add perf_cpu_map__max function
>       perf tools: Add perf_env__numa_node function
>       perf stat: Add --per-node agregation support
>=20
>  tools/perf/Documentation/perf-stat.txt |  5 +++++
>  tools/perf/builtin-stat.c              | 60 ++++++++++++++++++++++++++++=
++++++++++++++++++++++----------
>  tools/perf/lib/cpumap.c                | 12 ++++++++++++
>  tools/perf/lib/include/perf/cpumap.h   |  1 +
>  tools/perf/lib/libperf.map             |  1 +
>  tools/perf/util/cpumap.c               | 18 ++++++++++++++++++
>  tools/perf/util/cpumap.h               |  3 +++
>  tools/perf/util/env.c                  | 40 ++++++++++++++++++++++++++++=
++++++++++++
>  tools/perf/util/env.h                  |  6 ++++++
>  tools/perf/util/stat-display.c         | 15 +++++++++++++++
>  tools/perf/util/stat.c                 |  1 +
>  tools/perf/util/stat.h                 |  1 +
>  12 files changed, 153 insertions(+), 10 deletions(-)

