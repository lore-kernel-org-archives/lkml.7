Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB2C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383622187F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U1naSvuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732294AbfKFQeP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:34:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37340 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbfKFQeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gJWB8dxPoxVQ+gdnfTIOzPdZmHOHb8gqaBS6cJrX02Q=;
        b=U1naSvuPwRqKkmxAR3nu7G/wPb06bXZec06D1TBR32Bt/eKRxAnOv74zJDBV1GhOesAnQS
        C5JC2MBRyFc2p0sjvuKW0yw3FtiOYX7WNOUBcw4QyXMj+k82VBaSkl4JsG2JWKoGxQGeIY
        +inbz7M8b/SEgGuRFWQLDjsU/itg1WI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-LXNUEEhONT2QWwy3pijlmQ-1; Wed, 06 Nov 2019 11:34:10 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EE0B1005500;
        Wed,  6 Nov 2019 16:34:09 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 00C2D60BF4;
        Wed,  6 Nov 2019 16:34:07 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:34:07 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 3/9] perf evlist: Maintain evlist->all_cpus
Message-ID: <20191106163407.GN30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-4-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-4-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: LXNUEEhONT2QWwy3pijlmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:16PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> Maintain a cpumap in the evlist that is the union of all the cpus
> of the events.
>=20
> This needs a cpumap merge operation. To make the merge operation
> work efficiently maintain the cpumap in a sorted state.
>=20
> The sorting is also needed for the affinity loop changes later.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/lib/cpumap.c                  | 42 ++++++++++++++++++++++++
>  tools/perf/lib/evlist.c                  |  1 +
>  tools/perf/lib/include/internal/evlist.h |  1 +
>  tools/perf/lib/include/perf/cpumap.h     |  2 ++
>  4 files changed, 46 insertions(+)
>=20
> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index 2ca1fafa620d..5ca26a9d318f 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -68,6 +68,11 @@ static struct perf_cpu_map *cpu_map__default_new(void)
>  =09return cpus;
>  }
> =20
> +static int cmp_int(const void *a, const void *b)
> +{
> +=09return *(const int *)a - *(const int*)b;
> +}
> +
>  static struct perf_cpu_map *cpu_map__trim_new(int nr_cpus, int *tmp_cpus=
)
>  {
>  =09size_t payload_size =3D nr_cpus * sizeof(int);
> @@ -76,6 +81,7 @@ static struct perf_cpu_map *cpu_map__trim_new(int nr_cp=
us, int *tmp_cpus)
>  =09if (cpus !=3D NULL) {
>  =09=09cpus->nr =3D nr_cpus;
>  =09=09memcpy(cpus->map, tmp_cpus, payload_size);
> +=09=09qsort(cpus->map, nr_cpus, sizeof(int), cmp_int);
>  =09=09refcount_set(&cpus->refcnt, 1);
>  =09}
=20
please move the sort into separate change

> =20
> @@ -272,3 +278,39 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
> =20
>  =09return max;
>  }
> +
> +struct perf_cpu_map *perf_cpu_map__update(struct perf_cpu_map *orig,
> +=09=09=09=09=09  struct perf_cpu_map *other)
> +{

it's more like perf_cpu_map__merge, right?

> +=09int *tmp_cpus;
> +=09int tmp_len;
> +=09int i, j, k;
> +=09struct perf_cpu_map *merged;
> +
> +=09if (!orig) {
> +=09=09perf_cpu_map__get(other);
> +=09=09return other;
> +=09}
> +=09if (orig->nr =3D=3D other->nr &&
> +=09    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
> +=09=09return orig;
> +=09tmp_len =3D orig->nr + other->nr;
> +=09tmp_cpus =3D malloc(tmp_len * sizeof(int));
> +=09if (!tmp_cpus)
> +=09=09return NULL;
> +=09i =3D j =3D k =3D 0;
> +=09while (i < orig->nr && j < other->nr) {
> +=09=09if (orig->map[i] <=3D other->map[j])
> +=09=09=09tmp_cpus[k++] =3D orig->map[i++];
> +=09=09else
> +=09=09=09tmp_cpus[k++] =3D other->map[j++];
> +=09}
> +=09while (i < orig->nr)
> +=09=09tmp_cpus[k++] =3D orig->map[i++];
> +=09while (j < other->nr)
> +=09=09tmp_cpus[k++] =3D other->map[j++];
> +=09assert(k < tmp_len);
> +=09merged =3D cpu_map__trim_new(k, tmp_cpus);
> +=09free(tmp_cpus);
> +=09return merged;
> +}

this is great function for automated test, please add

thanks,
jirka

