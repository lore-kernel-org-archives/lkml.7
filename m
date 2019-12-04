Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EFEAC43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68C3207DD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 15:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PwEtbArt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbfLDPY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 10:24:58 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41606 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727828AbfLDPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 10:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575473096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iXblvK4im4RSLKf973UCn9v95Ru6NHZ9juTBPEaZf5c=;
        b=PwEtbArtWDimhJRbxfWpmYlnF2exLy19qHd7S3PZLu38qXd08uMZD8rm71sLdk8r2W6U7j
        LycGdvTm2Ofu+s14TSS68hugY6ZI1IqlXnR1Ca//wWgs0ECXa72rlo/Dc9G0WaRJ7K+Ldp
        YwnsRLrbdOYEoj4o+dw/tbACVov8JYM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-whcV6YW1NnW-kRfyOm764Q-1; Wed, 04 Dec 2019 10:24:53 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 954E518543A0;
        Wed,  4 Dec 2019 15:24:49 +0000 (UTC)
Received: from krava (ovpn-204-212.brq.redhat.com [10.40.204.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77FD119C68;
        Wed,  4 Dec 2019 15:24:47 +0000 (UTC)
Date:   Wed, 4 Dec 2019 16:24:44 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Meelis Roos <mroos@linux.ee>, LKML <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: UBSAN: Undefined behaviour in arch/x86/events/intel/p6.c:116:29
Message-ID: <20191204152444.GA15573@krava>
References: <02f44ed5-13ac-f9c6-1f35-129c41006900@linux.ee>
 <20191202170633.GN2844@hirez.programming.kicks-ass.net>
 <0676c6ec-4475-62dc-b202-a62deaedd2dd@linux.ee>
 <20191204121540.GE20746@krava>
 <20191204150656.GX2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
In-Reply-To: <20191204150656.GX2844@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: whcV6YW1NnW-kRfyOm764Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2019 at 04:06:56PM +0100, Peter Zijlstra wrote:
> On Wed, Dec 04, 2019 at 01:15:40PM +0100, Jiri Olsa wrote:
> > On Tue, Dec 03, 2019 at 03:39:49PM +0200, Meelis Roos wrote:
> > > > Does something like so fix it?
> > >=20
> > > Unfortunately not (tested on top of todays git):
> >=20
> > hi,
> > which p6 model are you seeing this on?
> > how do you trigger that?
>=20
> Triggers on any p6 model. I hacked up perf and used "qemu-system-x86_64
> -cpu pentium2".
>=20
> The below seems to cure things.
>=20
> ---
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 9a89d98c55bd..f17417644665 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1642,9 +1643,12 @@ static struct attribute_group x86_pmu_format_group=
 __ro_after_init =3D {
> =20
>  ssize_t events_sysfs_show(struct device *dev, struct device_attribute *a=
ttr, char *page)
>  {
> -=09struct perf_pmu_events_attr *pmu_attr =3D \
> +=09struct perf_pmu_events_attr *pmu_attr =3D

ugh, did this do something weird? ;-)

>  =09=09container_of(attr, struct perf_pmu_events_attr, attr);
> -=09u64 config =3D x86_pmu.event_map(pmu_attr->id);
> +=09u64 config =3D 0;
> +
> +=09if (pmu_attr->id < x86_pmu.max_events)
> +=09=09x86_pmu.event_map(pmu_attr->id);

hum, should this be assigned to config?

=09=09config =3D x86_pmu.event_map(pmu_attr->id);

jirka

> =20
>  =09/* string trumps id */
>  =09if (pmu_attr->event_str)
> @@ -1713,6 +1717,9 @@ is_visible(struct kobject *kobj, struct attribute *=
attr, int idx)
>  {
>  =09struct perf_pmu_events_attr *pmu_attr;
> =20
> +=09if (idx >=3D x86_pmu.max_events)
> +=09=09return 0;
> +
>  =09pmu_attr =3D container_of(attr, struct perf_pmu_events_attr, attr.att=
r);
>  =09/* str trumps id */
>  =09return pmu_attr->event_str || x86_pmu.event_map(idx) ? attr->mode : 0=
;
>=20

