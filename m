Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384D1CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4FE21872
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ur0a8o+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388076AbfJVIBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:01:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387692AbfJVIBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571731268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=exMmFKq0WNnl0QaOrDt0fxTmA4dmEn8kGQHFQk7dM8o=;
        b=Ur0a8o+IMdnt0rhi1oZ3SaBbSq/ZH7ThHCAX6V+01dTFZydFHVpXvldLgMVuaHFSDP6/Wy
        j27GwANP86EmSVTNUHR/jwRKL/LP2WmKTFseDpcgpny3ecp9vsjX6WTj6kDfgKJoGlG/kJ
        /hijVSj7efAJBO3yHvCWGuoLbmJEvIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-LzQ9twJJNz6CXGAeHAVkIw-1; Tue, 22 Oct 2019 04:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6266F107AD31;
        Tue, 22 Oct 2019 08:01:03 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id AC4375C1D4;
        Tue, 22 Oct 2019 08:01:01 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:01:00 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 1/9] perf evsel: Always preserve errno while cleaning
 up perf_event_open failures
Message-ID: <20191022080100.GA28177@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-2-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-2-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: LzQ9twJJNz6CXGAeHAVkIw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:51:54AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> In some cases when perf_event_open fails, it may do some closes to clean
> up. In special cases these closes can fail too, which overwrites the
> errno of the perf_event_open, which is then incorrectly reported.
>=20
> Save/restore errno around closes.
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> ---
>  tools/perf/util/evsel.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index abc7fda4a0fe..d831038b55f2 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1574,7 +1574,7 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
>  {
>  =09int cpu, thread, nthreads;
>  =09unsigned long flags =3D PERF_FLAG_FD_CLOEXEC;
> -=09int pid =3D -1, err;
> +=09int pid =3D -1, err, old_errno;
>  =09enum { NO_CHANGE, SET_TO_MAX, INCREASED_MAX } set_rlimit =3D NO_CHANG=
E;
> =20
>  =09if ((perf_missing_features.write_backward && evsel->core.attr.write_b=
ackward) ||
> @@ -1727,8 +1727,8 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
>  =09 */
>  =09if (err =3D=3D -EMFILE && set_rlimit < INCREASED_MAX) {
>  =09=09struct rlimit l;
> -=09=09int old_errno =3D errno;
> =20
> +=09=09old_errno =3D errno;
>  =09=09if (getrlimit(RLIMIT_NOFILE, &l) =3D=3D 0) {
>  =09=09=09if (set_rlimit =3D=3D NO_CHANGE)
>  =09=09=09=09l.rlim_cur =3D l.rlim_max;
> @@ -1812,6 +1812,7 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
>  =09if (err)
>  =09=09threads->err_thread =3D thread;
> =20
> +=09old_errno =3D errno;
>  =09do {
>  =09=09while (--thread >=3D 0) {
>  =09=09=09close(FD(evsel, cpu, thread));
> @@ -1819,6 +1820,7 @@ int evsel__open(struct evsel *evsel, struct perf_cp=
u_map *cpus,
>  =09=09}
>  =09=09thread =3D nthreads;
>  =09} while (--cpu >=3D 0);
> +=09errno =3D old_errno;
>  =09return err;
>  }
> =20
> --=20
> 2.21.0
>=20

