Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7103CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43C5A222BD
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 13:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emidFNVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfKKNat (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 08:30:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727054AbfKKNar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 08:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573479046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4iGX2jLwwPPOlI45s5Dwmf/HhqeeZarjqN7A9t+rnbw=;
        b=emidFNVx2WSF4KEx10J5jZLilWoHAvh71bHKp12ZJfy0KzMu/U276feA4SHwM6fTZxi5+k
        gom7xaUzdNS4G/CIaTlUfjTIaSzxaFUmWDN4ZOkgYhBE9AeMgIlwe4Nye+0goKQQE5ShTV
        Pgf8325rH0wovrWQlIFvQRGpDVFzE+k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-PQKZox66MXGI_06u9m3fmQ-1; Mon, 11 Nov 2019 08:30:43 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890A68064DC;
        Mon, 11 Nov 2019 13:30:42 +0000 (UTC)
Received: from krava (unknown [10.40.205.88])
        by smtp.corp.redhat.com (Postfix) with SMTP id 67B0450;
        Mon, 11 Nov 2019 13:30:41 +0000 (UTC)
Date:   Mon, 11 Nov 2019 14:30:40 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, acme@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 12/13] perf evsel: Add functions to enable/disable for
 a specific CPU
Message-ID: <20191111133040.GD12923@krava>
References: <20191107181646.506734-1-andi@firstfloor.org>
 <20191107181646.506734-13-andi@firstfloor.org>
MIME-Version: 1.0
In-Reply-To: <20191107181646.506734-13-andi@firstfloor.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: PQKZox66MXGI_06u9m3fmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2019 at 10:16:45AM -0800, Andi Kleen wrote:

SNIP

> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 7106f9a067df..79050a6f4991 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1205,13 +1205,26 @@ int perf_evsel__append_addr_filter(struct evsel *=
evsel, const char *filter)
>  =09return perf_evsel__append_filter(evsel, "%s,%s", filter);
>  }
> =20
> +/* Caller has to clear disabled after going through all CPUs. */
> +int evsel__enable_cpu(struct evsel *evsel, int cpu)
> +{
> +=09int err =3D perf_evsel__enable_cpu(&evsel->core, cpu);
> +=09return err;

=09return perf_evsel__enable_cpu(... ?

> +}
> +
>  int evsel__enable(struct evsel *evsel)
>  {
>  =09int err =3D perf_evsel__enable(&evsel->core);
> =20
>  =09if (!err)
>  =09=09evsel->disabled =3D false;
> +=09return err;
> +}
> =20
> +/* Caller has to set disabled after going through all CPUs. */
> +int evsel__disable_cpu(struct evsel *evsel, int cpu)
> +{
> +=09int err =3D perf_evsel__disable_cpu(&evsel->core, cpu);
>  =09return err;

=09return perf_evsel__disable_cpu(... ?

jirka

