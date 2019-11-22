Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBB6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:22:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D12071C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 13:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EExNY+FM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfKVNWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 08:22:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46883 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726548AbfKVNWf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:22:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574428954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+4wnR7dCvlIXj37ch8LQ+LBMc9e941hqLYJ5YiYY/54=;
        b=EExNY+FM7cHvRoF2+plNATcZW42dKZSC1HiyRK77MVjAd4nZxtXvN0gWIldlnL/V8iYRVi
        /r3CGIhFNWib1iB5g37pFiqH/D/DtH90kmKLXm1b//ILIRGR/YjAr9yaqDqBaVz2zQMreu
        Oftn3GtG87M1+KEEnNbsps/Y+gqaCr4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-t0HIDd_wN9ys9txeJAhyvw-1; Fri, 22 Nov 2019 08:22:31 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06DD010054E3;
        Fri, 22 Nov 2019 13:22:30 +0000 (UTC)
Received: from krava (unknown [10.40.205.117])
        by smtp.corp.redhat.com (Postfix) with SMTP id 047141A8D9;
        Fri, 22 Nov 2019 13:22:26 +0000 (UTC)
Date:   Fri, 22 Nov 2019 14:22:26 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] perf record: adapt affinity to machines with
 #CPUs > 1K
Message-ID: <20191122132226.GF17308@krava>
References: <26d1512a-9dea-bf7e-d18e-705846a870c4@linux.intel.com>
 <2561f736-bdb5-a10a-1a5d-590ad499ce49@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <2561f736-bdb5-a10a-1a5d-590ad499ce49@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: t0HIDd_wN9ys9txeJAhyvw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:38:57PM +0300, Alexey Budankov wrote:

SNIP

> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 063d1b93c53d..070b1873cd45 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -23,6 +23,7 @@
>  #include "mmap.h"
>  #include "../perf.h"
>  #include <internal/lib.h> /* page_size */
> +#include <linux/bitmap.h>
> =20
>  size_t mmap__mmap_len(struct mmap *map)
>  {
> @@ -215,7 +216,7 @@ void mmap__munmap(struct mmap *map)
>  =09auxtrace_mmap__munmap(&map->auxtrace_mmap);
>  }
> =20
> -static void build_node_mask(int node, cpu_set_t *mask)
> +static void build_node_mask(int node, struct mmap_cpu_mask *mask)
>  {
>  =09int c, cpu, nr_cpus;
>  =09const struct perf_cpu_map *cpu_map =3D NULL;
> @@ -228,28 +229,43 @@ static void build_node_mask(int node, cpu_set_t *ma=
sk)
>  =09for (c =3D 0; c < nr_cpus; c++) {
>  =09=09cpu =3D cpu_map->map[c]; /* map c index to online cpu index */
>  =09=09if (cpu__get_node(cpu) =3D=3D node)
> -=09=09=09CPU_SET(cpu, mask);
> +=09=09=09set_bit(cpu, mask->bits);
>  =09}
>  }
> =20
> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap=
_params *mp)
> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_=
params *mp)
>  {
> -=09CPU_ZERO(&map->affinity_mask);
> +=09map->affinity_mask.nbits =3D cpu__max_cpu();
> +=09map->affinity_mask.bits =3D bitmap_alloc(map->affinity_mask.nbits);
> +=09if (!map->affinity_mask.bits)
> +=09=09return 1;

I guess this works, but please return < 0 on error

thanks,
jirka

