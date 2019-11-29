Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AC7FC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC9216F4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 13:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHBuoohL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfK2NHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 08:07:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28046 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726360AbfK2NHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 08:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575032837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WnNpUelcmW1Zzw18d7Esh4Fn0UgHM+vp8eNsllmWrUk=;
        b=hHBuoohLN8j8+ERv8FM8BePppTXgWcR61yyE7WLp3vm3QcvomDkWHnv3n3IA1MQrd+BGwx
        jPshrpq1bUsBOBhdgLe+yVD4ZvQTfDHTtPDC53tc7CzJGUkfOzHnZBaSrBYEo9Y+RFskU4
        MtRU9DzbeR0SIkizd89fl0lbvIYHWhU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-htrLZBNQNJmWighpj58W8Q-1; Fri, 29 Nov 2019 08:07:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33559911A5;
        Fri, 29 Nov 2019 13:07:13 +0000 (UTC)
Received: from krava (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with SMTP id 94349608C9;
        Fri, 29 Nov 2019 13:07:11 +0000 (UTC)
Date:   Fri, 29 Nov 2019 14:07:10 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] perf record: adapt affinity to machines with
 #CPUs > 1K
Message-ID: <20191129130710.GB14169@krava>
References: <908dbe98-7d8d-0ec1-d4ae-242f3e104979@linux.intel.com>
 <21bc3ad7-e1f2-68da-f004-36354a6e40ea@linux.intel.com>
MIME-Version: 1.0
In-Reply-To: <21bc3ad7-e1f2-68da-f004-36354a6e40ea@linux.intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: htrLZBNQNJmWighpj58W8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 01:05:26PM +0300, Alexey Budankov wrote:

SNIP

>  # undef REASON
>  #endif
> =20
> -=09CPU_ZERO(&rec->affinity_mask);
>  =09rec->opts.affinity =3D PERF_AFFINITY_SYS;
> =20
>  =09rec->evlist =3D evlist__new();
> @@ -2499,6 +2504,14 @@ int cmd_record(int argc, const char **argv)
> =20
>  =09symbol__init(NULL);
> =20
> +=09rec->affinity_mask.nbits =3D cpu__max_cpu();
> +=09rec->affinity_mask.bits =3D bitmap_alloc(rec->affinity_mask.nbits);
> +=09if (!rec->affinity_mask.bits) {
> +=09=09pr_err("Failed to allocate thread mask for %ld cpus\n", rec->affin=
ity_mask.nbits);
> +=09=09return -ENOMEM;
> +=09}
> +=09pr_debug2("thread mask[%ld]: empty\n", rec->affinity_mask.nbits);

above can be done only for (rec->opts.affinity !=3D PERF_AFFINITY_SYS)


> +
>  =09err =3D record__auxtrace_init(rec);
>  =09if (err)
>  =09=09goto out;
> @@ -2613,6 +2626,8 @@ int cmd_record(int argc, const char **argv)
> =20
>  =09err =3D __cmd_record(&record, argc, argv);
>  out:
> +=09if (rec->affinity_mask.bits)
> +=09=09bitmap_free(rec->affinity_mask.bits);
>  =09evlist__delete(rec->evlist);
>  =09symbol__exit();
>  =09auxtrace_record__free(rec->itr);
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 30ff7aef06f2..615d05870849 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -219,6 +219,9 @@ static void perf_mmap__aio_munmap(struct mmap *map __=
maybe_unused)
> =20
>  void mmap__munmap(struct mmap *map)
>  {
> +=09if (map->affinity_mask.bits)
> +=09=09bitmap_free(map->affinity_mask.bits);

you don't need to check map->affinity_mask.bits, it's checked in free

jirka

