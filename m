Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E92C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7130F20675
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 11:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W5EuS9IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfLCLXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 06:23:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37096 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCLXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 06:23:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575372222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WuFqg7CCNbXCyfmGNkYBuxM4f9aggv3dQzU4efpQoaA=;
        b=W5EuS9INmUOboLFYE+a04gTYSMRe6KUwf23QhGg4eoYZ69XlUlTf1uoL+dClqVIehmTvEV
        cQZDjFBA+oD3XoR/IozT7XEqBJJYYpWfQQyqQtaZIwwjpIObHjEw6z6YJYTeas5lmzD7lK
        A39XCdI/FiPwmRVj4avAQmDYiMJZR80=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-DUbyUOuwMbmXWUsUzrN8ew-1; Tue, 03 Dec 2019 06:23:39 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF5AB18036BC;
        Tue,  3 Dec 2019 11:23:37 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 44B3560BFB;
        Tue,  3 Dec 2019 11:23:36 +0000 (UTC)
Date:   Tue, 3 Dec 2019 12:23:35 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] perf record: adapt affinity to machines with
 #CPUs > 1K
Message-ID: <20191203112335.GF17468@krava>
References: <f1e6e809-9e41-e410-57eb-1740512285a1@linux.intel.com>
 <2095b034-bf53-c374-0e34-adc006b00fbb@linux.intel.com>
 <20191203101252.GD17468@krava>
 <cc0dd7dc-400f-7097-b371-e895c016aaae@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <cc0dd7dc-400f-7097-b371-e895c016aaae@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: DUbyUOuwMbmXWUsUzrN8ew-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2019 at 01:48:05PM +0300, Alexey Budankov wrote:
>=20
>=20
> On 03.12.2019 13:12, Jiri Olsa wrote:
> > On Mon, Dec 02, 2019 at 09:58:48AM +0300, Alexey Budankov wrote:
> >=20
> > SNIP
> >=20
> >> =20
> >> -static void build_node_mask(int node, cpu_set_t *mask)
> >> +static void build_node_mask(int node, struct mmap_cpu_mask *mask)
> >>  {
> >>  =09int c, cpu, nr_cpus;
> >>  =09const struct perf_cpu_map *cpu_map =3D NULL;
> >> @@ -240,17 +242,23 @@ static void build_node_mask(int node, cpu_set_t =
*mask)
> >>  =09for (c =3D 0; c < nr_cpus; c++) {
> >>  =09=09cpu =3D cpu_map->map[c]; /* map c index to online cpu index */
> >>  =09=09if (cpu__get_node(cpu) =3D=3D node)
> >> -=09=09=09CPU_SET(cpu, mask);
> >> +=09=09=09set_bit(cpu, mask->bits);
> >>  =09}
> >>  }
> >> =20
> >> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct m=
map_params *mp)
> >> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mm=
ap_params *mp)
> >>  {
> >> -=09CPU_ZERO(&map->affinity_mask);
> >> +=09map->affinity_mask.nbits =3D cpu__max_cpu();
> >> +=09map->affinity_mask.bits =3D bitmap_alloc(map->affinity_mask.nbits)=
;
> >> +=09if (!map->affinity_mask.bits)
> >> +=09=09return -1;
> >=20
> > hum, this one should be also behind (rec->opts.affinity !=3D PERF_AFFIN=
ITY_SYS)
> > condition, right? sry I haven't noticed that before..
>=20
> That has not been so far, but, probably like this:
>=20
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 7f573f646431..832d2cb94b2c 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -269,7 +269,8 @@ int mmap__mmap(struct mmap *map, struct mmap_params *=
mp, int fd, int cpu)
>                 return -1;
>         }
> =20
> -       if (perf_mmap__setup_affinity_mask(map, mp)) {
> +       if (mp->affinity !=3D PERF_AFFINITY_SYS &&
> +               perf_mmap__setup_affinity_mask(map, mp)) {
>                 pr_debug2("failed to alloc mmap affinity mask, error %d\n=
",
>                           errno);
>                 return -1;

yes, that works too

jirka

