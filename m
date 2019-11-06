Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF63AC5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91CBB2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJZ97RoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfKFQd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:33:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50433 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbfKFQd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:33:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2/sGkcTJE/ccczjwCQaoSfIzTXnhbggMBxft/2WrJ4g=;
        b=XJZ97RoIYoPNp1WTL/dzpyTc2UjK/FEuiDGoqVEY2dfLmhZRAhmvKWrH4ZdsQEy2clPZ/3
        kSWH1rCcsxAC8AjWjJmoyqXD8u+qFXDpdMb/kAvNfv9+Yp30dTdL858PteknMkKAgUZ3/L
        fNlSHZsHXr/slsas/aOS9Fv1CPbF+Sk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-kuPXPneyPBSCkIQZ-8JgJg-1; Wed, 06 Nov 2019 11:33:54 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0F1C1005500;
        Wed,  6 Nov 2019 16:33:52 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 498BA5D70D;
        Wed,  6 Nov 2019 16:33:50 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:33:50 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 5/9] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191106163350.GL30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-6-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-6-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: kuPXPneyPBSCkIQZ-8JgJg-1
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

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dccf96e0d01b..8f3bfbe277b5 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -18,6 +18,7 @@
>  #include "debug.h"
>  #include "units.h"
>  #include <internal/lib.h> // page_size
> +#include "affinity.h"
>  #include "../perf.h"
>  #include "asm/bug.h"
>  #include "bpf-event.h"
> @@ -1165,9 +1166,33 @@ void perf_evlist__set_selected(struct evlist *evli=
st,
>  void evlist__close(struct evlist *evlist)
>  {
>  =09struct evsel *evsel;
> +=09struct affinity affinity;
> +=09int cpu, i;
> =20
> -=09evlist__for_each_entry_reverse(evlist, evsel)
> -=09=09evsel__close(evsel);
> +=09if (!evlist->core.cpus) {
> +=09=09evlist__for_each_entry_reverse(evlist, evsel)
> +=09=09=09evsel__close(evsel);
> +=09=09return;
> +=09}
> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +=09evlist__cpu_iter_start(evlist);
> +=09evlist__for_each_cpu (evlist, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry_reverse(evlist, evsel) {
> +=09=09=09if (evlist__cpu_iter_skip(evsel, cpu))
> +=09=09=09    continue;
> +=09=09=09perf_evsel__close_cpu(&evsel->core, evsel->cpu_index);
> +=09=09=09evlist__cpu_iter_next(evsel);
> +=09=09}
> +=09}

looks much better, how about we make it even more compact
from above patern, like:

=09affinity__setup

=09evlist__cpu_iter(evlist, i, cpu) {
=09=09affinity__set(&affinity, cpu);

=09=09evlist__for_each_entry_reverse(evlist, evsel) {
=09=09=09if (evsel__cpu_iter_skip(evsel, cpu))
=09=09=09=09continue;
=09=09=09perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter);
=09=09}
=09}

=09affinity__cleanup

where:
  - evlist__cpu_iter would call evlist__cpu_iter_start

  - evlist__cpu_iter_skip could increment evsel->cpu_index in false case
    so there's no need to have evlist__cpu_iter_next

  - rename evsel->cpu_index to evsel->cpu_iter

  - renamse evlist__cpu_iter_skip to evsel__cpu_iter_skip

jirka

