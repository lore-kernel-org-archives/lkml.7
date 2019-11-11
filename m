Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2776DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFB9222C1
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbPR+1JN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKKNbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:31:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726897AbfKKNbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xtSOb24JNZNa6JsLUYnqbS2iITwQ1rAnNMOHWwI7A40=;
        b=NbPR+1JNIMkNJrtsZSC0HnqSBLUxgS6UfjORAe48kkDFw9diQonWGQA48LZyj0dLXz8Z21
        /n/ZOlo592aQtcNHLPRNJ9/K91yCY7bCa2GM9q+Ah/TtpizEFYpuz4yE9drDGAuQ5wTppW
        zKW0uQf9uN5vbblik1VHTbSYlwPF8qU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-YrSIKMZ2OpalfX3ooecwdA-1; Mon, 11 Nov 2019 08:31:03 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E9E1005500;
        Mon, 11 Nov 2019 13:31:02 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6351A608EB;
        Mon, 11 Nov 2019 13:31:01 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:31:00 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 11/13] perf stat: Use affinity for reading
Message-ID: <20191111133100.GF12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-12-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-12-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: YrSIKMZ2OpalfX3ooecwdA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:44AM -0800, Andi Kleen wrote:

SNIP

> @@ -325,15 +318,34 @@ static int read_counter(struct evsel *counter, stru=
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
> +=09if (!(target__has_cpu(&target) && !target__has_per_thread(&target)))
> +=09=09ncpus =3D 1;
> +=09evlist__for_each_cpu (evsel_list, i, cpu) {
> +=09=09if (i >=3D ncpus)
> +=09=09=09break;
> +=09=09affinity__set(&affinity, cpu);
> +
> +=09=09evlist__for_each_entry(evsel_list, counter) {
> +=09=09=09if (evsel__cpu_iter_skip(counter, cpu))
> +=09=09=09=09continue;
> +=09=09=09counter->err =3D read_counter(counter, rs, counter->cpu_iter - =
1);

this will be overwritten by another cpu attempt,
so the check below won't get triggered properly

should we just break in case of error in here?

> +=09=09}
> +=09}
> +=09affinity__cleanup(&affinity);
> =20
>  =09evlist__for_each_entry(evsel_list, counter) {
> -=09=09ret =3D read_counter(counter, rs);
> -=09=09if (ret)
> +=09=09if (counter->err)
>  =09=09=09pr_debug("failed to read counter %s\n", counter->name);
> -
> -=09=09if (ret =3D=3D 0 && perf_stat_process_counter(&stat_config, counte=
r))
> +=09=09if (counter->err =3D=3D 0 && perf_stat_process_counter(&stat_confi=
g, counter))
>  =09=09=09pr_warning("failed to process counter %s\n", counter->name);
> +=09=09counter->err =3D 0;
>  =09}
>  }
> =20

SNIP

