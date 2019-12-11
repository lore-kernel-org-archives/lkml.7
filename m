Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1ACC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9889F2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 11:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UprJkblK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbfLKLi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:38:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727365AbfLKLi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 06:38:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576064304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OQRABxPZYtBN135c9DFGZrn/TMbTWDFaK78w/p/dvYA=;
        b=UprJkblK2L6J5V5+g87zYRfDi0vah9ZeprresulSfJNrXgfCKeiecJefDba2OTnacDbxv3
        5Ri2y4XAdqDcPSZ3QQZ6ZGgkPm4GYlxTOmoShLinfBhnezOAY0LCtFjdrUPAluNh0ggvYp
        02O4L0y9oTuN1Cl412huey+wAIrk//U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-gQCU4_CkOvSGm-IvioAmTQ-1; Wed, 11 Dec 2019 06:38:21 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 86E8F801E66;
        Wed, 11 Dec 2019 11:38:19 +0000 (UTC)
Received: from krava (unknown [10.43.17.106])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B473541FC;
        Wed, 11 Dec 2019 11:38:17 +0000 (UTC)
Date:   Wed, 11 Dec 2019 12:38:15 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 1/3] perf report: Change sort order by a specified
 event in group
Message-ID: <20191211113815.GB12087@krava>
References: <20191211073036.31504-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <20191211073036.31504-1-yao.jin@linux.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: gQCU4_CkOvSGm-IvioAmTQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 03:30:34PM +0800, Jin Yao wrote:

SNIP

> +
> +static int __hpp__group_sort_idx(struct hist_entry *a, struct hist_entry=
 *b,
> +=09=09=09=09 hpp_field_fn get_field, int idx)
> +{
> +=09struct evsel *evsel =3D hists_to_evsel(a->hists);
> +=09u64 *fields_a, *fields_b;
> +=09int cmp, nr_members, ret, i;
> +
> +=09cmp =3D field_cmp(get_field(a), get_field(b));
> +=09if (!perf_evsel__is_group_event(evsel))
> +=09=09return cmp;
> +
> +=09nr_members =3D evsel->core.nr_members;
> +=09ret =3D pair_fields_alloc(a, b, get_field, nr_members,
> +=09=09=09      &fields_a, &fields_b);
> +=09if (ret) {
> +=09=09ret =3D cmp;
> +=09=09goto out;
> +=09}
> +
> +=09for (i =3D 1; i < nr_members; i++) {
> +=09=09if (i =3D=3D idx) {
> +=09=09=09ret =3D field_cmp(fields_a[i], fields_b[i]);
> +=09=09=09if (ret)
> +=09=09=09=09goto out;
> +=09=09}
> +=09}
> +
> +=09if (cmp) {
> +=09=09ret =3D cmp;
> +=09=09goto out;
> +=09}
> +
> +=09for (i =3D 1; i < nr_members; i++) {
> +=09=09if (i !=3D idx) {
> +=09=09=09ret =3D field_cmp(fields_a[i], fields_b[i]);
> +=09=09=09if (ret)
> +=09=09=09=09goto out;
> +=09=09}

hi,
I'm missing why we compare the fields for 2nd time in here

thanks,
jirka

