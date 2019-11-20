Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C8C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1918921845
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S64F4gsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbfKTPMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 10:12:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44715 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728196AbfKTPMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 10:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574262750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=163gOnasp813YALUaRZik1EF1kXJ87AA18CckBS6bLM=;
        b=S64F4gsSI99tGR4Woq4eDxWQhnNyGnDVYcxeMxYu4aex3FGLSBA94J7nbDNk0axDCGTUrN
        5Pca7+vdkNJ2eeCjmUzgI+CIl5ltusLgjXsCy+cYabe47/oIOSUUM+uayeTCfxG3hq2STh
        RSOphtOvVMgoGFkuNIqrj9vKo4W17Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-Kd0SsJ4_McecSpPuLEpKqA-1; Wed, 20 Nov 2019 10:12:27 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09CF88026A1;
        Wed, 20 Nov 2019 15:12:26 +0000 (UTC)
Received: from krava (unknown [10.40.205.57])
        by smtp.corp.redhat.com (Postfix) with SMTP id D90261036C7B;
        Wed, 20 Nov 2019 15:12:24 +0000 (UTC)
Date:   Wed, 20 Nov 2019 16:12:23 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v7 10/12] perf stat: Use affinity for reading
Message-ID: <20191120151223.GF4007@krava>
References: <20191116055229.62002-1-andi@firstfloor.org>
 <20191116055229.62002-11-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191116055229.62002-11-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Kd0SsJ4_McecSpPuLEpKqA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 15, 2019 at 09:52:27PM -0800, Andi Kleen wrote:

SNIP

> +=09=09=09=09=09perf_evsel__name(counter),
> +=09=09=09=09=09cpu,
> +=09=09=09=09=09count->val, count->ena, count->run);
> +=09=09}
>  =09}
> =20
>  =09return 0;
> @@ -325,15 +318,36 @@ static int read_counter(struct evsel *counter, stru=
ct timespec *rs)
>  static void read_counters(struct timespec *rs)
>  {
>  =09struct evsel *counter;
> -=09int ret;
> +=09struct affinity affinity;
> +=09int i, ncpus, cpu;
> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +
> +=09ncpus =3D evsel_list->core.all_cpus->nr;

please use perf_cpu_map__nr

> +=09if (!target__has_cpu(&target) || target__has_per_thread(&target))
> +=09=09ncpus =3D 1;
> +=09evlist__for_each_cpu (evsel_list, i, cpu) {
> +=09=09if (i >=3D ncpus)
> +=09=09=09break;
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09if (evsel__cpu_iter_skip(counter, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (!counter->err)
> +=09=09=09=09counter->err =3D read_counter_cpu(counter, rs,
> +=09=09=09=09=09=09=09=09counter->cpu_iter - 1);

please use { } to enclose multiline if legs

thanks,
jirka

