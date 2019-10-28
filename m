Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B28CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F5D208C0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 15:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFXreMRs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389658AbfJ1Pjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 11:39:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42287 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726025AbfJ1Pjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1572277179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mJ9KzaFwM1RWaOAJlcioiXkMO8pxcCUgcIBsHAiwcZc=;
        b=jFXreMRsQUhQSBBWSASM8M9RfrBdx6CatOV9H+Dfk+c668S5auqaYO2GGI4vshH03YOjU2
        ltxQFQoJdOqcnv08SdDVEQvBa2phsvMR+f/rqHVt6HGowkFcT/tkVDJlN7yMqTRf/czP5b
        Le4AltD1nM1NEMsLW5dKbHiRKSHvn0o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-GZsLWB73O7-6f6W8FffYNw-1; Mon, 28 Oct 2019 11:39:35 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1C231005509;
        Mon, 28 Oct 2019 15:39:33 +0000 (UTC)
Received: from krava (unknown [10.43.17.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 3C721600C9;
        Mon, 28 Oct 2019 15:39:31 +0000 (UTC)
Date:   Mon, 28 Oct 2019 16:39:30 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/6] perf dso: Refactor dso_cache__read()
Message-ID: <20191028153930.GA15449@krava>
References: <20191025130000.13032-1-adrian.hunter@intel.com>
 <20191025130000.13032-3-adrian.hunter@intel.com>
MIME-Version: 1.0
In-Reply-To: <20191025130000.13032-3-adrian.hunter@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: GZsLWB73O7-6f6W8FffYNw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 03:59:56PM +0300, Adrian Hunter wrote:

SNIP

> +}
> =20
> -=09return ret;
> +static struct dso_cache *dso_cache__find(struct dso *dso,
> +=09=09=09=09=09 struct machine *machine,
> +=09=09=09=09=09 u64 offset,
> +=09=09=09=09=09 ssize_t *ret)
> +{
> +=09struct dso_cache *cache =3D __dso_cache__find(dso, offset);
> +
> +=09return cache ? cache : dso_cache__populate(dso, machine, offset, ret)=
;
>  }
> =20
>  static ssize_t dso_cache_read(struct dso *dso, struct machine *machine,
>  =09=09=09      u64 offset, u8 *data, ssize_t size)
>  {
>  =09struct dso_cache *cache;
> +=09ssize_t ret =3D 0;
> =20
> -=09cache =3D dso_cache__find(dso, offset);
> -=09if (cache)
> -=09=09return dso_cache__memcpy(cache, offset, data, size);
> -=09else
> -=09=09return dso_cache__read(dso, machine, offset, data, size);
> +=09cache =3D dso_cache__find(dso, machine, offset, &ret);
> +=09if (!cache)
> +=09=09return ret;

why not use the ERR_* macros to get error through the pointer
instead of adding extra argument?

jirka


> +
> +=09return dso_cache__memcpy(cache, offset, data, size);
>  }
> =20
>  /*
> --=20
> 2.17.1
>=20

