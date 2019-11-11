Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F156AC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86A9222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y125XSu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfKKNal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:30:41 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41597 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727102AbfKKNak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:30:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tN3lWawpUUhlRS9JBLb5opRa/ow45AltY9+PoLlCn98=;
        b=Y125XSu9B8LQK499w727Chzjg1xx0ZuL/Bs4Kv/wJXPERZ1etZ/ucho6dH1zyvuTA7IdBM
        B1jzUXtRxvW3WFUwewyh+ihrFbcRjbvfcW8ogLcnyZWVq700SfTpLZzIb2PbmEMbUNR+Rt
        Ksv1CW2ba1CxrcAxZYnmSXr9MdAvQRU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-kyBxeycLPuicjDe3EXKmng-1; Mon, 11 Nov 2019 08:30:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8F0641005500;
        Mon, 11 Nov 2019 13:30:35 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6DD2D600C6;
        Mon, 11 Nov 2019 13:30:34 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:30:33 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 09/13] perf evsel: Support opening on a specific CPU
Message-ID: <20191111133033.GC12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-10-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-10-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: kyBxeycLPuicjDe3EXKmng-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:42AM -0800, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>

SNIP

>  int perf_evsel__open_per_thread(struct evsel *evsel,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index b10d5ba21966..54513d70c109 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -223,7 +223,8 @@ int evsel__enable(struct evsel *evsel);
>  int evsel__disable(struct evsel *evsel);
> =20
>  int perf_evsel__open_per_cpu(struct evsel *evsel,
> -=09=09=09     struct perf_cpu_map *cpus);
> +=09=09=09     struct perf_cpu_map *cpus,
> +=09=09=09     int cpu);
>  int perf_evsel__open_per_thread(struct evsel *evsel,
>  =09=09=09=09struct perf_thread_map *threads);
>  int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
> diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> index 6822e4ffe224..36dc95032e4c 100644
> --- a/tools/perf/util/stat.c
> +++ b/tools/perf/util/stat.c
> @@ -517,7 +517,7 @@ int create_perf_stat_counter(struct evsel *evsel,
>  =09}
> =20
>  =09if (target__has_cpu(target) && !target__has_per_thread(target))
> -=09=09return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel));
> +=09=09return perf_evsel__open_per_cpu(evsel, evsel__cpus(evsel), -1);

how will -1 owrk in here? it will end up as:

   perf_evsel__open_per_cpu
    evsel__open_cpu( ...., start_cpu =3D -1, end_cpu =3D -1 + 1)
      for (cpu =3D start_cpu; cpu < end_cpu; cpu++) {

?

jirka

