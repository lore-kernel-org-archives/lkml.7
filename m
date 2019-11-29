Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC02CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7744A216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZADPzVbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfK2NJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:09:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31305 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726360AbfK2NJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:09:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575032993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXQRsFdfLYOm/MUUyIhSeoAXYv2SBvvANDEs00Y3qns=;
        b=ZADPzVbXMRB47SUG6iCE5OQK3JWCNqkYzkV/QeTfDvfUI+u9qyppBY1GY7R+rjAhl44LXJ
        63TY7nSxoe+ytn2hGewKcfHMDjRiuQzdf2pXTnL8rWM3K2n21c4Q1263yLvplNtSImpGfO
        nsCyn6kwRwVSmC9/pYxjAO2XLam9sGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-dmcG5Go5PVmnxMR5lf7-tw-1; Fri, 29 Nov 2019 08:09:49 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8DAA2911A4;
        Fri, 29 Nov 2019 13:09:48 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id EA7B85D9E1;
        Fri, 29 Nov 2019 13:09:46 +0000 (UTC)
Date:   Fri, 29 Nov 2019 14:09:46 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] perf mmap: declare type for cpu mask of arbitrary
 length
Message-ID: <20191129130946.GC14169@krava>
References: <908dbe98-7d8d-0ec1-d4ae-242f3e104979@linux.intel.com>
 <446c4345-cb20-d0ad-3b3d-b34683b1c1e0@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <446c4345-cb20-d0ad-3b3d-b34683b1c1e0@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: dmcG5Go5PVmnxMR5lf7-tw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 01:04:37PM +0300, Alexey Budankov wrote:
>=20
> Declare a dedicated struct map_cpu_mask type for cpu masks of
> arbitrary length. Mask is available thru bits pointer and the
> mask length is kept in nbits field. MMAP_CPU_MASK_BYTES() macro
> returns mask storage size in bytes. perf_mmap__print_cpu_mask()
> function can be used to log text representation of the mask.
>=20
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/mmap.c | 12 ++++++++++++
>  tools/perf/util/mmap.h | 11 +++++++++++
>  2 files changed, 23 insertions(+)
>=20
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 063d1b93c53d..30ff7aef06f2 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -23,6 +23,18 @@
>  #include "mmap.h"
>  #include "../perf.h"
>  #include <internal/lib.h> /* page_size */
> +#include <linux/bitmap.h>
> +
> +#define MASK_SIZE 1023
> +void perf_mmap__print_cpu_mask(struct mmap_cpu_mask *mask, const char *t=
ag)

'mmap_cpu_mask__scnprintf' name follows the name logic we try to use

jirka

> +{
> +=09char buf[MASK_SIZE + 1];
> +=09size_t len;
> +
> +=09len =3D bitmap_scnprintf(mask->bits, mask->nbits, buf, MASK_SIZE);
> +=09buf[len] =3D '\0';
> +=09pr_debug("%p: %s mask[%ld]: %s\n", mask, tag, mask->nbits, buf);
> +}
> =20
>  size_t mmap__mmap_len(struct mmap *map)
>  {
> diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
> index bee4e83f7109..598e2def8a48 100644
> --- a/tools/perf/util/mmap.h
> +++ b/tools/perf/util/mmap.h
> @@ -15,6 +15,15 @@
>  #include "event.h"
> =20
>  struct aiocb;
> +
> +struct mmap_cpu_mask {
> +=09unsigned long *bits;
> +=09size_t nbits;
> +};
> +
> +#define MMAP_CPU_MASK_BYTES(m) \
> +=09(BITS_TO_LONGS(((struct mmap_cpu_mask *)m)->nbits) * sizeof(unsigned =
long))
> +
>  /**
>   * struct mmap - perf's ring buffer mmap details
>   *
> @@ -52,4 +61,6 @@ int perf_mmap__push(struct mmap *md, void *to,
> =20
>  size_t mmap__mmap_len(struct mmap *map);
> =20
> +void perf_mmap__print_cpu_mask(struct mmap_cpu_mask *mask, const char *t=
ag);
> +
>  #endif /*__PERF_MMAP_H */
> --=20
> 2.20.1
>=20

