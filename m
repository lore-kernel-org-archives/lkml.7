Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EAC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96058214D8
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 12:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ENuSMDJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729088AbfLKMPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 07:15:04 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36441 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727365AbfLKMPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 07:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576066502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q+UFu80cgC5leHYfvbkDB/JCARHoiMnsWm2q8715p+Y=;
        b=ENuSMDJLVlmAHr7IST/C4lZEULPZv2HUcpMEjKaGzW+Ep6hAdfYYJZzZGIWgbUvM7FSupx
        brgvorp+9PkzDHGULpQvQ8rZVF8MBGRJXpBS17+zT7pZM0GUDQJxYrMedPDErgKgK1k87f
        O9G86ydvmPbbM4m4woxnqVfwlhOxxik=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-ozdVa5J-P-6-YEez5BnZ_A-1; Wed, 11 Dec 2019 07:14:58 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AFA8DBA3;
        Wed, 11 Dec 2019 12:14:57 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 619596A022;
        Wed, 11 Dec 2019 12:14:55 +0000 (UTC)
Date:   Wed, 11 Dec 2019 13:14:53 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20191211121453.GC12087@krava>
References: <20191211073036.31504-1-yao.jin@linux.intel.com>
 <20191211113815.GB12087@krava>
 <6ba174a8-309e-9410-e6ea-ac7bb7187757@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <6ba174a8-309e-9410-e6ea-ac7bb7187757@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ozdVa5J-P-6-YEez5BnZ_A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 08:01:44PM +0800, Jin, Yao wrote:
>=20
>=20
> On 12/11/2019 7:38 PM, Jiri Olsa wrote:
> > On Wed, Dec 11, 2019 at 03:30:34PM +0800, Jin Yao wrote:
> >=20
> > SNIP
> >=20
> > > +
> > > +static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_e=
ntry *b,
> > > +=09=09=09=09 hpp_field_fn get_field, int idx)
> > > +{
> > > +=09struct evsel *evsel =3D hists_to_evsel(a->hists);
> > > +=09u64 *fields_a, *fields_b;
> > > +=09int cmp, nr_members, ret, i;
> > > +
> > > +=09cmp =3D field_cmp(get_field(a), get_field(b));
> > > +=09if (!perf_evsel__is_group_event(evsel))
> > > +=09=09return cmp;
> > > +
> > > +=09nr_members =3D evsel->core.nr_members;
> > > +=09ret =3D pair_fields_alloc(a, b, get_field, nr_members,
> > > +=09=09=09      &fields_a, &fields_b);
> > > +=09if (ret) {
> > > +=09=09ret =3D cmp;
> > > +=09=09goto out;
> > > +=09}
> > > +
> > > +=09for (i =3D 1; i < nr_members; i++) {
> > > +=09=09if (i =3D=3D idx) {
> > > +=09=09=09ret =3D field_cmp(fields_a[i], fields_b[i]);
> > > +=09=09=09if (ret)
> > > +=09=09=09=09goto out;
> > > +=09=09}
> > > +=09}
> > > +
> > > +=09if (cmp) {
> > > +=09=09ret =3D cmp;
> > > +=09=09goto out;
> > > +=09}
> > > +
> > > +=09for (i =3D 1; i < nr_members; i++) {
> > > +=09=09if (i !=3D idx) {
> > > +=09=09=09ret =3D field_cmp(fields_a[i], fields_b[i]);
> > > +=09=09=09if (ret)
> > > +=09=09=09=09goto out;
> > > +=09=09}
> >=20
> > hi,
> > I'm missing why we compare the fields for 2nd time in here
> >=20
> > thanks,
> > jirka
> >=20
>=20
> Hi,
>=20
> I think we may continue comparing the remaining of fields if the index fi=
eld
> is equal. :)

aah, I missed it's actualy =3D=3D used in the first one ;-)

why don't you just call it directly?

=09ret =3D field_cmp(fields_a[idx], fields_b[idx])
=09if (ret)
=09=09goto out;

jirka

