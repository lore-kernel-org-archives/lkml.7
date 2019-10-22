Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD279CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B02A321872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhgshpV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388085AbfJVIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:01:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36260 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387692AbfJVIBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOdSf1iPdyuIGKQcZDNBRQHCgxJoZC1L79ZeEeYmKrs=;
        b=bhgshpV64nlWa6W8LNDnDZzRj0obgtdfescZ5V7ISilYX4eZb7WlB69gj1+Md5ZaXr8WOO
        B+BcMlprKyJYdjR74g047tal/gKPx8DqYCNP8lw158776WmA1q7NJSmUiRD8rDOMH+URLw
        MNgiO9e8KOVeSCvpaLvv1t2eE+2GDJo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-YufY5vFfNHqRQJ236x3gLg-1; Tue, 22 Oct 2019 04:01:19 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC3821800D79;
        Tue, 22 Oct 2019 08:01:17 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 43F0E60856;
        Tue, 22 Oct 2019 08:01:16 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:01:15 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 2/9] perf evsel: Avoid close(-1)
Message-ID: <20191022080115.GB28177@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-3-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-3-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: YufY5vFfNHqRQJ236x3gLg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:55AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> In some weak fallback cases close can be called a lot with -1. Check
> for this case and avoid calling close then.
>=20
> This is mainly to shut up valgrind which complains about this case.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/lib/evsel.c  | 3 ++-
>  tools/perf/util/evsel.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/lib/evsel.c b/tools/perf/lib/evsel.c
> index a8cb582e2721..5a89857b0381 100644
> --- a/tools/perf/lib/evsel.c
> +++ b/tools/perf/lib/evsel.c
> @@ -120,7 +120,8 @@ void perf_evsel__close_fd(struct perf_evsel *evsel)
> =20
>  =09for (cpu =3D 0; cpu < xyarray__max_x(evsel->fd); cpu++)
>  =09=09for (thread =3D 0; thread < xyarray__max_y(evsel->fd); ++thread) {
> -=09=09=09close(FD(evsel, cpu, thread));
> +=09=09=09if (FD(evsel, cpu, thread) >=3D 0)
> +=09=09=09=09close(FD(evsel, cpu, thread));
>  =09=09=09FD(evsel, cpu, thread) =3D -1;
>  =09=09}
>  }
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index d831038b55f2..d4451846af93 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1815,7 +1815,8 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
>  =09old_errno =3D errno;
>  =09do {
>  =09=09while (--thread >=3D 0) {
> -=09=09=09close(FD(evsel, cpu, thread));
> +=09=09=09if (FD(evsel, cpu, thread) >=3D 0)
> +=09=09=09=09close(FD(evsel, cpu, thread));
>  =09=09=09FD(evsel, cpu, thread) =3D -1;
>  =09=09}
>  =09=09thread =3D nthreads;
> --=20
> 2.21.0
>=20

