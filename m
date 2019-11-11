Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2692FC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB95222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0l9APiA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbfKKNbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:31:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727192AbfKKNbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:31:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479059;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bOjPCq6he7+ismBF6EWyJSenvCERiEZgaluLt8863/A=;
        b=X0l9APiANbb/etcL89gtLI46LavIjpBEU6Q2GZAhaPZRW7Gqh2kRtuizfZzwlRMYDYLlvp
        mh5nCQ+VZFZndnQCN1tWIpK9EKbJWiepLTK8RHxPCIgtmWMLWI1NIBxQhhP4NnfZPwxx4E
        QCItabQu5nlsNGPZ5JoJ4lKnH5/7wY0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-YzCIChQAMmarwZRMwlm6mQ-1; Mon, 11 Nov 2019 08:30:55 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A25D71800D48;
        Mon, 11 Nov 2019 13:30:54 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 823C818340;
        Mon, 11 Nov 2019 13:30:53 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:30:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 07/13] perf stat: Use affinity for closing file
 descriptors
Message-ID: <20191111133052.GE12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-8-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-8-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: YzCIChQAMmarwZRMwlm6mQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:40AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> Closing a perf fd can also trigger an IPI to the target CPU.
> Use the same affinity technique as we use for reading/enabling events
> to closing to optimize the CPU transitions.
>=20
> Before on a large test case with 94 CPUs:
>=20
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  32.56    3.085463          50     61483           close
>=20
> After:
>=20
>  10.54    0.735704          11     61485           close
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>=20
> ---
>=20
> v2: Use new iterator macros
> v3: Use new iterator macros
> Add missing affinity__cleanup
> v4:
> Update iterators again
> ---
>  tools/perf/util/evlist.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index dae6e846b2f8..0dcea66329e2 100644
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
> @@ -1169,9 +1170,31 @@ void perf_evlist__set_selected(struct evlist *evli=
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

should this be evlist->all_cpus?

jirka

> +=09=09evlist__for_each_entry_reverse(evlist, evsel)
> +=09=09=09evsel__close(evsel);
> +=09=09return;
> +=09}
> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +=09evlist__for_each_cpu (evlist, i, cpu) {
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry_reverse(evlist, evsel) {
> +=09=09=09if (evsel__cpu_iter_skip(evsel, cpu))
> +=09=09=09    continue;
> +=09=09=09perf_evsel__close_cpu(&evsel->core, evsel->cpu_iter - 1);
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);
> +=09evlist__for_each_entry_reverse(evlist, evsel) {
> +=09=09perf_evsel__free_fd(&evsel->core);
> +=09=09perf_evsel__free_id(&evsel->core);
> +=09}
>  }
> =20
>  static int perf_evlist__create_syswide_maps(struct evlist *evlist)
> --=20
> 2.23.0
>=20

