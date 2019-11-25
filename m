Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDE8C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 625F72082F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhjnM0Hp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbfKYJm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:42:27 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47316 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfKYJm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:42:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574674945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ja91wPrXR0QYm8g6TlhyppqtMsZgwbcud4ZTrv5sIt4=;
        b=NhjnM0HpqhZJLY31/bVW5MH+VzOX1iTaSS+qWBHdYX5UntjjmQmXUVH0E7zrP7SuVtlE/I
        l64zPmvozu+a2937jG5YBpCPOFdk8BHlt5xvALw1Gs5+hr038rnR3x/8Cj5roFU/UrfpEO
        4jQqiRmViIumzAkfv10DplxYgAQG334=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-7Q8qCZf6PuWtTLOInafARQ-1; Mon, 25 Nov 2019 04:42:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CEB8DC4B;
        Mon, 25 Nov 2019 09:42:22 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id D34E960C81;
        Mon, 25 Nov 2019 09:42:20 +0000 (UTC)
Date:   Mon, 25 Nov 2019 10:42:20 +0100
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
Message-ID: <20191125094220.GC4675@krava>
References: <fb356fe9-ac87-71ab-9845-075b3fac3199@linux.intel.com>
 <69bd0062-0f9e-889b-b7ef-0d97d257569b@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <69bd0062-0f9e-889b-b7ef-0d97d257569b@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7Q8qCZf6PuWtTLOInafARQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 09:08:57AM +0300, Alexey Budankov wrote:

SNIP

> -static void perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap=
_params *mp)
> +static int perf_mmap__setup_affinity_mask(struct mmap *map, struct mmap_=
params *mp)
>  {
> -=09CPU_ZERO(&map->affinity_mask);
> +=09map->affinity_mask.nbits =3D cpu__max_cpu();
> +=09map->affinity_mask.bits =3D bitmap_alloc(map->affinity_mask.nbits);
> +=09if (!map->affinity_mask.bits)
> +=09=09return -1;
> +
>  =09if (mp->affinity =3D=3D PERF_AFFINITY_NODE && cpu__max_node() > 1)
>  =09=09build_node_mask(cpu__get_node(map->core.cpu), &map->affinity_mask)=
;
>  =09else if (mp->affinity =3D=3D PERF_AFFINITY_CPU)
> -=09=09CPU_SET(map->core.cpu, &map->affinity_mask);
> +=09=09set_bit(map->core.cpu, map->affinity_mask.bits);
> +
> +=09return 0;
>  }
> =20
> +#define MASK_SIZE 1023
>  int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, int cpu=
)
>  {
> +=09char mask[MASK_SIZE + 1] =3D {0};

does this need to be initialized?

> +
>  =09if (perf_mmap__mmap(&map->core, &mp->core, fd, cpu)) {
>  =09=09pr_debug2("failed to mmap perf event ring buffer, error %d\n",
>  =09=09=09  errno);
>  =09=09return -1;
>  =09}
> =20
> -=09perf_mmap__setup_affinity_mask(map, mp);
> +=09if (perf_mmap__setup_affinity_mask(map, mp)) {
> +=09=09pr_debug2("failed to alloc mmap affinity mask, error %d\n",
> +=09=09=09  errno);
> +=09=09return -1;
> +=09}
> +=09bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits, m=
ask, MASK_SIZE);
> +=09pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbits, =
mask);

the bitmap_scnprintf could be called only for debug case, right?

=09if (version >=3D 2) {
=09=09bitmap_scnprintf(map->affinity_mask.bits, map->affinity_mask.nbits, m=
ask, MASK_SIZE);
=09=09pr_debug2("%p: mmap mask[%ld]: %s\n", map, map->affinity_mask.nbits, =
mask);
=09}

ditto int the record__adjust_affinity function

jirka

