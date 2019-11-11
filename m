Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9219DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CCC21783
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 14:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBakSwx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbfKKOEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 09:04:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52345 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726834AbfKKOEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 09:04:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573481061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u0pgqK+Di47rvdGG8Ohb/KWFrkUcTYrwZy2v64eurK4=;
        b=FBakSwx0eb8Wklfylv7BUV4dY64e0MHhBIMSM17m6J+3HZiSoSZNJvKLnFi30nJOyyHvxM
        N12O5WHo6TdwCHQfChk4B5ZTIkBGUra6ip1R0X9M/SpwR/mPoX1g0m+ROhwk1PvqjN8zFN
        WFjdKfO3svFlWzoIccH9+QsHD3ca81c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-u4gGE7GCPoWB9r04_uyJsw-1; Mon, 11 Nov 2019 09:04:18 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B0A7107ACC6;
        Mon, 11 Nov 2019 14:04:17 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B735289AA;
        Mon, 11 Nov 2019 14:04:15 +0000 (UTC)
Date:   Mon, 11 Nov 2019 15:04:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 13/13] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191111140415.GA26980@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-14-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-14-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: u4gGE7GCPoWB9r04_uyJsw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:46AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index 33080f79b977..571bb102b432 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -378,11 +378,28 @@ bool evsel__cpu_iter_skip(struct evsel *ev, int cpu=
)
>  void evlist__disable(struct evlist *evlist)
>  {
>  =09struct evsel *pos;
> +=09struct affinity affinity;
> +=09int cpu, i;

should we have the fallback to current code in here (and below) as well?
also for reading/openning?

jirka

> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +
> +=09evlist__for_each_cpu (evlist, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);
> =20
> +=09=09evlist__for_each_entry(evlist, pos) {
> +=09=09=09if (evsel__cpu_iter_skip(pos, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos-=
>core.fd)
> +=09=09=09=09continue;
> +=09=09=09evsel__disable_cpu(pos, pos->cpu_iter - 1);
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);
>  =09evlist__for_each_entry(evlist, pos) {
> -=09=09if (pos->disabled || !perf_evsel__is_group_leader(pos) || !pos->co=
re.fd)
> +=09=09if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
>  =09=09=09continue;
> -=09=09evsel__disable(pos);
> +=09=09pos->disabled =3D true;
>  =09}
> =20
>  =09evlist->enabled =3D false;
> @@ -391,11 +408,28 @@ void evlist__disable(struct evlist *evlist)
>  void evlist__enable(struct evlist *evlist)
>  {
>  =09struct evsel *pos;
> +=09struct affinity affinity;
> +=09int cpu, i;
> =20
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +
> +=09evlist__for_each_cpu (evlist, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry(evlist, pos) {
> +=09=09=09if (evsel__cpu_iter_skip(pos, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
> +=09=09=09=09continue;
> +=09=09=09evsel__enable_cpu(pos, pos->cpu_iter - 1);
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);
>  =09evlist__for_each_entry(evlist, pos) {
>  =09=09if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
>  =09=09=09continue;
> -=09=09evsel__enable(pos);
> +=09=09pos->disabled =3D false;
>  =09}
> =20
>  =09evlist->enabled =3D true;
> --=20
> 2.23.0
>=20

