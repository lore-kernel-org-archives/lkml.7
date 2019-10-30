Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115B9CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D843F217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XneWrAO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbfJ3KGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:06:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58947 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726032AbfJ3KGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572429961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q40xlgboLvVtUuQXzVRKVP3oEUq/lES4Rt0k+POHH+k=;
        b=XneWrAO15qF+T0RamZSWeqTbRcdCySx5iStd6eZQ7oY81t1Njjo1OZL0ReamJ6knHyGWas
        L1dMT9fcCTYBPVomlC8SmN4BPUG7fuhPFeOBS1f4+18tCjNZiUGE/TeP6rcVXDIsyyf6Rd
        0n8+QEyqH9KAAKI2TCQ51yPVwLUPsjY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-2CkZv_yzP_WUQ8PXGByx9A-1; Wed, 30 Oct 2019 06:05:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8016605;
        Wed, 30 Oct 2019 10:05:56 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7FD3760C57;
        Wed, 30 Oct 2019 10:05:55 +0000 (UTC)
Date:   Wed, 30 Oct 2019 11:05:54 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 4/7] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191030100554.GE20826@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-5-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191025181417.10670-5-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 2CkZv_yzP_WUQ8PXGByx9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:14:14AM -0700, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index da3c8f8ef68e..aeb82de36043 100644
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
> @@ -1170,9 +1171,33 @@ void perf_evlist__set_selected(struct evlist *evli=
st,
>  void evlist__close(struct evlist *evlist)
>  {
>  =09struct evsel *evsel;
> +=09struct affinity affinity;
> +=09struct perf_cpu_map *cpus;
> +=09int i, cpu;
> +
> +=09if (!evlist->core.cpus) {
> +=09=09evlist__for_each_entry_reverse(evlist, evsel)
> +=09=09=09evsel__close(evsel);
> +=09=09return;
> +=09}
> =20
> -=09evlist__for_each_entry_reverse(evlist, evsel)
> -=09=09evsel__close(evsel);
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +=09cpus =3D evlist__cpu_iter_start(evlist);
> +=09cpumap__for_each_cpu (cpus, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);

whats the point of affinity->changed flags when we call
affinity__set unconditionaly? I think we can do without
it, becase we'll always endup calling affinity__set

also here you're missing affinity__cleanup call in here

however, it seems superfluous to always allocate those
bitmaps, while we need just the current cpus that we
run on and also that is probably questionable

could we put 'struct affinity' to 'struct evlist'
and get rid of all affinity__setup/cleanup calls?
(apart from those in evlist__init and evlist__delete)

thanks,
jirka

