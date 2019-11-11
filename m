Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DC20222CF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OV5sfXUo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfKKNbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:31:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23045 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726843AbfKKNbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:31:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPQD8E2XCAm9S6Dc8C7OkBjON/HEZp/bVrno+fWX5wE=;
        b=OV5sfXUoaMB5HYcn/7E92v8CxycJJAhN0lFaxFp/oCbcz+EJHUcAPDNAo3Y85amJpp9QDa
        migcKK71ufzMUxNLQuuhRl2hTlRMg3V77ZOchZ/pwvMichZuG274+ZMsXlA9vnvxITiknT
        lUV19vvbz80Nwyc+3WxkWYmHKRQduz0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-pW-gECs3OH-dVdv8impuaQ-1; Mon, 11 Nov 2019 08:31:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D4901005502;
        Mon, 11 Nov 2019 13:31:39 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id F19D6608FB;
        Mon, 11 Nov 2019 13:31:37 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:31:37 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 04/13] perf evlist: Maintain evlist->all_cpus
Message-ID: <20191111133137.GH12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-5-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-5-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: pW-gECs3OH-dVdv8impuaQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:37AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/lib/cpumap.c b/tools/perf/lib/cpumap.c
> index d81656b4635e..b9f573438b93 100644
> --- a/tools/perf/lib/cpumap.c
> +++ b/tools/perf/lib/cpumap.c
> @@ -286,3 +286,46 @@ int perf_cpu_map__max(struct perf_cpu_map *map)
> =20
>  =09return max;
>  }
> +
> +struct perf_cpu_map *perf_cpu_map__merge(struct perf_cpu_map *orig,
> +=09=09=09=09=09 struct perf_cpu_map *other)
> +{
> +=09int *tmp_cpus;
> +=09int tmp_len;
> +=09int i, j, k;
> +=09struct perf_cpu_map *merged;
> +
> +=09if (!orig && !other)
> +=09=09return NULL;
> +=09if (!orig) {
> +=09=09perf_cpu_map__get(other);
> +=09=09return other;
> +=09}
> +=09if (!other)
> +=09=09return orig;

so we bump refcnt for other but not for orig?

could you please put to the comment expected results
wrt refcnt values for above cases?

> +=09if (orig->nr =3D=3D other->nr &&
> +=09    !memcmp(orig->map, other->map, orig->nr * sizeof(int)))
> +=09=09return orig;
> +=09tmp_len =3D orig->nr + other->nr;
> +=09tmp_cpus =3D malloc(tmp_len * sizeof(int));
> +=09if (!tmp_cpus)
> +=09=09return NULL;
> +=09i =3D j =3D k =3D 0;
> +=09while (i < orig->nr && j < other->nr) {
> +=09=09if (orig->map[i] <=3D other->map[j]) {
> +=09=09=09if (orig->map[i] =3D=3D other->map[j])
> +=09=09=09=09j++;
> +=09=09=09tmp_cpus[k++] =3D orig->map[i++];
> +=09=09} else
> +=09=09=09tmp_cpus[k++] =3D other->map[j++];
> +=09}
> +=09while (i < orig->nr)
> +=09=09tmp_cpus[k++] =3D orig->map[i++];
> +=09while (j < other->nr)
> +=09=09tmp_cpus[k++] =3D other->map[j++];
> +=09assert(k <=3D tmp_len);
> +=09merged =3D cpu_map__trim_new(k, tmp_cpus);
> +=09free(tmp_cpus);
> +=09perf_cpu_map__put(orig);
> +=09return merged;

please use some comments and blank lines to separate
the code above, it's too much.. ;-)

SNIP

>  LIBPERF_API int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int i=
dx);
>  LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
> diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-t=
est.c
> index 8b286e9b7549..5fa37cf7f283 100644
> --- a/tools/perf/tests/builtin-test.c
> +++ b/tools/perf/tests/builtin-test.c
> @@ -259,6 +259,11 @@ static struct test generic_tests[] =3D {
>  =09=09.desc =3D "Print cpu map",
>  =09=09.func =3D test__cpu_map_print,
>  =09},
> +=09{
> +=09=09.desc =3D "Merge cpu map",
> +=09=09.func =3D test__cpu_map_merge,
> +=09},

awesome ,thanks

jirka

