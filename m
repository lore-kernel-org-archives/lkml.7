Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0804EC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5C8217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fuquo1cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732300AbfKFQeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:34:23 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbfKFQeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X1J/x47SLmzAVSoAirAJ0SPhGjwmLUuDbVGGEz46xRQ=;
        b=Fuquo1cb+3I+MtKLSX7ovKI1dZammTM2FeFy2Hp6DXfSrH3QpE5vNrESSdiGpp6kqqXOci
        zSr2dSVbPmZB3C3+t6kPlKCiCcaWU6Lnq3r7SMy1alf+e9pU+eatVItRYdKz33/0kr9BMx
        kWxcJ4k1AmLu4vFwieAZw95ZH5+wPFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-v4yiYYSPN42IrhJoedkrAA-1; Wed, 06 Nov 2019 11:34:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FE988017E0;
        Wed,  6 Nov 2019 16:34:18 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id BD1EB60CD3;
        Wed,  6 Nov 2019 16:34:16 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:34:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 5/9] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191106163415.GO30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-6-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-6-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: v4yiYYSPN42IrhJoedkrAA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:18PM -0800, Andi Kleen wrote:

SNIP

> ---
>  tools/perf/lib/evsel.c              | 27 +++++++++++++++++++++------
>  tools/perf/lib/include/perf/evsel.h |  1 +
>  tools/perf/util/evlist.c            | 29 +++++++++++++++++++++++++++--
>  tools/perf/util/evsel.h             |  1 +
>  4 files changed, 50 insertions(+), 8 deletions(-)
>=20
> diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
> index 5a89857b0381..ea775dacbd2d 100644
> --- a/tools/perf/lib/evsel.c
> +++ b/tools/perf/lib/evsel.c
> @@ -114,16 +114,23 @@ int perf_evsel__open(struct perf_evsel *evsel, stru=
ct perf_cpu_map *cpus,
>  =09return err;
>  }
> =20
> +static void perf_evsel__close_fd_cpu(struct perf_evsel *evsel, int cpu)
> +{
> +=09int thread;
> +
> +=09for (thread =3D 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> +=09=09if (FD(evsel, cpu, thread) >=3D 0)
> +=09=09=09close(FD(evsel, cpu, thread));
> +=09=09FD(evsel, cpu, thread) =3D -1;
> +=09}
> +}
> +
>  void perf_evsel__close_fd(struct perf_evsel *evsel)
>  {
> -=09int cpu, thread;
> +=09int cpu;
> =20
>  =09for (cpu =3D 0; cpu < xyarray__max_x(evsel->fd); cpu++)
> -=09=09for (thread =3D 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> -=09=09=09if (FD(evsel, cpu, thread) >=3D 0)
> -=09=09=09=09close(FD(evsel, cpu, thread));
> -=09=09=09FD(evsel, cpu, thread) =3D -1;
> -=09=09}
> +=09=09perf_evsel__close_fd_cpu(evsel, cpu);
>  }
> =20
>  void perf_evsel__free_fd(struct perf_evsel *evsel)
> @@ -141,6 +148,14 @@ void perf_evsel__close(struct perf_evsel *evsel)
>  =09perf_evsel__free_fd(evsel);
>  }
> =20
> +void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
> +{
> +=09if (evsel->fd =3D=3D NULL)
> +=09=09return;
> +
> +=09perf_evsel__close_fd_cpu(evsel, cpu);
> +}
> +

please move the perf_evsel__close_cpu addition into separate patch

thanks,
jirka

