Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D801CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2A3217F9
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 10:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W0IxFs8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfJ3KF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 06:05:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726032AbfJ3KF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 06:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572429955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=831vu3/eyL3XBkcwHKgpZZmB+ELrHuAQb4Ifd9QhbrE=;
        b=W0IxFs8tLkCMZYmTvDSUx6pN7pq3ODvi71B04mR5jqNeF5NdNvGz0d4NA6XN4xmjNq+IQW
        9p73RXkBy2Crl6Pig9YbPUTLsbPph4vOF9Kxd9El44O3eyXM6Ue7trQ5KVf/jpzq19uHfZ
        A8briAxx6xqZwu3Hlc73d2xrgfwW5fo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-3EM_zPcxPie4WA0HXpEC5Q-1; Wed, 30 Oct 2019 06:05:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 230ED1800D55;
        Wed, 30 Oct 2019 10:05:50 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id C53E760C4B;
        Wed, 30 Oct 2019 10:05:48 +0000 (UTC)
Date:   Wed, 30 Oct 2019 11:05:47 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, eranian@google.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v3 3/7] perf evsel: Add iterator to iterate over events
 ordered by CPU
Message-ID: <20191030100547.GD20826@krava>
References: <20191025181417.10670-1-andi@firstfloor.org>
 <20191025181417.10670-4-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191025181417.10670-4-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 3EM_zPcxPie4WA0HXpEC5Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 11:14:13AM -0700, Andi Kleen wrote:
> From: Andi Kleen <ak@linux.intel.com>
>=20
> Add some common code that is needed to iterate over all events
> in CPU order. Used in followon patches
>=20
> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>=20
> ---
>=20
> v2: Add cpumap__for_each_cpu macro to factor out some common code
> ---
>  tools/perf/util/cpumap.h |  8 ++++++++
>  tools/perf/util/evlist.c | 33 +++++++++++++++++++++++++++++++++
>  tools/perf/util/evlist.h |  4 ++++
>  tools/perf/util/evsel.h  |  1 +
>  4 files changed, 46 insertions(+)
>=20
> diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
> index 2553bef1279d..a9b13d72fd29 100644
> --- a/tools/perf/util/cpumap.h
> +++ b/tools/perf/util/cpumap.h
> @@ -60,4 +60,12 @@ int cpu_map__build_map(struct perf_cpu_map *cpus, stru=
ct perf_cpu_map **res,
> =20
>  int cpu_map__cpu(struct perf_cpu_map *cpus, int idx);
>  bool cpu_map__has(struct perf_cpu_map *cpus, int cpu);
> +
> +#define __cpumap__for_each_cpu(cpus, index, cpu, maxcpu)\
> +=09for ((index) =3D 0; =09=09=09=09\
> +=09     (cpu) =3D (index) < (maxcpu) ? (cpus)->map[index] : -1, (index) =
< (maxcpu); \
> +=09     (index)++)
> +#define cpumap__for_each_cpu(cpus, index, cpu) \
> +=09__cpumap__for_each_cpu(cpus, index, cpu, (cpus)->nr)

there's perf_cpu_map__for_each_cpu macro in libperf

jirka

