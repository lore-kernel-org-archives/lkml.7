Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75B5C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A1D32067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gYqMUQs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732308AbfKFQem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:34:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60798 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727570AbfKFQel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IZCsNH8mhID3uhq4CoMtih4TeSDJ9ibx3kHU/lSzM90=;
        b=gYqMUQs2xJuHGdKo+WcNYAeq+axMRoLpVpWJsSCSfVTbc7ObvYYSg7bkTf9e966YSiIvQi
        /pURoF3O4jse7fydkzEZ9O7w4J6yCgp9cbx8FMK5NOKdpNQzDvQ+5NBFn4+NVG4txWGkDf
        BmcXHUXPXsAP+BC0/CgbnZ/81eX4ljs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-RRCGNq_-PxuIptA594t_IA-1; Wed, 06 Nov 2019 11:34:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B16C477;
        Wed,  6 Nov 2019 16:34:34 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id ABB2219C6A;
        Wed,  6 Nov 2019 16:34:32 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:34:31 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 9/9] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191106163431.GQ30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-10-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-10-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RRCGNq_-PxuIptA594t_IA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:22PM -0800, Andi Kleen wrote:

SNIP

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
>  int perf_evsel__apply_filter(struct perf_evsel *evsel, const char *filte=
r)
>  {
> -=09return perf_evsel__run_ioctl(evsel,
> +=09int err =3D 0, i;
> +
> +=09for (i =3D 0; i < evsel->cpus->nr && !err; i++)
> +=09=09err =3D perf_evsel__run_ioctl(evsel,
>  =09=09=09=09     PERF_EVENT_IOC_SET_FILTER,
> -=09=09=09=09     (void *)filter);
> +=09=09=09=09     (void *)filter, i);
> +=09return err;
>  }

please move the new function additions to separate patches

thanks,
jirka

