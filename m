Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CE7CA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA2620663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 10:30:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4gEl0Vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404479AbfJWKa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 06:30:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60593 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404424AbfJWKa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 06:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571826656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RVZt7S+cO4Xzjye2W2B0LgB7MmmghyWfzCHIR01Nk8k=;
        b=R4gEl0Vs6lQILFhRt1RzLSYrCiGEbIoT5mhLEQ+8b8gDLTYzNYkg8sP9itBwSXFFDbqzcp
        bti7DZ5zg7hBtPbusYhMQrUDWdu7MbY4fZcpwfzgpQJDsYZe2YA9WL5l6tW4Lx6S+lXnKH
        EauXf/JHrGzo/fBa8llo5o9qIBuvAvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-9ZOPozPOM-a4-5hDN9Oc_Q-1; Wed, 23 Oct 2019 06:30:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 878A51800D6B;
        Wed, 23 Oct 2019 10:30:51 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id E3519600CC;
        Wed, 23 Oct 2019 10:30:49 +0000 (UTC)
Date:   Wed, 23 Oct 2019 12:30:48 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com,
        peterz@infradead.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v2 9/9] perf stat: Use affinity for enabling/disabling
 events
Message-ID: <20191023103048.GK22919@krava>
References: <20191020175202.32456-1-andi@firstfloor.org>
 <20191020175202.32456-10-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191020175202.32456-10-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 9ZOPozPOM-a4-5hDN9Oc_Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2019 at 10:52:02AM -0700, Andi Kleen wrote:

SNIP

> =20
>  void evlist__enable(struct evlist *evlist)
>  {
>  =09struct evsel *pos;
> +=09struct affinity affinity;
> +=09struct perf_cpu_map *cpus;
> +=09int i;
> +
> +=09if (affinity__setup(&affinity) < 0)
> +=09=09return;
> +
> +=09cpus =3D evlist__cpu_iter_start(evlist);
> +=09for (i =3D 0; i < cpus->nr; i++) {
> +=09=09int cpu =3D cpus->map[i];
> +=09=09affinity__set(&affinity, cpu);
> =20
> +=09=09evlist__for_each_entry(evlist, pos) {
> +=09=09=09if (evlist__cpu_iter_skip(pos, cpu))
> +=09=09=09=09continue;
> +=09=09=09if (!perf_evsel__is_group_leader(pos) || !pos->core.fd)
> +=09=09=09=09continue;

all the previous patches and this one have this code in common,
could we make this a single function, that would call a callback
that would have affinity set.. sort of like what we do in=20
cpu_function_call in the kernel

thanks,
jirka

> +=09=09=09evsel__enable_cpu(pos, pos->cpu_index);
> +=09=09=09evlist__cpu_iter_next(pos);
> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);

SNIP

