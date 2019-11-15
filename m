Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD052C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916B020730
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzbgiIUz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbfKOOz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 09:55:26 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51700 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727496AbfKOOz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 09:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573829724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gVJiD5KIKKxH+P4zSFyekTbUzbxp2tb6lGakEbXukdc=;
        b=BzbgiIUzWJ5p9ykQWUMBgszqBZKynpIUqLIflzv9ZtHUB9C/ofKeQ6zOolmQyDsD4QdMuF
        dWN0eHWNo10H4Ndoa5ChY+DefVZnwcL3wX1SdW6zQvBmRPFSZeCOg1sxELJaB6uH1OMhFL
        LqK2SGLH9Y1WAJNrvW6C0n39OKVPRBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-bVeeAcuKMbaSCJkLDeINLg-1; Fri, 15 Nov 2019 09:55:21 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E7F18A6F48;
        Fri, 15 Nov 2019 14:55:20 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 509041036C65;
        Fri, 15 Nov 2019 14:55:18 +0000 (UTC)
Date:   Fri, 15 Nov 2019 15:55:18 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 11/12] perf evsel: Add functions to enable/disable for
 a specific CPU
Message-ID: <20191115145518.GA4255@krava>
References: <20191112005941.649137-1-andi@firstfloor.org>
 <20191112005941.649137-12-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191112005941.649137-12-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: bVeeAcuKMbaSCJkLDeINLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 11, 2019 at 04:59:40PM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> Refactor the existing functions to use these functions internally.
>=20
> Used in the next patch
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
> ---
>  tools/perf/lib/evsel.c              | 49 +++++++++++++++++++++--------
>  tools/perf/lib/include/perf/evsel.h |  2 ++
>  tools/perf/util/evsel.c             | 13 +++++++-
>  tools/perf/util/evsel.h             |  2 ++
>  4 files changed, 52 insertions(+), 14 deletions(-)
>=20
> diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
> index ea775dacbd2d..89ddfade0b96 100644
> --- a/tools/perf/lib/evsel.c
> +++ b/tools/perf/lib/evsel.c
> @@ -198,38 +198,61 @@ int perf_evsel__read(struct perf_evsel *evsel, int =
cpu, int thread,
>  }
> =20
>  static int perf_evsel__run_ioctl(struct perf_evsel *evsel,
> -=09=09=09=09 int ioc,  void *arg)
> +=09=09=09=09 int ioc,  void *arg,
> +=09=09=09=09 int cpu)
>  {
> -=09int cpu, thread;
> +=09int thread;
> =20
> -=09for (cpu =3D 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
> -=09=09for (thread =3D 0; thread < xyarray__max_y(evsel->fd); thread++) {
> -=09=09=09int fd =3D FD(evsel, cpu, thread),
> -=09=09=09    err =3D ioctl(fd, ioc, arg);
> +=09for (thread =3D 0; thread < xyarray__max_y(evsel->fd); thread++) {
> +=09=09int fd =3D FD(evsel, cpu, thread),
> +=09=09    err =3D ioctl(fd, ioc, arg);
> =20
> -=09=09=09if (err)
> -=09=09=09=09return err;
> -=09=09}
> +=09=09if (err)
> +=09=09=09return err;
>  =09}
> =20
>  =09return 0;
>  }
> =20
> +int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu)
> +{
> +=09return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, cpu);

please use NULL instead of 0, I initialy confused it for index

for all the calls perf_evsel__run_ioctl below

thanks,
jirka

> +}
> +
>  int perf_evsel__enable(struct perf_evsel *evsel)
>  {
> -=09return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0);
> +=09int i;
> +=09int err =3D 0;
> +
> +=09for (i =3D 0; i < evsel->cpus->nr && !err; i++)
> +=09=09err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_ENABLE, 0, i);
> +=09return err;
> +}
> +
> +int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu)
> +{
> +=09return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, cpu);
>  }
> =20
>  int perf_evsel__disable(struct perf_evsel *evsel)
>  {
> -=09return perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0);
> +=09int i;
> +=09int err =3D 0;
> +
> +=09for (i =3D 0; i < evsel->cpus->nr && !err; i++)
> +=09=09err =3D perf_evsel__run_ioctl(evsel, PERF_EVENT_IOC_DISABLE, 0, i)=
;
> +=09return err;
>  }
> =20

SNIP

