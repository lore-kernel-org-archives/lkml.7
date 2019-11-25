Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84FCC432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796EF20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 11:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doiyTXQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbfKYLVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 06:21:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56472 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727495AbfKYLVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 06:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574680889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xa2EnHdNdPylvQ5G4EeatVQ72rlUf1Gu0qzI0xrlkt0=;
        b=doiyTXQ4I4IYAKReENRzVjljE9D1U4JkIBgOtgQNZyTJeGmDoPIyuv3V53XNl/1jz8zdB+
        onQZvn9ZnUfAWGJ3MBLS49wyeHnmQDjZDPP5SrlMLuEn2SuEKqxaM2JNtZge6JMEsfennk
        xLNEz77qhVPXJ98BbXf7HROCdI71DRQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-E5ZoiKzUMT2fAjAH9kPJmQ-1; Mon, 25 Nov 2019 06:21:26 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D970A804369;
        Mon, 25 Nov 2019 11:21:24 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3AA2C19C69;
        Mon, 25 Nov 2019 11:21:23 +0000 (UTC)
Date:   Mon, 25 Nov 2019 12:21:22 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] perf record: adapt affinity to machines with
 #CPUs > 1K
Message-ID: <20191125112122.GA1201@krava>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
 <69bd0062-0f9e-889b-b7ef-0d97d257569b@linux.intel.com>
 <20191125094220.GC4675@krava>
 <9b9209ce-ba61-824f-9443-3909991ff222@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <9b9209ce-ba61-824f-9443-3909991ff222@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: E5ZoiKzUMT2fAjAH9kPJmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 02:13:20PM +0300, Alexey Budankov wrote:
> On 25.11.2019 12:42, Jiri Olsa wrote:
> > On Mon, Nov 25, 2019 at 09:08:57AM +0300, Alexey Budankov wrote:
> >=20
> > SNIP
> >=20
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
> >> +
> >>  =09if (mp->affinity =3D=3D PERF_AFFINITY_NODE && cpu__max_node() > 1)
> >>  =09=09build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_ma=
sk);
> >>  =09else if (mp->affinity =3D=3D PERF_AFFINITY_CPU)
> >> -=09=09CPU_SET(map->core.cpu, &map->affinity_mask);
> >> +=09=09set_bit(map->core.cpu, map->affinity_mask.bits);
> >> +
> >> +=09return 0;
> >>  }
> >> =20
> >> +#define MASK_SIZE 1023
> >>  int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int =
cpu)
> >>  {
> >> +=09char mask[MASK_SIZE + 1] =3D {0};
> >=20
> > does this need to be initialized?
>=20
> This is to make sure the message is zero terminated for vfprintf call()

hum AFAICS it's used only in bitmap_scnprintf, which should
terminate the string properly

jirka

>=20
> >=20
> >> +
> >>  =09if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
> >>  =09=09pr_debug2("failed to mmap perf event ring buffer, error %d\n",
> >>  =09=09=09  errno);
> >>  =09=09return -1;
> >>  =09}
> >> =20
> >> -=09perf_mmap__setup_affinity_mask(map, mp);
> >> +=09if (perf_mmap__setup_affinity_mask(map, mp)) {
> >> +=09=09pr_debug2("failed to alloc mmap affinity mask, error %d\n",
> >> +=09=09=09  errno);
> >> +=09=09return -1;
> >> +=09}
> >> +=09bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits=
, mask, MASK_SIZE);
> >> +=09pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbit=
s, mask);
> >=20
> > the bitmap_scnprintf could be called only for debug case, right?
>=20
> Right. It is required to prepare debug message.
>=20
> >=20
> > =09if (version >=3D 2) {
> > =09=09bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbit=
s, mask, MASK_SIZE);
> > =09=09pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbi=
ts, mask);
> > =09}
> >=20
> > ditto int the record__adjust_affinity function
> >=20
> > jirka
> >=20
> >=20
>=20
> ~Alexey
>=20

