Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC3C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA445222CB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBYof4Ot"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbfKFQeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 11:34:31 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727570AbfKFQeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 11:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573058070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BQP7afY4/MZ7S29LaklU0C/wM1CnsMUrSv6g4R9XuMk=;
        b=ZBYof4OtXJDFD6DweJouqUJiEuHiGviNBOF89SbYzj7KJXYQV2xaBbYXY12JAKncLxKwTq
        Dxa+ZhvKpO8FEDKPSwWzA3YW/aTHqThqecF/wepDR4MoWlN9S1PRlNbmLpjSwpp+N+EN/J
        dll1BflTk9X1JgUhvWydJqt3JYeCdYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-BY5XieEJPmmFXSIGprnm5g-1; Wed, 06 Nov 2019 11:34:27 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 806F71800D53;
        Wed,  6 Nov 2019 16:34:26 +0000 (UTC)
Received: from krava (ovpn-204-115.brq.redhat.com [10.40.204.115])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1FFDB5D726;
        Wed,  6 Nov 2019 16:34:24 +0000 (UTC)
Date:   Wed, 6 Nov 2019 17:34:24 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     acme@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v4 7/9] perf stat: Use affinity for opening events
Message-ID: <20191106163424.GP30214@krava>
References: <20191105002522.83803-1-andi@firstfloor.org>
 <20191105002522.83803-8-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191105002522.83803-8-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: BY5XieEJPmmFXSIGprnm5g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2019 at 04:25:20PM -0800, Andi Kleen wrote:

SNIP

> +}
> +
>  void evsel__close(struct evsel *evsel)
>  {
>  =09perf_evsel__close(&evsel->core);
> @@ -1832,9 +1839,10 @@ void evsel__close(struct evsel *evsel)
>  }
> =20
>  int perf_evsel__open_per_cpu(struct evsel *evsel,
> -=09=09=09     struct perf_cpu_map *cpus)
> +=09=09=09     struct perf_cpu_map *cpus,
> +=09=09=09     int cpu)
>  {
> -=09return evsel__open(evsel, cpus, NULL);
> +=09return evsel__open_cpu(evsel, cpus, NULL, cpu, cpu + 1);
>  }
> =20
>  int perf_evsel__open_per_thread(struct evsel *evsel,
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 2e3b011ed09e..d5440a928745 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -94,6 +94,8 @@ struct evsel {
>  =09struct evsel=09=09*metric_leader;
>  =09bool=09=09=09collect_stat;
>  =09bool=09=09=09weak_group;
> +=09bool=09=09=09reset_group;
> +=09bool=09=09=09errored;

would be great to move some of the changes into separate patches,
it seems all related to new code, but would ease up the review
like these 2 bools above or adding cpu to create_perf_stat_counter
and adding evsel__open_cpu funtion and related changes

thanks,
jirka

